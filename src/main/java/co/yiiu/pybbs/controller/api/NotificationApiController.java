package co.yiiu.pybbs.controller.api;

import co.yiiu.pybbs.model.User;
import co.yiiu.pybbs.service.NotificationService;
import co.yiiu.pybbs.service.UserService;
import co.yiiu.pybbs.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by tomoya.
 * Copyright (c) 2018, All Rights Reserved.
 * https://yiiu.co
 */
@RestController
@RequestMapping("/api/notification")
public class NotificationApiController extends BaseApiController {

  @Autowired
  private NotificationService notificationService;
  @Autowired
  private UserService userService;
  @GetMapping("/notRead")
  public Result notRead(HttpSession session) {
    User user = getApiUser();
    User user2 = (User) session.getAttribute("_user");
    String token=(String)session.getAttribute("_token");
    userService.refresh(user2.getOriginId(),token);
    return success(notificationService.countNotRead(user.getId()));
  }

  @GetMapping("/markRead")
  public Result markRead(HttpSession session) {
    User user = getApiUser();
    user.setMessage(0);
    userService.update(user);
    notificationService.markRead(user.getId());
    User user2 = (User) session.getAttribute("_user");
    String token=(String)session.getAttribute("_token");
    userService.refresh(user2.getOriginId(),token);
    return success();
  }

  // 通知列表
  @GetMapping("/list")
  public Result list(HttpSession session) {
    User user = getApiUser();
    // 未读消息列表
    List<Map<String, Object>> notReadNotifications = notificationService.selectByUserId(user.getId(), false, 20);
    // 已读消息列表
    List<Map<String, Object>> readNotifications = notificationService.selectByUserId(user.getId(), true, 20);
    Map<String, Object> map = new HashMap<>();
    map.put("notRead", notReadNotifications);
    map.put("read", readNotifications);
    User user2 = (User) session.getAttribute("_user");
    String token=(String)session.getAttribute("_token");
    userService.refresh(user2.getOriginId(),token);
    return success(map);
  }
}
