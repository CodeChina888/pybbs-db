package co.yiiu.pybbs.util.aop;

import java.lang.annotation.*;
@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface ServiceLogs {
    String description() default "";
}
