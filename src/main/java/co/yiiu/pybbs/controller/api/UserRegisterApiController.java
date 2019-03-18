package co.yiiu.pybbs.controller.api;

import co.yiiu.pybbs.controller.front.BaseController;
import co.yiiu.pybbs.model.User;
import co.yiiu.pybbs.service.SystemConfigService;
import co.yiiu.pybbs.service.UserService;
import co.yiiu.pybbs.util.CookieUtil;
import co.yiiu.pybbs.util.HttpClient;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@RestController
@RequestMapping("/api/v1/forum")
public class UserRegisterApiController extends BaseController {
    @Autowired
    private UserService userService;
    @Autowired
    private CookieUtil cookieUtil;
    @Autowired
    private SystemConfigService systemConfigService;


    @PostMapping("/register")
    public String register(String token,HttpSession session){
        String url="http://service.adl.io/memcenter/api/v1/inner/auth/validateAuth";
        String json= HttpClient.sendPostRequest(url,null,token);
        JSONObject jsonObject= JSON.parseObject(json);
        String data=jsonObject.getString("data");
        JSONObject dataObjects= JSON.parseObject(data);
        String row =dataObjects.getString("row");
        JSONObject rowObject= JSON.parseObject(row);
        String id=rowObject.getString("id");
        String avatar=rowObject.getString("avatar");
        String username=rowObject.getString("username");
        if(!userService.hasPermission(Integer.valueOf(id))){
            System.out.println("权限访问失败");
            return render("components/error");
        }
        User user;
//        user.setOriginId(Integer.valueOf(id));
        session.setAttribute("_token",token);
        session.setAttribute("_originId",id);
        System.out.println("当前sessionID:"+session.getId());
        if(userService.isExist(Integer.valueOf(id))){
            user=userService.selectByoriginId(Integer.valueOf(id));
//            System.out.println(user.toString());
            doUserStorage(session,user);
            userService.refresh(Integer.valueOf(id),token);
            System.out.println("你已经注册过帐号了");
        }else{
            user=userService.addUser(Integer.valueOf(id),username,"123456",avatar,null, null);
            doUserStorage(session, user);
            userService.refresh(Integer.valueOf(id),token);
        }
//        return "index";
        return render("components/error");
    }

    // 登录成功后，处理的逻辑一样，这里提取出来封装一个方法处理
    private void doUserStorage(HttpSession session, User user) {
        // 将用户信息写session
        if (session != null) {
            session.setAttribute("_user", user);
        }
        // 将用户token写cookie
        cookieUtil.setCookie(systemConfigService.selectAllConfig().get("cookie_name").toString(), user.getToken());
    }
}
