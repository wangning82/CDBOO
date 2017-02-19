<%@ page contentType="text/html;charset=UTF-8" import="com.cdboo.common.Constants" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>频道管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			var message = '${message}';
			if(message){
				top.$.jBox.tip(message,"提示");
			}
		});
		
		function openChannelWin(){
			top.$.jBox.open("iframe:${ctx}/channel/cdbooChannel/openChannelWin", "分配频道",$(top.document).width()-240,$(top.document).height()-240,{
				buttons:{"确定分配":"ok", "关闭":true}, bottomText:"通过查询条件选择频道，选择后窗口不会关闭，可以连续选择。",submit:function(v, h, f){
					var checkArray = h.find("iframe")[0].contentWindow.getCheckData();
					if (v=="ok"){
						try {
							var tpl = $("#cdbooChannelTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
							for (var i = 0; i < checkArray.length; i++) {
								var entity = checkArray[i];
								if(checkChannelIdIsExists(entity.id)){
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
		
		function checkChannelIdIsExists(channelId){
			var flag = false;
			$("input[name = 'channelIds']").each(function(index){
				var id = $(this).val();
				//alert("["+id+"]:["+musicId+"]["+(id == musicId)+"]")
				if(id == channelId){
					flag = true;
					return false;
				}
			});
			return flag;
		}
		
		function deleteRow(obj){
			$(obj).parent().parent().remove();
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/businessplan/plan/listTimestep">行业计划列表</a></li>
		<li><a href="${ctx}/businessplan/plan/form?id=${businessPlan.id}">时段编辑</a></li>
		<li class="active"><a href="#">频道编辑</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="businessPlan" action="${ctx}/businessplan/plan/saveTimestepChannel" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="timeStepId"/>
			<div class="form-actions">
				<input id="btnSubmit" class="btn btn-primary" type="button" value="分配频道" onclick="openChannelWin()"/>&nbsp;
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保存"/>&nbsp;
				<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			</div>
			<table id="contentTable" class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th class="hide"></th>
						<th style="width: 5%">频道编号</th>
						<th style="width: 10%">频道名称</th>
						<th style="width: 10%">频道图片</th>
						<th style="width: 5%">风格类型</th>
						<th style="width: 5%">风格类型明细</th>
						<th style="width: 5%">频道版本</th>
						<th style="width: 5%">频道类型</th>
						<th style="width: 5%">业态</th>
						<th style="width: 10%">创建时间</th>
						<th style="width: 5%">操作</th>
					</tr>
				</thead>
				<tbody id="tb">
				<c:forEach items="${businessPlan.cdbooChannels}" var="channel" varStatus="status">
					<tr>
						<td class="hide"><input type="hidden" name="channelIds" value="${channel.id }"/></td>
						<td>${channel.channelNo}</td>
						<td>${channel.channelName}</td>		
						<td><pic:preview path="${channel.photoPath}"></pic:preview></td>
						<td>${fns:getDictLabel(channel.themeType, 'theme_type', '')}</td>
						<td><theme:themeDetail themeConcreteType="${channel.themeConcreteType }" themeType="${channel.themeType }"></theme:themeDetail></td>
						<td>${channel.channelVersion}</td>
						<td>${fns:getDictLabel(channel.channelType, 'channel_type', '')}</td>
						<td>
							<select name="operationTypes" class="input-small ">
	                           <option value="">请选择</option>
							   <c:forEach items="${businessPlan.cdbooConditionList}" var="condition">
									<option value="${condition.id}" <c:if test="${channel.operationType eq condition.id }">selected</c:if> >${condition.name}</option>
							   </c:forEach>
	                        </select>
	                    </td>
	                    <td><fmt:formatDate value="${channel.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td><a href="#" onclick="deleteRow(this)">删除</a></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			
		<script type="text/template" id="cdbooChannelTpl">//<!--
					<tr>
							<td class="hide">
								<input name="channelIds" type="hidden" value="{{row.id}}"/>
							</td>
							<td>
								{{row.channelNo}}
							</td>
							<td>
								{{row.channelName}}
							</td>
							<td>
								<img src="{{row.photoPath}}" width="${Constants.IMG_WIDTH}" height="${Constants.IMG_HEIGHT}" onclick="disPic('{{row.photoPath}}')"/>
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
								{{row.channelType}}
							</td>
							<td>
								<select name="operationTypes" class="input-small ">
                           			<option value="">请选择</option>
						   			<c:forEach items="${businessPlan.cdbooConditionList}" var="condition">
										<option value="${condition.id}">${condition.name}</option>
						   			</c:forEach>
                        		</select>
							</td>
							<td>
								{{row.createDate}}
							</td>
							<td class="text-center"><a href="#" onclick="deleteRow(this)">删除</a></td>
					</tr>//-->
		</script>
	</form:form>
</body>
</html>