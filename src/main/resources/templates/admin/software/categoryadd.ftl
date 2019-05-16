<#include "../layout/layout.ftl">
<@html page_title="软件分类" page_tab="software">
  <section class="content-header">
    <h1>
      <small>列表</small>
    </h1>
    <ol class="breadcrumb">
      <li><a href="/forum/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
      <li><a href="/forum/admin/software/categorylist">软件</a></li>
      <li class="active">分类</li>
    </ol>
  </section>
  <section class="content">
    <div class="box box-info">
      <div class="box-header with-border">
        <h3 class="box-title">软件分类</h3>
      </div>
      <div class="box-body">
        <form id="form" action="/forum/admin/software/categoryadd" method="post" enctype="multipart/form-data">
          <input type="hidden" value="${cgId!0}" name="cgId">
          <input type="hidden" value="${layer!0}" name="layer">
          <div class="form-group">
            <label>名称</label>
            <input type="text" name="name" value="" class="form-control">
          </div>
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
