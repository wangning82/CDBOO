<%@ page contentType="text/html;charset=UTF-8" import="com.cdboo.common.Constants"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>频道信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			changeThemeConcreteType('${cdbooChannel.themeType}','${cdbooChannel.themeConcreteType}');
		});
		
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		function changeThemeConcreteType(selectVal,selectedVal){
			var theme = '${Constants.THEMETYPE_THEME }';
			var holiday = '${Constants.THEMETYPE_HOLIDAY }';
			
			$('#themeConcreteType').empty();
			$('#themeConcreteType').append('<option value="">请选择</option>');
			
			var dictList;
			if(selectVal == theme){
				dictList = ${fns:toJson(fns:getDictList('season_type'))};
			}
			if(selectVal == holiday){
				dictList = ${fns:toJson(fns:getDictList('holiday_type'))};
			}
			
			if(dictList && dictList.length>0){
				for(var i = 0; i <dictList.length;i++){
					var dictVal = dictList[i].value;
					$('#themeConcreteType').append('<option value="'+dictList[i].value+'">'+dictList[i].label+'</option>');
				}
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/channel/cdbooChannel/">频道信息列表</a></li>
		<shiro:hasPermission name="channel:cdbooChannel:edit"><li><a href="${ctx}/channel/cdbooChannel/form">频道信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cdbooChannel" action="${ctx}/channel/cdbooChannel/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>频道编号：</label>
				<form:input path="channelNo" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>频道名称：</label>
				<form:input path="channelName" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li><label>风格类型：</label>
				<form:select path="themeType" class="input-medium" onchange="changeThemeConcreteType(this.value)">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('theme_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>风格明细：</label>
				<form:select id="themeConcreteType" path="themeConcreteType" class="input-medium">
					<form:option value="" label="请选择"/>
					<form:options items="${themeConcreteTypeList}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>频道版本：</label>
				<form:input path="channelVersion" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>音乐风格：</label>
				<form:select path="musicStyle" class="input-medium">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('music_style')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>场所：</label>
				<form:select path="site" class="input-medium">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('site_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>速度：</label>
				<form:select path="speed" class="input-medium">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('speed_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>人声：</label>
				<form:select path="voice" class="input-medium">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('voice_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>元素：</label>
				<form:select path="element" class="input-medium">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('element_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>情绪：</label>
				<form:select path="emotion" class="input-medium">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('emotion_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>乐器：</label>
				<form:select path="instrument" class="input-medium">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('instrument_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>创建时间：</label>
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${cdbooChannel.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${cdbooChannel.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>频道类型：</label>
				<form:select path="channelType" class="input-medium">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('channel_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				<shiro:hasPermission name="channel:cdbooChannel:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cdbooChannel">
			<tr>
				<td><a href="${ctx}/channel/cdbooChannel/form?id=${cdbooChannel.id}">
					${cdbooChannel.channelNo}
				</a></td>
				<td>
					${cdbooChannel.channelName}
				</td>
				<td>
					${cdbooChannel.photoPath}
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
				<td>
					${fns:getDictLabel(cdbooChannel.channelType, 'channel_type', '')}
				</td>
				<shiro:hasPermission name="channel:cdbooChannel:edit"><td>
    				<a href="${ctx}/channel/cdbooChannel/form?id=${cdbooChannel.id}">修改</a>
					<a href="${ctx}/channel/cdbooChannel/delete?id=${cdbooChannel.id}" onclick="return confirmx('确认要删除该频道信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>