package co.yiiu.pybbs.service;

import co.yiiu.pybbs.mapper.TagMapper;
import co.yiiu.pybbs.model.AdminUser;
import co.yiiu.pybbs.model.Tag;
import co.yiiu.pybbs.model.Topic;
import co.yiiu.pybbs.model.TopicTag;
import co.yiiu.pybbs.util.MyPage;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Created by tomoya.
 * Copyright (c) 2018, All Rights Reserved.
 * https://yiiu.co
 */
@Service
@Transactional
public class TagService {

  @Autowired
  private TagMapper tagMapper;
  @Autowired
  private TopicTagService topicTagService;
  @Autowired
  private SystemConfigService systemConfigService;
  @Autowired
  private TopicService topicService;
  @Autowired
  private AdminUserService adminUserService;

  public Tag selectById(Integer id) {
    return tagMapper.selectById(id);
  }

  public Tag selectByName(String name) {
    QueryWrapper<Tag> wrapper = new QueryWrapper<>();
    wrapper.lambda()
        .eq(Tag::getName, name);
    return tagMapper.selectOne(wrapper);
  }

  public List<Tag> selectByIds(Integer id) {
    QueryWrapper<Tag> wrapper = new QueryWrapper<>();
    wrapper.lambda().eq(Tag::getId,id);
    return tagMapper.selectList(wrapper);
  }

  // 根据话题查询关联的所有标签
  public List<Tag> selectByTopicId(Integer topicId) {
    List<TopicTag> topicTags = topicTagService.selectByTopicId(topicId);
    List<Integer> tagIds = topicTags.stream().map(TopicTag::getTagId).collect(Collectors.toList());
    QueryWrapper<Tag> wrapper = new QueryWrapper<>();
    wrapper.lambda()
        .in(Tag::getId, tagIds);
    return tagMapper.selectList(wrapper);
  }

  // 将创建话题时填的tag处理并保存
  public List<Tag> insertTag(String newTags) {
    // 使用工具将字符串按逗号分隔成数组
    String[] _tags = StringUtils.commaDelimitedListToStringArray(newTags);
    List<Tag> tagList = new ArrayList<>();
    for (String _tag : _tags) {
      Tag tag = this.selectByName(_tag);
      if (tag == null) {
        tag = new Tag();
        tag.setName(_tag);
        tag.setTopicCount(1);
        tag.setInTime(new Date());
        tagMapper.insert(tag);
      } else {
        tag.setTopicCount(tag.getTopicCount() + 1);
        tagMapper.updateById(tag);
      }
      tagList.add(tag);
    }
    return tagList;
  }

  // 将创建tag保存
  public void insertTag(Tag tag){
    if(tag!=null){
      tag.setName(tag.getName());
      tag.setDescription(tag.getDescription());
      tag.setInTime(new Date());
      tag.setTopicCount(0);
      tagMapper.insert(tag);
    }else
      return;
  }

  // 将标签的话题数都-1
  public void reduceTopicCount(Integer id) {
    List<Tag> tags = this.selectByTopicId(id);
    tags.forEach(tag -> {
      tag.setTopicCount(tag.getTopicCount() - 1);
      tagMapper.updateById(tag);
    });
  }

  // 查询标签关联的话题
  public MyPage<Map<String, Object>> selectTopicByTagId(Integer tagId, Integer pageNo) {
    MyPage<Map<String, Object>> iPage = new MyPage<>(pageNo, Integer.parseInt(systemConfigService.selectAllConfig().get("page_size").toString()));
    return tagMapper.selectTopicByTagId(iPage, tagId);
  }

  // 查询标签列表
  public IPage<Tag> selectAll(Integer pageNo, Integer pageSize, String name) {
    IPage<Tag> iPage = new MyPage<>(pageNo, pageSize == null ? Integer.parseInt(systemConfigService.selectAllConfig().get("page_size").toString()) : pageSize);
    QueryWrapper<Tag> wrapper = new QueryWrapper<>();
    // 当传进来的name不为null的时候，就根据name查询
    if (!StringUtils.isEmpty(name)) {
      wrapper.lambda().eq(Tag::getName, name);
    }
    wrapper.orderByDesc("topic_count");
    return tagMapper.selectPage(iPage, wrapper);
  }

  public List<Tag> selectall(){
    QueryWrapper<Tag> wrapper = new QueryWrapper<>();
    wrapper.eq("admin_id", 0);
    return tagMapper.selectList(wrapper);
  }

  public List<Tag> selectAllByAdminId(){
    List<Tag> tagList=new ArrayList<Tag>();
    tagList=tagMapper.getAllTagByAdminId();
    return tagList;
  }



  public void update(Tag tag) {
    tagMapper.updateById(tag);
  }

  // 如果 topic_tag 表里还有关联的数据，这里删除会报错
  public void delete(Integer id) {
    AdminUser adminUser=adminUserService.selectById(tagMapper.selectById(id).getAdminId());
    adminUser.setTagId(0);
    tagMapper.deleteById(id);
    List<Topic> topics=tagMapper.selectAllTopicByTagId(id);
    for (Topic topic:topics) {
      topicService.selectById(topic.getId());
    }
  }

  // ---------------------------- admin ----------------------------


  //同步标签的话题数
  public void async() {
    List<Tag> tags = tagMapper.selectList(null);
    tags.forEach(tag -> {
      List<TopicTag> topicTags = topicTagService.selectByTagId(tag.getId());
      tag.setTopicCount(topicTags.size());
      this.update(tag);
    });
  }

  // 查询今天新增的标签数
  public int countToday() {
    return tagMapper.countToday();
  }

  public int countTodayByadminId(Integer adminId) {

    return tagMapper.countTodayByadminId(adminId);
  }

  public List selectAllTag(){
    List tagList=new ArrayList();
    tagList=tagMapper.getAllTag();
    return tagList;
  }



}
