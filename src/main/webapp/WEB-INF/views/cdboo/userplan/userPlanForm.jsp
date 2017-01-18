<%@ page contentType="text/html;charset=UTF-8" import="com.cdboo.common.Constants"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户计划管理</title>
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

		var timestepData = '';
		var channelData = '';
		var conditionData = '';
		function addRow(list, idx, tpl, row){
			var user = $('#userId').val();
			if(!user){
				top.$.jBox.alert("请先选择用户后添加","提示");
				return;
			}
			$(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: true, row: row
			}));

			$(list+idx).find("select").each(function(){

				if ($(this).attr('id') == 'planList' + idx + '_userTimestepId') {
					for (var i = 0; i < timestepData.length; i++) {
						$(this).append("<option value='" + timestepData[i].id + "'>" + timestepData[i].name + "</option>");
					}
				}

				if ($(this).attr('id') == 'planList' + idx + '_userChannelId') {
					for (var i = 0; i < channelData.length; i++) {
						$(this).append("<option value='" + channelData[i].id +","+ channelData[i].channelType + "'>" + channelData[i].channelName + "</option>");
					}
				}
				
				if ($(this).attr('id') == 'planList' + idx + '_operationType') {
					for (var i = 0; i < conditionData.length; i++) {
						$(this).append("<option value='" + conditionData[i].id + "'>" + conditionData[i].name + "</option>");
					}
				}

				$(this).val($(this).attr("data-value"));
				$(this).trigger("change");
			});

			$(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
				var ss = $(this).attr("data-value").split(',');
				for (var i=0; i<ss.length; i++){
					if($(this).val() == ss[i]){
						$(this).attr("checked","checked");
					}
				}
			});
			//themeChanged(idx);
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

		function themeChanged(idx) {
			var style = $("#planList" + idx + "_musicStyle").val();
			var themeType = '${Constants.THEMETYPE_THEME}';//0 主题
			var styleType = '${Constants.THEMETYPE_STYLE}';//2 风格
			var holidayType = '${Constants.THEMETYPE_HOLIDAY}';//1 节日
			var spotsType = '${Constants.THEMETYPE_SPOTS}';//3 插播
			
			if(style){
				if (style == spotsType) {
					//如果是插播，默认开启时间段选择，关闭日期选择，关闭业态选择，开启和插播相关的组件
					helpChangeDisStatus(idx,true,false,true,true,false);
				} else if(style == holidayType){
					//如果是节日，默认开启时间段选择，关闭日期选择，开启业态选择，关闭和插播相关的组件
					helpChangeDisStatus(idx,true,false,false,false,true);
				}
				else if(style == themeType || style == styleType){
					//如果是主题和风格，默认开启日期选择，关闭时间段选择，开启业态选择，关闭和插播相关的组件
					helpChangeDisStatus(idx,false,true,false,false,true);
				}
			}
			else{
				helpChangeDisStatus(idx,false,true,false,false,true);
			}
		}
		
		/**
			切换组件显示帮助方法
			idx:行索引
			dataSpanDisFlag:日期段选择显示隐藏控制，true为显示，false为隐藏
			checkboxSpanDisFlag:星期选择显示隐藏控制，true为显示，false为隐藏
			intervalTimeDisFlag:间隔时间选择显示隐藏控制，true为显示，false为隐藏
			rateDisFlag:循环次数选择显示隐藏控制，true为显示，false为隐藏
			conditionDisFlag:业态选择显示隐藏控制，true为显示，false为隐藏
		*/
		function helpChangeDisStatus(idx,dataSpanDisFlag,checkboxSpanDisFlag,intervalTimeDisFlag,rateDisFlag,conditionDisFlag){
			if(dataSpanDisFlag){
				$("#dateSpan_" + idx).show();
			}
			else{
				$("#dateSpan_" + idx).hide();
			}
			
			if(checkboxSpanDisFlag){
				$("#checkboxSpan_" + idx).show();
			}
			else{
				$("#checkboxSpan_" + idx).hide();
			}
			
			if(intervalTimeDisFlag){
				//$("#intervalTimeTH").show();
				$("#intervalTimeTD_" + idx).show();
			}
			else{
				//$("#intervalTimeTH").hide();
				$("#intervalTimeTD_" + idx).hide();
			}
			
			if(rateDisFlag){
				//$('#rateTH').show();
				$("#rateTD_" + idx).show();
			}
			else{
				//$('#rateTH').hide();
				$("#rateTD_" + idx).hide();
			}
			
			if(conditionDisFlag){
				//业态title列
				//$('#conditionTH').show();
				//业态数据列
				$('#conditionTD_' + idx).show();
			}
			else{
				//业态title列
				//$('#conditionTH').hide();
				//业态数据列
				$('#conditionTD_' + idx).hide();
			}
		}
		
		function channelTypeChanged(obj,idx){
			var childChannelType = '${Constants.CHANNEL_TYPE_CHILD}';//0 子频道
			var groupChannelType = '${Constants.CHANNEL_TYPE_GROUP}';//1 组合频道
			
			var selectedVal = obj.value;
			if(selectedVal){
				var valArray = selectedVal.split(",");
				var channelType = valArray[1];
				if(channelType == childChannelType){
					$('#channelTypeTD'+idx).html("子频道");
				}
				if(channelType == groupChannelType){
					$('#channelTypeTD'+idx).html("组合频道");
				}
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/userplan/cdbooPlan/userPlanList">用户计划列表</a></li>
		<li class="active"><a href="#">用户计划编辑</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="planModel" action="${ctx}/userplan/cdbooPlan/userPlanSave" method="post" class="form-horizontal">
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">用户：</label>
			<div class="controls">
				${fns:getUser().name}
				<input type="hidden" id="userId" name="user.id" value="${fns:getUser().id }"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">计划详情：</label>
			<div class="controls">
				<table id="contentTable" class="table table-striped table-bordered table-condensed">
					<thead>
					<tr>
						<th class="hide"></th>
						<th>编号</th>
						<th>名称</th>
						<th>时段</th>
						<th>频道</th>
						<th>频道类型</th>
						<th>风格</th>
						<th id="dateBetweenTH">日期区间</th>
						<th id="rateTH">循环次数</th>
						<th id="intervalTimeTH">间隔时间(分钟)</th>
						<th id="conditionTH">业态</th>
						<th>备注</th>
					</tr>
					</thead>
					<tbody id="planList">
					</tbody>
				</table>
				<script type="text/template" id="planTpl">//<!--
						<tr id="planList{{idx}}">
							<td class="hide">
								<input id="planList{{idx}}_id" name="planList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="planList{{idx}}_delFlag" name="planList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<input id="planList{{idx}}_planNo" name="planList[{{idx}}].planNo" type="text" value="{{row.planNo}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="planList{{idx}}_playName" name="planList[{{idx}}].playName" type="text" value="{{row.playName}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<select id="planList{{idx}}_userTimestepId" name="planList[{{idx}}].userTimestepId" data-value="{{row.userTimestepId}}" class="input-small ">
									<option value="">请选择</option>
									<c:forEach items="${planModel.cdbooUserTimestepList}" var="cdbooUserTimestep">
										<option value="${cdbooUserTimestep.id}">${cdbooUserTimestep.name}</option>
									</c:forEach>
								</select>
							</td>
                            <td>
								<select id="planList{{idx}}_userChannelId" name="planList[{{idx}}].userChannelId" data-value="{{row.channel.id}},{{row.channel.channelType}}" class="input-small " onchange="channelTypeChanged(this,'{{idx}}');">
									<option value="">请选择</option>
									<c:forEach items="${planModel.cdbooChannelList}" var="cdbooChannel">
										<option value="${cdbooChannel.id},${cdbooChannel.channelType}">${cdbooChannel.channelName}</option>
									</c:forEach>
								</select>
							</td>
							<td id="channelTypeTD{{idx}}" align="center">
								
							</td>
                            <td>
                                <select id="planList{{idx}}_musicStyle" name="planList[{{idx}}].musicStyle" data-value="{{row.musicStyle}}" class="input-small " onchange="javascript:themeChanged({{idx}});">
                                    <option value="">请选择</option>
                                    <c:forEach items="${fns:getDictList('theme_type')}" var="style">
										<option value="${style.value}">${style.label}</option>
									</c:forEach>
                                </select>
							</td>

                            <td nowrap="nowrap">
                            	<span id="checkboxSpan_{{idx}}" >
									<c:forEach items="${fns:getDictList('week')}" var="style">
										<input type="checkbox" name="planList[{{idx}}].week" value="${style.value}" data-value="{{row.week}}" />${style.label}
									</c:forEach>
								</span>
								<span id="dateSpan_{{idx}}">
									<input id="planList{{idx}}_startDate" name="planList[{{idx}}].startDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
										value="{{row.startDate}}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
									<input id="planList{{idx}}_endDate" name="planList[{{idx}}].endDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
										value="{{row.endDate}}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
								</span>
							</td>

							<td>
								<span id="rateTD_{{idx}}" >
									<select id="planList{{idx}}_rate" name="planList[{{idx}}].rate" data-value="{{row.rate}}" class="input-small ">
                                    	<option value="">请选择</option>
										<c:forEach begin="1" end="20" step="1" var="rate">
											<option value="${rate}">${rate}</option>
										</c:forEach>
                                	</select>
								</span>		
							</td>

							<td>
								<span id="intervalTimeTD_{{idx}}" >
									<select id="planList{{idx}}_intervalTime" name="planList[{{idx}}].intervalTime" data-value="{{row.intervalTime}}" class="input-small ">
                                    	<option value="">请选择</option>
										<c:forEach begin="1" end="60" step="1" var="minute">
											<option value="${minute}">${minute}</option>
										</c:forEach>
                                	</select>
								</span>
							</td>

							<td>
								<span id="conditionTD_{{idx}}" >
									<select id="planList{{idx}}_operationType" name="planList[{{idx}}].operationType" data-value="{{row.operationType}}" class="input-small ">
                                    	<option value="">请选择</option>
										<c:forEach items="${planModel.cdbooConditionList}" var="condition">
											<option value="${condition.id}">${condition.name}</option>
										</c:forEach>
                                	</select>
								</span>
							</td>

							<td>
								<input id="planList{{idx}}_remarks" name="planList[{{idx}}].remarks" type="text" value="{{row.remarks}}" maxlength="255" class="input-small "/>
							</td>
						</tr>//-->
				</script>
				<script type="text/javascript">
					var planRowIdx = 0, planTpl = $("#planTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
					$(document).ready(function() {
						var data = ${fns:toJson(planModel.planList)};

						for (var i = 0; i < data.length; i++) {
							addRow('#planList', planRowIdx, planTpl, data[i]);
							planRowIdx = planRowIdx + 1;
						}
					});
				</script>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="plan:cdbooPlan:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>

	</form:form>
</body>
</html>