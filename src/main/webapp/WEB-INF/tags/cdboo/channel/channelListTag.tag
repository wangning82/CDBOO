<%@ tag language="java" pageEncoding="UTF-8" import="com.cdboo.common.Constants"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="channelList" type="java.util.List" required="true" description="频道集合"%>
<%@ attribute name="channelElementName" type="java.lang.String" required="true" description="频道隐藏域id名称"%>
<%@ attribute name="sortElementName" type="java.lang.String" required="false" description="排序隐藏域id名称"%>
<%@ attribute name="userElementId" type="java.lang.String" required="false" description="查询对应用户id所关联的频道,不传查询所有"%>
<%@ attribute name="channelType" type="java.lang.String" required="false" description="指定频道类型"%>
<script type="text/javascript">
	function deleteRow(obj){
		$(obj).parent().parent().remove();
	}
	
	function openMappingWin(){
		var ids = '';
		var channelIdSize = $("input[name = '${channelElementName}']").size();
		if(channelIdSize > 0){
			$("input[name = '${channelElementName}']").each(function(index){
				var id = $(this).val();
				ids += id;
				if(index != channelIdSize-1){
					ids += ",";
				}
			});
		}
		var elementId = '${userElementId}';
		var userId = '';
		if(elementId){
			userId = $('#'+elementId).val();
		}
		
		top.$.jBox.open("iframe:${ctx}/channel/cdbooChannel/openChannelWin?userId="+userId+"&ids="+ids+"&channelType=${channelType}", "分配频道",$(top.document).width()-240,$(top.document).height()-400,{
			buttons:{"确定分配":"ok", "关闭":true}, bottomText:"通过查询条件选择频道，选择后窗口不会关闭，可以连续选择。",submit:function(v, h, f){
				var checkArray = h.find("iframe")[0].contentWindow.getCheckData();
				if (v=="ok"){
					try {
						var tpl = $("#channelTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						for (var i = 0; i < checkArray.length; i++) {
							var entity = checkArray[i];
							if(checkChannelIsExists(entity.id)){
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
	
	//检查频道id是否存在
	function checkChannelIsExists(channelId){
		var flag = false;
		$("input[name = '${channelElementName}']").each(function(index){
			var id = $(this).val();
			//alert("["+id+"]:["+musicId+"]["+(id == musicId)+"]")
			if(id == channelId){
				flag = true;
				return false;
			}
		});
		return flag;
	}
</script>

<div class="form-actions">
	<input id="assignButton" class="btn btn-primary" type="button" value="分配频道" onclick="openMappingWin()"/>
</div>

<div class="control-group">
	<label class="control-label">子频道列表：</label>
	<div class="controls">
		<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th style="width: 10%">频道编号</th>
					<th style="width: 15%">频道名称</th>
					<th style="width: 10%">频道图片</th>
					<th style="width: 10%">风格类型</th>
					<th style="width: 10%">风格类型明细</th>
					<th style="width: 10%">频道版本</th>
					<c:if test="${not empty sortElementName }">
						<th style="width: 10%">排序</th>
					</c:if>	
					<th style="width: 15%">创建时间</th>
					<th style="width: 10%">操作</th>
				</tr>
			</thead>					
			<tbody id="tb">
				<c:forEach items="${channelList}" var="cdbooChannel" varStatus="status">
					<tr>
						<td>
							${cdbooChannel.channelNo}<input type="hidden" id="${channelElementName }" name = '${channelElementName }' value="${cdbooChannel.id }">
						</td>
						<td>
							${cdbooChannel.channelName}
						</td>
						<td>
							<pic:preview path="${cdbooChannel.photoPath}"></pic:preview>
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
							<c:if test="${cdbooChannel.themeType eq Constants.THEMETYPE_STYLE }">
								${fns:getDictLabel(cdbooChannel.themeConcreteType,'style_type', '')}
							</c:if>
						</td>
						<td>
							${cdbooChannel.channelVersion}
						</td>
						<c:if test="${not empty sortElementName}">
							<td>
								<input type="text" name="${sortElementName }" value="${cdbooChannel.sort}" class="input-small">
							</td>
						</c:if>
						<td>
							<fmt:formatDate value="${cdbooChannel.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
						<td><a href="#" onclick="deleteRow(this)">删除</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<c:if test="${not empty sortElementName}">
	<script type="text/template" id="channelTpl">//<!--
		<tr>
			<td>{{row.channelNo}}<input type="hidden" name = '${channelElementName }' value='{{row.id}}'></td>
			<td>{{row.channelName}}</td>
			<td><img src="{{row.photoPath}}" width="${Constants.IMG_WIDTH}" height="${Constants.IMG_HEIGHT}" onclick="disPic('{{row.photoPath}}')"/></td>
			<td>{{row.themeType}}</td>
			<td>{{row.themeConcreteType}}</td>
			<td>{{row.channelVersion}}</td>
			<td><input type="text" name="${sortElementName }" value="0" class="input-small"></td>
			<td>{{row.createDate}}</td>
			<td><a href="#" onclick="deleteRow(this)">删除</a></td>
		</tr>//-->
	</script>	
</c:if>
<c:if test="${empty sortElementName}">
	<script type="text/template" id="channelTpl">//<!--
		<tr>
			<td>{{row.channelNo}}<input type="hidden" name = '${channelElementName }' value='{{row.id}}'></td>
			<td>{{row.channelName}}</td>
			<td><img src="{{row.photoPath}}" width="${Constants.IMG_WIDTH}" height="${Constants.IMG_HEIGHT}" onclick="disPic('{{row.photoPath}}')"/></td>
			<td>{{row.themeType}}</td>
			<td>{{row.themeConcreteType}}</td>
			<td>{{row.channelVersion}}</td>
			<td>{{row.createDate}}</td>
			<td><a href="#" onclick="deleteRow(this)">删除</a></td>
		</tr>//-->
	</script>	
</c:if>
			