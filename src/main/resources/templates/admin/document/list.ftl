<#include "../layout/layout.ftl">
<@html page_title="文档中心" page_tab="document">
  <section class="content-header">
      <h1>
          文档
          <small>中心</small>
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
          <a href="/forum/documentCenter/add" class="btn btn-xs btn-primary pull-right">文档上传</a>
        </#if>
          </div>
          <!-- /.box-header -->
          <div class="box-body">
              <table class="table table-bordered">
                  <thead>
                  <tr>
                      <th>ID</th>
                      <th>文档类别</th>
                      <th>文档种类</th>
                      <th>文档分类</th>
                      <th>文档名称</th>
                      <th>文档路径</th>
                      <th>访问路径</th>
                      <th>上传时间</th>
                  </tr>
                  </thead>
              <tbody>
          <#list page.records as record>
          <tr>
              <td>${record.id}</td>
              <td>${record.documentClass!}</td>
              <td>${record.documentType!}</td>
              <td>${record.documentClassify!}</td>
              <td>${record.documentName!}</td>
              <td>${record.url!}</td>
              <td>${record.path!}</td>
              <td>${record.inTime?string('yyyy-MM-dd HH:mm:ss')}</td>
          </tr>
          </#list>
              </tbody>
              </table>
          </div>
      </div>
  <#include "../layout/paginate.ftl">
    <@paginate currentPage=page.current totalPage=page.pages actionUrl="/forum/documentCenter/list" urlParas=""/>
  </section>
</@html>
