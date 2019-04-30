package co.yiiu.pybbs.controller.admin;

import co.yiiu.pybbs.mapper.AdminUserMapper;
import co.yiiu.pybbs.model.AdminUser;
import co.yiiu.pybbs.model.Plate;
import co.yiiu.pybbs.model.Tag;
import co.yiiu.pybbs.service.*;
import co.yiiu.pybbs.util.bcrypt.BCryptPasswordEncoder;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

/**
 * Created by tomoya.
 * Copyright (c) 2018, All Rights Reserved.
 * https://yiiu.co
 */
@Controller
@RequestMapping("/forum/admin/admin_user")
public class AdminUserAdminController extends BaseAdminController {

  @Autowired
  private AdminUserService adminUserService;
  @Autowired
  private RoleService roleService;
  @Autowired
  private TagService tagService;
  @Autowired
  private AdminUserMapper adminUserMapper;
  @Autowired
  private PlateServies plateServies;

  @RequiresPermissions("admin_user:list")
  @GetMapping("/list")
  public String list(Model model) {
    model.addAttribute("adminUsers", adminUserService.selectAll());
    return "admin/admin_user/list";
  }

  @RequiresPermissions("admin_user:add")
  @GetMapping("/add")
  public String add(Model model) {
    // 查询所有的角色
    model.addAttribute("roles", roleService.selectAll());
    // 查询所有的模块
    model.addAttribute("plate",plateServies.selectall());
    return "admin/admin_user/add";
  }

  @RequiresPermissions("admin_user:add")
  @PostMapping("/add")
  public String save(AdminUser adminUser) {
    adminUser.setInTime(new Date());
    adminUser.setPassword(new BCryptPasswordEncoder().encode(adminUser.getPassword()));
    adminUser.setTagId(0);
    adminUserService.insert(adminUser);
    return redirect("/admin/admin_user/list");
  }

  @RequiresPermissions("admin_user:edit")
  @GetMapping("/edit")
  public String edit(Integer id, Model model) {
    // 查询所有的角色
    model.addAttribute("roles", roleService.selectAll());
    List<Tag> tags = tagService.selectall();
    tags.add(tagService.selectById(adminUserService.selectById(id).getTagId()));
      model.addAttribute("tags",tags);
      model.addAttribute("adminUser", adminUserService.selectById(id));
    return "admin/admin_user/edit";
  }

  @RequiresPermissions("admin_user:edit")
  @PostMapping("/edit")
  public String edit(AdminUser adminUser) {
    if (StringUtils.isEmpty(adminUser.getPassword())) {
      adminUser.setPassword(null);
    } else {
      adminUser.setPassword(new BCryptPasswordEncoder().encode(adminUser.getPassword()));
    }

    adminUserService.update(adminUser);
    return redirect("/forum/admin/admin_user/list");
  }

  @RequiresPermissions("admin_user:delete")
  @GetMapping("/delete")
  public String delete(Integer id) {
    adminUserService.delete(id);
    return redirect("/forum/admin/admin_user/list");
  }

  @GetMapping("/detail/{name}")
  public String detail(@PathVariable String name, Model model) {
    model.addAttribute("adminUser", adminUserService.selectByUsername(name));
    return "admin/admin_user/detail";
  }
}
