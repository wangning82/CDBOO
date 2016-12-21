<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户服务信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/userservice/cdbooUserService/">用户服务信息列表</a></li>
		<shiro:hasPermission name="userservice:cdbooUserService:edit"><li><a href="${ctx}/userservice/cdbooUserService/form">用户服务信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cdbooUserService" action="${ctx}/userservice/cdbooUserService/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>用户id：</label>
				<sys:treeselect id="user" name="user.id" value="${cdbooUserService.user.id}" labelName="user.name" labelValue="${cdbooUserService.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>用户id</th>
				<th>合同开始时间</th>
				<th>合同结束时间</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="userservice:cdbooUserService:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cdbooUserService">
			<tr>
				<td><a href="${ctx}/userservice/cdbooUserService/form?id=${cdbooUserService.id}">
					${cdbooUserService.user.name}
				</a></td>
				<td>
					<fmt:formatDate value="${cdbooUserService.contractStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${cdbooUserService.contractEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${cdbooUserService.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${cdbooUserService.remarks}
				</td>
				<shiro:hasPermission name="userservice:cdbooUserService:edit"><td>
    				<a href="${ctx}/userservice/cdbooUserService/form?id=${cdbooUserService.id}">修改</a>
					<a href="${ctx}/userservice/cdbooUserService/delete?id=${cdbooUserService.id}" onclick="return confirmx('确认要删除该用户服务信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>