<%@ page contentType="text/html;charset=UTF-8" import="com.cdboo.common.Constants" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>频道信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/channel/groupChannel/user/">用户组合频道信息列表</a></li>
		<li class="active"><a><c:if test = "${not empty userChannel.id}">用户组合频道信息查看</c:if><c:if test = "${empty userChannel.id}">用户组合频道信息添加</c:if></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="userChannel" action="${ctx}/channel/groupChannel/user/save" method="post" class="form-horizontal">
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">用户：</label>
			<div class="controls">
				<!-- 如果是修改，则用户锁定，不能编辑 -->
				<c:if test = "${not empty userChannel.id}">
					${userChannel.user.name}
				</c:if>
				<!-- 如果是新增，则用户不锁定，允许编辑 -->
				<c:if test = "${empty userChannel.id}">
					<sys:treeselect id="user" name="user.id" value="${userChannel.user.id}" labelName="user.name" labelValue="${userChannel.user.name}"
						title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true" />
				</c:if>
			</div>
		</div>
		
		<c:if test = "${empty userChannel.id}">
			<channel:channelListTag userElementId="userId" isInclude="1" channelElementName="channelIds" channelList="${userChannel.channelList }" channelType="${Constants.CHANNEL_TYPE_GROUP }"></channel:channelListTag>
		</c:if>
		<c:if test = "${not empty userChannel.id}">
			<channel:channelListTag isReview="1" userElementId="userId" isInclude="1" channelElementName="channelIds" channelList="${userChannel.channelList }" channelType="${Constants.CHANNEL_TYPE_GROUP }"></channel:channelListTag>
		</c:if>
		
		<div class="form-actions">
			<c:if test = "${empty userChannel.id}">
				<shiro:hasPermission name="channel:groupChannel:user:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			</c:if>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="javascript:window.location.href='${ctx}/channel/groupChannel/user/'"/>
		</div>
	</form:form>
</body>
</html>