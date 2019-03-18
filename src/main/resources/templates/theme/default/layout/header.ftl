<#macro header page_tab>
<div class="my_header">
<header class="navbar my_navbar" style="margin-bottom:0">
        <div class="header-set el-row">
            <div class="el-col el-col-4"><a href="https://www.linkedbyx.com/home"
                    class="home-logo router-link-exact-active router-link-active">
                    <div class="xpro-logo"></div>
                </a></div>
            <ul class="xpro-nav">
                <li class="xpro-nav-li is-active"><a href="https://www.linkedbyx.com/home"
                        class="router-link-exact-active router-link-active">首页</a></li>
                <li class="xpro-nav-li"><a href="https://www.linkedbyx.com/taskCenter/latest" class="">任务中心</a></li>
                <li class="xpro-nav-li"><a href="https://www.linkedbyx.com/studyCenter/types" class="">学习中心</a></li>
                <li class="xpro-nav-li"><a href="https://www.linkedbyx.com/train/home" class="">认证培训</a></li>
                <li class="xpro-nav-li"><a href="https://www.linkedbyx.com/market" class="">积分商城</a></li>
                <li class="xpro-nav-li"><a href="https://www.linkedbyx.com/forum" class=""><strong>前往论坛</strong></a></li>
                <li class="xpro-nav-li v">|</li>
                <li class="xpro-nav-li" style="position: relative">
                    <div class="el-dropdown" id="sommmouns_drop_down"><span class="el-dropdown-link"><span class="d"><span
                                    class="layout-text-ellipsis">会员990b31f38828d5c6</span> <span
                                    class="user-level"><span>LV1</span></span> <span
                                    class="iconfont icon-caretdown"></span></span></span> </div>
                    <ul id="sommmouns_drop_down_ul" class="el-dropdown-menu self-menu" style="transform-origin: center top; z-index: 2006; top: 60px; left: 40px; display: none">
                        <li class="el-dropdown-menu__item layout-text-center">个人中心</li>
                        <li class="el-dropdown-menu__item layout-text-center">注销</li>
                    </ul>
                    <script>
                        $('#sommmouns_drop_down').click(function() {
                            console.log(1)
                            $('#sommmouns_drop_down_ul').slideDown()
                            return false
                        })
                        $('#sommmouns_drop_down_ul').click(function() {
                            return false
                        })
                        document.onclick = function () {
                            $('#sommmouns_drop_down_ul').slideUp()
                        }
                    </script>
                </li>
            </ul>
        </div>
    </header>
<nav class="navbar navbar-default" style="border-radius: 0;border-color: #e7e7e7; background:#f8f8f8">
  <div class="container">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <#--<a class="navbar-brand" href="/">${site.name}</a>-->
        <a class="navbar-brand" href="/">安恒信息</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li <#if page_tab == "index">class="active"</#if>><a href="/"><i class="fa fa-home"></i> ${i18n.getMessage("index")}</a></li>
        <li <#if page_tab == "tags">class="active"</#if>><a href="/tags"><i class="fa fa-tags"></i> ${i18n.getMessage("tag")}</a></li>
      </ul>
      <#--<#if site.search == "1">-->
        <#--<form class="navbar-form navbar-left" action="/search" method="get">-->
          <#--<div class="form-group">-->
            <#--<input type="text" name="keyword" value="${keyword!}" class="form-control" required placeholder="Search">-->
          <#--</div>-->
          <#--<button type="submit" class="btn btn-info">${i18n.getMessage("search")}</button>-->
        <#--</form>-->
      <#--</#if>-->
      <ul class="nav navbar-nav navbar-right">
        <#--<li <#if page_tab == "api">class="active"</#if>><a href="/api">API</a></li>-->
        <#if _user??>
          <li <#if page_tab == "notification">class="active"</#if>><a href="/notifications"><i class="fa fa-envelope"></i> ${i18n.getMessage("notification")} <span class="badge badge-default" id="nh_count"></span></a></li>
          <li <#if page_tab == "user">class="active"</#if>><a href="/user/${_user.username}"><i class="fa fa-user"></i> ${_user.username}</a></li>
          <li <#if page_tab == "settings">class="active"</#if>><a href="/settings"><i class="fa fa-cog"></i> ${i18n.getMessage("setting")}</a></li>
          <li><a href="javascript:if(confirm('确定要登出吗？登出了就没办法发帖回帖了哦!'))window.location.href='/logout'"><i class="fa fa-sign-out"></i> ${i18n.getMessage("logout")}</a></li>
        <#else>
          <li <#if page_tab == "login">class="active"</#if>><a href="/login"><i class="fa fa-sign-in"></i> ${i18n.getMessage("login")}</a></li>
          <li <#if page_tab == "register">class="active"</#if>><a href="/register"><i class="fa fa-sign-out"></i> ${i18n.getMessage("register")}</a></li>
          <#if !model.isEmpty(site.oauth_github_client_id!) && !model.isEmpty(site.oauth_github_client_secret!)>
            <li><a href="/oauth/github"><i class="fa fa-github"></i> ${i18n.getMessage("github_login")}</a></li>
          </#if>
        </#if>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
</div>

</#macro>
