<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>计划管理</title>
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
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/myplan/cdbooMyPlan/">计划列表</a></li>
		<li class="active"><a href="${ctx}/myplan/cdbooMyPlan/form?id=${cdbooMyPlan.id}">计划<shiro:hasPermission name="myplan:cdbooMyPlan:edit">${not empty cdbooMyPlan.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="myplan:cdbooMyPlan:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cdbooMyPlan" action="${ctx}/myplan/cdbooMyPlan/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">计划名称：</label>
			<div class="controls">
				<form:input path="planName" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">用户id：</label>
			<div class="controls">
				<sys:treeselect id="user" name="user.id" value="${cdbooMyPlan.user.id}" labelName="user.name" labelValue="${cdbooMyPlan.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">周属性：</label>
			<div class="controls">
				<form:input path="week" htmlEscape="false" maxlength="2" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">风格（主题，节日，计划，插播）：</label>
			<div class="controls">
				<form:select path="style" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('theme_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">开始日期：</label>
			<div class="controls">
				<input name="startDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${cdbooMyPlan.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">结束日期：</label>
			<div class="controls">
				<input name="endDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${cdbooMyPlan.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">循环次数：</label>
			<div class="controls">
				<form:input path="cycleIndex" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">重复时间：</label>
			<div class="controls">
				<form:input path="intervalTime" htmlEscape="false" maxlength="10" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
			<div class="control-group">
				<label class="control-label">计划时段频道关联表：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>用户时段id</th>
								<th>用户频道id</th>
								<th>备注</th>
								<th>频道类型，是组合频道还是子频道</th>
								<th>业态id，机构表id</th>
								<shiro:hasPermission name="myplan:cdbooMyPlan:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="cdbooMyPlanTimestepList">
						</tbody>
						<shiro:hasPermission name="myplan:cdbooMyPlan:edit"><tfoot>
							<tr><td colspan="7"><a href="javascript:" onclick="addRow('#cdbooMyPlanTimestepList', cdbooMyPlanTimestepRowIdx, cdbooMyPlanTimestepTpl);cdbooMyPlanTimestepRowIdx = cdbooMyPlanTimestepRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="cdbooMyPlanTimestepTpl">//<!--
						<tr id="cdbooMyPlanTimestepList{{idx}}">
							<td class="hide">
								<input id="cdbooMyPlanTimestepList{{idx}}_id" name="cdbooMyPlanTimestepList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="cdbooMyPlanTimestepList{{idx}}_delFlag" name="cdbooMyPlanTimestepList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<input id="cdbooMyPlanTimestepList{{idx}}_userTimestep" name="cdbooMyPlanTimestepList[{{idx}}].userTimestep.id" type="text" value="{{row.userTimestep.id}}" maxlength="64" class="input-small "/>
							</td>
							<td>
								<input id="cdbooMyPlanTimestepList{{idx}}_userChannel" name="cdbooMyPlanTimestepList[{{idx}}].userChannel.id" type="text" value="{{row.userChannel.id}}" maxlength="64" class="input-small "/>
							</td>
							<td>
								<textarea id="cdbooMyPlanTimestepList{{idx}}_remarks" name="cdbooMyPlanTimestepList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
							<td>
								<input id="cdbooMyPlanTimestepList{{idx}}_channelType" name="cdbooMyPlanTimestepList[{{idx}}].channelType" type="text" value="{{row.channelType}}" maxlength="1" class="input-small "/>
							</td>
							<td>
								<input id="cdbooMyPlanTimestepList{{idx}}_operationType" name="cdbooMyPlanTimestepList[{{idx}}].operationType" type="text" value="{{row.operationType}}" maxlength="64" class="input-small "/>
							</td>
							<shiro:hasPermission name="myplan:cdbooMyPlan:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#cdbooMyPlanTimestepList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var cdbooMyPlanTimestepRowIdx = 0, cdbooMyPlanTimestepTpl = $("#cdbooMyPlanTimestepTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(cdbooMyPlan.cdbooMyPlanTimestepList)};
							for (var i=0; i<data.length; i++){
								addRow('#cdbooMyPlanTimestepList', cdbooMyPlanTimestepRowIdx, cdbooMyPlanTimestepTpl, data[i]);
								cdbooMyPlanTimestepRowIdx = cdbooMyPlanTimestepRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="myplan:cdbooMyPlan:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>