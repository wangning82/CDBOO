<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户时段管理</title>
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
		
		<c:if test="${empty cdbooUserTimestep.id }">
			function linkTimeStepInfo(timeStepId){
				$('#name').val('');
	        	$('#startTime').val('');
	        	$('#endTime').val('');
	        	$('#remarks').val('');
	        	
				$.ajax({
			        type: "post",
			        async: false,
			        url: "getTimeStep",
			        data: {
			        	timeStepId: timeStepId
			        },
			        dataType: "json",
			        success: function (data) {
						var timeStep = eval(data);
			        	$('#name').val(timeStep.timestepName);
			        	$('#startTime').val(timeStep.starttime);
			        	$('#endTime').val(timeStep.endtime);
			        	$('#remarks').val(timeStep.remarks);
			        }
			   });
			}
		</c:if>
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/usertimestep/cdbooUserTimestep/">用户时段列表</a></li>
		<li class="active"><a href="${ctx}/usertimestep/cdbooUserTimestep/form?id=${cdbooUserTimestep.id}">用户时段<shiro:hasPermission name="usertimestep:cdbooUserTimestep:edit">${not empty cdbooUserTimestep.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="usertimestep:cdbooUserTimestep:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cdbooUserTimestep" action="${ctx}/usertimestep/cdbooUserTimestep/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">用户名称：</label>
			<div class="controls">
				<c:if test="${not empty cdbooUserTimestep.id }">
					<sys:treeselect id="user" disabled="disabled" name="user.id" value="${cdbooUserTimestep.user.id}" labelName="user.name" labelValue="${cdbooUserTimestep.user.name}"
						title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
				</c:if>
				<c:if test="${empty cdbooUserTimestep.id }">
					<sys:treeselect id="user" name="user.id" value="${cdbooUserTimestep.user.id}" labelName="user.name" labelValue="${cdbooUserTimestep.user.name}"
						title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
				</c:if>
			</div>
		</div>
		<c:if test="${empty cdbooUserTimestep.id }">
			<div class="control-group">
				<label class="control-label">时段选择：</label>
				<div class="controls">
						<form:select path="lastTimeStepId" class="input-medium" onchange="linkTimeStepInfo(this.value)">
							<form:option value="" label="请选择"/>
							<form:options items="${cdbooUserTimestep.timestepEntityList }" itemLabel="timestepName" itemValue="id"/>
						</form:select>
				</div>
			</div>
		</c:if>
		<div class="control-group">
			<label class="control-label">时段名称：</label>
			<div class="controls">
				<form:input id="name" path="name" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">开始时间：</label>
			<div class="controls">
				<input id="startTime" name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="${cdbooUserTimestep.startTime}"
					onclick="WdatePicker({dateFmt:'HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">结束时间：</label>
			<div class="controls">
				<input id="endTime" name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="${cdbooUserTimestep.endTime}"
					onclick="WdatePicker({dateFmt:'HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea id="remarks" path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="usertimestep:cdbooUserTimestep:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="javascript:window.location.href='${ctx}/usertimestep/cdbooUserTimestep/'"/>
		</div>
	</form:form>
</body>
</html>