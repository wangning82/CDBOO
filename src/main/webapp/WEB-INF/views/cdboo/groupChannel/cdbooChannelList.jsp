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
			var style = '${Constants.THEMETYPE_STYLE }';
			
			$('#themeConcreteType').empty();
			$('#themeConcreteType').append('<option value="">请选择</option>');
			
			var dictList;
			if(selectVal == theme){
				dictList = ${fns:toJson(fns:getDictList('season_type'))};
			}
			if(selectVal == holiday){
				dictList = ${fns:toJson(fns:getDictList('holiday_type'))};
			}
			if(selectVal == style){
				dictList = ${fns:toJson(fns:getDictList('style_type'))};
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
		<li class="active"><a href="${ctx}/channel/groupChannel/">频道信息列表</a></li>
		<shiro:hasPermission name="channel:groupChannel:edit"><li><a href="${ctx}/channel/groupChannel/form">频道信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cdbooChannel" action="${ctx}/channel/groupChannel/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input type="hidden" name="channelType" value="1"/>
		<ul class="ul-form">
			<li><label>频道编号：</label>
				<form:input path="channelNo" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>频道名称：</label>
				<form:input path="channelName" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li><label>频道版本：</label>
				<form:input path="channelVersion" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>创建时间：</label>
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${cdbooChannel.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${cdbooChannel.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
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
				<th>频道版本</th>
				<th>子频道数量</th>
				<th>创建时间</th>
				<shiro:hasPermission name="channel:groupChannel:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cdbooChannel">
			<tr>
				<td><a href="${ctx}/channel/groupChannel/form?id=${cdbooChannel.id}">
					${cdbooChannel.channelNo}
				</a></td>
				<td>
					${cdbooChannel.channelName}
				</td>
				<td>
					<pic:preview path="${cdbooChannel.photoPath}" ></pic:preview>
				</td>
				<td>
					${cdbooChannel.channelVersion}
				</td>
				<td>
					${cdbooChannel.childChannelSize}
				</td>
				<td>
					<fmt:formatDate value="${cdbooChannel.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="channel:groupChannel:edit"><td>
    				<a href="${ctx}/channel/groupChannel/form?id=${cdbooChannel.id}">修改</a>
					<a href="${ctx}/channel/groupChannel/delete?id=${cdbooChannel.id}" onclick="return confirmx('确认要删除该频道信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>