<#include "../layout/layout.ftl">
<@html page_title="软件列表" page_tab="software">
  <section class="content-header">
    <h1>
      软件
      <small>分类</small>
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
      <!-- /.box-header -->
      <div class="box-body">
        <form action="/forum/admin/software/categorylist" class="form-inline">
        </form>
          <form action="/forum/admin/software/categoryadd" class="form-inline">
              <div class="form-group" style="margin-bottom: 10px;">
                  <button type="submit" class="btn btn-primary btn-sm">添加分类</button>
              </div>
          </form>
        <table class="table table-bordered table-striped">
          <thead>
          <tr>
               <th>#</th>
              <th>名称</th>
              <th>存放地址</th>
              <th>创建时间</th>
              <th>描述</th>
              <th>操作</th>
          </tr>
          </thead>
          <tbody>
          <#list page.records as category>
            <tr>
              <td>${ category.id}</td>
              <!-- <td><a href="/admin/software/categorylist/${category.id! }" target="_blank">${category.name!}</a></td> -->
              <td>
               <#if category.hasSg == true>
                 <form action="/forum/admin/software/categorylist" class="form-inline">
                   <div class="form-group" style="margin-bottom: 10px;">
                   <input type="hidden" value="${category.id}" name="cgId">
                   <button type="submit" class="btn btn-primary btn-sm">${category.name!}</button>
                   </div>
                 </form>
                   <#else >
                   <a href="/forum/admin/software/list?categoryId=${category.id!}" class="btn btn-primary btn-sm">${category.name!}</a>
               </#if>
              </td>
              <td>${ category.path}</td>
              <td>${ category.inTime?string("yyyy.dd.mm. HH:mm:ss")}</td>
              <td>${ category.description}</td>
              <td>
                  <form action="/forum/admin/software/categoryadd" class="btn btn-xs btn-sm">
                          <input type="hidden" value="${category.id!}" name="cgId">
                          <input type="hidden" value="${category.path}" name="path">
                          <input type="hidden" value="${category.layer!}" name="layer">
                          <button type="submit" class="btn btn-primary btn-sm">添加子类</button>
                  </form>
                  <form action="/forum/admin/software/add" class="btn btn-xs btn-sm">
                           <input type="hidden" value="${category.id!}" name="categoryId">
                           <button type="submit" class="btn btn-primary btn-sm">上传软件</button>
                  </form>
              </td>
            </tr>
            <#if  category.intro??>
              <tr><td colspan="5">${ category.description!}</td></tr>
            </#if>
          </#list>
          </tbody>
        </table>
      </div>
    </div>
    <#include "../layout/paginate.ftl">
    <@paginate currentPage=page.current totalPage=page.pages actionUrl="/forum/admin/software/categorylist/" urlParas="&name=${name!}"/>
  </section>
<section class="content">
    <div class="box box-info">
        <div class="box-header with-border">
            <h3 class="box-title">当前${categoryName!}目录下软件列表</h3>
        </div>
        <!-- /.box-header -->
        <div class="box-body">
            <form action="/forum/admin/software/add" class="form-inline">
                <div class="form-group" style="margin-bottom: 10px;">
                    <input type="hidden" value="${categoryId!}" name="categoryId">
<#--                    <button type="submit" class="btn btn-primary btn-sm">上传软件</button>-->
                </div>
            </form>
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>#</th>
                    <th>名称</th>
                    <th>大小</th>
                    <th>存放地址</th>
                    <th>更新时间</th>
                    <th>版本</th>
                    <th>描述</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <#list softs.records as software>
                    <tr>
                    <td>${software.id}</td>
                    <td>${software.originName!}</td>
                    <td>${software.size}</td>
                    <td>${software.url}</td>
                    <td>${software.inTime?string("yyyy.dd.mm. HH:mm:ss")}</td>
                    <td>${software.version}</td>
                    <td>${software.description}</td>
                    <td>
                    <#if sec.hasPermission('software:edit')>
                        <a href="/forum/admin/software/edit?id=${software.id}" class="btn btn-xs btn-warning">编辑</a>
                    </#if>
                    <#if sec.hasPermission('software:delete')>
                        <button onclick="actionBtn('${software.id}','delete', this)" class="btn btn-xs btn-danger">删除</button>
                    </#if>
                    </td>
                    </tr>
                    <#if software.intro??>
                        <tr><td colspan="5">${software.description!}</td></tr>
                    </#if>
                </#list>
                </tbody>
            </table>
        </div>
    </div>
    <#include "../layout/paginate.ftl">
    <@paginate currentPage=page.current totalPage=page.pages actionUrl="/forum/admin/software/list/"
    urlParas="&categoryId=${categoryId!}"/>
</section>
<script>
    <#if sec.hasPermissionOr("software: categorydelete")>
    function actionBtn(id, action, self) {
        var msg, url;
        var tip = $(self).text().replace(/[\r\n]/g, '').trim();
         if(action === 'delete') {
            url = '/forum/admin/software/delete?id=' + id;
            msg = '确定要删除这个板块吗？';
        }

        if (confirm(msg)) {
            $.get(url, function (data) {
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
</@html>
