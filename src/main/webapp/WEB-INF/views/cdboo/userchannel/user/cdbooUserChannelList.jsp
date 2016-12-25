<%@ page contentType="text/html;charset=UTF-8" import="com.cdboo.common.Constants"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户频道管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic}/cdboo/userchannel/userchannel.js"></script>
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
		<li class="active"><a href="${ctx}/userchannel/userChannel/">频道列表</a></li>
		<shiro:hasPermission name="userchannel:userChannel:edit"><li><a href="${ctx}/userchannel/userChannel/form">频道编辑</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cdbooUserChannel" action="${ctx}/userchannel/userChannel/" method="post" class="breadcrumb form-search">
		<input id="pageNo"  name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<form:hidden id="userId" path="user.id" />
		<ul class="ul-form">
			<li><label>用户名称：</label>
				${fns:getUserById(cdbooUserChannel.user.id).name}
			</li>
			<li><label>频道：</label>
				<form:select id="channelId" path="channel.id" class="input-medium">
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
				<th>频道编号</th>
				<th>频道名称</th>
				<th>频道图片</th>
				<th>风格类型</th>
				<th>风格类型明细</th>
				<th>频道版本</th>
				<th>创建时间</th>
				<th>频道类型</th>
				<th>歌曲数量</th>
				<shiro:hasPermission name="userchannel:userChannel:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="cdbooUserChannel">
				<tr>
					<td><a href="${ctx}/userchannel/userChannel/form?channel.id=${cdbooUserChannel.channel.id}&&channel.channelName=${cdbooUserChannel.channel.channelName}">
							${cdbooUserChannel.channel.channelNo}
						</a></td>
						<td>
							${cdbooUserChannel.channel.channelName}
						</td>
						<td>
							<img alt="" src="${cdbooUserChannel.channel.photoPath}" height="100" width="100">
							
						</td>
						<td>
							${fns:getDictLabel(cdbooUserChannel.channel.themeType, 'theme_type', '')}
						</td>
						<td>
							<c:if test="${cdbooUserChannel.channel.themeType eq Constants.THEMETYPE_THEME }">
								${fns:getDictLabel(cdbooUserChannel.channel.themeConcreteType,'season_type', '')}
							</c:if>
							<c:if test="${cdbooUserChannel.channel.themeType eq Constants.THEMETYPE_HOLIDAY }">
								${fns:getDictLabel(cdbooUserChannel.channel.themeConcreteType,'holiday_type', '')}
							</c:if>
						</td>
						<td>
							${cdbooUserChannel.channel.channelVersion}
						</td>
						<td>
							<fmt:formatDate value="${cdbooUserChannel.channel.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
						<td>
							${fns:getDictLabel(cdbooUserChannel.channel.channelType, 'channel_type', '')}
						</td>
						<td>
							${cdbooUserChannel.musicSize}
						</td>
						<shiro:hasPermission name="userchannel:userChannel:edit"><td>
		    				<a href="${ctx}/userchannel/userChannel/form?channel.id=${cdbooUserChannel.channel.id}&&channel.channelName=${cdbooUserChannel.channel.channelName}">修改</a>
							<a href="${ctx}/userchannel/userChannel/delete?channel.id=${cdbooUserChannel.channel.id}&&channel.channelName=${cdbooUserChannel.channel.channelName}" onclick="return confirmx('确认要删除该频道信息吗？', this.href)">删除</a>
						</td></shiro:hasPermission>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>