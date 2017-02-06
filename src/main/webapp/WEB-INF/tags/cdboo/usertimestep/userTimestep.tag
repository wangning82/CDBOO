<%@ tag language="java" pageEncoding="UTF-8" import="com.cdboo.common.Constants"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="userTimestepList" type="java.util.List" required="true" description="用户时段集合"%>
<%@ attribute name="userTimestepElementName" type="java.lang.String" required="true" description="用户时段隐藏域id名称"%>
<%@ attribute name="userElementId" type="java.lang.String" required="false" description="查询对应用户id所关联的时段,不传查询所有"%>
<script type="text/javascript">
	function deleteRow(obj){
		$(obj).parent().parent().remove();
	}
	
	function openMappingWin(){
		var ids = '';
		var userTimestepIdSize = $("input[name = '${userTimestepElementName}']").size();
		if(userTimestepIdSize > 0){
			$("input[name = '${userTimestepElementName}']").each(function(index){
				var id = $(this).val();
				ids += id;
				if(index != userTimestepIdSize-1){
					ids += ",";
				}
			});
		}
		var elementId = '${userElementId}';
		var userId = '';
		if(elementId){
			userId = $('#'+elementId).val();
		}
		
		top.$.jBox.open("iframe:${ctx}/usertimestep/cdbooUserTimestep/openUserTimestepWin?userId="+userId+"&ids="+ids, "分配时段",$(top.document).width()-240,$(top.document).height()-400,{
			buttons:{"确定分配":"ok", "关闭":true}, bottomText:"通过查询条件选择用户时段，选择后窗口不会关闭，可以连续选择。",submit:function(v, h, f){
				var checkArray = h.find("iframe")[0].contentWindow.getCheckData();
				if (v=="ok"){
					try {
						var tpl = $("#cdbooUserTimestepTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						for (var i = 0; i < checkArray.length; i++) {
							var entity = checkArray[i];
							if(checkUserTimestepIdIsExists(entity.id)){
								continue;
							}
							//alert(entity.id+":"+entity.musicName+":"+entity.actor+":"+entity.special+":"+entity.musicOwner+":"+entity.volume)
							$('#cdbooUserTimestepList').append(Mustache.render(tpl, {row: entity}));
						}
						showTip('追加时段成功，请继续选择时段','success');
					} catch (e) {
						showTip('追加时段失败，请重新选择时段','error');
					}
					
			    	return false;
				}
			}, loaded:function(h){
				$(".jbox-content", top.document).css("overflow-y","hidden");
			}
		});
	}
	
	function appendChannel(){
		var elementId = '${userElementId}';
		var userId = '';
		if(elementId){
			userId = $('#'+elementId).val();
		}
		
		top.$.jBox.open("iframe:${ctx}/usertimestep/cdbooUserTimestep/openUserTimestepWin?userId="+userId+"&ids="+ids, "分配时段",$(top.document).width()-240,$(top.document).height()-400,{
			buttons:{"确定分配":"ok", "关闭":true}, bottomText:"通过查询条件选择用户时段，选择后窗口不会关闭，可以连续选择。",submit:function(v, h, f){
				var checkArray = h.find("iframe")[0].contentWindow.getCheckData();
				if (v=="ok"){
					try {
						var tpl = $("#cdbooUserTimestepTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						for (var i = 0; i < checkArray.length; i++) {
							var entity = checkArray[i];
							if(checkUserTimestepIdIsExists(entity.id)){
								continue;
							}
							//alert(entity.id+":"+entity.musicName+":"+entity.actor+":"+entity.special+":"+entity.musicOwner+":"+entity.volume)
							$('#cdbooUserTimestepList').append(Mustache.render(tpl, {row: entity}));
						}
						showTip('追加时段成功，请继续选择时段','success');
					} catch (e) {
						showTip('追加时段失败，请重新选择时段','error');
					}
					
			    	return false;
				}
			}, loaded:function(h){
				$(".jbox-content", top.document).css("overflow-y","hidden");
			}
		});
	}
	
	//检查时段id是否存在
	function checkUserTimestepIdIsExists(userTimestepId){
		var flag = false;
		$("input[name = '${userTimestepElementName}']").each(function(index){
			var id = $(this).val();
			//alert("["+id+"]:["+musicId+"]["+(id == musicId)+"]")
			if(id == userTimestepId){
				flag = true;
				return false;
			}
		});
		return flag;
	}
</script>
<div class="form-actions">
	<input id="assignButton" class="btn btn-primary" type="button" value="分配时段" onclick="openMappingWin()"/>
</div>
<div class="control-group">
	<label class="control-label">时段列表：</label>
			<div class="controls">
				<table id="contentTable" class="table table-striped table-bordered table-condensed">
					<thead>
						<tr>
							<th class="hide"></th>
							<th style="width: 30%">时段名称</th>
							<th style="width: 30%">开始时间</th>
							<th style="width: 30%">结束时间</th>
							<th style="width: 10%">操作</th>
						</tr>
					</thead>
					<tbody id="cdbooUserTimestepList">
						<c:forEach items="${userTimestepList }" var="userTimestep" >
							<tr>
								<td class="hide">
									<input name="${userTimestepElementName}" type="hidden" value="${userTimestep.id }"/>
								</td>
								<td>
									${userTimestep.name }
								</td>
								<td>
									${userTimestep.startTime }
								</td>
								<td>
									${userTimestep.endTime }
								</td>
								<td class="text-center"><a href="#" onclick="deleteRow(this)">删除</a>&nbsp;<a href="#" onclick="appendChannel(${userTimestep.id })">添加频道</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>	
				<script type="text/template" id="cdbooUserTimestepTpl">//<!--
					<tr>
							<td class="hide">
								<input name="${userTimestepElementName}" type="hidden" value="{{row.id}}"/>
							</td>
							<td>
								{{row.name}}
							</td>
							<td>
								{{row.startTime}}
							</td>
							<td>
								{{row.endTime}}
							</td>
							<td class="text-center" width="10"><a href="#" onclick="deleteRow(this)">删除</a>&nbsp;<a href="#" onclick="appendChannel({{row.id}})">添加频道</a></td>
					</tr>//-->
				</script>
	</div>	
</div>		