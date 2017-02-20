<%@ page contentType="text/html;charset=UTF-8" import="com.cdboo.common.Constants"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>频道信息管理</title>
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
		
		function changeThemeConcreteType(selectVal){
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
		
		function importButtonClick(channelId){
			$('#importForm').attr('action','${ctx}/channel/cdbooChannel/import?channelId='+channelId);
			$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
				bottomText:"导入文件不能超过500M，仅允许导入“zip”格式文件！"});
		}
		
		function openMusicListWin(channelId){
			top.$.jBox.open("iframe:${ctx}/channel/cdbooChannel/openChannelMusicWin?id="+channelId, "音乐列表",$(top.document).width()-240,$(top.document).height()-240,{
				buttons:{"关闭":true,"关闭":true}, loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
		}
		
		function setVolumeWin(channelId){
			
			var submit = function (v, h, f) {
               $('#channelId').val(channelId);
               $('#volumeId').val(f.volume);
               $('#setVolumeForm').submit();
               return true;
            };

			var html = "";
			html += '<div id="setVolumeBox">';
			html += '<form class="form-search" style="padding-left:20px;text-align:center;"><br/>';
			html += '<input id="id" name="id" type="hidden" value="'+channelId+'"/>';
			html += '<select name="volume" id="volume" class="input-xlarge ">';	
			html += '<option value="">请选择</option>';
			var volumeJson = ${fns:toJson(fns:getVolumeList()) };
			if(volumeJson && volumeJson.length>0){
				for(var i = 0;i<volumeJson.length;i++){
					html += '<option value="'+volumeJson[i].value+'" >'+volumeJson[i].lable+'</option>';
				}
			}
			html += '</select>';
			html += '</form>';
			html += '</div>';	
		
			jBox(html, {
                title: "音量调整", submit: submit
            });
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/channel/cdbooChannel/">频道信息列表</a></li>
		<shiro:hasPermission name="channel:cdbooChannel:edit"><li><a href="${ctx}/channel/cdbooChannel/form">频道信息添加</a></li></shiro:hasPermission>
	</ul>
	<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/channel/cdbooChannel/import" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
		</form>
	</div>
	<form id="setVolumeForm" action="${ctx}/channel/cdbooChannel/setVolume" method="post"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');">
		<input type="hidden" name="id" id="channelId"/>	
		<input type="hidden" name="volume" id="volumeId"/>	
	</form>
	<form:form id="searchForm" modelAttribute="cdbooChannel" action="${ctx}/channel/cdbooChannel/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input type="hidden" name="channelType" value="${Constants.CHANNEL_TYPE_CHILD }"/>
		<ul class="ul-form">
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
				<th>歌曲数量</th>
				<th>创建时间</th>
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
					${cdbooChannel.musicSize}
				</td>
				<td>
					<fmt:formatDate value="${cdbooChannel.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="channel:cdbooChannel:edit"><td>
					<a href="${ctx}/channel/cdbooChannel/form?id=${cdbooChannel.id}">修改</a>
					<a href="${ctx}/channel/cdbooChannel/delete?id=${cdbooChannel.id}" onclick="return confirmx('确认要删除该频道信息吗？', this.href)">删除</a>
					<a href="#" onclick="importButtonClick('${cdbooChannel.id}')" >导入音乐</a>
					<a href="#" onclick="openMusicListWin('${cdbooChannel.id}')" >音乐列表</a>
					<a href="#" onclick="setVolumeWin('${cdbooChannel.id}')" >调整音量</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>