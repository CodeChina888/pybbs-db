<#include "../layout/layout.ftl"/>
<@html page_title=user.username + " 的个人主页" page_tab="user">
<div class="row">
  <div class="col-md-3 animated fadeIn">
    <div class="well profile-top">
        <div>
          <div class="head-container">
            <img src="${user.avatar!}" style="width:230px;height:230px;"/>
          </div>
        </div>
    </div>
    <div class="panel panel-default">
      <div class="panel-body">
       <h3 style="margin-top: 0">${user.username!}</h3>
         <#if user.bio??>
              <p><i class="gray">${user.bio!}</i></p>
            </#if>
            <p>积分：<a href="/forum/top100">${user.score}</a></p>
            
            <p>收藏话题: <a href="/forum/user/${user.username}/collects">${collectCount!0}</a></p>
            <div>入驻时间: ${model.formatDate(user.inTime)}</div>
      </div>
    </div>
  </div>
  <div class="col-md-9">
    <#include "../components/user_topics.ftl"/>
    <@user_topics pageNo=1 pageSize=10 username=username isFooter=true/>

    <#include "../components/user_comments.ftl"/>
    <@user_comments pageNo=1 pageSize=10 username=username isFooter=true/>
  </div>
  <#--  <div class="col-md-3 hidden-xs">
    <div class="panel panel-info"><p></p></div>
    <#if githubLogin??>
      <#include "../components/github_repos.ftl"/>
    </#if>
  </div>  -->
</div>
</@html>
