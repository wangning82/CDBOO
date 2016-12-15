<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>行业时段管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#no").focus();
            $("#inputForm").validate({
                rules: {
                    loginName: {remote: "${ctx}/sys/user/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')}
                },
                messages: {
                    loginName: {remote: "用户登录名已存在"},
                    confirmNewPassword: {equalTo: "输入与上面相同的密码"}
                },
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
    <li><a href="${ctx}/business/business/listTimestep">时段列表</a></li>
    <shiro:hasPermission name="business:timestep:edit"><li class="active"><a href="${ctx}/business/business/businessTimestepForm">行业时段添加</a></li></shiro:hasPermission>
</ul><br/>
<form:form id="inputForm" modelAttribute="businessTimestep" action="${ctx}/business/business/businessTimestepSave" method="post" class="form-horizontal">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>

    <input type="hidden" name="delFlag" value="0" />
    <div class="control-group">
        <label class="control-label">行业:</label>
        <div class="controls">
            <sys:treeselect id="business" name="business.id" value="${businessTimestep.business.id}" labelName="business.name" labelValue="${businessTimestep.business.name}"
                            title="行业" url="/business/business/treeData" cssClass="required"/>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">名称:</label>
        <div class="controls">
            <form:input path="name" htmlEscape="false" maxlength="50" class="required"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">时段:</label>
        <div class="controls">
            <form:checkboxes path="timestepIdList" items="${timestepList}" itemLabel="timestepName" itemValue="id" htmlEscape="false" class="required"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">备注:</label>
        <div class="controls">
            <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
        </div>
    </div>

    <div class="form-actions">
        <shiro:hasPermission name="sys:user:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>