<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>策略发布管理</title>
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
		
		//终端对象
		function Term(id,idx){
			this.id = id;
			this.idx = idx;
		}
		
		//父窗口调用收集数据方法
		function getData(){
			var dataArray = new Array();
			$('input[name="termIds"]:checked').each(function(index){
				var termId = $(this).val();
				var term = new Term(termId,index);
				dataArray.push(term);
			});
			return dataArray;
		}
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="cabinetmsProgramTactic" action="${ctx}/programtactic/cabinetmsProgramTactic/termList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th></th>
					<th>终端名称</th>
					<th>所属机构</th>
					<th>ip</th>
					<th>终端状态</th>
					<th>所属策略</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${page.list}" var="term" varStatus="status">
				<tr>
					<td><input type="checkbox" name="termIds" value="${term.id }"/></td>
					<td>
						${term.terminalName}
					</td>
					<td>
						<c:if test="${not empty term.office.id }">
							<c:set value="${fns:getEntity('office',term.office.id)}" var="office"></c:set>
							<c:if test="${not empty office }">
								${office.name }
							</c:if>
						</c:if>
					</td>
					<td>
						${term.terminalIp}
					</td>
					<td>
						${fns:getDictLabel(term.status,'terminal_status','') }
					</td>
					<td>
						<c:if test="${not empty term.programTactic.id }">
							<c:set value="${fns:getEntity('programTactic',term.programTactic.id) }" var="tactic"></c:set>
							<c:if test="${not empty tactic }">
								${tactic.name }
							</c:if>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<div class="pagination">${page}</div>
	</form:form>
</body>
</html>