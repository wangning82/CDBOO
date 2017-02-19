<%@ tag language="java" pageEncoding="UTF-8" import="com.cdboo.common.Constants"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="timestepList" type="java.util.List" required="true" description="时段集合"%>
<%@ attribute name="businessId" type="java.lang.String" required="true" description="行业id"%>
<%@ attribute name="timestepElementName" type="java.lang.String" required="true" description="时段隐藏域id名称"%>
<%@ attribute name="redirectURL" type="java.lang.String" required="true" description="添加频道跳转url前缀"%>

<script type="text/javascript">
	$(document).ready(function() {
		
	});
	
	function deleteRow(obj){
		$(obj).parent().parent().remove();
	}
	
	function openMappingWin(){
		var ids = '';
		var userTimestepIdSize = $("input[name = '${timestepElementName}']").size();
		if(userTimestepIdSize > 0){
			$("input[name = '${timestepElementName}']").each(function(index){
				var id = $(this).val();
				ids += id;
				if(index != userTimestepIdSize-1){
					ids += ",";
				}
			});
		}
		
		top.$.jBox.open("iframe:${ctx}/timestep/timestep/openTimestepWin?ids="+ids, "分配时段",$(top.document).width()-240,$(top.document).height()-240,{
			buttons:{"确定分配":"ok", "关闭":true}, bottomText:"通过查询条件选择时段，选择后窗口不会关闭，可以连续选择。",submit:function(v, h, f){
				var checkArray = h.find("iframe")[0].contentWindow.getCheckData();
				if (v=="ok"){
					try {
						var tpl = $("#timestepTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						for (var i = 0; i < checkArray.length; i++) {
							var entity = checkArray[i];
							if(checkTimestepIdIsExists(entity.id)){
								continue;
							}
							//alert(entity.id+":"+entity.musicName+":"+entity.actor+":"+entity.special+":"+entity.musicOwner+":"+entity.volume)
							$('#timestepList').append(Mustache.render(tpl, {row: entity}));
						}
						showTip('追加时段成功，请继续选择时段','success');
					} catch (e) {
						alert(e)
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
	function checkTimestepIdIsExists(timestepId){
		var flag = false;
		$("input[name = '${timestepElementName}']").each(function(index){
			var id = $(this).val();
			//alert("["+id+"]:["+musicId+"]["+(id == musicId)+"]")
			if(id == timestepId){
				flag = true;
				return false;
			}
		});
		return flag;
	}
	
	function appendChannel(timeStepId,businessId){
		window.location.href = "${redirectURL}?id="+businessId+"&timeStepId="+timeStepId;
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
					<tbody id="timestepList">
						<c:forEach items="${timestepList }" var="timestep" >
							<tr>
								<td class="hide">
									<input name="${timestepElementName}" type="hidden" value="${timestep.id }"/>
								</td>
								<td>
									${timestep.timestepName }
								</td>
								<td>
									${timestep.starttime }
								</td>
								<td>
									${timestep.endtime }
								</td>
								<td class="text-center"><a href="#" onclick="deleteRow(this)">删除</a>&nbsp;<a href="#" onclick="appendChannel('${timestep.id }','${businessId }')">添加频道</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>	
				<script type="text/template" id="timestepTpl">//<!--
					<tr>
							<td class="hide">
								<input name="${timestepElementName}" type="hidden" value="{{row.id}}"/>
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
							<td class="text-center" width="10"><a href="#" onclick="deleteRow(this)">删除</a>&nbsp;<a href="#" onclick="appendChannel('{{row.id}}','${businessId }')">添加频道</a></td>
					</tr>//-->
				</script>
	</div>	
</div>		