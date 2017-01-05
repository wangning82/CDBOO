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
			var style = '${Constants.THEMETYPE_STYLE }';
			
			$('#themeConcreteType').empty();
			$('#themeConcreteType').append('<option value="">请选择</option>');
			
			var dictList;
			if(selectVal == theme){
				dictList = ${fns:toJson(fns:getDictList('season_type'))};
			}
			if(selectVal == holiday){
				dictList = ${fns:toJson(fns:getDictList('holiday_type'))};
			}
			if(selectVal == style){
				dictList = ${fns:toJson(fns:getDictList('style_type'))};
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
		<li><a href="${ctx}/channel/cdbooChannel/">频道信息列表</a></li>
		<li class="active"><a href="${ctx}/channel/cdbooChannel/form?id=${cdbooChannel.id}">频道信息<shiro:hasPermission name="channel:cdbooChannel:edit">${not empty cdbooChannel.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="channel:cdbooChannel:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cdbooChannel" action="${ctx}/channel/cdbooChannel/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden" id="channelType" name="channelType" value="${Constants.CHANNEL_TYPE_CHILD }">
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">频道编号：</label>
			<div class="controls">
				<form:input path="channelNo" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">频道名称：</label>
			<div class="controls">
				<form:input path="channelName" htmlEscape="false" maxlength="200" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">频道版本：</label>
			<div class="controls">
				<form:input path="channelVersion" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">频道图片：</label>
			<div class="controls">
				<input type="hidden" id="photoPath" name="photoPath" value="${cdbooChannel.photoPath }" required>
				<sys:ckfinder input="photoPath" type="images"  uploadPath="/images" selectMultiple="false" maxWidth="100" maxHeight="100"/>
				
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">风格类型：</label>
			<div class="controls">
				<form:select id="themeType" path="themeType" class="input-xlarge " onchange="changeThemeConcreteType(this.value)">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('theme_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">风格类型明细：</label>
			<div class="controls">
				<form:select id="themeConcreteType" path="themeConcreteType" class="input-xlarge ">
					<form:option value="" label="请选择"/>
					<form:options items="${themeConcreteTypeList}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">场所：</label>
			<div class="controls">
				<form:select path="site" class="input-xlarge ">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('site_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">速度：</label>
			<div class="controls">
				<form:select path="speed" class="input-xlarge ">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('speed_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">人声：</label>
			<div class="controls">
				<form:select path="voice" class="input-xlarge ">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('voice_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">音乐风格：</label>
			<div class="controls">
				<form:checkboxes path="musicStyleList" items="${allMusicStyleList}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">元素：</label>
			<div class="controls">
				<form:checkboxes path="elementTypeList" items="${allElementTypeList}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">情绪：</label>
			<div class="controls">
				<form:checkboxes path="emotionTypeList" items="${allEmotionTypeList}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">乐器：</label>
			<div class="controls">
				<form:checkboxes path="instrumentTypeList" items="${allInstrumentTypeList}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="channel:cdbooChannel:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>