package co.yiiu.pybbs.model;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by tomoya.
 * Copyright (c) 2018, All Rights Reserved.
 * https://yiiu.co
 */
@Data
public class AdminUser implements Serializable {

  private static final long serialVersionUID = 8264158018518861440L;
  @TableId(type = IdType.AUTO)
  private Integer id;
  private String username;
  private String password;
  private Date inTime;
  private Integer roleId;
  private Integer tagId;
  private Integer plate_id;
}
