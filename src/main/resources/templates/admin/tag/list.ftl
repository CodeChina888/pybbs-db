<#include "../layout/layout.ftl">
<@html page_title="板块列表" page_tab="tag">
  <section class="content-header">
    <h1>
      板块
      <small>列表</small>
    </h1>
    <ol class="breadcrumb">
      <li><a href="/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
      <li><a href="/admin/tag/list">板块</a></li>
      <li class="active">列表</li>
    </ol>
  </section>
  <section class="content">
    <div class="box box-info">
      <div class="box-header with-border">
        <h3 class="box-title">板块列表</h3>
        <#if sec.hasPermission('tag:async')>
          <button type="button" onclick="asyncTopicCount()" class="btn btn-xs btn-danger pull-right">同步话题数</button>
          <script>
            function asyncTopicCount() {
              if(confirm('如果标签数比较多，这个操作会很耗费时间，确定继续吗？')) {
                $.get("/admin/tag/async", function (data) {
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
          </script>
        </#if>
      </div>
      <!-- /.box-header -->
      <div class="box-body">
        <form action="/admin/tag/list" class="form-inline">
          <div class="form-group" style="margin-bottom: 10px;">
            <input type="text" name="name" value="${name!}" class="form-control" placeholder="标签名">
            <button type="submit" class="btn btn-primary btn-sm">搜索</button>
          </div>
        </form>
          <form action="/admin/tag/add" class="form-inline">
              <div class="form-group" style="margin-bottom: 10px;">
                  <button type="submit" class="btn btn-primary btn-sm">添加板块</button>
              </div>
          </form>
        <table class="table table-bordered table-striped">
          <thead>
          <tr>
               <th>#</th>
              <th>名称</th>
              <th>话题数</th>
              <th>管理员</th>
              <th>操作</th>
          </tr>
          </thead>
          <tbody>
          <#list page.records as tag>
            <tr>
              <td>${tag.id}</td>
              <td><a href="/topic/tag/${tag.name!}" target="_blank">${tag.name!}</a></td>
              <td>${tag.topicCount!0}</td>
              <td>
              <#if tag.adminName??>
                  <a href="/admin/admin_user/detail/${tag.adminName}" target="_blank">${tag.adminName!}</a>
              <#else>
                  <p>暂无</p>
              </#if>
              </td>
              <td>
                <#if sec.hasPermission('tag:edit')>
                  <a href="/admin/tag/edit?id=${tag.id}" class="btn btn-xs btn-warning">编辑</a>
                </#if>
                <#if sec.hasPermission('tag:delete')>
                  <button onclick="actionBtn('${tag.id}','delete', this)" class="btn btn-xs btn-danger">删除</button>
                </#if>
              </td>
            </tr>
            <#if tag.intro??>
              <tr><td colspan="5">${tag.description!}</td></tr>
            </#if>
          </#list>
          </tbody>
        </table>
      </div>
    </div>
    <#include "../layout/paginate.ftl">
    <@paginate currentPage=page.current totalPage=page.pages actionUrl="/admin/tag/list" urlParas="&name=${name!}"/>
  </section>
<script>
    <#if sec.hasPermissionOr("tag:delete")>
    function actionBtn(id, action, self) {
        var msg, url;
        var tip = $(self).text().replace(/[\r\n]/g, '').trim();
         if(action === 'delete') {
            url = '/admin/tag/delete?id=' + id;
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
