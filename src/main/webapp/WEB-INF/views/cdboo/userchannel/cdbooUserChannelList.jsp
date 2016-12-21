<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户频道管理</title>
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
		<li class="active"><a href="${ctx}/userchannel/cdbooUserChannel/">用户频道列表</a></li>
		<shiro:hasPermission name="userchannel:cdbooUserChannel:edit"><li><a href="${ctx}/userchannel/cdbooUserChannel/form">用户频道添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cdbooUserChannel" action="${ctx}/userchannel/cdbooUserChannel/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>用户id：</label>
				<sys:treeselect id="user" name="user.id" value="${cdbooUserChannel.user.id}" labelName="user.name" labelValue="${cdbooUserChannel.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>频道id：</label>
				<form:select path="channel.id" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>音乐id：</label>
				<form:select path="music.id" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				<th>用户id</th>
				<th>频道id</th>
				<th>音乐id</th>
				<th>创建人</th>
				<th>创建时间</th>
				<shiro:hasPermission name="userchannel:cdbooUserChannel:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cdbooUserChannel">
			<tr>
				<td><a href="${ctx}/userchannel/cdbooUserChannel/form?id=${cdbooUserChannel.id}">
					${cdbooUserChannel.user.name}
				</a></td>
				<td>
					${fns:getDictLabel(cdbooUserChannel.channel.id, '', '')}
				</td>
				<td>
					${fns:getDictLabel(cdbooUserChannel.music.id, '', '')}
				</td>
				<td>
					${cdbooUserChannel.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${cdbooUserChannel.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="userchannel:cdbooUserChannel:edit"><td>
    				<a href="${ctx}/userchannel/cdbooUserChannel/form?id=${cdbooUserChannel.id}">修改</a>
					<a href="${ctx}/userchannel/cdbooUserChannel/delete?id=${cdbooUserChannel.id}" onclick="return confirmx('确认要删除该用户频道吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>