<#include "../layout/layout.ftl">
<@html page_title="分类中心" page_tab="category">
  <section class="content-header">
      <h1>
          分类标签
          <small>管理</small>
      </h1>
      <ol class="breadcrumb">
          <li><a href="/forum/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
          <li><a href="/forum/category/list">分类标签</a></li>
          <li class="active">管理</li>
      </ol>
  </section>
  <section class="content">
      <div class="box box-info">
          <div class="box-header with-border">
              <a href="/forum/category/list"><h3 class="box-title">分类标签</h3></a>
              <a href="/forum/documentCategory/list"><h3 class="box-title">分类标签管理</h3></a>
              <#if sec.hasPermission('DocumentCategory:add')>
                  <a href="/forum/documentCategory/add" class="btn btn-xs btn-primary pull-right">添加</a>
              </#if>
          </div>
          <!-- /.box-header -->
          <div class="box-body">
              <table class="table table-bordered">
                  <thead>
                  <tr>
                      <th>分类名称</th>
                      <th>分类所属</th>
                      <th>操作</th>
                  </tr>
                  </thead>
              <tbody>

          <#list category as category>
          <tr>
              <td>${category.name}</td>
              <td>${category.PName}</td>
              <td>
                  <#if sec.hasPermission("DocumentCategory:delete")>
                      <button onclick="deleteBtn('${category.id}')" class="btn btn-xs btn-danger">删除</button>
                  </#if>
                  <#if sec.hasPermission("DocumentCategory:edit")>
                      <a href="/forum/documentCategory/edit/${category.id}" class="btn btn-xs btn-warning">编辑</a>
                  </#if>
              </td>
          </tr>

          </#list>
              </tbody>
              </table>
          </div>
      </div>
      <script>
          <#if sec.hasPermission("DocumentCategory:delete")>
          function deleteBtn(code) {
              if (confirm('确定要删除这个分类吗？')) {
                  $.get("/forum/documentCategory/delete?id=" + code, function (data) {
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
      <@paginate currentPage=page.current totalPage=page.pages actionUrl="/forum/category/list" urlParas=""/>
  </section>
</@html>
