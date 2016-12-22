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
	    });
		
		function MusicEntity(id,musicName,actor,special,musicOwner,volume){
			this.id = id;
			this.musicName = musicName;
			this.actor = actor;
			this.special = special;
			this.musicOwner = musicOwner;
			this.volume = volume;
		}
		
		function getCheckData(){
			var checkArray = new Array();
			$('input[name="musicIds"]:checkbox:checked').each(function(){
				var id = $(this).val();
				var idName = $(this).attr('id');
				var idNameArray = idName.split("_");
				var rowIndex = idNameArray[1];
				var musicName = $('#name_'+rowIndex).val();
				var actor = $('#actor_'+rowIndex).val();
				var special = $('#special_'+rowIndex).val();
				var musicOwner = $('#musicOwner_'+rowIndex).val();
				var volume = $('#volume_'+rowIndex).val();
				
				var musicEntity = new MusicEntity(id,musicName,actor,special,musicOwner,volume);
				checkArray.push(musicEntity);
			});
			return checkArray;
		}
		
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="cdbooMusic" action="${ctx}/music/cdbooMusic/openMusicWin" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>音乐编号：</label>
				<form:input path="musicNo" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>音乐名称：</label>
				<form:input path="musicName" htmlEscape="false" maxlength="1000" class="input-medium"/>
			</li>
			<li><label>艺人：</label>
				<form:input path="actor" htmlEscape="false" maxlength="1000" class="input-medium"/>
			</li>
			<li><label>专辑：</label>
				<form:input path="special" htmlEscape="false" maxlength="1000" class="input-medium"/>
			</li>
			<li><label>音乐类型：</label>
				<form:select path="musicOwner" class="input-mini">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('owner_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>创建时间：</label>
				<input name="createDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${cdbooMusic.createDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th><input type="checkbox" onclick="changeCB(this.checked,'musicIds')" /></th>
				<th>音乐名称</th>
				<th>艺人</th>
				<th>专辑</th>
				<th>音乐类型</th>
				<th>音量</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cdbooMusic" varStatus="status">
			<tr>
				<td><input type="checkbox" id="id_${status.index }" name="musicIds" value="${cdbooMusic.id }"/>
					<input type="hidden" id="name_${status.index }" value = "${cdbooMusic.musicName}"/>
					<input type="hidden" id="actor_${status.index }" value = "${cdbooMusic.actor}"/>
					<input type="hidden" id="special_${status.index }" value = "${cdbooMusic.special}"/>
					<input type="hidden" id="musicOwner_${status.index }" value = "${fns:getDictLabel(cdbooMusic.musicOwner, 'owner_type', '')}"/>
					<input type="hidden" id="volume_${status.index }" value = "${cdbooMusic.volume}"/>
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
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>