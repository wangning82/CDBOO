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
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/channel/groupChannel/front/user/">组合频道信息列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="cdbooUserGroup" action="${ctx}/channel/groupChannel/front/user/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>用户：</label>
				${fns:getUser().name }
				<input type="hidden" id="userId" name="user.id" value="${fns:getUser().id }"/>
			</li>
			<li><label>组合频道：</label>
				<form:select id="groupId" path="cdbooChannel.id" class="input-medium">
					<form:option value="" label="请选择"/>
					<form:options items="${cdbooUserGroup.channelList }" itemLabel="channelName" itemValue="id"/>
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
				<th>频道编号</th>
				<th>频道名称</th>
				<th>频道图片</th>
				<th>频道版本</th>
				<th>子频道数量</th>
				<th>创建时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="userGroup">
			<tr>
				<td><a href="${ctx}/channel/groupChannel/front/user/form?cdbooChannel.id=${userGroup.cdbooChannel.id}&user.id=${userGroup.user.id}">
					${userGroup.cdbooChannel.channelNo}
				</a></td>
				<td>
					${userGroup.cdbooChannel.channelName}
				</td>
				<td>
					<pic:preview path="${userGroup.cdbooChannel.photoPath}" ></pic:preview>
				</td>
				<td>
					${userGroup.cdbooChannel.channelVersion}
				</td>
				<td>
					${userGroup.childChannelSize}
				</td>
				<td>
					<fmt:formatDate value="${userGroup.cdbooChannel.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
    				<a href="${ctx}/channel/groupChannel/front/user/form?cdbooChannel.id=${userGroup.cdbooChannel.id}&user.id=${userGroup.user.id}">查看</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>