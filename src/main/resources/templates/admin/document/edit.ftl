<#include "../layout/layout.ftl">
<@html page_title="文档编辑" page_tab="document">
    <section class="content-header">
        <h1>
            文档
            <small>列表</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="/forum/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li><a href="/forum/documentCenter/list">文档</a></li>
            <li class="active">编辑</li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">文档编辑</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
                <form id="form" action="/forum/documentCenter/edit" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${document.id}">
                    <input type="hidden" name="code" value="${document.code}">
                    <div class="form-group">
                        <label>上传pdf文件</label>
                        <input type="hidden" name="pdfPath" value="${document.pdfPath}">
                        <input type="hidden" name="pdfUrl" value="${document.pdfUrl}">
                        <input type="hidden" name="pdfName" value="${document.pdfName}">
                        <input type="file" name="pdfFile" value="" class="form-control">
                        <label>上传文件</label>
                        <input type="hidden" name="fullpath" value="${document.fullpath}">
                        <input type="hidden" name="originName" value="${document.originName}">
                        <input type="hidden" name="url" value="${document.url}">
                        <input type="hidden" name="path" value="${document.path}">
                        <input type="file" name="files" value="" class="form-control">
                    </div>
                    <label>产品归属</label><br>
                    <select name="documentCategoryId">
                        <#list categoryList as name>
                            <option value="${name.id}">${name.name}</option>
                        </#list>
                    </select>
                    <br>
                    <div class="form-group">
                    <span >
                    <label for="">标签选择</label>
                    <br>
                     <select name="ids" multiple="multiple">
                       <#list labels as label>
                           <option name="ids" value ="${label.id}">${label.code!}</option>
                       </#list>
                     </select>
                    </span>
                        <br>
                        <button type="submit" id="btn" class="btn btn-primary">提交</button>
                </form>
            </div>
        </div>
    </section>
</@html>

