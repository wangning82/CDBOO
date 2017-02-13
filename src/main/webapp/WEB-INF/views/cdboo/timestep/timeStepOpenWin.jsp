<%@ page contentType="text/html;charset=UTF-8" import="com.cdboo.common.Constants"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>时段信息管理</title>
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
		
		function timestepEntity(id,name,startTime,endTime){
			this.id = id;
			this.name = name;
			this.startTime = startTime;
			this.endTime = endTime;
		}
		
		function getCheckData(){
			var checkArray = new Array();
			$('input[name="timestepIds"]:checkbox:checked').each(function(){
				var id = $(this).val();
				var idName = $(this).attr('id');
				var idNameArray = idName.split("_");
				var rowIndex = idNameArray[1];
				var name = $('#name_'+rowIndex).val();
				var startTime = $('#startTime_'+rowIndex).val();
				var endTime = $('#endTime_'+rowIndex).val();
				var timestep = new timestepEntity(id,name,startTime,endTime);
				checkArray.push(timestep);
			});
			return checkArray;
		}
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="timestep" action="${ctx}/timestep/timestep/openTimestepWin" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<form:hidden path="ids"/>
		<ul class="ul-form">
			<li><label>时段编号：</label>
				<form:input path="timestepNo" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>时段名称：</label>
				<form:input path="timestepName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th><input type="checkbox" onclick="changeCB(this.checked,'timestepIds')" /></th>
				<th>时段编号</th>
				<th>时段名称</th>
				<th>开始时间</th>
				<th>结束时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="timestep" varStatus="status">
			<tr>
				<td>
					<input type="checkbox" id="id_${status.index }" name="timestepIds" value="${timestep.id}" />
					<input type="hidden" id="name_${status.index }" value = "${timestep.timestepName}"/>
					<input type="hidden" id="startTime_${status.index }" value = "${timestep.starttime}"/>
					<input type="hidden" id="endTime_${status.index }" value = "${timestep.endtime}"/>
				</td>
				<td>
					${timestep.timestepNo}
				</td>
				<td>
					${timestep.timestepName}
				</td>
				<td>
					${timestep.starttime}
				</td>
				<td>
					${timestep.endtime}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>