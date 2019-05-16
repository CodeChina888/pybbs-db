<#include "../layout/layout.ftl">
<@html page_title="软件编辑" page_tab="software">
  <section class="content-header">
  </section>
  <section class="content">
    <div class="box box-info">
      <!-- /.box-header -->
      <div class="box-body">
        <form id="form" action="/forum/admin/software/edit" method="post" enctype="multipart/form-data">
           <input type="hidden" name="id" value="${software.id}">
          <div class="form-group">
            <label>软件名称</label>
            <input type="text" name="originName" value="${software.originName!}" class="form-control">
          </div>
            <label>分类</label>
               <div class="form-group">
                <span >
                <select name="categorys">
                <#list categorys as category>
                   <option name="categorys" value ="${category.id}"
                   <#if software.categoryId?? && software.categoryId == category.id>selected</#if>
                   >${category.name!}</option>
                </#list>
                </select>
                </span>
               </div>
            <!--<input type="text" name="url" value="${software.url!}" class="form-control">-->
          <div class="form-group">
            <label>版本号</label>
            <input type="text" name="version" value="${software.version!}" class="form-control">
          </div>
          <label>标签</label>
        <div class="form-group">
        <span >
        <select name="label" multiple="multiple">
           <#list labels as label>
                  <option name="label" value ="${label.id}">${label.name!}</option>
           </#list>
        </select>
        </span>
        </div>
      <div class="form-group">
       <label for="">描述</label>
       <textarea name="description" rows="7" class="form-control">${software.description!}</textarea>
      </div>
          <button type="submit" id="btn" class="btn btn-primary">提交</button>
        </form>
      </div>
    </div>
  </section>
</@html>
