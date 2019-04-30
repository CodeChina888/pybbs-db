<#include "../layout/layout.ftl">
<@html page_title="文档添加" page_tab="document">
    <body>
    <form action="/forum/documentCenter/upload" method="post" enctype="multipart/form-data">
        <label>上传文档</label><br>
        <label>产品分类</label><br>
        <input type="text" name="documentClass"><br>
        <label>产品种类</label><br>
        <input type="text" name="documentType"><br>
        <label>文档分类</label><br>
        <input type="text" name="documentClassify"><br>
        <label>文档名称</label><br>
        <input type="text" name="documentName"><br>
        <span>标签选择</span><br>
        <span>
        <select name="ids" multiple="multiple">
           <#list labels as label>
               <option name="ids" value ="${label.id}">${label.code!}</option>
           </#list>
        </select>
        </span><br>
        <label>上传文档</label><br>
        <input type="file" name="file"/>
        <input type="submit" value="上传"/>
    </form>
    </body>
</@html>
