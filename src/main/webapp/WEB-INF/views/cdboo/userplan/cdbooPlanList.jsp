<%@ page contentType="text/html;charset=UTF-8" import="com.cdboo.common.Constants" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户计划管理</title>
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
		
		function userTreeselectCallBack(v, h, f) {
			var userId = $('#userId').val();
			$('#userTimestepId').empty();
			$('#userChannelId').empty();
			
			$.ajax({
				type: "POST",
				async: false,
				url: "${ctx}/userplan/cdbooPlan/getUserInfo",
				data: {
					userId: userId
				},
				dataType: "json",
				success: function (data) {
					$('#planList').empty();
					var timestepData = data.timeStepList;
					var channelData = data.channelList;
					if(timestepData && timestepData.length>0){
						$('#userTimestepId').append('<option value="" selected>请选择</option>');
				       	var dataArray = eval(timestepData);
				       	for(var i = 0;i<dataArray.length;i++){
				       		$('#userTimestepId').append('<option value="'+dataArray[i].id+'">'+dataArray[i].name+'</option>');
				       	}
					}
					
					if(channelData && channelData.length>0){
						$('#userChannelId').append('<option value="" selected>请选择</option>');
				       	var dataArray = eval(channelData);
				       	for(var i = 0;i<dataArray.length;i++){
				       		$('#userChannelId').append('<option value="'+dataArray[i].id+'">'+dataArray[i].channelName+'</option>');
				       	}
					}
				}
			});
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/userplan/cdbooPlan/">用户计划列表</a></li>
		<shiro:hasPermission name="userplan:cdbooPlan:edit"><li><a href="${ctx}/userplan/cdbooPlan/form">用户计划添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cdbooPlan" action="${ctx}/userplan/cdbooPlan/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>计划编号：</label>
				<form:input path="planNo" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>计划名称：</label>
				<form:input path="playName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>用户：</label>
				<sys:treeselect id="user" name="user.id" value="${cdbooPlan.user.id}" labelName="user.name" labelValue="${cdbooPlan.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>用户时段：</label>
				<form:select id="userTimestepId" path="userTimestepId" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${timestepList}" itemLabel="name" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>用户频道：</label>
				<form:select id="userChannelId" path="userChannelId" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${channelList}" itemLabel="channelName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>风格：</label>
				<form:select path="musicStyle" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('theme_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				<th>计划编号</th>
				<th>计划名称</th>
				<th>用户</th>
				<th>用户时段</th>
				<th>用户频道</th>
				<th>频道类型</th>
				<th>风格</th>
				<th>日期区间</th>
				<th>循环次数</th>
				<th>间隔时间</th>
				<th>业态</th>
				<th>备注信息</th>
				<shiro:hasPermission name="userplan:cdbooPlan:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cdbooPlan">
			<tr>
				<td><a href="${ctx}/userplan/cdbooPlan/form?id=${cdbooPlan.id}">
					${cdbooPlan.planNo}
				</a></td>
				<td>
					${cdbooPlan.playName}
				</td>
				<td>
					${cdbooPlan.user.name}
				</td>
				<td>
					${cdbooPlan.timestep.timestepName}
				</td>
				<td>
					${cdbooPlan.channel.channelName}
				</td>
				<td>
					${fns:getDictLabel(cdbooPlan.channel.channelType, "channel_type", "")}
				</td>
				<td>
					${fns:getDictLabel(cdbooPlan.musicStyle, 'theme_type', '')}
				</td>
				<td>
					<!-- 如果是主题或者风格，显示星期中文字符串-->
					<c:if test="${cdbooPlan.musicStyle eq Constants.THEMETYPE_THEME || cdbooPlan.musicStyle eq Constants.THEMETYPE_STYLE}">
						${fns:getChineseWeek(cdbooPlan.week) }
					</c:if>
					<!-- 如果不是主题或者风格，显示日期段，只有两种情况，就是插播或者节日-->
					<c:if test="${cdbooPlan.musicStyle ne Constants.THEMETYPE_THEME && cdbooPlan.musicStyle ne Constants.THEMETYPE_STYLE}">
						<fmt:formatDate value="${cdbooPlan.startDate}" pattern="yyyy-MM-dd"/>到<fmt:formatDate value="${cdbooPlan.endDate}" pattern="yyyy-MM-dd"/>
					</c:if>
				</td>
				<td>
					<!-- 如果是插播，显示循环次数-->
					<c:if test="${cdbooPlan.musicStyle eq Constants.THEMETYPE_SPOTS}">
						${cdbooPlan.rate}次
					</c:if>
				</td>
				<td>
					<!-- 如果是插播，显示重复时间-->
					<c:if test="${cdbooPlan.musicStyle eq Constants.THEMETYPE_SPOTS}">
						${cdbooPlan.intervalTime}分钟
					</c:if>
				</td>
				<td>
					<!-- 如果不是插播，显示业态，插播没有业态 -->
					<c:if test="${cdbooPlan.musicStyle ne Constants.THEMETYPE_SPOTS}">
						${fns:getEntity('office',cdbooPlan.operationType)}
					</c:if>
				</td>
				<td>
					${cdbooPlan.remarks}
				</td>
				<shiro:hasPermission name="userplan:cdbooPlan:edit"><td>
    				<a href="${ctx}/userplan/cdbooPlan/form?id=${cdbooPlan.id}">修改</a>
					<a href="${ctx}/userplan/cdbooPlan/delete?id=${cdbooPlan.id}" onclick="return confirmx('确认要删除该用户计划吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>