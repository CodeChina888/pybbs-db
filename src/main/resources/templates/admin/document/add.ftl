<#include "../layout/layout.ftl">
<@html page_title="文档添加" page_tab="document">
    <body>
    <form action="/forum/documentCenter/upload" method="post" enctype="multipart/form-data">
        <label>上传文档</label><br>
        <label>文档类别</label><br>
        <input type="text" name="documentClass"><br>
        <label>文档种类</label><br>
        <input type="text" name="documentType"><br>
        <label>文档分类</label><br>
        <input type="text" name="documentClassify"><br>
        <label>文档名称</label><br>
        <input type="text" name="documentName"><br>
        <label>文档地址</label><br>
        <input type="text" name="url"><br>
        <label>上传文档</label><br>
        <input type="file" name="file"/>
        <input type="submit" value="上传"/>
    </form>
    </body>
</@html>
