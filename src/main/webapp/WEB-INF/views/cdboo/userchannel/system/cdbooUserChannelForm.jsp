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
				if(v == 'ok'){
					$('#assignButton').attr('disabled',false);
					$('#tb').empty();
					linkMusic();
				}
				if(v == 'clear' ){
					$('#assignButton').attr('disabled',true);
				}
			}
		</c:if>
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/userchannel/cdbooUserChannel/">用户频道列表</a></li>
		<li class="active"><a href="${ctx}/userchannel/cdbooUserChannel/form?id=${cdbooUserChannel.id}">用户频道<shiro:hasPermission name="userchannel:cdbooUserChannel:edit">${not empty cdbooUserChannel.user.id && not empty cdbooUserChannel.channel.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="userchannel:cdbooUserChannel:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cdbooUserChannel" action="${ctx}/userchannel/cdbooUserChannel/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden" id="owner_type_public" value="${Constants.MUSICOWNER_PUBLIC}"/>
		<input type="hidden" id="owner_type_private" value="${Constants.MUSICOWNER_PRIVATE}"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">用户：</label>
			<div class="controls">
				<!-- 如果是修改，则用户锁定，不能编辑 -->
				<c:if test = "${not empty cdbooUserChannel.user.id && not empty cdbooUserChannel.channel.id}">
					<sys:treeselect disabled="disabled" id="user" name="user.id" value="${cdbooUserChannel.user.id}" labelName="user.name" labelValue="${cdbooUserChannel.user.name}"
						title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true" />
				</c:if>
				<!-- 如果是新增，则用户不锁定，允许编辑 -->
				<c:if test = "${empty cdbooUserChannel.user.id && empty cdbooUserChannel.channel.id}">
					<sys:treeselect id="user" name="user.id" value="${cdbooUserChannel.user.id}" labelName="user.name" labelValue="${cdbooUserChannel.user.name}"
						title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true" />
				</c:if>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">频道：</label>
			<div class="controls">
				<form:select id="channelId" path="channel.id" class="input-xlarge " onchange="linkMusic()">
					<form:option value="" label="请选择"/>
					<form:options items="${channelList}" itemLabel="channelName" itemValue="id" htmlEscape="false"/>
				</form:select>
				&nbsp;
				<input id="assignButton" <c:if test = "${empty cdbooUserChannel.user.id && empty cdbooUserChannel.channel.id}">disabled="disabled"</c:if> class="btn btn-primary" type="button" value="分配音乐" onclick="openMappingWin()"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">音乐列表：</label>
			<div class="controls">
				<music:musicListTag musicIdElementName="musicIds" musicList="${musicList }" userElementId="userId"></music:musicListTag>
			</div>
		</div>
		
		<div class="form-actions">
			<shiro:hasPermission name="userchannel:cdbooUserChannel:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>