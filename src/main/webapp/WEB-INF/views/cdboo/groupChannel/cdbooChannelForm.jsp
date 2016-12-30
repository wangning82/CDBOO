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
		
		function changeThemeConcreteType(selectVal){
			var theme = '${Constants.THEMETYPE_THEME }';
			var holiday = '${Constants.THEMETYPE_HOLIDAY }';
			
			$('#themeConcreteType').empty();
			$('#themeConcreteType').append('<option value="">请选择</option>');
			
			var dictList;
			if(selectVal == theme){
				dictList = ${fns:toJson(fns:getDictList('season_type'))};
			}
			if(selectVal == holiday){
				dictList = ${fns:toJson(fns:getDictList('holiday_type'))};
			}
			
			if(dictList && dictList.length>0){
				for(var i = 0; i <dictList.length;i++){
					$('#themeConcreteType').append('<option value="'+dictList[i].value+'">'+dictList[i].label+'</option>');
				}
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/channel/groupChannel/">频道信息列表</a></li>
		<li class="active"><a href="${ctx}/channel/groupChannel/form?id=${cdbooChannel.id}">频道信息<shiro:hasPermission name="channel:groupChannel:edit">${not empty cdbooChannel.id?'修改':'添加'}</shiro:hasPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cdbooGroupChild" action="${ctx}/channel/groupChannel/save" method="post" class="form-horizontal">
		<form:hidden path="groupChannelId.id"/>
		<input type="hidden" id="channelType" name="channelType" value="${Constants.CHANNEL_TYPE_CHILD }">
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">用户：</label>
			<div class="controls">
				<!-- 如果是修改，则用户锁定，不能编辑 -->
				<c:if test = "${not empty cdbooGroupChild.userId.id && not empty cdbooGroupChild.groupChannelId.id}">
					<sys:treeselect disabled="disabled" id="user" name="user.id" value="${cdbooGroupChild.userId.id}" labelName="user.name" labelValue="${cdbooGroupChild.userId.name}"
						title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true" />
				</c:if>
				<!-- 如果是新增，则用户不锁定，允许编辑 -->
				<c:if test = "${empty cdbooGroupChild.userId.id && empty cdbooGroupChild.groupChannelId.id}">
					<sys:treeselect id="user" name="user.id" value="${cdbooGroupChild.userId.id}" labelName="user.name" labelValue="${cdbooGroupChild.userId.name}"
						title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true" />
				</c:if>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">频道编号：</label>
			<div class="controls">
				<form:input path="groupChannelId.channelNo" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">频道名称：</label>
			<div class="controls">
				<form:input path="groupChannelId.channelName" htmlEscape="false" maxlength="200" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">频道版本：</label>
			<div class="controls">
				<form:input path="groupChannelId.channelVersion" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">频道图片：</label>
			<div class="controls">
				<input type="hidden" id="photoPath" name="groupChannelId.photoPath" value="${cdbooChannel.photoPath }" required>
				<sys:ckfinder input="photoPath" type="images"  uploadPath="/images" selectMultiple="false" maxWidth="100" maxHeight="100"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="groupChannelId.remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">子频道列表：</label>
			<div class="controls">
				<channel:channelListTag channelElementName="channelIds" channelList="${cdbooGroupChild.childChannelList }" userElementId="userId"></channel:channelListTag>
			</div>
		</div>
		
		<div class="form-actions">
			<input id="assignButton" class="btn btn-primary" type="button" value="分配频道" onclick="openMappingWin()"/>
			<shiro:hasPermission name="channel:groupChannel:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>