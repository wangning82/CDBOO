<%@ page contentType="text/html;charset=UTF-8" import="com.cdboo.common.Constants" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户频道管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic}/cdboo/userchannel/userchannel.js"></script>
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
		
		//检查音乐id是否存在
		function checkMusicIsExists(musicId){
			var flag = false;
			$("input[name = 'musicIds']").each(function(index){
				var id = $(this).val();
				//alert("["+id+"]:["+musicId+"]["+(id == musicId)+"]")
				if(id == musicId){
					flag = true;
					return false;
				}
			});
			return flag;
		}
		
		<c:if test="${empty cdbooUserChannel.id }">
			//新增的时候不做频道联动，覆盖用户选择回调函数
			function userTreeselectCallBack(v, h, f) {
				$('#tb').empty();
				linkMusic();
			}
		</c:if>
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/userchannel/userChannel/">频道列表</a></li>
		<li class="active"><a href="${ctx}/userchannel/userChannel/form">频道编辑</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cdbooUserChannel" action="${ctx}/userchannel/userChannel/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden" id="owner_type_public" value="${Constants.MUSICOWNER_PUBLIC}"/>
		<input type="hidden" id="owner_type_private" value="${Constants.MUSICOWNER_PRIVATE}"/>
		<sys:message content="${message}"/>
		
		<div class="control-group">
			<label class="control-label">用户名称：</label>
			<div class="controls">
				${fns:getUser().name}
				<input type="hidden" id="userId" name="user.id" value="${fns:getUser().id }"/>
				&nbsp;
			<input id="assignButton" class="btn btn-primary" type="button" value="分配频道" onclick="openMappingWin()"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">子频道列表：</label>
			<div class="controls">
				<channel:channelListTag channelElementName="channelIds" channelList="${cdbooUserChannel.channelList }" channelType="0" userElementId="userId"></channel:channelListTag>
			</div>
		</div>
		
		<div class="form-actions">
			<shiro:hasPermission name="userchannel:userChannel:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>