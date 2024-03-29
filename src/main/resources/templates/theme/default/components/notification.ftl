<#macro notification userId read limit>
  <@tag_notifications userId=userId read=read limit=limit>
    <#list notifications as notification>
      <div class="media notification_${read}">
        <div class="media-left">
          <img src="${notification.avatar!}" class="avatar avatar-sm">
        </div>
        <div class="media-body">
          <div class="gray" <#if !notification.read>style="font-weight:700;"</#if>>
            <#if (notification.username)??>
              <a href="/forum/user/${notification.username}">${notification.username}</a>
              <span>${model.formatDate(notification.inTime)}</span>
              <#if notification.action == "COMMENT">
                评论了你的话题 <a href="/forum/topic/${notification.topicId}">${notification.title}</a>
              <#elseif notification.action == "REPLY">
                在话题 <a href="/forum/topic/${notification.topicId}">${notification.title}</a> 下回复了你
              <#elseif notification.action == "COLLECT">
                收藏了你的话题 <a href="/forum/topic/${notification.topicId}">${notification.title}</a>
              </#if>
<#--            <#else>-->
<#--              <#if notification.pass>-->
<#--                话题审核通过 <a href="/forum/topic/${notification.topicId}">${notification.title}</a>-->
<#--              <#else>-->
<#--                话题审核未通过-->
<#--              </#if>-->
            </#if>
          </div>
          <#if notification.content??>
            <div class="payload">
              ${model.formatContent(notification.content)}
            </div>
          </#if>
        </div>
      </div>
      <#if notification_has_next>
        <div class="divide"></div>
      </#if>
    </#list>
  </@tag_notifications>
</#macro>