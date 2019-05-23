<#include "../layout/layout.ftl">
<@html page_title="文档下载" page_tab="document">
    <section class="content-header">
    </section>
    <section class="content">
        <div class="box box-info">
            <div class="box-body">
                <form action="/forum/document/list" class="form-inline">
                    <@document_list pageNo=pageNo>
                    <div class="form-group">
                        <input type="text" name="name" class="form-control" placeholder="请输入关键字搜索">
                        <button type="submit" class="btn btn-primary btn-sm">搜索</button>
                    </div>
                </form>
                <table class="table table-bordered table-striped">
                    <thead>
                    <tr>
                        <th>编号</th>
                        <th>文档名称</th>
                        <th>上传时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                        <#list page.records as document>
                            <tr>
                                <td>${ document.id}</td>
                                <td>${ document.originName}</td>
                                <td>${ document.inTime?string("yyyy-MM-dd HH:mm:ss")}</td>
                                <td>
                                <a href=${ document.url} class="btn btn-xs btn-danger">下载</a>
                                <a href="/forum/document/previews/${document.code}" class="btn btn-xs btn-primary">预览</a></td>
                            </tr>
                        </#list>
                    </@document_list>
                    </tbody>
                </table>
                <#include "../components/paginate.ftl"/>
                <@paginate currentPage=page.current totalPage=page.pages actionUrl="/forum/document/list"/>
            </div>
        </div>
    </section>
</@html>
