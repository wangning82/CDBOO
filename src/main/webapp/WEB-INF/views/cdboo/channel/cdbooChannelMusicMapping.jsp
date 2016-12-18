<%@ page contentType="text/html;charset=UTF-8" import="com.cdboo.common.Constants" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>频道信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
		
		function changeThemeConcreteType(selectVal){
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
					$('#themeConcreteType').append('<option value="'+dictList[i].value+'">'+dictList[i].label+'</option>');
				}
			}
		}
		
		function deleteRow(obj){
			$(obj).parent().parent().remove();
		}
		
		function openMappingWin(){
			var ids = '';
			var musicIdSize = $("input[name = 'musicIds']").size();
			alert('musicSize:'+musicIdSize)
			if(musicIdSize > 0){
				$("input[name = 'musicIds']").each(function(index){
					var id = $(this).val();
					ids += id;
					if(index != musicIdSize-1){
						ids += ",";
					}
				});
			}
			alert('ids:'+ids)
			top.$.jBox.open("iframe:${ctx}/music/cdbooMusic/openMusicWin?ids="+ids, "分配音乐",$(top.document).width()-240,$(top.document).height()-240,{
				buttons:{"确定分配":"ok", "清除已选":"clear", "关闭":true}, bottomText:"通过查询条件选择音乐，选择后窗口不会关闭，可以连续选择。",submit:function(v, h, f){
					var checkArray = h.find("iframe")[0].contentWindow.getCheckData();
					if (v=="ok"){
						var tpl = $("#musicTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						for (var i = 0; i < checkArray.length; i++) {
							var entity = checkArray[i];
							//alert(entity.id+":"+entity.name+":"+entity.actor+":"+entity.special+":"+entity.musicOwner+":"+entity.volume)
							$('#tb').append(Mustache.render(tpl, {row: entity}));
						}
				    	return true;
					} else if (v=="clear"){
						return false;
	                }
					
				}, loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/channel/cdbooChannel/">频道信息列表</a></li>
		<li><a href="${ctx}/channel/cdbooChannel/form?id=${cdbooChannel.id}">频道信息<shiro:hasPermission name="channel:cdbooChannel:edit">${not empty cdbooChannel.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="channel:cdbooChannel:edit">查看</shiro:lacksPermission></a></li>
		<li class="active"><a href="${ctx}/channel/cdbooChannel/mapping">频道音乐关联</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cdbooChannel" action="${ctx}/channel/cdbooChannel/saveMapping" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden" id="channelType" name="channelType" value="${Constants.CHANNEL_TYPE_CHILD }">
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">选择频道：</label>
			<div class="controls">
				<form:select id="themeType" path="themeType" class="input-xlarge " onchange="changeThemeConcreteType(this.value)">
					<form:option value="" label="请选择"/>
					<form:options items="${channelList}" itemLabel="channelName" itemValue="id" htmlEscape="false"/>
				</form:select>
				<input id="assignButton" class="btn btn-primary" type="button" value="分配音乐" onclick="openMappingWin()"/>
			</div>
		</div>
		
		<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th>音乐名称</th>
					<th>艺人</th>
					<th>专辑</th>
					<th>音乐类型</th>
					<th>音量</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody id="tb">
				<c:forEach items="${musicList}" var="cdbooMusic" varStatus="status">
					<tr>
						<td>
							${cdbooMusic.musicName}
							<input type="hidden" name = 'musicIds' value="${cdbooMusic.id }">
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
							<a href="#" onclick="deleteRow(this)">删除</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	
		<div class="form-actions">
			<shiro:hasPermission name="channel:cdbooChannel:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	
	<script type="text/template" id="musicTpl">//<!--
		<tr>
			<td>{{row.name}}<input type="hidden" name = 'musicIds' value="{{row.id}}"></td>
			<td>{{row.actor}}</td>
			<td>{{row.special}}</td>
			<td>{{row.musicOwner}}</td>
			<td>{{row.volume}}</td>
			<td><a href="#" onclick="deleteRow(this)">删除</a></td>
		</tr>//-->
	</script>
	
</body>
</html>