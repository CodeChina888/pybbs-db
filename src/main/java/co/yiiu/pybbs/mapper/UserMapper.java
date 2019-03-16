package co.yiiu.pybbs.mapper;

import co.yiiu.pybbs.model.User;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * Created by tomoya.
 * Copyright (c) 2018, All Rights Reserved.
 * https://yiiu.co
 */
public interface UserMapper extends BaseMapper<User> {
  int countToday();

  User selectByoriginId(Integer id);

  Integer isExist(Integer id);
}
