<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>歌曲信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	    $(document).ready(function(){
			$(".mp3").jmp3({
				showfilename: "false",
				backcolor: "DDA0DD",
				forecolor: "C71585",
				width: 100,
				showdownload: "true"
			});
			
			var message = '${message}';
			if(message){
				top.$.jBox.tip(message,"提示");
			}
	    });
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="cdbooChannel" action="${ctx}/channel/cdbooChannel/channelMusicSave" method="post" class="breadcrumb form-search">
		<form:hidden path="id"/>
		<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th>音乐编号</th>
					<th>音乐名称</th>
					<th>艺人</th>
					<th>专辑</th>
					<th>音乐类型</th>
					<th>音量</th>
					<th>排序</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${cdbooChannelMusics}" var="cdbooChannelMusic" varStatus="status">
				<input name="cdbooChannelMusics[${status.index }].id" type="hidden" value="${cdbooChannelMusic.id }" />
				<c:set value="${cdbooChannelMusic.music }" var="cdbooMusic"></c:set>
				<tr>
					<td>
						${cdbooMusic.musicNo}
					</td>
					<td>
						${cdbooMusic.musicName}<br/>
						<span id="music${status.index }" class="mp3" >${cdbooMusic.path }</span>
					</td>
					<td>
						${cdbooMusic.actor}
					</td>
					<td>
						${cdbooMusic.special}
					</td>
					<td>
						${fns:getDictLabel(cdbooMusic.musicOwner, 'owner_type', '')}
					</td>
					<td>
						${cdbooMusic.volume}
					</td>
					<td>
						<input type="text" name="cdbooChannelMusics[${status.index }].sort" value="${cdbooChannelMusic.sort}">
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		
		<div class="form-actions">
			<shiro:hasPermission name="channel:cdbooChannel:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
		</div>
	</form:form>
</body>
</html>