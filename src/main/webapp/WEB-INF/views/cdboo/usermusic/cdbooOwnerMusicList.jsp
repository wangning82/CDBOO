<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户曲库信息管理</title>
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
		<li class="active"><a href="${ctx}/usermusic/cdbooOwnerMusic/">用户曲库信息列表</a></li>
		<shiro:hasPermission name="usermusic:cdbooOwnerMusic:edit"><li><a href="${ctx}/usermusic/cdbooOwnerMusic/form">用户曲库信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cdbooOwnerMusic" action="${ctx}/usermusic/cdbooOwnerMusic/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>音乐id：</label>
				<form:select path="musicId" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>用户id：</label>
				<form:select path="user.id" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>音乐id</th>
				<th>用户id</th>
				<th>创建者</th>
				<th>创建时间</th>
				<shiro:hasPermission name="usermusic:cdbooOwnerMusic:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cdbooOwnerMusic">
			<tr>
				<td><a href="${ctx}/usermusic/cdbooOwnerMusic/form?id=${cdbooOwnerMusic.id}">
					${fns:getDictLabel(cdbooOwnerMusic.musicId, '', '')}
				</a></td>
				<td>
					${fns:getDictLabel(cdbooOwnerMusic.user.id, '', '')}
				</td>
				<td>
					${cdbooOwnerMusic.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${cdbooOwnerMusic.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="usermusic:cdbooOwnerMusic:edit"><td>
    				<a href="${ctx}/usermusic/cdbooOwnerMusic/form?id=${cdbooOwnerMusic.id}">修改</a>
					<a href="${ctx}/usermusic/cdbooOwnerMusic/delete?id=${cdbooOwnerMusic.id}" onclick="return confirmx('确认要删除该用户曲库信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>