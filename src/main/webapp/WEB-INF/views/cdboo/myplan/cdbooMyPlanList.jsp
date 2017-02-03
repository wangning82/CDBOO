<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>计划管理</title>
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
		<li class="active"><a href="${ctx}/myplan/cdbooMyPlan/">计划列表</a></li>
		<shiro:hasPermission name="myplan:cdbooMyPlan:edit"><li><a href="${ctx}/myplan/cdbooMyPlan/form">计划添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cdbooMyPlan" action="${ctx}/myplan/cdbooMyPlan/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>计划名称：</label>
				<form:input path="planName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>用户id：</label>
				<sys:treeselect id="user" name="user.id" value="${cdbooMyPlan.user.id}" labelName="user.name" labelValue="${cdbooMyPlan.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>风格（主题，节日，计划，插播）：</label>
				<form:select path="style" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('theme_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				<th>计划名称</th>
				<th>用户id</th>
				<th>周属性</th>
				<th>风格（主题，节日，计划，插播）</th>
				<th>开始日期</th>
				<th>结束日期</th>
				<th>循环次数</th>
				<th>重复时间</th>
				<shiro:hasPermission name="myplan:cdbooMyPlan:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cdbooMyPlan">
			<tr>
				<td><a href="${ctx}/myplan/cdbooMyPlan/form?id=${cdbooMyPlan.id}">
					${cdbooMyPlan.planName}
				</a></td>
				<td>
					${cdbooMyPlan.user.name}
				</td>
				<td>
					${cdbooMyPlan.week}
				</td>
				<td>
					${fns:getDictLabel(cdbooMyPlan.style, 'theme_type', '')}
				</td>
				<td>
					<fmt:formatDate value="${cdbooMyPlan.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${cdbooMyPlan.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${cdbooMyPlan.cycleIndex}
				</td>
				<td>
					${cdbooMyPlan.intervalTime}
				</td>
				<shiro:hasPermission name="myplan:cdbooMyPlan:edit"><td>
    				<a href="${ctx}/myplan/cdbooMyPlan/form?id=${cdbooMyPlan.id}">修改</a>
					<a href="${ctx}/myplan/cdbooMyPlan/delete?id=${cdbooMyPlan.id}" onclick="return confirmx('确认要删除该计划吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>