<#include "../layout/layout.ftl">
<@html page_title="软件列表" page_tab="software">
  <section class="content-header">
    <h1>
      软件
      <small>列表</small>
    </h1>
    <ol class="breadcrumb">
      <li><a href="/forum/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
      <li><a href="/forum/admin/tag/list">板块</a></li>
      <li class="active">列表</li>
    </ol>
  </section>
  <section class="content">
    <div class="box box-info">
      <div class="box-header with-border">
        <h3 class="box-title">软件列表</h3>
      </div>
      <!-- /.box-header -->
      <div class="box-body">
        <form action="/forum/admin/software/list" class="form-inline">
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
              <th>大小</th>
              <th>存放地址</th>
              <th>更新时间</th>
              <th>版本</th>
              <th>描述</th>
              <th>操作</th>
          </tr>
          </thead>
          <tbody>
          <#list page.records as software>
            <tr>
              <td>${software.id}</td>
              <td>${software.fileName!}</td>
              <td>${software.size}</td>
              <td>${software.url}</td>
              <td>${software.inTime?string("yyyy.dd.mm. HH:mm:ss")}</td>
              <td>${software.version}</td>
              <td>${software.description}</td>
              <td>
                 <a href="/api/software/download/${software.id}" class="btn btn-xs btn-warning">下载</a>
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
  </section>
<script>
    <#if sec.hasPermissionOr("software:delete")>
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