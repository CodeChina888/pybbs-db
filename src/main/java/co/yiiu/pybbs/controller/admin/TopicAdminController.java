package co.yiiu.pybbs.controller.admin;

import co.yiiu.pybbs.model.Tag;
import co.yiiu.pybbs.model.Topic;
import co.yiiu.pybbs.service.NotificationService;
import co.yiiu.pybbs.service.TagService;
import co.yiiu.pybbs.service.TopicService;
import co.yiiu.pybbs.util.MyPage;
import co.yiiu.pybbs.util.Result;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Created by tomoya.
 * Copyright (c) 2018, All Rights Reserved.
 * https://yiiu.co
 */
@Controller
@RequestMapping("/admin/topic")
public class TopicAdminController extends BaseAdminController {

  @Autowired
  private TopicService topicService;
  @Autowired
  private TagService tagService;
  @Autowired
  private NotificationService notificationService;


  private Integer userid;
  @RequiresPermissions("topic:list")
  @GetMapping("/list")
  public String list(@RequestParam(defaultValue = "1") Integer pageNo, String startDate, String endDate,
                     String username, Model model) {

    if (StringUtils.isEmpty(startDate)) startDate = null;
    if (StringUtils.isEmpty(endDate)) endDate = null;
    if (StringUtils.isEmpty(username)) username = null;
    if (getAdminUser().getRoleId()==1){
      MyPage<Map<String, Object>> page = topicService.selectAllForAdmin(pageNo, startDate, endDate, username);
      model.addAttribute("page", page);
      model.addAttribute("startDate", startDate);
      model.addAttribute("endDate", endDate);
      model.addAttribute("username", username);
    }else {
         userid=getAdminUser().getId();
      MyPage<Map<String, Object>> page=topicService.selectTopicByAdminId(userid,pageNo,null);
      model.addAttribute("page", page);
    }

    return "admin/topic/list";
  }

  @RequiresPermissions("topic:edit")
  @GetMapping("/edit")
  public String edit(Integer id, Model model) {
    Tag tag=tagService.selectById(topicService.selectById(id).getTagId());
    if (tag.getAdminId()==getAdminUser().getId()||getAdminUser().getRoleId()==1)
    {
      model.addAttribute("topic", topicService.selectById(id));
      model.addAttribute("tags", tag.getName());
      return "admin/topic/edit";
    }
    return "templates/theme/default/error";
  }

  @RequiresPermissions("topic:edit")
  @PostMapping("edit")
  @ResponseBody
  public Result update(Integer id, String title, String content, String tags) {
    System.out.println(tags);
    Topic topic = topicService.selectById(id);
    topicService.updateTopic(topic, title, content, tags);
    return success();
  }

  @RequiresPermissions("topic:check")
  @GetMapping ("/check")
  public String check(Integer id,Model model) {
    Tag tag=tagService.selectById(topicService.selectById(id).getTagId());

    if (tag.getAdminId()==getAdminUser().getId()||getAdminUser().getRoleId()==1)
    {
      Topic topic = topicService.selectById(id);
      model.addAttribute("topic",topic);
      model.addAttribute("tags", tag.getName());
      return "admin/topic/check";
    }return "templates/theme/default/error";
  }
  @RequiresPermissions("topic:check")
  @PostMapping("/check")
  @ResponseBody
  public Result isPass(Integer id, String title, String content, String tags,Boolean pass) {
    System.out.println(tags);
    Topic topic = topicService.selectById(id);
    topic.setPass(pass);
    notificationService.insert(0,topic.getUserId(),id,"check",content);
    topicService.updateTopic(topic, title, content, tags);
    return success();
  }

  @RequiresPermissions("topic:good")
  @GetMapping("/good")
  @ResponseBody
  public Result good(Integer id) {
    Tag tag=tagService.selectById(topicService.selectById(id).getTagId());

    if (tag.getAdminId()==getAdminUser().getId()||getAdminUser().getRoleId()==1)
    {
      Topic topic = topicService.selectById(id);
      topic.setGood(!topic.getGood());
      topicService.update(topic);
      return success();
    }return error("没有加精权限");
  }

  @RequiresPermissions("topic:top")
  @GetMapping("/top")
  @ResponseBody
  public Result top(Integer id) {
    Tag tag=tagService.selectById(topicService.selectById(id).getTagId());
    if (tag.getAdminId()==getAdminUser().getId()||getAdminUser().getRoleId()==1)
    {
      Topic topic = topicService.selectById(id);
      topic.setTop(!topic.getTop());
      topicService.update(topic);
      return success();
    }return error("没有置顶权限");
  }

  @RequiresPermissions("topic:delete")
  @GetMapping("/delete")
  @ResponseBody
  public Result delete(Integer id) {
    Tag tag=tagService.selectById(topicService.selectById(id).getTagId());
    if (tag.getAdminId()==getAdminUser().getId()||getAdminUser().getRoleId()==1)
    {
      Topic topic = topicService.selectById(id);
      topicService.delete(topic, null);
      return success();
    }return error("没有删除权限");
  }

  @RequiresPermissions("topic:index")
  @GetMapping("/index")
  @ResponseBody
  public Result index(Integer id) {
    Topic topic = topicService.selectById(id);
    topicService.indexTopic(String.valueOf(topic.getId()), topic.getTitle(), topic.getContent());
    return success();
  }

  @RequiresPermissions("topic:index_all")
  @GetMapping("/index_all")
  @ResponseBody
  public Result index_all() {
    topicService.indexAllTopic();
    return success();
  }

  @RequiresPermissions("topic:delete_index")
  @GetMapping("/delete_index")
  @ResponseBody
  public Result delete_index(String id) { // ajax传过来的id，这用String接收，不用再转一次了
    topicService.deleteTopicIndex(id);
    return success();
  }

  @RequiresPermissions("topic:delete_all_index")
  @GetMapping("/delete_all_index")
  @ResponseBody
  public Result delete_all_index() {
    topicService.deleteAllTopicIndex();
    return success();
  }
}
