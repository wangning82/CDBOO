<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>节目管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					var programFile = $('#programFile').val();
					if (programFile == '') {
						top.$.jBox.info('请选择节目文件!', '提示', {closed:function() {
						}});
					} else {
						loading('正在提交，请稍等...');
						form.submit();
					}
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


		function templateChanged() {
			var modelName = $('#modelName').val();

			$.ajax({
				type: 'POST',
				url: "${ctx}/program/program/template",
				dataType: "json",
				data: {
					modelName: modelName
				},
				success: function(data, textStatus) {
					$('#templateContent').val(data.templateContent);
				}

			});


		}

	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/program/program/">节目管理列表</a></li>
		<li class="active"><a href="${ctx}/program/program/form?id=${program.id}">节目管理<shiro:hasPermission name="program:program:edit">${not empty program.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="program:program:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="program" action="${ctx}/program/program/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<%--<div class="control-group">--%>
			<%--<label class="control-label">节目编号：</label>--%>
			<%--<div class="controls">--%>
				<%--<form:input path="no" htmlEscape="false" maxlength="64" class="input-xlarge "/>--%>
			<%--</div>--%>
		<%--</div>--%>

		<div class="control-group">
			<label class="control-label">节目名称：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">模版名称：</label>
			<div class="controls">
				<form:select path="modelName" class="input-xlarge required">
					<form:option value="" label="" />
					<form:options items="${fns:getDictList('template_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">节目标题：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">节目文件：</label>
			<div class="controls">
				<form:hidden id="programFile" path="programFile" htmlEscape="false" maxlength="255" class="input-xlarge" />
				<sys:ckfinder input="programFile" type="files" uploadPath="/programFile" selectMultiple="true" />
			</div>
		</div>

		<%--<div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				<form:select path="status" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('program_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>--%>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>

		<%--<div class="control-group">
			<label class="control-label">模板内容：</label>
			<div class="controls">
				<textarea id="templateContent" rows="4" maxlength="5000" class="input-xxlarge "></textarea>
			</div>
		</div>--%>

		<div class="form-actions">
			<c:if test="${program.id == null || program.status == '1'}">
				<shiro:hasPermission name="program:program:edit">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
				</shiro:hasPermission>
			</c:if>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>