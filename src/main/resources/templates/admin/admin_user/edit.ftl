<#include "../layout/layout.ftl">
<@html page_title="用户编辑" page_tab="auth_admin_user">
  <section class="content-header">
    <h1>
      用户
      <small>编辑</small>
    </h1>
    <ol class="breadcrumb">
      <li><a href="/forum/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
      <li><a href="/forum/admin/user/list">用户</a></li>
      <li class="active">编辑</li>
    </ol>
  </section>
  <section class="content">
    <div class="box box-info">
      <div class="box-header with-border">
        <h3 class="box-title">用户编辑</h3>
      </div>
      <!-- /.box-header -->
      <div class="box-body">
        <div class="row">
          <div class="col-sm-6">
            <form id="form" action="/forum/admin/admin_user/edit" method="post">
              <input type="hidden" name="id" value="${adminUser.id}">
              <div class="form-group">
                <label>用户名</label>
                <input type="text" id="username" name="username" value="${adminUser.username!}" class="form-control" placeholder="用户名">
              </div>
              <div class="form-group">
                <label>新密码（若需要更改密码，直接输入即可，否则不需要填写）</label>
                <input type="password" id="password" name="password" class="form-control"  placeholder="密码">
              </div>
              <div class="form-group">
                <label>角色</label>
                <p>
                  <#list roles as role>
                    <input type="radio" name="roleId" value="${role.id}" id="role_${role.id}"
                           <#if role.id == adminUser.roleId>checked</#if>>&nbsp;
                    <label for="role_${role.id}">${role.name!}</label>
                  </#list>
                </p>
              </div>
<#--              <div class="form-group">-->
<#--                  <#if adminUser.roleId !=1>-->
<#--                    <label>模块</label>-->
<#--                    <p>-->
<#--                    <#list plate as plate>-->
<#--                    <input type="radio" name="tagId" value="${plate.id}" id="tag_${plate.id}"-->
<#--                    <#if plate.id == adminUser.tagId>checked</#if>>&nbsp;-->
<#--                    <label for="tag_${plate.id}">${plate.name!"还没添加板块"}</label>-->
<#--                    </#list>-->
<#--                  </#if>-->
<#--                </p>-->
<#--              </div>-->
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
       //var oldPassword = $("#oldPassword").val();
      var password = $("#password").val();
        var department = $("#department").val();
        var email = $("#email").val();
        var phone = $("#phone").val();
      var roleId = $("input[name='roleId']:checked").val();
        var tagId = $("input[name='tagId']:checked").val();
      if(!username) {
        toast('用户名不能为空');
      }
      $.ajax({
        url: '/forum/admin/admin_user/edit',
        async: true,
        cache: false,
        type: 'post',
        dataType: 'json',
        data: {
          id: '${adminUser.id}',
          username: username,
          password: password,
            department:department,
            email:email,
            phone:phone,
          roleId: roleId,
            tagId:tagId
        }
    })
  })
</script>
</@html>
