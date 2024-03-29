package co.yiiu.pybbs.controller.front;

import co.yiiu.pybbs.model.OAuthUser;
import co.yiiu.pybbs.model.User;
import co.yiiu.pybbs.service.CollectService;
import co.yiiu.pybbs.service.NotificationService;
import co.yiiu.pybbs.service.OAuthUserService;
import co.yiiu.pybbs.service.UserService;
import co.yiiu.pybbs.util.aop.MyLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by tomoya.
 * Copyright (c) 2018, All Rights Reserved.
 * https://yiiu.co
 */
@Controller
@RequestMapping("/forum/user")
public class UserController extends BaseController {

  @Autowired
  private UserService userService;
  @Autowired
  private CollectService collectService;
  @Autowired
  private OAuthUserService oAuthUserService;
  @Autowired
  NotificationService notificationService;

  @GetMapping("/{username}")
  public String profile(@PathVariable String username, Model model, HttpSession session) {
    // 查询用户个人信息
    User user = userService.selectByUsername(username);
    // 查询oauth登录的用户信息
    List<OAuthUser> oAuthUsers = oAuthUserService.selectByUserId(user.getId());
    // 查询用户收藏的话题数
    Integer collectCount = collectService.countByUserId(user.getId());

    user.setMessage(notificationService.countNotRead(user.getId()));
    // 找出oauth登录里有没有github，有的话把github的login提取出来
    List<String> logins = oAuthUsers.stream().filter(oAuthUser -> oAuthUser.getType().equals("GITHUB")).map(OAuthUser::getLogin).collect(Collectors.toList());
    if (logins.size() > 0) {
      model.addAttribute("githubLogin", logins.get(0));
    }
    model.addAttribute("user", user);
    model.addAttribute("username", username);
    model.addAttribute("oAuthUsers", oAuthUsers);
    model.addAttribute("collectCount", collectCount);
    User users = (User) session.getAttribute("_user");
    String token=(String)session.getAttribute("_token");
    userService.refresh(users.getOriginId(),token);
    return render("user/profile");
  }
  @GetMapping("/{username}/topics")
  public String topics(@PathVariable String username, @RequestParam(defaultValue = "1") Integer pageNo, Model model,HttpSession session) {
    User user = (User) session.getAttribute("_user");
    String token=(String)session.getAttribute("_token");
    userService.refresh(user.getOriginId(),token);
    model.addAttribute("username", username);
    model.addAttribute("pageNo", pageNo);
    return render("user/topics");
  }

  @GetMapping("/{username}/comments")
  public String comments(@PathVariable String username, @RequestParam(defaultValue = "1") Integer pageNo, Model model,HttpSession session) {
    model.addAttribute("username", username);
    User user = (User) session.getAttribute("_user");
    String token=(String)session.getAttribute("_token");
    userService.refresh(user.getOriginId(),token);
    model.addAttribute("pageNo", pageNo);
    return render("user/comments");
  }


  @GetMapping("/{username}/collects")
  public String collects(@PathVariable String username, @RequestParam(defaultValue = "1") Integer pageNo, Model model,HttpSession session) {
    model.addAttribute("username", username);
    model.addAttribute("pageNo", pageNo);
    User user = (User) session.getAttribute("_user");
    String token=(String)session.getAttribute("_token");
    userService.refresh(user.getOriginId(),token);
    return render("user/collects");
  }
}
