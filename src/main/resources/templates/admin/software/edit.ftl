<#include "../layout/layout.ftl">
<@html page_title="软件编辑" page_tab="software">
    <section class="content-header">
        <h1>
            软件
            <small>编辑</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="/forum/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li><a href="/forum/softwareCenter/list">软件</a></li>
            <li class="active">编辑</li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">软件编辑</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
                <form id="form" action="/forum/softwareCenter/edit" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${software.id}">
                    <input type="hidden" name="code" value="${software.code}">
                    <div class="form-group">
                        <label>上传文件</label>
                        <input type="file" name="files" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>版本</label>
                        <input type="text" name="version" value="${software.version}" class="form-control">
                        <label>描述</label>
                        <input type="text" name="description" value="${software.description}" class="form-control">
                    </div>
                    <label>产品归属</label><br>
                    <select name="softwareCategoryId">
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

