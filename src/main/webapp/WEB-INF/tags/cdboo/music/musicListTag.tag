<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="musicList" type="java.util.List" required="true" description="音乐集合"%>
<%@ attribute name="musicIdElementName" type="java.lang.String" required="true" description="音乐隐藏域id名称"%>
<%@ attribute name="userElementId" type="java.lang.String" required="false" description="查询对应用户id所购买的曲目,不传查询所有"%>
<script type="text/javascript">
	function deleteRow(obj){
		$(obj).parent().parent().remove();
	}
	
	function openMappingWin(){
		var ids = '';
		var musicIdSize = $("input[name = '${musicIdElementName}']").size();
		if(musicIdSize > 0){
			$("input[name = '${musicIdElementName}']").each(function(index){
				var id = $(this).val();
				ids += id;
				if(index != musicIdSize-1){
					ids += ",";
				}
			});
		}
		var elementId = '${userElementId}';
		var userId = '';
		if(elementId){
			userId = $('#'+elementId).val();
		}
		
		top.$.jBox.open("iframe:${ctx}/music/cdbooMusic/openMusicWin?userId="+userId+"&ids="+ids, "分配音乐",$(top.document).width()-240,$(top.document).height()-400,{
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
							//alert(entity.id+":"+entity.musicName+":"+entity.actor+":"+entity.special+":"+entity.musicOwner+":"+entity.volume)
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
		var flag = false;
		$("input[name = '${musicIdElementName}']").each(function(index){
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
				<td>${cdbooMusic.musicName}<input type="hidden" name = '${musicIdElementName }' value="${cdbooMusic.id }"></td>
				<td>${cdbooMusic.actor}</td>
				<td>${cdbooMusic.special}</td>
				<td>${fns:getDictLabel(cdbooMusic.musicOwner, 'owner_type', '')}</td>
				<td>${cdbooMusic.volume}</td>
				<td><a href="#" onclick="deleteRow(this)">删除</a></td>
			</tr>
		</c:forEach>
	</tbody>
</table>	

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