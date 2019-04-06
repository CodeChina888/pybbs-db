<#include "../layout/layout.ftl">
<@html page_title="日志列表" page_tab="record">
  <section class="content-header">
    <h1>
        日志
      <small>列表</small>
    </h1>
    <ol class="breadcrumb">
      <li><a href="/forum/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
      <li><a href="/forum/admin/record/list">日志</a></li>
      <li class="active">列表</li>
    </ol>
  </section>
  <section class="content">
    <div class="box box-info">
      <div class="box-header with-border">
        <h3 class="box-title">日志列表</h3>
      </div>
      <!-- /.box-header -->
      <div class="box-body">
        <table class="table table-bordered table-striped">
          <thead>
          <tr>
              <th>Id</th>
              <th>用户Id</th>
              <th>用户名</th>
              <th>操作</th>
              <th>操作对象</th>
              <th>内容</th>
              <th>日期</th>
          </tr>
          </thead>
          <tbody>
          <#list page.records as record>
            <tr>
              <td>${record.id}</td>
              <td>${record.originId}</td>
              <td>${record.username}</td>
              <td>${record.operation}</td>
              <td>${record.method}</td>
              <td>${record.params}</td>
              <td>${record.inTime?string('yyyy-MM-dd HH:mm:ss')}</td>
            </tr>
          </#list>
          </tbody>
        </table>
      </div>
    </div>
    <#include "../layout/paginate.ftl">
    <@paginate currentPage=page.current totalPage=page.pages actionUrl="/forum/admin/record/list" urlParas=""/>
  </section>
</@html>
