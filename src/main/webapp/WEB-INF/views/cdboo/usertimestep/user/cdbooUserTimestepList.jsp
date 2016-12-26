<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户时段管理</title>
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
		
		function userTreeselectCallBack(v, h, f){
			var userId = $('#userId').val();
			$.ajax({
		        type: "post",
		        async: false,
		        url: "getTimeStepListByUser",
		        data: {
		        	userId: userId
		        },
		        dataType: "json",
		        success: function (data) {
		        	$('#name').empty();
					$('#name').append('<option value="" selected>请选择</option>');
					
			       	var dataArray = eval(data);
			       	for(var i = 0;i<dataArray.length;i++){
			       		var name = dataArray[i].name;
			       		$('#name').append('<option value="'+name+'">'+name+'</option>');
			       	}
		        }
		    });
		}			
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/usertimestep/userTimestep/">用户时段列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="cdbooUserTimestep" action="${ctx}/usertimestep/userTimestep/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<form:hidden id="userId" path="user.id" />
		<ul class="ul-form">
			<li><label>用户名称：</label>
				${fns:getUserById(cdbooUserTimestep.user.id).name}
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
				<th>用户名称</th>
				<th>时段名称</th>
				<th>开始时间</th>
				<th>结束时间</th>
				<th>创建人</th>
				<th>创建时间</th>
				<shiro:hasPermission name="usertimestep:userTimestep:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cdbooUserTimestep">
			<tr>
				<td><a href="${ctx}/usertimestep/userTimestep/form?id=${cdbooUserTimestep.id}">
					${cdbooUserTimestep.user.name}
				</a></td>
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
				<shiro:hasPermission name="usertimestep:userTimestep:edit"><td>
    				<a href="${ctx}/usertimestep/userTimestep/form?id=${cdbooUserTimestep.id}">修改</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>