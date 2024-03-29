<#macro html page_title page_tab>
<!doctype html>
<html lang="zh-CN" style="background:#eee">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>${page_title!}</title>
    <link rel="icon" href="http://www1.dbappsecurity.com.cn/images/tt/tt.ico">
<#--css-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css"/>
    <link rel="stylesheet" href="/static/theme/default/css/app.css" />
    <link rel="stylesheet" href="/static/theme/default/css/aa.css" />
    <link rel="stylesheet" href="/static/theme/default/css/animate.css" />
    <link rel="stylesheet" href="/static/theme/default/css/profile.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<#--javascript-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>
    <script>
        function toast(txt, icon) {
            $.toast({
                text: txt, // Text that is to be shown in the toast
                heading: '系统提醒', // Optional heading to be shown on the toast
                icon: icon || 'error', // Type of toast icon warning, info, success, error
                showHideTransition: 'slide', // fade, slide or plain
                allowToastClose: true, // Boolean value true or false
                hideAfter: 2000, // false to make it sticky or number representing the miliseconds as time after which toast needs to be hidden
                stack: false, // false if there should be only one toast at a time or a number representing the maximum number of toasts to be shown at a time
                position: 'top-right', // bottom-left or bottom-right or bottom-center or top-left or top-right or top-center or mid-center or an object representing the left, right, top, bottom values
            });
        }
    </script>
    <style>
        *{margin: 0; padding: 0;}
        .my_wrapper{display: flex; flex-direction: column; height: 100%;}
        .my_header{flex: 0 0 auto;height:130px;}
        .my_container{flex: 1 0 auto;}
        .my_footer{flex: 0 0 auto;height:84px;}
    </style>
</head>
<body>
<div class="wrapper my_wrapper" >
  <#include "header.ftl"/>
  <@header page_tab=page_tab/>
    <div class="container my_container">
    <#nested />
    </div>
  <#include "footer.ftl"/>
</div>
</body>
</html>
</#macro>
