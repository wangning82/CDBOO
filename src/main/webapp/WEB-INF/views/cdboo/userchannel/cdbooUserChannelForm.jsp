<%@ page contentType="text/html;charset=UTF-8" import="com.cdboo.common.Constants" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户频道管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic}/cdboo/userchannel/userchannel.js"></script>
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
		
		function deleteRow(obj){
			$(obj).parent().parent().remove();
		}
		
		function openMappingWin(){
			var ids = '';
			var musicIdSize = $("input[name = 'musicIds']").size();
			if(musicIdSize > 0){
				$("input[name = 'musicIds']").each(function(index){
					var id = $(this).val();
					ids += id;
					if(index != musicIdSize-1){
						ids += ",";
					}
				});
			}
			top.$.jBox.open("iframe:${ctx}/music/cdbooMusic/openMusicWin?ids="+ids, "分配音乐",$(top.document).width()-240,$(top.document).height()-400,{
				buttons:{"确定分配":"ok", "关闭":true}, bottomText:"通过查询条件选择音乐，选择后窗口不会关闭，可以连续选择。",submit:function(v, h, f){
					var checkArray = h.find("iframe")[0].contentWindow.getCheckData();
					if (v=="ok"){
						try {
							var tpl = $("#musicTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
							for (var i = 0; i < checkArray.length; i++) {
								var entity = checkArray[i];
								if(checkMusicIsExists(entity.id)){
									continue;
								}
								//alert(entity.id+":"+entity.name+":"+entity.actor+":"+entity.special+":"+entity.musicOwner+":"+entity.volume)
								$('#tb').append(Mustache.render(tpl, {row: entity}));
							}
							showTip('追加歌曲成功，请继续选择歌曲','success');
						} catch (e) {
							showTip('追加歌曲失败，请重新选择歌曲','error');
						}
						
				    	return false;
					}
				}, loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
		}
		
		//检查音乐id是否存在
		function checkMusicIsExists(musicId){
			var musicIdSize = $("input[name = 'musicIds']").size();
			if(musicIdSize <= 0){
				return true;
			}
			var flag = false;
			$("input[name = 'musicIds']").each(function(index){
				var id = $(this).val();
				//alert("["+id+"]:["+musicId+"]["+(id == musicId)+"]")
				if(id == musicId){
					flag = true;
					return false;
				}
			});
			return flag;
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/userchannel/cdbooUserChannel/">用户频道列表</a></li>
		<li class="active"><a href="${ctx}/userchannel/cdbooUserChannel/form?id=${cdbooUserChannel.id}">用户频道<shiro:hasPermission name="userchannel:cdbooUserChannel:edit">${not empty cdbooUserChannel.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="userchannel:cdbooUserChannel:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cdbooUserChannel" action="${ctx}/userchannel/cdbooUserChannel/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden" id="owner_type_public" value="${Constants.MUSICOWNER_PUBLIC}"/>
		<input type="hidden" id="owner_type_private" value="${Constants.MUSICOWNER_PRIVATE}"/>
		<input type="hidden" id="isLinkMusic" value="true"/>
		
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">用户：</label>
			<div class="controls">
				<sys:treeselect id="user" name="user.id" value="${cdbooUserChannel.user.id}" labelName="user.name" labelValue="${cdbooUserChannel.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">频道：</label>
			<div class="controls">
				<form:select id="channelId" path="channel.id" class="input-xlarge " onchange="linkMusic()">
					<form:option value="" label="请选择"/>
					<form:options items="${channels}" itemLabel="channelName" itemValue="id" htmlEscape="false"/>
				</form:select>
				&nbsp;
				<input id="assignButton" class="btn btn-primary" type="button" value="分配音乐" onclick="openMappingWin()"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">音乐列表：</label>
			<div class="controls">
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
			</div>
		</div>
		
		<div class="form-actions">
			<shiro:hasPermission name="userchannel:cdbooUserChannel:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	
	<script type="text/template" id="musicTpl">//<!--
		<tr>
			<td>{{row.musicName}}<input type="hidden" name = 'musicIds' value="{{row.id}}"></td>
			<td>{{row.actor}}</td>
			<td>{{row.special}}</td>
			<td>{{row.musicOwner}}</td>
			<td>{{row.volume}}</td>
			<td><a href="#" onclick="deleteRow(this)">删除</a></td>
		</tr>//-->
	</script>
</body>
</html>