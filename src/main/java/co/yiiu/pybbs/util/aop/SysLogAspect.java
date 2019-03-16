package co.yiiu.pybbs.util.aop;

import co.yiiu.pybbs.model.Record;
import co.yiiu.pybbs.model.User;
import co.yiiu.pybbs.service.RecordService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.Map;

/**
 * 系统日志：切面处理类
 */
@Aspect
@Component
public class SysLogAspect {
    @Autowired
    private RecordService recordService;

    @Pointcut("@annotation(co.yiiu.pybbs.util.aop.MyLog)")
    public void Pointcut(){

    }

    @AfterReturning(pointcut = "Pointcut()")
    public void saveSysLog(JoinPoint joinPoint)
    {
        Record record=new Record();
        //从切面织入点处通过反射机制获取织入点处的方法
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        //获取切入点所在的方法
        Method method = signature.getMethod();

        MyLog myLog = method.getAnnotation(MyLog.class);
        if (myLog != null) {
            String value = myLog.value();
            record.setOperation(value);//保存获取的操作
        }

        //获取请求的类名
        String className = joinPoint.getTarget().getClass().getName();
        //获取请求的方法名
        String methodName = method.getName();
//        record.setMethod(className + "." + methodName);
        record.setMethod(methodName);

        //请求的参数
        Object[] args = joinPoint.getArgs();
        Object[] arguments=new Object[args.length];
        for(int i=0;i<args.length;i++){
            if(args[i] instanceof ServletRequest ||args[i] instanceof ServletResponse||args[i] instanceof MultipartFile)
            {
                continue;
            }
            arguments[i]=args[i];
        }
        //将参数所在的数组转换成json
        String params = "";
       if(arguments!=null){
           params=JSON.toJSONString(arguments);
           JSONArray jsonObject=JSONObject.parseArray(params);
           record.setParams(jsonObject.get(0).toString());
//           String param=jsonObject.toString();
//           if(param.contains("lastAccessedTime"))
//               record.setParams(jsonObject.get(0).toString());
//           else
//               record.setParams(jsonObject.toJSONString());
        }
        record.setInTime(new Date());
        //从session中获得当前用户名
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession();
        User user=(User)session.getAttribute("_user");
        record.setUsername(user.getUsername());
        record.setOriginId(user.getOriginId());
        recordService.insert(record);
    }

}
