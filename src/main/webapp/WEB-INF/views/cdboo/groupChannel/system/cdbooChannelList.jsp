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
		<li class="active"><a href="${ctx}/channel/groupChannel/">频道信息列表</a></li>
		<shiro:hasPermission name="channel:groupChannel:edit"><li><a href="${ctx}/channel/groupChannel/form">频道信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cdbooGroupChild" action="${ctx}/channel/groupChannel/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input type="hidden" name="channelType" value="${Constants.CHANNEL_TYPE_GROUP }"/>
		<ul class="ul-form">
			<li><label>组合频道：</label>
				<form:select id="groupId" path="groupChannelId.id" class="input-medium">
					<form:option value="" label="请选择"/>
					<form:options items="${cdbooGroupChild.channelList }" itemLabel="channelName" itemValue="id"/>
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
				<shiro:hasPermission name="channel:groupChannel:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="groupChannel">
			<tr>
				<td><a href="${ctx}/channel/groupChannel/form?groupChannelId.id=${groupChannel.groupChannelId.id}">
					${groupChannel.groupChannelId.channelNo}
				</a></td>
				<td>
					${groupChannel.groupChannelId.channelName}
				</td>
				<td>
					<pic:preview path="${groupChannel.groupChannelId.photoPath}" ></pic:preview>
				</td>
				<td>
					${groupChannel.groupChannelId.channelVersion}
				</td>
				<td>
					${groupChannel.childChannelSize}
				</td>
				<td>
					<fmt:formatDate value="${groupChannel.groupChannelId.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="channel:groupChannel:edit"><td>
    				<a href="${ctx}/channel/groupChannel/form?groupChannelId.id=${groupChannel.groupChannelId.id}">修改</a>
					<a href="${ctx}/channel/groupChannel/delete?groupChannelId.id=${groupChannel.groupChannelId.id}" onclick="return confirmx('确认要删除该频道信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>