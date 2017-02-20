<%@ tag language="java" pageEncoding="UTF-8" import="com.cdboo.common.Constants"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="channelList" type="java.util.List" required="true" description="频道集合"%>
<%@ attribute name="channelElementName" type="java.lang.String" required="true" description="频道隐藏域id名称"%>
<%@ attribute name="sortElementName" type="java.lang.String" required="false" description="排序隐藏域id名称"%>
<%@ attribute name="userElementId" type="java.lang.String" required="false" description="查询对应用户id所关联的频道,不传查询所有"%>
<%@ attribute name="channelType" type="java.lang.String" required="false" description="指定频道类型"%>
<%@ attribute name="isInclude" type="java.lang.String" required="true" description="是否查询包含用户id的频道数据，0为包含，1为不包含，即查询不等于用户已有频道数据的那些频道"%>
<%@ attribute name="isReview" type="java.lang.String" required="false" description="是否是查看模式，查看模式只能看不能编辑，如果是则页面屏蔽编辑保存等按钮，只展示数据"%>

<!-- 如果没有传递isReview值，默认给0，代表非查看模式 -->
<c:if test="${empty isReview}">
	<c:set value="0" var="isReview"></c:set>
</c:if>

<!-- 如果是查看模式 ，则不做javascript创建，弹出窗口按钮也不再显示-->
<c:if test="${isReview eq '0' }">
	<script type="text/javascript">
		//删除行方法
		function deleteRow(obj){
			$(obj).parent().parent().remove();
		}
		
		function openMappingWin(){
			//如果页面已经存在数据，则收集这些数据的id集合字符串，用逗号分隔 Start
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
			//如果页面已经存在数据，则收集这些数据的id集合字符串，用逗号分隔 End
			
			//如果传了userElementId，根据这个页面id获得用户值 Start
			var elementId = '${userElementId}';
			var userId = '';
			if(elementId){
				userId = $('#'+elementId).val();
			}
			//如果传了userElementId，根据这个页面id获得用户值 End
			
			top.$.jBox.open("iframe:${ctx}/channel/cdbooChannel/openChannelWin?includeFlag=${isInclude}&userId="+userId+"&ids="+ids+"&channelType=${channelType}", "分配频道",$(top.document).width()-240,$(top.document).height()-240,{
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
</c:if>

<script type="text/javascript">
	function toChildChannelPage(channelId){
		top.$.jBox.open("iframe:${ctx}/channel/cdbooChannel/toChildChannelWin?id="+channelId, "子频道列表",$(top.document).width()-240,$(top.document).height()-240,{
			buttons:{"关闭":true}
		});
	}
</script>
<div class="control-group">
	<label class="control-label">频道列表：</label>
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
					
					<c:if test="${isReview eq '0' }">
						<th style="width: 10%">操作</th>
					</c:if>
					<!-- 如果是组合频道，则显示子频道列表，否则不显示该列 -->
					<c:if test="${channelType eq Constants.CHANNEL_TYPE_GROUP }">
						<th style="width: 10%">子频道列表</th>
					</c:if>
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
						<c:if test="${isReview eq '0' }">
							<td><a href="#" onclick="deleteRow(this)">删除${channelType }</a></td>
						</c:if>
						<!-- 如果是组合频道，则显示子频道列表查看按钮，否则不显示该列 -->
						<c:if test="${channelType eq Constants.CHANNEL_TYPE_GROUP }">
							<td><a href="#" onclick="toChildChannelPage('${cdbooChannel.id}')">查看</a></td>
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<!-- 如果是查看模式 ，则不做javascript创建-->
<c:if test="${isReview eq '0'}">
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
			<td><a href="#" onclick="toChildChannelPage('{{row.id}}')">查看</a></td>
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
			<td><a href="#" onclick="toChildChannelPage('{{row.id}}')">查看</a></td>
		</tr>//-->
		</script>	
	</c:if>
</c:if>
