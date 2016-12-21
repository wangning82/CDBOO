<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>插播计划管理</title>
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
		<li class="active"><a href="${ctx}/musicinsert/cdbooMusicInsert/">插播计划列表</a></li>
		<shiro:hasPermission name="musicinsert:cdbooMusicInsert:edit"><li><a href="${ctx}/musicinsert/cdbooMusicInsert/form">插播计划添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cdbooMusicInsert" action="${ctx}/musicinsert/cdbooMusicInsert/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>插播编号：</label>
				<form:input path="insertNo" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>插播名称：</label>
				<form:input path="insertName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>用户：</label>
				<sys:treeselect id="user" name="user.id" value="${cdbooMusicInsert.user.id}" labelName="user.name" labelValue="${cdbooMusicInsert.user.name}"
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
				<th>插播编号</th>
				<th>插播名称</th>
				<th>开始日期</th>
				<th>结束日期</th>
				<th>音乐</th>
				<th>时间点</th>
				<th>循环次数</th>
				<th>创建者</th>
				<th>创建时间</th>
				<th>用户</th>
				<shiro:hasPermission name="musicinsert:cdbooMusicInsert:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cdbooMusicInsert">
			<tr>
				<td><a href="${ctx}/musicinsert/cdbooMusicInsert/form?id=${cdbooMusicInsert.id}">
					${cdbooMusicInsert.insertNo}
				</a></td>
				<td>
					${cdbooMusicInsert.insertName}
				</td>
				<td>
					<fmt:formatDate value="${cdbooMusicInsert.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${cdbooMusicInsert.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${cdbooMusicInsert.musicId}
				</td>
				<td>
					${cdbooMusicInsert.time}
				</td>
				<td>
					${cdbooMusicInsert.number}
				</td>
				<td>
					${cdbooMusicInsert.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${cdbooMusicInsert.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${cdbooMusicInsert.user.name}
				</td>
				<shiro:hasPermission name="musicinsert:cdbooMusicInsert:edit"><td>
    				<a href="${ctx}/musicinsert/cdbooMusicInsert/form?id=${cdbooMusicInsert.id}">修改</a>
					<a href="${ctx}/musicinsert/cdbooMusicInsert/delete?id=${cdbooMusicInsert.id}" onclick="return confirmx('确认要删除该插播计划吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>