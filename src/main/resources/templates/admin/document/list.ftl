<#include "../layout/layout.ftl">
<@html page_title="文档中心" page_tab="document">
  <section class="content-header">
      <h1>
          文档
          <small>列表</small>
      </h1>
      <ol class="breadcrumb">
          <li><a href="/forum/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
          <li><a href="/forum/documentCenter/list">文档</a></li>
          <li class="active">中心</li>
      </ol>
  </section>
  <section class="content">
      <div class="box box-info">
          <div class="box-header with-border">
              <h3 class="box-title">文档中心</h3>
              <#if sec.hasPermission('document:add')>
                  <a href="/forum/documentCenter/add" class="btn btn-xs btn-primary pull-right">上传文档</a>
              </#if>
          </div>
          <!-- /.box-header -->
          <div class="box-body">
              <table class="table table-bordered">
                  <thead>
                  <tr>
                      <th>文档名称</th>
                      <th>产品归属</th>
                      <th>上传时间</th>
                      <th>操作</th>
                  </tr>
                  </thead>
              <tbody>
          <#list page.records as record>
          <tr>
              <th>${record.originName}</th>
              <th>${record.category}</th>
              <td>${record.inTime?string('yyyy-MM-dd HH:mm:ss')}</td>
              <td>
                  <#if sec.hasPermission("document:delete")>
                      <button onclick="deleteBtn('${record.code}')" class="btn btn-xs btn-danger">删除</button>
                  </#if>
                  <#if sec.hasPermission("document:edit")>
                      <a href="/forum/documentCenter/edit/${record.code}" class="btn btn-xs btn-warning">编辑</a>
                  </#if>
              </td>
          </tr>
          </#list>
              </tbody>
              </table>
          </div>
      </div>
      <script>
          <#if sec.hasPermission("document:delete")>
          function deleteBtn(code) {
              if (confirm('确定要删除这个文档吗？')) {
                  $.get("/forum/documentCenter/delete/" + code, function (data) {
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
    <@paginate currentPage=page.current totalPage=page.pages actionUrl="/forum/documentCenter/list" urlParas=""/>
  </section>
</@html>
