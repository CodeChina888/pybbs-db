<#include "../layout/layout.ftl"/>
<@html page_title="创建话题" page_tab="">
  <div class="row">
    <div class="col-md-9">
      <div class="panel panel-info">
        <div class="panel-heading">发布话题</div>
        <div class="panel-body">
          <form action="" onsubmit="return;" id="form">
            <div class="form-group">
              <label for="title">标题</label>
              <input type="text" name="title" id="title" class="form-control" placeholder="标题"/>
            </div>
            <div class="form-group">
              <label for="content">内容</label>
              <a href="javascript:;" id="uploadImageBtn" class="pull-right">上传图片</a>
              <textarea name="content" id="content" class="form-control"
                        placeholder="内容，支持Markdown语法"></textarea>
            </div>
            <div class="form-group">
              <label>板块</label>
              <select id="tags">
                <#list list as list>
                  <option>${list}</option>
                </#list>
              </select>
                <script>
                    const dom = document.getElementById('tags')
                    const opts = Array.prototype.slice.call(dom.getElementsByTagName('option'))
                    const Herf = window.location.href
                    let arr = Herf.split('=')
                    const selectOpt = opts.filter(function(value) {
                        return value.innerHTML === decodeURI(arr[1])
                    })
                    if (selectOpt[0]) {
                        selectOpt[0].setAttribute('selected', true)
                    }
                </script>
            </div>
            <div class="form-group">
              <button type="button" id="btn" class="btn btn-info">发布话题</button>
            </div>
          </form>
        </div>
      </div>
    </div>
    <div class="col-md-3 hidden-xs">
      <#include "../components/markdown_guide.ftl"/>
      <#include "../components/create_topic_guide.ftl"/>
    </div>
  </div>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.38.0/codemirror.min.css" rel="stylesheet">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.38.0/codemirror.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.38.0/mode/markdown/markdown.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.38.0/addon/display/placeholder.min.js"></script>
  <script>
    $(function () {
      CodeMirror.keyMap.default["Shift-Tab"] = "indentLess";
      CodeMirror.keyMap.default["Tab"] = "indentMore";
      window.editor = CodeMirror.fromTextArea(document.getElementById("content"), {
        lineNumbers: true,     // 显示行数
        indentUnit: 4,         // 缩进单位为4
        tabSize: 4,
        matchBrackets: true,   // 括号匹配
        mode: 'markdown',     // Markdown模式
        lineWrapping: true,    // 自动换行
      });

      $("#btn").click(function () {
        var title = $("#title").val();
        var content = window.editor.getDoc().getValue();
        var tags = $("#tags").val();

        $.ajax({
          url: '/api/topic',
          cache: false,
          async: false,
          type: 'post',
          dataType: 'json',
          contentType: 'application/json',
          headers: {
            'token': '${_user.token}'
          },
          data: JSON.stringify({
            title: title,
            content: content,
            tags: tags,
          }),
          success: function (data) {
            if (data.code === 200) {
              toast("创建成功", "success");
              setTimeout(function () {
                window.location.href = "/topic/" + data.detail.topic.id
              }, 700);
            } else {
              toast(data.description);
            }
          }
        })
      });
    });
  </script>
  <#include "../components/upload.ftl"/>
</@html>
