<#include "../layout/layout.ftl">
<@html page_title="软件列表" page_tab="software">
    <section class="content-header">
        <h1>
            软件
            <small>分类</small>
        </h1>
    </section>
    <section class="content">
        <div class="box box-info">
            <div class="box-body">
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
                    <@software_categorylist pageNo=pageNo pageSize=40 categoryId=categoryId>
                        <#list page.records as category>
                            <tr>
                                <td>${ category.id}</td>
                                <td>
                                    <#if category.hasSg == true>
                                        <form action="/forum/software/categorylist" class="form-inline">
                                            <div class="form-group" style="margin-bottom: 10px;">
                                                <input type="hidden" value="${category.id}" name="categoryId">
                                                <button type="submit" class="btn btn-primary btn-sm">${category.name!}</button>
                                            </div>
                                        </form>
                                    <#else >
                                        <a href="/api/software/list/${category.id!}" class="btn btn-primary btn-sm">${category.name!}</a>
                                    </#if>
                                </td>
                                <td>${ category.path}</td>
                                <td>${ category.inTime?string("yyyy.dd.mm. HH:mm:ss")}</td>
                                <td>${ category.description}</td>
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
<#--    <script>-->
<#--        <#if sec.hasPermissionOr("software: categorydelete")>-->
<#--        function actionBtn(id, action, self) {-->
<#--            var msg, url;-->
<#--            var tip = $(self).text().replace(/[\r\n]/g, '').trim();-->
<#--            if(action === 'delete') {-->
<#--                url = '/forum/admin/tag/delete?id=' + id;-->
<#--                msg = '确定要删除这个板块吗？';-->
<#--            }-->

<#--            if (confirm(msg)) {-->
<#--                $.get(url, function (data) {-->
<#--                    if (data.code === 200) {-->
<#--                        toast("成功", "success");-->
<#--                        setTimeout(function () {-->
<#--                            window.location.reload();-->
<#--                        }, 700);-->
<#--                    } else {-->
<#--                        toast(data.description);-->
<#--                    }-->
<#--                })-->
<#--            }-->
<#--        }-->
<#--        </#if>-->
<#--    </script>-->
</@html>
