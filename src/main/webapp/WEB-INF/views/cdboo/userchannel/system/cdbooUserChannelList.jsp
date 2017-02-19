<%@ page contentType="text/html;charset=UTF-8" %>
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
		
		function openMusicListWin(channelId){
			top.$.jBox.open("iframe:${ctx}/channel/cdbooChannel/openChannelMusicWin?id="+channelId, "音乐列表",$(top.document).width()-240,$(top.document).height()-240,{
				buttons:{"关闭":true}, loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
		}
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/userchannel/cdbooUserChannel/">用户频道列表</a></li>
		<shiro:hasPermission name="userchannel:cdbooUserChannel:edit"><li><a href="${ctx}/userchannel/cdbooUserChannel/form">用户频道添加</a></li></shiro:hasPermission>
	</ul>
	
	<form:form id="searchForm" modelAttribute="cdbooUserChannel" action="${ctx}/userchannel/cdbooUserChannel/" method="post" class="breadcrumb form-search">
		<input id="pageNo"  name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>用户：</label>
				<sys:treeselect id="user" name="user.id" value="${cdbooUserChannel.user.id}" labelName="user.name" labelValue="${cdbooUserChannel.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
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
				<th style="width: 10%">用户名称</th>
				<th style="width: 5%">频道编号</th>
				<th style="width: 10%">频道名称</th>
				<th style="width: 10%">频道图片</th>
				<th style="width: 5%">风格类型</th>
				<th style="width: 5%">风格类型明细</th>
				<th style="width: 5%">频道版本</th>
				<th style="width: 10%">创建时间</th>
				<th style="width: 5%">频道类型</th>
				<th style="width: 5%">歌曲数量</th>
				<shiro:hasPermission name="userchannel:cdbooUserChannel:edit"><th style="width: 20%">操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cdbooUserChannel">
			<tr>
				<td>
					${cdbooUserChannel.user.name}
				</td>
				<td><a href="${ctx}/userchannel/cdbooUserChannel/form?user.id=${cdbooUserChannel.user.id}&&channel.id=${cdbooUserChannel.channel.id}&&user.name=${cdbooUserChannel.user.name}&&channel.channelName=${cdbooUserChannel.channel.channelName}">
							${cdbooUserChannel.channel.channelNo}
						</a></td>
						<td>
							${cdbooUserChannel.channel.channelName}
						</td>
						<td>
							<pic:preview path="${cdbooUserChannel.channel.photoPath}"></pic:preview>
						</td>
						<td>
							${fns:getDictLabel(cdbooUserChannel.channel.themeType, 'theme_type', '')}
						</td>
						<td>
							<theme:themeDetail themeConcreteType="${cdbooUserChannel.channel.themeConcreteType }" themeType="${cdbooUserChannel.channel.themeType }"></theme:themeDetail>
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
						<shiro:hasPermission name="userchannel:cdbooUserChannel:edit"><td>
		    				<a href="${ctx}/userchannel/cdbooUserChannel/form?id=${cdbooUserChannel.id}">修改</a>
							<a href="${ctx}/userchannel/cdbooUserChannel/delete?id=${cdbooUserChannel.id}" onclick="return confirmx('确认要删除该用户频道吗？', this.href)">删除</a>
							<a href="#" onclick="openMusicListWin('${cdbooUserChannel.channel.id}')" >音乐列表</a>
						</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>