<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>消息策略管理</title>
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
	<%--<ul class="nav nav-tabs">--%>
		<%--<li class="active"><a href="${ctx}/noticetactic/cabinetmsNoticeTactic/">消息策略列表</a></li>--%>
		<%--<shiro:hasPermission name="noticetactic:cabinetmsNoticeTactic:edit"><li><a href="${ctx}/noticetactic/cabinetmsNoticeTactic/form">消息策略添加</a></li></shiro:hasPermission>--%>
	<%--</ul>--%>
	<form:form id="searchForm" modelAttribute="cabinetmsNoticeTactic" action="${ctx}/noticetactic/cabinetmsNoticeTactic/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>策略编号：</label>
				<form:input path="no" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>策略名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>消息编号：</label>
				<form:input path="noticeNo" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>消息名称：</label>
				<form:input path="noticeName" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>状态：</label>
				<form:select path="status" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>创建时间：</label>
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${cabinetmsNoticeTactic.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${cabinetmsNoticeTactic.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>策略名称</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="noticetactic:cabinetmsNoticeTactic:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cabinetmsNoticeTactic">
			<tr>
				<td><a href="${ctx}/noticetactic/cabinetmsNoticeTactic/form?id=${cabinetmsNoticeTactic.id}">
					${cabinetmsNoticeTactic.name}
				</a></td>
				<td>
					<fmt:formatDate value="${cabinetmsNoticeTactic.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${cabinetmsNoticeTactic.remarks}
				</td>
				<shiro:hasPermission name="noticetactic:cabinetmsNoticeTactic:edit"><td>
    				<a href="${ctx}/noticetactic/cabinetmsNoticeTactic/form?id=${cabinetmsNoticeTactic.id}">修改</a>
					<a href="${ctx}/noticetactic/cabinetmsNoticeTactic/delete?id=${cabinetmsNoticeTactic.id}" onclick="return confirmx('确认要删除该消息策略吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>