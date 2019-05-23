<#include "../layout/layout.ftl">
<@html page_title="软件列表" page_tab="software">
    <section class="content-header">
        <h1>
            软件
            <small>列表</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="/forum/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li><a href="/forum/softwareCenter/list">软件</a></li>
            <li class="active">列表</li>
        </ol>
  </section>
  <section class="content">
      <div class="box box-info">
          <div class="box-header with-border">
              <h3 class="box-title">软件中心</h3>
              <#if sec.hasPermission('document:add')>
                  <a href="/forum/softwareCenter/add" class="btn btn-xs btn-primary pull-right">上传软件</a>
              </#if>
          </div>
          <!-- /.box-header -->
          <div class="box-body">
              <table class="table table-bordered">
                  <thead>
                  <tr>
                      <th>软件名称</th>
                      <th>产品归属</th>
                      <th>版本</th>
                      <th>描述</th>
                      <th>上传时间</th>
                      <th>操作</th>
                  </tr>
                  </thead>
              <tbody>
          <#list page.records as record>
          <tr>
              <th>${record.originName}</th>
              <th>${record.category}</th>
              <th>${record.version}</th>
              <th>${record.description}</th>
              <td>${record.inTime?string('yyyy-MM-dd HH:mm:ss')}</td>
              <td>
                  <#if sec.hasPermission("software:delete")>
                      <button onclick="deleteBtn('${record.code}')" class="btn btn-xs btn-danger">删除</button>
                  </#if>
                  <#if sec.hasPermission("software:edit")>
                      <a href="/forum/softwareCenter/edit/${record.code}" class="btn btn-xs btn-warning">编辑</a>
                  </#if>
              </td>
          </tr>
          </#list>
              </tbody>
              </table>
          </div>
      </div>
      <script>
          <#if sec.hasPermission("software:delete")>
          function deleteBtn(code) {
              if (confirm('确定要删除这个软件吗？')) {
                  $.get("/forum/softwareCenter/delete/" + code, function (data) {
                      if (data.code === 200) {
                          toast("成功", "success");
                          setTimeout(function () {
                              window.location.reload();
                          }, 700);
                      } else {
                          toast(data.description);
                      }
                  })
              }
          }
          </#if>

      </script>
  <#include "../layout/paginate.ftl">
    <@paginate currentPage=page.current totalPage=page.pages actionUrl="/forum/softwareCenter/list" urlParas=""/>
  </section>
</@html>
