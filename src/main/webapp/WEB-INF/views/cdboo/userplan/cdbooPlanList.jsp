<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户计划管理</title>
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
		<li class="active"><a href="${ctx}/userplan/cdbooPlan/">用户计划列表</a></li>
		<shiro:hasPermission name="userplan:cdbooPlan:edit"><li><a href="${ctx}/userplan/cdbooPlan/form">用户计划添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cdbooPlan" action="${ctx}/userplan/cdbooPlan/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>计划编号：</label>
				<form:input path="planNo" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>计划名称：</label>
				<form:input path="playName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>用户id：</label>
				<sys:treeselect id="user" name="user.id" value="${cdbooPlan.user.id}" labelName="user.name" labelValue="${cdbooPlan.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>用户时段id：</label>
				<form:input path="userTimestepId" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>用户频道id：</label>
				<form:input path="userChannelId" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>风格：</label>
				<form:select path="musicStyle" class="input-medium">
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
				<th>计划编号</th>
				<th>计划名称</th>
				<th>用户id</th>
				<th>用户时段id</th>
				<th>用户频道id</th>
				<th>风格</th>
				<th>日期</th>
				<th>开始日期</th>
				<th>结束日期</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="userplan:cdbooPlan:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cdbooPlan">
			<tr>
				<td><a href="${ctx}/userplan/cdbooPlan/form?id=${cdbooPlan.id}">
					${cdbooPlan.planNo}
				</a></td>
				<td>
					${cdbooPlan.playName}
				</td>
				<td>
					${cdbooPlan.user.name}
				</td>
				<td>
					${cdbooPlan.userTimestepId}
				</td>
				<td>
					${cdbooPlan.userChannelId}
				</td>
				<td>
					${fns:getDictLabel(cdbooPlan.musicStyle, '', '')}
				</td>
				<td>
					${cdbooPlan.week}
				</td>
				<td>
					<fmt:formatDate value="${cdbooPlan.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${cdbooPlan.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${cdbooPlan.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${cdbooPlan.remarks}
				</td>
				<shiro:hasPermission name="userplan:cdbooPlan:edit"><td>
    				<a href="${ctx}/userplan/cdbooPlan/form?id=${cdbooPlan.id}">修改</a>
					<a href="${ctx}/userplan/cdbooPlan/delete?id=${cdbooPlan.id}" onclick="return confirmx('确认要删除该用户计划吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>