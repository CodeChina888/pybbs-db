package co.yiiu.pybbs.controller.front;

import co.yiiu.pybbs.model.Collect;
import co.yiiu.pybbs.model.Tag;
import co.yiiu.pybbs.model.Topic;
import co.yiiu.pybbs.model.User;
import co.yiiu.pybbs.service.CollectService;
import co.yiiu.pybbs.service.TagService;
import co.yiiu.pybbs.service.TopicService;
import co.yiiu.pybbs.service.UserService;
import co.yiiu.pybbs.util.MyPage;
import co.yiiu.pybbs.util.aop.MyLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Created by tomoya.
 * Copyright (c) 2018, All Rights Reserved.
 * https://yiiu.co
 */
@Controller
@RequestMapping("/forum/topic")
public class TopicController extends BaseController {

  @Autowired
  private TopicService topicService;
  @Autowired
  private TagService tagService;
  @Autowired
  private UserService userService;
  @Autowired
  private CollectService collectService;

  // 话题详情
  @GetMapping("/{id}")
  public String detail(@PathVariable Integer id, Model model, HttpServletRequest request,HttpSession session) {
    // 查询话题详情
    Topic topic = topicService.selectById(id);
    Assert.notNull(topic, "话题不存在");
    // 查询话题关联的标签
    Tag tags = tagService.selectById(topic.getTagId());
    // 查询话题的作者信息
    User topicUser = userService.selectById(topic.getUserId());
    // 查询话题有多少收藏
    List<Collect> collects = collectService.selectByTopicId(id);
    // 如果自己登录了，查询自己是否收藏过这个话题
    if (getUser() != null) {
      Collect collect = collectService.selectByTopicIdAndUserId(id, getUser().getId());
      model.addAttribute("collect", collect);
    }
    // 话题浏览量+1
    topic = topicService.addViewCount(topic, request);
    model.addAttribute("topic", topic);
    model.addAttribute("tags", tags);
    model.addAttribute("topicUser", topicUser);
    model.addAttribute("collects", collects);
    User user = (User) session.getAttribute("_user");
    String token=(String)session.getAttribute("_token");
    userService.refresh(user.getOriginId(),token);
    return render("topic/detail");
  }

  @GetMapping("/create")
  public String create(String tag, Model model,HttpSession session) {
    model.addAttribute("tag",tag);
    List list=tagService.selectAllTag();
    model.addAttribute("list",list);
    User user = (User) session.getAttribute("_user");
    String token=(String)session.getAttribute("_token");
    userService.refresh(user.getOriginId(),token);
    return render("topic/create");
  }

  // 编辑话题
  @MyLog(value = "编辑话题")  //这里添加了AOP的自定义注解
  @GetMapping("/edit/{id}")
  public String edit(Model model,@PathVariable Integer id,HttpSession session) {
    Topic topic = topicService.selectById(id);
    Assert.isTrue(topic.getUserId().equals(getUser().getId()), "谁给你的权限修改别人的话题的？");
    // 查询话题的标签
    Tag tags = tagService.selectById(topic.getTagId());
    // 将标签集合转成逗号隔开的字符串
    List list=tagService.selectAllTag();
    model.addAttribute("topic", topic);
    model.addAttribute("tags", tags.getName());
    model.addAttribute("list",list);
    User user = (User) session.getAttribute("_user");
    String token=(String)session.getAttribute("_token");
    userService.refresh(user.getOriginId(),token);
    return render("topic/edit");
  }

  @GetMapping("/tag/{id}")
  public String tag(@PathVariable Integer id, @RequestParam(defaultValue = "1") Integer pageNo, Model model,HttpSession session) {
    Tag tag = tagService.selectById(id);
    Assert.notNull(tag, "模板不存在");
    // 查询标签关联的话题
    MyPage<Map<String, Object>> iPage = tagService.selectTopicByTagId(tag.getId(), pageNo);
    model.addAttribute("tag", tag);
    model.addAttribute("page", iPage);
    User user = (User) session.getAttribute("_user");
    String token=(String)session.getAttribute("_token");
    userService.refresh(user.getOriginId(),token);
    return render("tag/tag");
  }
}
