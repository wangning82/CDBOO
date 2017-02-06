<%@ page contentType="text/html;charset=UTF-8" import="com.cdboo.common.Constants" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>频道管理</title>
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
		
		function addRow(list, idx, tpl, row){
			$(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: true, row: row
			}));
			$(list+idx).find("select").each(function(){
				$(this).val($(this).attr("data-value"));
			});
			$(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
				var ss = $(this).attr("data-value").split(',');
				for (var i=0; i<ss.length; i++){
					if($(this).val() == ss[i]){
						$(this).attr("checked","checked");
					}
				}
			});
		}
		
		function delRow(obj, prefix){
			var id = $(prefix+"_id");
			var delFlag = $(prefix+"_delFlag");
			if (id.val() == ""){
				$(obj).parent().parent().remove();
			}else if(delFlag.val() == "0"){
				delFlag.val("1");
				$(obj).html("&divide;").attr("title", "撤销删除");
				$(obj).parent().parent().addClass("error");
			}else if(delFlag.val() == "1"){
				delFlag.val("0");
				$(obj).html("&times;").attr("title", "删除");
				$(obj).parent().parent().removeClass("error");
			}
		}
		
		function openUserChannelWin(){
			var ids = '';
			var userChannelIdsSize = $("input[name = 'userChannelIds']").size();
			if(userChannelIdsSize > 0){
				$("input[name = 'userChannelIds']").each(function(index){
					var id = $(this).val();
					ids += id;
					if(index != userChannelIdsSize-1){
						ids += ",";
					}
				});
			}
			
			var userId = '${cdbooMyPlan.user.id}';
			
			top.$.jBox.open("iframe:${ctx}/userchannel/cdbooUserChannel/openUserChannelWin?user.id="+userId+"&ids="+ids, "分配频道",$(top.document).width()-240,$(top.document).height()-400,{
				buttons:{"确定分配":"ok", "关闭":true}, bottomText:"通过查询条件选择用户绑定的频道，选择后窗口不会关闭，可以连续选择。",submit:function(v, h, f){
					var checkArray = h.find("iframe")[0].contentWindow.getCheckData();
					if (v=="ok"){
						try {
							var tpl = $("#cdbooUserChannelTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
							for (var i = 0; i < checkArray.length; i++) {
								var entity = checkArray[i];
								if(checkUserChannelIdIsExists(entity.id)){
									continue;
								}
								//alert(entity.id+":"+entity.musicName+":"+entity.actor+":"+entity.special+":"+entity.musicOwner+":"+entity.volume)
								$('#tb').append(Mustache.render(tpl, {row: entity}));
							}
							showTip('追加频道成功，请继续选择频道','success');
						} catch (e) {
							showTip('追加频道失败，请重新选择频道','error');
						}
						
				    	return false;
					}
				}, loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
		}
		
		function checkUserChannelIdIsExists(userChannelId){
			var flag = false;
			$("input[name = 'userChannelIds']").each(function(index){
				var id = $(this).val();
				//alert("["+id+"]:["+musicId+"]["+(id == musicId)+"]")
				if(id == userChannelId){
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
		<li><a href="${ctx}/myplan/cdbooMyPlan/">计划列表</a></li>
		<li><a href="${ctx}/myplan/cdbooMyPlan/form?id=${cdbooMyPlan.id}">计划<shiro:hasPermission name="myplan:cdbooMyPlan:edit">${not empty cdbooMyPlan.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="myplan:cdbooMyPlan:edit">查看</shiro:lacksPermission></a></li>
		<li><a href="${ctx}/myplan/cdbooMyPlan/toEditTimestepPage?id=${cdbooMyPlan.id}&user.id=${cdbooMyPlan.user.id}">时段编辑</a></li>
		<li class="active"><a href="#">频道编辑</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cdbooMyPlan" action="${ctx}/myplan/cdbooMyPlan/saveTimestepChannel" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="userTimeStepId"/>
		<sys:message content="${message}"/>
		<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th class="hide"></th>
					<th style="width: 10%">用户名称</th>
					<th style="width: 5%">频道编号</th>
					<th style="width: 10%">频道名称</th>
					<th style="width: 10%">频道图片</th>
					<th style="width: 5%">风格类型</th>
					<th style="width: 5%">风格类型明细</th>
					<th style="width: 5%">频道版本</th>
					<th style="width: 10%">创建时间</th>
					<th style="width: 5%">频道类型</th>
				</tr>
			</thead>
			<tbody id="tb">
			<c:forEach items="${cdbooMyPlan.cdbooUserChannels}" var="cdbooUserChannel">
				<tr>
					<td class="hide"><input type="hidden" name="userChannelIds" value="${cdbooUserChannel.id }"/></td>
					<td>${cdbooUserChannel.user.name}</td>
					<td>${cdbooUserChannel.channel.channelNo}</td>
					<td>${cdbooUserChannel.channel.channelName}</td>		
					<td><pic:preview path="${cdbooUserChannel.channel.photoPath}"></pic:preview></td>
					<td>${fns:getDictLabel(cdbooUserChannel.channel.themeType, 'theme_type', '')}</td>
					<td><theme:themeDetail themeConcreteType="${cdbooUserChannel.channel.themeConcreteType }" themeType="${cdbooUserChannel.channel.themeType }"></theme:themeDetail></td>
					<td>${cdbooUserChannel.channel.channelVersion}</td>
					<td><fmt:formatDate value="${cdbooUserChannel.channel.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td>${fns:getDictLabel(cdbooUserChannel.channel.channelType, 'channel_type', '')}</td>
					<td><a href="#" onclick="deleteRow(this)">删除</a></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<script type="text/template" id="cdbooUserChannelTpl">//<!--
					<tr>
							<td class="hide">
								<input name="userChannelIds" type="hidden" value="{{row.id}}"/>
							</td>
							<td>
								{{row.channelNo}}
							</td>
							<td>
								{{row.channelName}}
							</td>
							<td>
								{{row.photoPath}}
							</td>
							<td>
								{{row.themeType}}
							</td>
							<td>
								{{row.themeConcreteType}}
							</td>
							<td>
								{{row.channelVersion}}
							</td>
							<td>
								{{row.photoPath}}
							</td>
							<td>
								{{row.createDate}}
							</td>
							<td>
								{{row.channelType}}
							</td>

							<td class="text-center" width="10"><a href="#" onclick="deleteRow(this)">删除</a></td>
					</tr>//-->
		</script>
	</form:form>
</body>
</html>