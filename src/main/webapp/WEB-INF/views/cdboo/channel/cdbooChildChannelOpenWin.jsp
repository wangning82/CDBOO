<%@ page contentType="text/html;charset=UTF-8" import="com.cdboo.common.Constants"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>频道信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
	</script>
</head>
<body>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>频道编号</th>
				<th>频道名称</th>
				<th>频道图片</th>
				<th>风格类型</th>
				<th>风格类型明细</th>
				<th>频道版本</th>
				<th>频道类型</th>
				<th>创建时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${cdbooChannel.childChannelList}" var="cdbooChannel" varStatus="status">
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
					<theme:themeDetail themeConcreteType="${cdbooChannel.themeConcreteType }" themeType="${cdbooChannel.themeType }"></theme:themeDetail>
				</td>
				<td>
					${cdbooChannel.channelVersion}
				</td>
				<td>
					${fns:getDictLabel(cdbooChannel.channelType, 'channel_type', '')}
				</td>
				<td>
					<fmt:formatDate value="${cdbooChannel.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>