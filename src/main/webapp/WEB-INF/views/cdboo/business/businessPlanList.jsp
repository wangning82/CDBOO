<%@ page contentType="text/html;charset=UTF-8" import="com.cdboo.common.Constants" %>
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
		function redirect(){
			$('#addForm').submit();
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/businessplan/plan/listTimestep">行业计划列表</a></li>
		<c:if test="${not empty businessPlan.business && not empty businessPlan.business.id}">
			<shiro:hasPermission name="businessplan:plan:edit"><li><a href="#" onclick="redirect()">行业计划添加</a></li></shiro:hasPermission>
		</c:if>
	</ul>
	<form action="${ctx}/businessplan/plan/form" id="addForm">
		<input type="hidden" name="business.id" value="${businessPlan.business.id}">
	</form>
	<form:form id="searchForm" modelAttribute="businessPlan" action="${ctx}/businessplan/plan/listTimestep" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		
		<ul class="ul-form">
			<li><label>计划名称：</label>
				<form:input path="planName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>风格：</label>
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
				<th>风格</th>
				<th>日期区间</th>
				<th>循环次数</th>
				<th>重复时间</th>
				<th>备注</th>
				<shiro:hasPermission name="businessplan:plan:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cdbooMyPlan">
			<tr>
				<td><a href="${ctx}/businessplan/plan/form?id=${cdbooMyPlan.id}">
					${cdbooMyPlan.planName}
				</a></td>
				<td>
					${fns:getDictLabel(cdbooMyPlan.style, 'theme_type', '')}
				</td>
				<td>
					<!-- 如果是主题或者风格，显示星期中文字符串-->
					<c:if test="${cdbooMyPlan.style eq Constants.THEMETYPE_THEME || cdbooMyPlan.style eq Constants.THEMETYPE_STYLE}">
						${fns:getChineseWeek(cdbooMyPlan.week) }
					</c:if>
					<!-- 如果不是主题或者风格，显示日期段，只有两种情况，就是插播或者节日-->
					<c:if test="${cdbooMyPlan.style ne Constants.THEMETYPE_THEME && cdbooMyPlan.style ne Constants.THEMETYPE_STYLE}">
						<fmt:formatDate value="${cdbooMyPlan.startDate}" pattern="yyyy-MM-dd"/>到<fmt:formatDate value="${cdbooMyPlan.endDate}" pattern="yyyy-MM-dd"/>
					</c:if>
				</td>
				<td>
					<!-- 如果是插播，显示循环次数-->
					<c:if test="${cdbooMyPlan.style eq Constants.THEMETYPE_SPOTS}">
						${cdbooMyPlan.cycleIndex}次
					</c:if>
				</td>
				<td>
					<!-- 如果是插播，显示循环次数-->
					<c:if test="${cdbooMyPlan.style eq Constants.THEMETYPE_SPOTS}">
						${cdbooMyPlan.intervalTime}分钟
					</c:if>
				</td>
				<td>
					${cdbooMyPlan.remarks}
				</td>
				<shiro:hasPermission name="businessplan:plan:edit"><td>
    				<a href="${ctx}/businessplan/plan/form?id=${cdbooMyPlan.id}">修改</a>
					<a href="${ctx}/businessplan/plan/delete?id=${cdbooMyPlan.id}" onclick="return confirmx('确认要删除该计划吗？', this.href)">删除</a>
					<a href="${ctx}/businessplan/plan/toEditTimestepPage?id=${cdbooMyPlan.id}">编辑时段</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>