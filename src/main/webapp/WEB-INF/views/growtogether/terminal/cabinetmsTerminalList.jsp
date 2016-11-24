<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>终端管理管理</title>
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

        function screenshot(id) {
			$.ajax({
				type: "POST",
				url: "${ctx}/terminal/cabinetmsTerminal/screenshot",
				data: {
					id: id
				},
				dataType: "json",
				success: function (data) {

				}
			});
			var index = 0;
			while(index < 3){
				var picpath = getPic(id);
				if(picpath != ""){
					window.open(${pageContext.request.contextPath}picpath);
					break;
				}else{
					index ++;
				}
			}

		}

		function getPic(id){
			var screenshot = "";
			$.ajax({
				type: "POST",
				url: "${ctx}/terminal/cabinetmsTerminal/findTerminal",
				data: {
					id: id
				},
				async: false,
				dataType: "json",
				success: function (data) {
					screenshot = data.screenshot;
				}
			});
			return screenshot;
		}

		function shutdown(id) {
			$.ajax({
				type: "POST",
				url: "${ctx}/terminal/cabinetmsTerminal/shutdown",
				data: {
					id: id
				},
				dataType: "json",
				success: function (data) {

				}
			});
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/terminal/cabinetmsTerminal/">终端管理列表</a></li>
		<shiro:hasPermission name="terminal:cabinetmsTerminal:edit"><li><a href="${ctx}/terminal/cabinetmsTerminal/form">终端管理添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cabinetmsTerminal" action="${ctx}/terminal/cabinetmsTerminal/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>终端名称：</label>
				<form:input path="terminalName" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>终端IP：</label>
				<form:input path="terminalIp" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>机构：</label>
				<sys:treeselect id="office" name="office.id" value="${cabinetmsTerminal.office.id}" labelName="office.name" labelValue="${cabinetmsTerminal.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>节目策略：</label>
				<form:select path="programTactic.id" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>终端状态：</label>
				<form:select path="status" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('terminal_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				<th style="width: 10%">终端名称</th>
				<th style="width: 10%">终端IP</th>
				<th style="width: 10%">机构</th>
				<th style="width: 14%">节目策略</th>
				<th style="width: 14%">消息</th>
				<th style="width: 8%">终端状态</th>
				<th style="width: 12%">更新时间</th>
				<th style="width: 12%">备注</th>
				<shiro:hasPermission name="terminal:cabinetmsTerminal:edit">
					<th style="width: 10%">操作</th>
				</shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cabinetmsTerminal">
			<tr>
				<td><a href="${ctx}/terminal/cabinetmsTerminal/form?id=${cabinetmsTerminal.id}">
					${cabinetmsTerminal.terminalName}
				</a></td>
				<td>
					${cabinetmsTerminal.terminalIp}
				</td>
				<td>
					${cabinetmsTerminal.office.name}
				</td>
				<td>
					${cabinetmsTerminal.programTactic.name}
				</td>
				<td>
					${cabinetmsTerminal.notice.noticeName}
				</td>
				<td>
					${fns:getDictLabel(cabinetmsTerminal.status, 'terminal_status', '')}
				</td>
				<td>
					<fmt:formatDate value="${cabinetmsTerminal.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${cabinetmsTerminal.remarks}
				</td>
				<shiro:hasPermission name="terminal:cabinetmsTerminal:edit">
					<td>
						<a href="${ctx}/terminal/cabinetmsTerminal/form?id=${cabinetmsTerminal.id}">修改</a>&nbsp;
						<a href="${ctx}/terminal/cabinetmsTerminal/delete?id=${cabinetmsTerminal.id}" onclick="return confirmx('确认要删除该终端管理吗？', this.href)">删除</a>
						<c:if test="${cabinetmsTerminal.status != '4'}">
							<a href="javascript:void(0)" onclick="screenshot('${cabinetmsTerminal.id}');">截屏</a>&nbsp;
							<a href="javascript:void(0)" onclick="shutdown('${cabinetmsTerminal.id}');">关机</a>
						</c:if>
					</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>