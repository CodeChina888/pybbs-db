package co.yiiu.pybbs.controller.front;

import co.yiiu.pybbs.model.Data;
import co.yiiu.pybbs.model.Message;
import co.yiiu.pybbs.model.User;
import co.yiiu.pybbs.service.SystemConfigService;
import co.yiiu.pybbs.service.UserService;
import co.yiiu.pybbs.util.CookieUtil;
import co.yiiu.pybbs.util.HttpClient;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Locale;

/**
 * Created by tomoya.
 * Copyright (c) 2018, All Rights Reserved.
 * https://yiiu.co
 */
@Controller
@RequestMapping("/forum")
public class IndexController extends BaseController {

  private Logger log = LoggerFactory.getLogger(IndexController.class);

  @Autowired
  private CookieUtil cookieUtil;
  @Autowired
  private SystemConfigService systemConfigService;
  @Autowired
  private UserService userService;
  @Value("${spring.tokenurl}")
  private String tokenUrl;
  @Autowired
  private User user;

  // 首页
  @GetMapping({"", "/index", "/index.html"})
  public String index(@RequestParam(defaultValue = "all") String tab, @RequestParam(defaultValue = "1") Integer pageNo, Model model,HttpSession session,String token) {
    model.addAttribute("tab", tab);
    model.addAttribute("pageNo", pageNo);
    if(token!=null){
      String url=tokenUrl+"/memcenter/api/v1/inner/auth/validateAuth";
      String json= HttpClient.sendPostRequest(url,null,token);
      JSONObject jsonObject= JSON.parseObject(json);
      String code=jsonObject.getString("code");
      if(code.equals("40401")){
        log.error("----TokenError----");
        return render("tokenError");
      }
      String data=jsonObject.getString("data");
      JSONObject dataObjects= JSON.parseObject(data);
      String row =dataObjects.getString("row");
      JSONObject rowObject= JSON.parseObject(row);
      String id=rowObject.getString("id");
      String avatar=rowObject.getString("avatar");
      String username=rowObject.getString("username");
      if(!userService.hasPermission(Integer.valueOf(id))){
        log.error("----NoPermission----");
        return render("components/error");
      }
      session.setAttribute("_token",token);
      if(userService.isExist(Integer.valueOf(id))){
        user=userService.selectByoriginId(Integer.valueOf(id));
        Message<Data> message = userService.userMessage(user.getOriginId());
        user.setAvatar(message.getData().getRow().getAvatar());
        user.setUsername(message.getData().getRow().getUsername());
        userService.update(user);
        session.setAttribute("_user", user);
        log.error("----IsAuthenticated----");
        return render("index");
      }
      user=userService.addUser(Integer.valueOf(id),username,"123456",avatar,null, null);
      session.setAttribute("_user", user);
    }
    return render("index");
  }

  @GetMapping("/top100")
  public String top100(HttpSession session) {
      User user = (User) session.getAttribute("_user");
      String token=(String)session.getAttribute("_token");
      userService.refresh(user.getOriginId(),token);
    return render("top100");
  }

  @GetMapping("/error")
  public String error(){
    return render("components/error");
  }

  @GetMapping("/tokenError")
  public String tokenError(){
    return render("tokenError");
  }

  @GetMapping("/tags")
  public String tags(@RequestParam(defaultValue = "1") Integer pageNo, Model model,HttpSession session) {
    model.addAttribute("pageNo", pageNo);
    User user = (User) session.getAttribute("_user");
    String token=(String)session.getAttribute("_token");
    if (user!=null && token!=null)
      userService.refresh(user.getOriginId(),token);
    return render("tag/tags");
  }

  // 登录
  @GetMapping("/login")
  public String login() {
    return render("login");
  }

  // 注册
  @GetMapping("/register")
  public String register() {
    return render("register");
  }

  // 通知
  @GetMapping("/notifications")
  public String notifications() {
    return render("notifications");
  }

  // 登出
  @GetMapping("/logout")
  public String logout(HttpSession session) {
    if (session.getAttribute("_user") != null) {
      User user = (User) session.getAttribute("_user");
      // 清除redis里的缓存
      userService.delRedisUser(user);
      // 清除session里的用户信息
      session.removeAttribute("_user");
      session.removeAttribute("_token");
      // 清除cookie里的用户token
      cookieUtil.clearCookie(systemConfigService.selectAllConfig().get("cookie_name").toString());
    }
    return redirect("/forum");
  }

  // 登录后台
  @GetMapping("/adminlogin")
  public String adminlogin() {
    Subject subject = SecurityUtils.getSubject();
    if (subject.isAuthenticated()) return redirect("/forum/admin/index");
    return "admin/login";
  }

  // 处理后台登录逻辑
  @PostMapping("/adminlogin")
  public String adminlogin(String username, String password, String code, HttpSession session,
                           @RequestParam(defaultValue = "0") Boolean rememberMe,
                           RedirectAttributes redirectAttributes) {
    String captcha = (String) session.getAttribute("_captcha");
    if (captcha == null || StringUtils.isEmpty(code) || !captcha.equalsIgnoreCase(code)) {
      redirectAttributes.addFlashAttribute("error", "验证码不正确");
    } else {
      try {
        // 添加用户认证信息
        Subject subject = SecurityUtils.getSubject();
        if (!subject.isAuthenticated()) {
          UsernamePasswordToken token = new UsernamePasswordToken(username, password, rememberMe);
          //进行验证，这里可以捕获异常，然后返回对应信息
          subject.login(token);
        }
      } catch (AuthenticationException e) {
        log.error(e.getMessage());
        redirectAttributes.addFlashAttribute("error", "用户名或密码错误");
        redirectAttributes.addFlashAttribute("username", username);
        return redirect("/forum/adminlogin");
      }
    }
    return redirect("/forum/admin/index");
  }

  @GetMapping("/software/categorylist")
  public String software(@RequestParam(defaultValue = "1") Integer pageNo, Model model){
    model.addAttribute("pageNo",pageNo);
    return render("software/categorylist");
  }

  @GetMapping("/search")
  public String search(@RequestParam(defaultValue = "1") Integer pageNo, @RequestParam String keyword, Model model) {
    Assert.isTrue(systemConfigService.selectAllConfig().get("search").toString().equals("1"), "网站没有启动搜索功能，联系站长问问看");
    model.addAttribute("pageNo", pageNo);
    model.addAttribute("keyword", keyword);
    return render("search");
  }

  // 切换语言
  @GetMapping("changeLanguage")
  public String changeLanguage(String lang, HttpSession session, HttpServletRequest request) {
    String referer = request.getHeader("referer");
    if ("zh".equals(lang)) {
      session.setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.SIMPLIFIED_CHINESE);
    } else if ("en".equals(lang)) {
      session.setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.US);
    }
    return StringUtils.isEmpty(referer) ? redirect("/") : redirect(referer);
  }
}
