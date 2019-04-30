<#include "../layout/layout.ftl">
<@html page_title="文档中心" page_tab="document">
    <section class="content-header">
        <h1>
            文档
            <small>中心</small>
        </h1>
    </section>
    <section class="content">
        <div class="box box-info">
            <div class="box-body">
                <table class="table table-bordered table-striped">
                    <thead>
                    <tr>
                        <th>编号</th>
                        <th>产品名称</th>
                        <th>产品种类</th>
                        <th>文档分类</th>
                        <th>文档说明</th>
                        <th>上传时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <@document_list pageNo=pageNo>
                        <#list page.records as document>
                            <tr>
                                <td>${ document.id}</td>
                                <td>${ document.documentClass}</td>
                                <td>${ document.documentType}</td>
                                <td>${ document.documentClassify}</td>
                                <td>${ document.documentName}</td>
                                <td>${ document.inTime?string("yyyy.dd.mm. HH:mm:ss")}</td>
                                <td>
                                <a href=${ document.url} class="btn btn-xs btn-danger">下载</a>
                                <a href=${ document.url} class="btn btn-xs btn-primary">预览</a></td>
                            </tr>
                        </#list>
                    </@document_list>
                    </tbody>
                </table>

            </div>
        </div>
    </section>
</@html>
