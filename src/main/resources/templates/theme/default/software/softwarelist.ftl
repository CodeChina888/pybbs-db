<#include "../layout/layout.ftl">
<@html page_title="软件列表" page_tab="software">
  <section class="content-header">
    <h1>
      软件
      <small>列表</small>
    </h1>
  </section>
  <section class="content">
    <div class="box box-info">
      <!-- /.box-header -->
      <div class="box-body">
        <table class="table table-bordered table-striped">
          <thead>
          <tr>
               <th>编号</th>
              <th>名称</th>
              <th>大小</th>
<#--              <th>存放地址</th>-->
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
              <td>${software.originName!}</td>
              <td>${software.size}</td>
<#--              <td>${software.url}</td>-->
              <td>${software.inTime?string("yyyy-MM-dd HH:mm:ss")}</td>
              <td>${software.version}</td>
              <td>${software.description}</td>
              <td>
                 <a href="/api/software/download/${software.code}" class="btn btn-xs btn-warning">下载</a>
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
