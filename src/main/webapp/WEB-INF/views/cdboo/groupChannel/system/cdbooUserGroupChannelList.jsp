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
		<li class="active"><a href="${ctx}/channel/groupChannel/user/">用户组合频道信息列表</a></li>
		<shiro:hasPermission name="channel:groupChannel:user:edit"><li><a href="${ctx}/channel/groupChannel/user/form">用户组合频道信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cdbooUserChannel" action="${ctx}/channel/groupChannel/user/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>用户：</label>
				<sys:treeselect id="user" name="user.id" value="${cdbooUserChannel.user.id}" labelName="user.name" labelValue="${cdbooUserChannel.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>组合频道：</label>
				<form:select id="groupId" path="channel.id" class="input-medium">
					<form:option value="" label="请选择"/>
					<form:options items="${cdbooUserChannel.channelList }" itemLabel="channelName" itemValue="id"/>
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
				<th>频道编号</th>
				<th>频道名称</th>
				<th>频道图片</th>
				<th>频道版本</th>
				<th>子频道数量</th>
				<th>创建时间</th>
				<shiro:hasPermission name="channel:groupChannel:user:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="userChannel">
			<tr>
				<td>
					${userChannel.user.name}
				</td>
				<td><a href="${ctx}/channel/groupChannel/user/form?id=${userChannel.id}">
					${userChannel.channel.channelNo}
				</a></td>
				<td>
					${userChannel.channel.channelName}
				</td>
				<td>
					<pic:preview path="${userChannel.channel.photoPath}" ></pic:preview>
				</td>
				<td>
					${userChannel.channel.channelVersion}
				</td>
				<td>
					${userChannel.childChannelSize}
				</td>
				<td>
					<fmt:formatDate value="${userChannel.channel.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="channel:groupChannel:user:edit"><td>
    				<a href="${ctx}/channel/groupChannel/user/form?id=${userChannel.id}">查看</a>
					<a href="${ctx}/channel/groupChannel/user/delete?id=${userChannel.id}" onclick="return confirmx('确认要删除该频道信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>