<#include "../layout/layout.ftl">
<@html page_title="软件列表" page_tab="software">
  <section class="content-header">
    <h1>
      软件
      <small>分类</small>
    </h1>
    <ol class="breadcrumb">
      <li><a href="/forum/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
      <li><a href="/forum/admin/tag/list">板块</a></li>
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
          <div class="form-group" style="margin-bottom: 10px;">
            <input type="text" name="name" value="${name!}" class="form-control" placeholder="软件名">
            <button type="submit" class="btn btn-primary btn-sm">搜索</button>
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

          </tr>
          </thead>
          <tbody>
          <@software_categorylist pageNo=pageNo pageSize=40>
          <#list page.records as category>
            <tr>
              <td>${ category.id}</td>
              <td><a href="/api/software/list/${category.id!}" target="_blank">${category.name!}</a></td>
              <td>${ category.path}</td>
              <td>${ category.inTime?string("yyyy.dd.mm. HH:mm:ss")}</td>
              <td>${ category.description}</td>
              <td>

            </tr>
            <#if  category.intro??>
              <tr><td colspan="5">${ category.description!}</td></tr>
            </#if>
          </#list>
            </@software_categorylist>
          </tbody>
        </table>

      </div>
    </div>


  </section>
<script>
    <#if sec.hasPermissionOr("software: categorydelete")>
    function actionBtn(id, action, self) {
        var msg, url;
        var tip = $(self).text().replace(/[\r\n]/g, '').trim();
         if(action === 'delete') {
            url = '/forum/admin/tag/delete?id=' + id;
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
