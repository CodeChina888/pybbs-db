<#include "../layout/layout.ftl">
<@html page_title="话题编辑" page_tab="topic">
  <section class="content-header">
    <h1>
      话题
      <small>编辑</small>
    </h1>
    <ol class="breadcrumb">
      <li><a href="/forum/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
      <li><a href="/forum/admin/topic/list">话题</a></li>
      <li class="active">编辑</li>
    </ol>
  </section>
  <section class="content">
    <div class="box box-info">
      <div class="box-header with-border">
        <h3 class="box-title">话题编辑</h3>
      </div>
      <!-- /.box-header -->
      <div class="box-body">
        <form action="" onsubmit="return;" id="form">
          <div class="form-group">
            <label for="title">标题</label>
            <input type="text" name="title" id="title" value="${topic.title}" class="form-control" placeholder="标题"/>
          </div>
          <div class="form-group">
            <label for="content">内容</label>
            <textarea name="content" id="content" class="form-control"
                      placeholder="内容，支持Markdown语法">${topic.content!?html}</textarea>
          </div>
          <div class="form-group">
            <label for="tags">标签</label>
            <input type="text" name="tags" id="tags" value="${tags}" class="form-control" />
          </div>
          <div class="form-group">
            <button type="button" id="pass" class="btn btn-primary">通过</button>
            <button type="button" id="nopass" class="btn btn-primary">不通过</button>
          </div>
        </form>
      </div>
    </div>
  </section>
<link href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.38.0/codemirror.min.css" rel="stylesheet">
<style>
  .CodeMirror {
    border: 1px solid #ddd;
  }
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.38.0/codemirror.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.38.0/mode/markdown/markdown.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.38.0/addon/display/placeholder.min.js"></script>
<script>
  $(function () {
    CodeMirror.keyMap.default["Shift-Tab"] = "indentLess";
    CodeMirror.keyMap.default["Tab"] = "indentMore";
    var editor = CodeMirror.fromTextArea(document.getElementById("content"), {
      lineNumbers: true,     // 显示行数
      indentUnit: 4,         // 缩进单位为4
      tabSize: 4,
      matchBrackets: true,   // 括号匹配
      mode: 'markdown',     // Markdown模式
      lineWrapping: true,    // 自动换行

    });

    $("#pass").click(function () {
      var title = $("#title").val();
      var content = editor.getDoc().getValue();
      var tags = $("#tags").val();
      var pass=true;

        if (!title || title.length > 120) {
            toast("请输入标题，且最大长度在120个字符以内");
            return;
        }
      $.post("/forum/admin/topic/check", {
        id: ${topic.id},
        title: title,
        content: content,
        tags: tags,
          pass: pass,
      }, function (data) {

        if (data.code === 200) {
          toast("更新成功", "success");
          setTimeout(function () {
            window.location.href = "/forum/admin/topic/list";
          }, 700);
        } else {
          toast(data.description);
        }
      })
    });
      $("#nopass").click(function () {
          var title = $("#title").val();
          var content = editor.getDoc().getValue();
          var tags = $("#tags").val();
          var pass=false;
          $.post("/forum/admin/topic/check", {
              id: ${topic.id},
              title: title,
              content: content,
              tags: tags,
              pass:pass,
          }, function (data) {
              if (data.code === 200) {
                  toast("更新成功", "success");
                  setTimeout(function () {
                      window.location.href = "/forum/admin/topic/list";
                  }, 700);
              } else {
                  toast(data.description);
              }
          })
      });
  });
</script>
</@html>
