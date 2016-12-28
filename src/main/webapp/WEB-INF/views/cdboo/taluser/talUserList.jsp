<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<%--<title>home管理</title>--%>
	<%--<meta name="decorator" content="default"/>--%>
	<%--<script type="text/javascript">--%>
		<%--$(document).ready(function() {--%>
			<%----%>
		<%--});--%>
		<%--function page(n,s){--%>
			<%--$("#pageNo").val(n);--%>
			<%--$("#pageSize").val(s);--%>
			<%--$("#searchForm").submit();--%>
        	<%--return false;--%>
        <%--}--%>
	<%--</script>--%>
</head>
<body style="overflow:hidden">
<div id="Layer1" style="position:absolute; width:100%; height:100%; z-index:-1">
	<img src="${ctxStatic}/cdboo/images/indexback.jpg" height="100%" width="100%"/>
</div>
	<%--<ul class="nav nav-tabs">--%>
		<%--<li class="active"><a href="${ctx}/taluser/talUser/">home列表</a></li>--%>
		<%--<shiro:hasPermission name="taluser:talUser:edit"><li><a href="${ctx}/taluser/talUser/form">home添加</a></li></shiro:hasPermission>--%>
	<%--</ul>--%>
	<%--<form:form id="searchForm" modelAttribute="talUser" action="${ctx}/taluser/talUser/" method="post" class="breadcrumb form-search">--%>
		<%--<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>--%>
		<%--<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>--%>
		<%--<ul class="ul-form">--%>
			<%--<li><label>登录名：</label>--%>
				<%--<form:input path="loginName" htmlEscape="false" maxlength="100" class="input-medium"/>--%>
			<%--</li>--%>
			<%--<li><label>昵称：</label>--%>
				<%--<form:input path="nickname" htmlEscape="false" maxlength="100" class="input-medium"/>--%>
			<%--</li>--%>
			<%--<li><label>邮箱：</label>--%>
				<%--<form:input path="email" htmlEscape="false" maxlength="200" class="input-medium"/>--%>
			<%--</li>--%>
			<%--<li><label>电话：</label>--%>
				<%--<form:input path="phone" htmlEscape="false" maxlength="200" class="input-medium"/>--%>
			<%--</li>--%>
			<%--<li><label>用户头像：</label>--%>
				<%--<form:input path="photo" htmlEscape="false" maxlength="1000" class="input-medium"/>--%>
			<%--</li>--%>
			<%--<li><label>最后登陆IP：</label>--%>
				<%--<form:input path="loginIp" htmlEscape="false" maxlength="100" class="input-medium"/>--%>
			<%--</li>--%>
			<%--<li><label>最后登陆时间：</label>--%>
				<%--<input name="loginDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"--%>
					<%--value="<fmt:formatDate value="${talUser.loginDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"--%>
					<%--onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>--%>
			<%--</li>--%>
			<%--<li><label>创建时间：</label>--%>
				<%--<input name="createDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"--%>
					<%--value="<fmt:formatDate value="${talUser.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"--%>
					<%--onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>--%>
			<%--</li>--%>
			<%--<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>--%>
			<%--<li class="clearfix"></li>--%>
		<%--</ul>--%>
	<%--</form:form>--%>
	<%--<sys:message content="${message}"/>--%>
	<%--<table id="contentTable" class="table table-striped table-bordered table-condensed">--%>
		<%--<thead>--%>
			<%--<tr>--%>
				<%--<th>登录名</th>--%>
				<%--<th>昵称</th>--%>
				<%--<th>邮箱</th>--%>
				<%--<th>电话</th>--%>
				<%--<th>用户头像</th>--%>
				<%--<th>最后登陆IP</th>--%>
				<%--<th>最后登陆时间</th>--%>
				<%--<th>创建时间</th>--%>
				<%--<shiro:hasPermission name="taluser:talUser:edit"><th>操作</th></shiro:hasPermission>--%>
			<%--</tr>--%>
		<%--</thead>--%>
		<%--<tbody>--%>
		<%--<c:forEach items="${page.list}" var="talUser">--%>
			<%--<tr>--%>
				<%--<td><a href="${ctx}/taluser/talUser/form?id=${talUser.id}">--%>
					<%--${talUser.loginName}--%>
				<%--</a></td>--%>
				<%--<td>--%>
					<%--${talUser.nickname}--%>
				<%--</td>--%>
				<%--<td>--%>
					<%--${talUser.email}--%>
				<%--</td>--%>
				<%--<td>--%>
					<%--${talUser.phone}--%>
				<%--</td>--%>
				<%--<td>--%>
					<%--${talUser.photo}--%>
				<%--</td>--%>
				<%--<td>--%>
					<%--${talUser.loginIp}--%>
				<%--</td>--%>
				<%--<td>--%>
					<%--<fmt:formatDate value="${talUser.loginDate}" pattern="yyyy-MM-dd HH:mm:ss"/>--%>
				<%--</td>--%>
				<%--<td>--%>
					<%--<fmt:formatDate value="${talUser.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>--%>
				<%--</td>--%>
				<%--<shiro:hasPermission name="taluser:talUser:edit"><td>--%>
    				<%--<a href="${ctx}/taluser/talUser/form?id=${talUser.id}">修改</a>--%>
					<%--<a href="${ctx}/taluser/talUser/delete?id=${talUser.id}" onclick="return confirmx('确认要删除该home吗？', this.href)">删除</a>--%>
				<%--</td></shiro:hasPermission>--%>
			<%--</tr>--%>
		<%--</c:forEach>--%>
		<%--</tbody>--%>
	<%--</table>--%>
	<%--<div class="pagination">${page}</div>--%>
</body>
</html>