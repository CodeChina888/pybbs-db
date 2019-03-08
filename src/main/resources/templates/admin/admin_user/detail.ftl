<#include "../layout/layout.ftl">
<@html page_title="用户编辑" page_tab="auth_admin_user">
  <section class="content-header">
    <h1>
      用户
      <small>详情</small>
    </h1>
    <ol class="breadcrumb">
      <li><a href="/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
      <li><a href="/admin/user/list">用户</a></li>
      <li class="active">信息</li>
    </ol>
  </section>
  <section class="content">
    <div class="box box-info">
      <div class="box-header with-border">
        <h3 class="box-title">用户信息</h3>
      </div>
      <!-- /.box-header -->
      <div class="box-body">
        <div class="row">
          <div class="col-sm-6">

              <input type="hidden" name="id" value="${adminUser.id}">
              <div class="form-group">
                <label>用户名</label>
                <input type="text" id="username" name="username" value="${adminUser.username!}" class="form-control" placeholder="用户名">
              </div>
    <div class="form-group">
<label>部门</label>
<input type="text" id="department" name="department"value="${adminUser.department!}" class="form-control" placeholder="部门">
    </div>
    <div class="form-group">
<label>邮箱</label>
<input type="email" id="email" name="email" value="${adminUser.email!}" class="form-control" placeholder="邮箱">
    </div>
    <div class="form-group">
<label>电话</label>
<input type="number" id="phone" name="phone" value="${adminUser.phone!}" class="form-control" placeholder="电话">
    </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</@html>
