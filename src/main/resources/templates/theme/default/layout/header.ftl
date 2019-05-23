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
                <a class="navbar-brand" href="/forum">安恒信息</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li <#if page_tab == "index">class="active"</#if>><a href="/forum"><i class="fa fa-home"></i> ${i18n.getMessage("index")}</a></li>
                    <li <#if page_tab == "tags">class="active"</#if>><a href="/forum/tags"><i class="fa fa-tags"></i> ${i18n.getMessage("tag")}</a></li>
                    <li <#if page_tab == "software">class="active"</#if>><a href="/forum/software/list"><i class="fa fa-tags"></i> 软件下载</a></li>
                    <li <#if page_tab == "document">class="active"</#if>><a href="/forum/document/list"><i class="fa fa-tags"></i> 文档下载</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
        <#if _user??>
          <li <#if page_tab == "notification">class="active"</#if>><a href="/forum/notifications"><i class="fa fa-envelope"></i> ${i18n.getMessage("notification")} <span class="badge badge-default" id="nh_count"></span></a></li>
          <li <#if page_tab == "user">class="active"</#if>><a href="/forum/user/${_user.username}"><i class="fa fa-user"></i> ${_user.username}</a></li>
        </#if>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
</div>

</#macro>
