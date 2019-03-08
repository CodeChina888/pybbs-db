<#include "../layout/layout.ftl">
<@html page_title="板块添加" page_tab="tag">
  <section class="content-header">
    <h1>
      <small>列表</small>
    </h1>
    <ol class="breadcrumb">
      <li><a href="/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
      <li><a href="/admin/tag/list">板块</a></li>
      <li class="active">添加</li>
    </ol>
  </section>
  <section class="content">
    <div class="box box-info">
      <div class="box-header with-border">
        <h3 class="box-title">板块添加</h3>
      </div>
      <!-- /.box-header -->
      <div class="box-body">
        <form id="form" action="/admin/tag/add" method="post" enctype="multipart/form-data">
          <#--<input type="hidden" value="${tag.id}" name="id">-->
          <div class="form-group">
            <label>名称</label>
            <input type="text" name="name" value="" class="form-control">
          </div>
          <#--<div class="form-group">-->
            <#--<label>话题数</label>-->
            <#--<input type="number" pattern="\d" name="topicCount" value="${tag.topicCount!}" class="form-control">-->
          <#--</div>-->
          <#--<div class="form-group">-->
            <#--<label>Icon</label>-->
            <#--<input type="file" name="file" class="form-control"><br>-->
            <#--<#if tag.icon??>-->
              <#--<img src="${tag.icon!}" width="50" alt="">-->
            <#--</#if>-->
          <#--</div>-->
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
