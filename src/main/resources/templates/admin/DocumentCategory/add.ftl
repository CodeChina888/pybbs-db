<#include "../layout/layout.ftl">
<@html page_title="分类中心" page_tab="category">
    <section class="content-header">
        <h1>
            分类
            <small>中心</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="/forum/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li><a href="/forum/category/list">分类</a></li>
            <li class="active">中心</li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">分类添加</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
                <form id="form" action="/forum/documentCategory/add" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <input type="text" name="name" class="form-control">
                    </div>
                    <select name="pid">
                        <#list categoriesList as name>
                            <option value="${name.id}">${name.PName}</option>
                        </#list>
                    </select>
                    <br>
                    <button type="submit" id="btn" class="btn btn-primary">提交</button>
                </form>
            </div>
        </div>
    </section>
</@html>

