package co.yiiu.pybbs.service;

import co.yiiu.pybbs.config.service.RedisService;
import co.yiiu.pybbs.mapper.UserMapper;
import co.yiiu.pybbs.model.Data;
import co.yiiu.pybbs.model.Message;
import co.yiiu.pybbs.model.Row;
import co.yiiu.pybbs.model.User;
import co.yiiu.pybbs.util.Constants;
import co.yiiu.pybbs.util.HttpClientUtil;
import co.yiiu.pybbs.util.JsonUtil;
import co.yiiu.pybbs.util.MyPage;
import co.yiiu.pybbs.util.bcrypt.BCryptPasswordEncoder;
import co.yiiu.pybbs.util.identicon.Identicon;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.lang.reflect.Type;
import java.util.*;

/**
 * Created by tomoya.
 * Copyright (c) 2018, All Rights Reserved.
 * https://yiiu.co
 */
@Service
@Transactional
public class UserService {

  @Autowired
  private UserMapper userMapper;
  @Autowired
  private CollectService collectService;
  @Autowired
  private TopicService topicService;
  @Autowired
  private CommentService commentService;
  @Autowired
  private Identicon identicon;
  @Autowired
  private NotificationService notificationService;
  @Autowired
  private SystemConfigService systemConfigService;
  @Autowired
  private RedisService redisService;

  // 根据用户名查询用户，用于获取用户的信息比对密码
  public User selectByUsername(String username) {
    String userJson = redisService.getString(Constants.REDIS_USER_USERNAME_KEY + username);
    User user;
    if (userJson == null) {
      QueryWrapper<User> wrapper = new QueryWrapper<>();
      wrapper.lambda()
          .eq(User::getUsername, username);
      user = userMapper.selectOne(wrapper);
      redisService.setString(Constants.REDIS_USER_USERNAME_KEY + username, JsonUtil.objectToJson(user));
    } else {
      user = JsonUtil.jsonToObject(userJson, User.class);
    }
    return user;
  }

  // 递归生成token，防止token重复
  // 理论上uuid生成的token是不可能重复的
  // 加个逻辑放心 : )
  private String generateToken() {
    String token = UUID.randomUUID().toString();
    User user = this.selectByToken(token);
    if (user != null) {
      return this.generateToken();
    }
    return token;
  }

  // 注册创建用户
  public User addUser(Integer OriginId,String username, String password, String avatar, String email, String bio) {
    String token = this.generateToken();
    User user = new User();
    user.setOriginId(OriginId);
    user.setUsername(username);
    if (!StringUtils.isEmpty(password)) user.setPassword(new BCryptPasswordEncoder().encode(password));
    user.setToken(token);
    user.setInTime(new Date());
//    if (avatar == null) avatar = identicon.generator(username);
    user.setAvatar(avatar);
    user.setEmail(email);
    userMapper.insert(user);
    // 再查一下，有些数据库里默认值保存后，类里还是null
    return this.selectById(user.getId());
  }

  // 根据用户token查询用户
  public User selectByToken(String token) {
    String userJson = redisService.getString(Constants.REDIS_USER_TOKEN_KEY + token);
    User user;
    if (userJson == null) {
      QueryWrapper<User> wrapper = new QueryWrapper<>();
      wrapper.lambda()
          .eq(User::getToken, token);
      user = userMapper.selectOne(wrapper);
      redisService.setString(Constants.REDIS_USER_TOKEN_KEY + token, JsonUtil.objectToJson(user));
    } else {
      user = JsonUtil.jsonToObject(userJson, User.class);
    }
    return user;
  }

  public User selectById(Integer id) {
    String userJson = redisService.getString(Constants.REDIS_USER_ID_KEY + id);
    User user;
    if (userJson == null) {
      user = userMapper.selectById(id);
      redisService.setString(Constants.REDIS_USER_ID_KEY + id, JsonUtil.objectToJson(user));
    } else {
      user = JsonUtil.jsonToObject(userJson, User.class);
    }
    return user;
  }

  public User selectByoriginId(Integer originId) {
    String userJson = redisService.getString(Constants.REDIS_USER_ID_KEY + originId);
    User user;
    if (userJson == null) {
      user =userMapper.selectByoriginId(originId);
      redisService.setString(Constants.REDIS_USER_ID_KEY + originId, JsonUtil.objectToJson(user));
    } else {
      user = JsonUtil.jsonToObject(userJson, User.class);
    }
    return user;
  }

  public boolean isExist(Integer originId) {
    Integer flag=userMapper.isExist(originId);
    if(flag>0)
      return true;
    else
      return false;
  }

  // 查询用户积分榜
  public List<User> selectTop(Integer limit) {
    QueryWrapper<User> wrapper = new QueryWrapper<>();
    wrapper
        .orderByDesc("score")
        .last("limit " + limit);
    return userMapper.selectList(wrapper);
  }

  // 更新用户信息
  public void update(User user) {
    userMapper.updateById(user);
    // 删除redis里的缓存
    this.delRedisUser(user);
  }

  //查询x平台用户信息
  public Message<Data> userMessage(Integer id ){
    //User user=userService.selectById(userid);
    String url="http://xpro.adl.io/service/memcenter/api/v1/inner/member/getUserInfo?id="+id;
    String message = HttpClientUtil.doGet(url);
    Gson gson = new Gson();
    //Map<String, Object> map = new HashMap<String, Object>();
    Type type=new TypeToken<Message<Data>>(){}.getType();
    Message<Data> dataMessage = gson.fromJson(message, type);
    //Row row=dataMessage.getData().getRow();
    //System.out.println(row.getRealname());
    return dataMessage;
  }

  //查询x平台用户是否有登陆论坛的权限
  public Boolean hasPermission(Integer id){
    String url="http://service.adl.io/memcenter/api/v1/inner/forum/userHasPermission?userId="+id;
    String message=HttpClientUtil.doGet(url);
    Gson gson = new Gson();
    Type type=new TypeToken<Message<Data>>(){}.getType();
    Message<Data> dataMessage = gson.fromJson(message, type);
    if (Integer.parseInt(dataMessage.getCode())==00000)
    { Row row = dataMessage.getData().getRow();
      return row.getHasPermission();
    }else {
      return false;
    }
  }

  //刷新token
  public void refresh(Integer id) {
    Message<Data> dataMessage = this.userMessage(id);
    String url = "http://service.adl.io/memcenter/api/v1/inner/auth/refresh";
    Map<String, String> head = new HashMap<>();
    head.put("Authorization", "Bearer "+dataMessage.getData().getJwtToken());
    String message = HttpClientUtil.doPost(url, null, head);
    Gson gson = new Gson();
    Type type=new TypeToken<Message<Data>>(){}.getType();
    Message<Data> Message = gson.fromJson(message, type);
    System.out.println("code:"+Message.getCode());
  }




  // ------------------------------- admin ------------------------------------------

  public IPage<User> selectAll(Integer pageNo) {
    MyPage<User> page = new MyPage<>(pageNo, Integer.parseInt((String) systemConfigService.selectAllConfig().get("page_size")));
    page.setDesc("in_time");
    return userMapper.selectPage(page, null);
  }

  // 查询今天新增的话题数
  public int countToday() {
    return userMapper.countToday();
  }

  // 删除用户
  public void deleteUser(Integer id) {
    // 删除用户的通知
    notificationService.deleteByUserId(id);
    // 删除用户的收藏
    collectService.deleteByUserId(id);
    // 删除用户发的帖子
    topicService.deleteByUserId(id);
    // 删除用户发的评论
    commentService.deleteByUserId(id);
    // 删除redis里的缓存
    User user = this.selectById(id);
    this.delRedisUser(user);
    // 删除用户本身
    userMapper.deleteById(id);
  }

  // 删除redis缓存
  public void delRedisUser(User user) {
    redisService.delString(Constants.REDIS_USER_ID_KEY + user.getId());
    redisService.delString(Constants.REDIS_USER_USERNAME_KEY + user.getUsername());
    redisService.delString(Constants.REDIS_USER_TOKEN_KEY + user.getToken());
  }
}
