<#include "../layout/layout.ftl">
<@html page_title="用户添加" page_tab="auth_admin_user">
  <section class="content-header">
    <h1>
     用户
      <small>添加</small>
    </h1>
    <ol class="breadcrumb">
      <li><a href="/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
      <li><a href="/admin/user/list">用户</a></li>
      <li class="active">添加</li>
    </ol>
  </section>
  <section class="content">
    <div class="box box-info">
      <div class="box-header with-border">
        <h3 class="box-title">用户添加</h3>
      </div>
      <!-- /.box-header -->
      <div class="box-body">
        <div class="row">
          <div class="col-sm-6">
            <form id="form" action="/admin/admin_user/add" method="post">
              <div class="form-group">
                <label>用户名</label>
                <input type="text" id="username" name="username" class="form-control" placeholder="用户名">
              </div>
              <div class="form-group">
                <label>密码</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="密码">
              </div>
              <div class="form-group">
                <label>部门</label>
                <input type="text" id="department" name="department" class="form-control" placeholder="部门">
              </div>
              <div class="form-group">
                <label>邮箱</label>
                <input type="email" id="email" name="email" class="form-control" placeholder="邮箱">
              </div>
              <div class="form-group">
                <label>电话</label>
                <input type="number" id="phone" name="phone" class="form-control" placeholder="电话">
              </div>
              <div class="form-group">
                <label>角色</label>
                <p>
                  <#list roles as role>
                    <input type="radio" name="roleId" value="${role.id}" id="role_${role.id}">&nbsp;
                    <label for="role_${role.id}">${role.name!}</label>
                  </#list>
                </p>
              </div>
              <div class="form-group">
                <label>模块</label>
                <p>
                  <#list tags as tag>
                  <input type="radio" name="tagId" value="${tag.id}" id="tag_${tag.id}"
                  <#--<#if tag.id == adminUser.tagId>checked</#if>>&nbsp;-->
                  <label for="tag_${tag.id}">${tag.name!}</label>
                  </#list>
                </p>
              </div>
              <button type="submit" class="btn btn-xs btn-primary">保存</button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </section>
<script>
  $(function() {
    $("#form").submit(function() {
      var username = $("#username").val();
      var password = $("#password").val();
        var department = $("#department").val();
        var email = $("#email").val();
        var phone = $("#phone").val();
      var roleId = $("input[name='roleId']:checked").val();
        var tagId = $("input[name='tagId']:checked").val();
      if(!username) {
        toast('用户名不能为空');
        return false;
      }
      if(!password) {
        toast('密码不能为空');
        return false;
      }
      $.ajax({
        url: '/admin/admin_user/add',
        async: true,
        cache: false,
        type: 'post',
        dataType: 'json',
        data: {
          username: username,
          password: password,
            department:department,
            email:email,
            phone:phone,
          roleId: roleId,
            tagId: tagId
        }

      })
    })
  })
</script>
</@html>
