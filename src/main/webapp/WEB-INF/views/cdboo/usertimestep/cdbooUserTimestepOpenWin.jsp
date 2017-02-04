<%@ page contentType="text/html;charset=UTF-8" import="com.cdboo.common.Constants"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>频道信息管理</title>
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
		
		function UserTimestepEntity(id,name,startTime,endTime){
			this.id = id;
			this.name = name;
			this.startTime = startTime;
			this.endTime = endTime;
		}
		
		function getCheckData(){
			var checkArray = new Array();
			$('input[name="userTimestepIds"]:checkbox:checked').each(function(){
				var id = $(this).val();
				var idName = $(this).attr('id');
				var idNameArray = idName.split("_");
				var rowIndex = idNameArray[1];
				var name = $('#name_'+rowIndex).val();
				var startTime = $('#startTime_'+rowIndex).val();
				var endTime = $('#endTime_'+rowIndex).val();
				var userTimestep = new UserTimestepEntity(id,name,startTime,endTime);
				checkArray.push(userTimestep);
			});
			return checkArray;
		}
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="cdbooUserTimestep" action="${ctx}/usertimestep/cdbooUserTimestep/openUserTimestepWin" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<form:hidden path="userId"/>
		<form:hidden path="ids"/>
		<ul class="ul-form">
			<li><label>用户：</label>
				<sys:treeselect id="user" name="user.id" value="${cdbooUserTimestep.user.id}" labelName="user.name" labelValue="${cdbooUserTimestep.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>时段名称：</label>
				<form:select id="name" path="name" class="input-medium">
					<form:option value="" label="请选择"/>
					<form:options items="${cdbooUserTimestep.timestepList }" itemLabel="name" itemValue="name"/>
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
				<th><input type="checkbox" onclick="changeCB(this.checked,'userTimestepIds')" /></th>
				<th>用户名称</th>
				<th>时段名称</th>
				<th>开始时间</th>
				<th>结束时间</th>
				<th>创建人</th>
				<th>创建时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cdbooUserTimestep" varStatus="status">
			<tr>
				<td>
					<input type="checkbox" id="id_${status.index }" name="userTimestepIds" value="${cdbooUserTimestep.id}" />
					<input type="hidden" id="name_${status.index }" value = "${cdbooUserTimestep.name}"/>
					<input type="hidden" id="startTime_${status.index }" value = "${cdbooUserTimestep.startTime}"/>
					<input type="hidden" id="endTime_${status.index }" value = "${cdbooUserTimestep.endTime}"/>
				</td>
				<td>
					${cdbooUserTimestep.user.name}
				</td>
				<td>
					${cdbooUserTimestep.name}
				</td>
				<td>
					${cdbooUserTimestep.startTime}
				</td>
				<td>
					${cdbooUserTimestep.endTime}
				</td>
				<td>
					${fns:getUserById(cdbooUserTimestep.createBy.id).name}
				</td>
				<td>
					<fmt:formatDate value="${cdbooUserTimestep.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>