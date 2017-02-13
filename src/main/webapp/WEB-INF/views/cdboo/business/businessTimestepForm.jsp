<%@ page contentType="text/html;charset=UTF-8" import="com.cdboo.common.Constants" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>时段管理</title>
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
		<li><a href="${ctx}/businessplan/plan/listTimestep">行业计划列表</a></li>
		<li class="active"><a href="#">行业时段编辑</a></li>
	</ul><br/>
	
	<form:form id="inputForm" modelAttribute="businessPlan" action="${ctx}/businessplan/plan/saveTimestep" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden" value="${businessPlan.business.id }" name="business.id">
		<sys:message content="${message}"/>		
		
		<timestep:timestep timestepElementName="timeStepIds" businessId="${businessPlan.id }" timestepList="${businessPlan.timesteps }"></timestep:timestep>
		
		<div class="form-actions">
			<shiro:hasPermission name="businessplan:plan:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>