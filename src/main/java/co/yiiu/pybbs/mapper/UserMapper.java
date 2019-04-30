package co.yiiu.pybbs.mapper;

import co.yiiu.pybbs.model.User;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.springframework.stereotype.Component;

/**
 * Created by tomoya.
 * Copyright (c) 2018, All Rights Reserved.
 * https://yiiu.co
 */
@Component
public interface UserMapper extends BaseMapper<User> {
  int countToday();

  User selectByoriginId(Integer id);

  Integer isExist(Integer id);
}
