<#include "../layout/layout.ftl">
<@html page_title="软件添加" page_tab="software">
  <section class="content-header">
    <h1>
      <small>列表</small>
    </h1>
    <ol class="breadcrumb">
      <li><a href="/forum/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
      <li><a href="/forum/admin/software/categorylist">软件</a></li>
      <li class="active">添加</li>
    </ol>
  </section>
  <section class="content">
    <div class="box box-info">
      <div class="box-header with-border">
        <h3 class="box-title">软件添加</h3>
      </div>
      <!-- /.box-header -->
      <div class="box-body">
        <form id="form" action="/forum/admin/software/add" method="post" enctype="multipart/form-data">
          <input type="hidden" value="${categoryId}" name="categoryId">
          <div class="form-group">
            <label>上传文件</label>
            <input type="file" name="file" value="" class="form-control">
          </div>
          <input type="hidden" name="path" value="${path}" class="form-control">
          <div class="form-group">
            <label>版本号</label>
            <input type="text" name="version" value="" class="form-control">
          </div>
        <div class="form-group">
        <span >
        <select name="label" multiple="multiple">
           <#list Labels as label>
             <option name="label" value ="${label.id}">${label.name!}</option>
           </#list>
        </select>
        </span>
            <div class="form-group">
            <label for="">描述</label>
            <textarea name="description" rows="7" class="form-control"></textarea>
          </div>
          <button type="submit" id="btn" class="btn btn-primary">提交</button>
        </form>
      </div>
    </div>
  </section>
</@html>
