package co.yiiu.pybbs.controller.api;

import co.yiiu.pybbs.model.User;
import co.yiiu.pybbs.service.SystemConfigService;
import co.yiiu.pybbs.service.UserService;
import co.yiiu.pybbs.util.CookieUtil;
import co.yiiu.pybbs.util.HttpClient;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/api/v1/forum")
public class UserRegisterApiController {
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
//        String phone=rowObject.getString("phone");
//        String level=rowObject.getString("level");
        String id=rowObject.getString("id");
        session.setAttribute("originid",id);
        String avatar=rowObject.getString("avatar");
        String username=rowObject.getString("username");
        if(!userService.hasPermission(Integer.valueOf(id))){
            System.out.println("权限访问失败");
            return "components/error";
        }
        User user;
        if(userService.isExist(Integer.valueOf(id))){
            user=userService.selectByoriginId(Integer.valueOf(id));
            System.out.println("originid:"+user.getOriginId());
            doUserStorage(session, user);
            userService.refresh(Integer.parseInt(id));
            System.out.println("你已经注册过帐号了");
            return "index";
        }
        user=userService.addUser(Integer.valueOf(id),username,"123456",avatar,null, null);
        doUserStorage(session, user);
        return "index";
    }

    // 登录成功后，处理的逻辑一样，这里提取出来封装一个方法处理
    private void doUserStorage(HttpSession session, User user) {
        // 将用户信息写session
        if (session != null) {
            session.setAttribute("_user", user);
        }
        // 将用户token写cookie
        cookieUtil.setCookie(systemConfigService.selectAllConfig().get("cookie_name").toString(), user.getToken());
        System.out.println("当前session用户为:"+session.getAttribute("_user"));
//        Map<String, Object> map = new HashMap<>();
//        map.put("user", user);
//        map.put("token", user.getToken());
    }

}
