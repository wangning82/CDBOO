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
			
			$("#btnImport").click(function(){
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
					bottomText:"导入文件不能超过500M，仅允许导入“zip”格式文件！"});
			});
			
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出曲库数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/music/cdbooMusic/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
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
	<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/music/cdbooMusic/import" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
		</form>
	</div>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/music/cdbooMusic/">歌曲信息列表</a></li>
		<shiro:hasPermission name="music:cdbooMusic:edit"><li><a href="${ctx}/music/cdbooMusic/form">歌曲信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cdbooMusic" action="${ctx}/music/cdbooMusic/" method="post" class="breadcrumb form-search">
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
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${cdbooMusic.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${cdbooMusic.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="btns"><input id="btnImport" class="btn btn-primary" type="button" value="导入"/></li>
			<li class="btns"><input id="btnExport" class="btn btn-primary" type="button" value="导出"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>音乐编号</th>
				<th>音乐名称</th>
				<th>艺人</th>
				<th>专辑</th>
				<th>音乐类型</th>
				<th>音量</th>
				<th>音乐时长</th>
				<th>创建时间</th>
				<shiro:hasPermission name="music:cdbooMusic:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cdbooMusic" varStatus="status">
			<tr>
				<td>
					${cdbooMusic.musicNo}
				</td>
				<td>
					<a href="${ctx}/music/cdbooMusic/form?id=${cdbooMusic.id}">${cdbooMusic.musicName}</a><br/>
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
					${cdbooMusic.volume}%
				</td>
				<td>
					${cdbooMusic.duration}
				</td>
				<td>
					<fmt:formatDate value="${cdbooMusic.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="music:cdbooMusic:edit"><td>
    				<a href="${ctx}/music/cdbooMusic/form?id=${cdbooMusic.id}">修改</a>
					<a href="${ctx}/music/cdbooMusic/delete?id=${cdbooMusic.id}" onclick="return confirmx('确认要删除该歌曲信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>