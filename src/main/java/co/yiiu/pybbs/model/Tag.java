package co.yiiu.pybbs.model;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import org.springframework.stereotype.Component;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by tomoya.
 * Copyright (c) 2018, All Rights Reserved.
 * https://yiiu.co
 */
@Component
public class Tag implements Serializable {
  private static final long serialVersionUID = 3257790983905872243L;
  @TableId(type = IdType.AUTO)
  private Integer id;
  private String name;
  private String description;
  // 当前标签下的话题个数
  private Integer topicCount;
  private Date inTime;
  private  Integer adminId;
  private String adminName;

  public String getAdminName()
  {
    return adminName;
  }

  public void setAdminName(String adminName)
  {
    this.adminName = adminName;
  }

  public Integer getAdminId()
  {
    return adminId;
  }

  public void setAdminId(Integer adminId)
  {
    this.adminId = adminId;
  }

  public Date getInTime() {
    return inTime;
  }

  public void setInTime(Date inTime) {
    this.inTime = inTime;
  }

  public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public Integer getTopicCount() {
    return topicCount;
  }

  public void setTopicCount(Integer topicCount) {
    this.topicCount = topicCount;
  }

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }


}
