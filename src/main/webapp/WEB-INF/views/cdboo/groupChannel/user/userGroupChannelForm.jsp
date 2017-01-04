<%@ page contentType="text/html;charset=UTF-8" import="com.cdboo.common.Constants" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>频道信息管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/channel/groupChannel/user/">频道信息列表</a></li>
		<li class="active"><a><c:if test = "${not empty cdbooUserGroup.user.id && not empty cdbooUserGroup.cdbooChannel.id}">组合频道信息查看</c:if><c:if test = "${empty cdbooUserGroup.user.id && empty cdbooUserGroup.cdbooChannel.id}">组合频道信息添加</c:if></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cdbooUserGroup" action="#" method="post" class="form-horizontal">
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">用户：</label>
			<div class="controls">
				${cdbooUserGroup.user.name}
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">组合频道：</label>
			<div class="controls">
				${cdbooUserGroup.cdbooChannel.channelName}
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">子频道列表：</label>
			<div class="controls">
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
						</tr>
					</thead>					
					<tbody id="tb">
						<c:forEach items="${cdbooUserGroup.groupChildList}" var="cdbooChannel" varStatus="status">
							<tr>
								<td>
									${cdbooChannel.channelNo}
								</td>
								<td>
									${cdbooChannel.channelName}
								</td>
								<td>
									<pic:preview path="${cdbooChannel.photoPath}" ></pic:preview>
								</td>
								<td>
									${fns:getDictLabel(cdbooChannel.themeType, 'theme_type', '')}
								</td>
								<td>
									<c:if test="${cdbooChannel.themeType eq Constants.THEMETYPE_THEME }">
										${fns:getDictLabel(cdbooChannel.themeConcreteType,'season_type', '')}
									</c:if>
									<c:if test="${cdbooChannel.themeType eq Constants.THEMETYPE_HOLIDAY }">
										${fns:getDictLabel(cdbooChannel.themeConcreteType,'holiday_type', '')}
									</c:if>
								</td>
								<td>
									${cdbooChannel.channelVersion}
								</td>
								<td>
									<fmt:formatDate value="${cdbooChannel.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>	
			</div>
		</div>
		
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>