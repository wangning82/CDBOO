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
		
		function ChannelEntity(id,channelNo,channelName,photoPath,themeType,themeConcreteType,channelVersion,createDate){
			this.id = id;
			this.channelNo = channelNo;
			this.channelName = channelName;
			this.photoPath = photoPath;
			this.themeType = themeType;
			this.themeConcreteType = themeConcreteType;
			this.channelVersion = channelVersion;
			this.createDate = createDate;
		}
		
		function getCheckData(){
			var checkArray = new Array();
			$('input[name="channelIds"]:checkbox:checked').each(function(){
				var id = $(this).val();
				alert(id)
				var idName = $(this).attr('id');
				var idNameArray = idName.split("_");
				var rowIndex = idNameArray[1];
				var channelNo = $('#channelNo_'+rowIndex).val();
				var channelName = $('#channelName_'+rowIndex).val();
				var photoPath = $('#photoPath_'+rowIndex).val();
				var themeType = $('#themeType_'+rowIndex).val();
				var themeConcreteType = $('#themeConcreteType_'+rowIndex).val();
				var channelVersion = $('#channelVersion_'+rowIndex).val();
				var createDate = $('#createDate_'+rowIndex).val();
				
				var channelEntity = new ChannelEntity(id,channelNo,channelName,photoPath,themeType,themeConcreteType,channelVersion,createDate);
				checkArray.push(channelEntity);
			});
			return checkArray;
		}
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="cdbooChannel" action="${ctx}/channel/cdbooChannel/openChannelWin" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input type="hidden" name="channelType" value="0"/>
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
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th><input type="checkbox" onclick="changeCB(this.checked,'channelIds')" /></th>
				<th>频道编号</th>
				<th>频道名称</th>
				<th>频道图片</th>
				<th>风格类型</th>
				<th>风格类型明细</th>
				<th>频道版本</th>
				<th>创建时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cdbooChannel" varStatus="status">
			<tr>
				<td><input type="checkbox" id="id_${status.index }" name="channelIds" value="${cdbooChannel.id }"/>
					<input type="hidden" id="channelNo_${status.index }" value = "${cdbooChannel.channelNo}"/>
					<input type="hidden" id="channelName_${status.index }" value = "${cdbooChannel.channelName}"/>
					<input type="hidden" id="photoPath_${status.index }" value = "${cdbooChannel.photoPath}"/>
					<input type="hidden" id="themeType_${status.index }" value = "${fns:getDictLabel(cdbooChannel.themeType, 'theme_type', '')}"/>
					<c:if test="${cdbooChannel.themeType eq Constants.THEMETYPE_THEME }">
						<input type="hidden" id="themeConcreteType_${status.index }" value = "${fns:getDictLabel(cdbooChannel.themeConcreteType,'season_type', '')}"/>
					</c:if>
					<c:if test="${cdbooChannel.themeType eq Constants.THEMETYPE_HOLIDAY }">
						<input type="hidden" id="themeConcreteType_${status.index }" value = "${fns:getDictLabel(cdbooChannel.themeConcreteType,'holiday_type', '')}"/>
					</c:if>
					<input type="hidden" id="channelVersion_${status.index }" value = "${cdbooChannel.channelVersion}"/>
					<fmt:formatDate value="${cdbooChannel.createDate}" pattern="yyyy-MM-dd HH:mm:ss" var="formatCreateDate"/>
					<input type="hidden" id="createDate_${status.index }" value = "${formatCreateDate}"/>
				</td>
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
	<div class="pagination">${page}</div>
</body>
</html>