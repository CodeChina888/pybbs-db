<#include "../layout/layout.ftl">
<@html page_title="分类中心" page_tab="category">
    <section class="content-header">
        <h1>
            文档分类
            <small>中心</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="/forum/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li><a href="/forum/documentCategory/list">文档分类</a></li>
            <li class="active">中心</li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">文档分类中心</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
                <form id="form" action="/forum/documentCategory/edit" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${id}">
                    <input type="hidden" name="pid" value="${documentCategory.pid}">
                    <input type="hidden" name="topId" value="${documentCategory.topId}">
                    <div class="form-group">
                        <input type="text" name="name" class="form-control">
                    </div>
                    <button type="submit" id="btn" class="btn btn-primary">提交</button>
                </form>
            </div>
        </div>
    </section>
</@html>

