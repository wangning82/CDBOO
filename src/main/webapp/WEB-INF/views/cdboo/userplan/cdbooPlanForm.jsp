<%@ page contentType="text/html;charset=UTF-8" %>
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
		<li><a href="${ctx}/userplan/cdbooPlan/">用户计划列表</a></li>
		<li class="active"><a href="${ctx}/userplan/cdbooPlan/form?id=${cdbooPlan.id}">用户计划<shiro:hasPermission name="userplan:cdbooPlan:edit">${not empty cdbooPlan.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="userplan:cdbooPlan:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="planModel" action="${ctx}/userplan/cdbooPlan/save" method="post" class="form-horizontal">
		<sys:message content="${message}"/>

		<div class="control-group">
			<label class="control-label">用户：</label>
			<div class="controls">
				<sys:treeselect id="user" name="userId" value="${cdbooPlan.user.id}" labelName="" labelValue="${planModel.userName}"
								title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
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
						<th>风格</th>
						<th>星期</th>
						<th>开始日期</th>
						<th>结束日期</th>
						<th>备注</th>
						<shiro:hasPermission name="userplan:cdbooPlan:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
					</tr>
					</thead>
					<tbody id="planList">
					</tbody>
					<shiro:hasPermission name="userplan:cdbooPlan:edit"><tfoot>
					<tr><td colspan="16"><a href="javascript:" onclick="addRow('#planList', planRowIdx, planTpl);planRowIdx = planRowIdx + 1;" class="btn">新增</a></td></tr>
					</tfoot></shiro:hasPermission>
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
									<c:forEach items="${timestepList}" var="timestep">
										<option value="${timestep.id}">${timestep.timestepName}</option>
									</c:forEach>
								</select>
							</td>

                            <td>
								<select id="planList{{idx}}_userChannelId" name="planList[{{idx}}].userChannelId" data-value="{{row.userChannelId}}" class="input-small ">
									<option value="">请选择</option>
									<c:forEach items="${channelList}" var="channel">
										<option value="${channel.id}">${channel.channelName}</option>
									</c:forEach>
								</select>
							</td>
							
                            <td>
                                <select id="planList{{idx}}_musicStyle" name="planList[{{idx}}].musicStyle" data-value="{{row.musicStyle}}" class="input-small ">
                                    <option value="">请选择</option>
                                    <c:forEach items="${fns:getDictList('music_style')}" var="style">
										<option value="${style.value}">${style.label}</option>
									</c:forEach>
                                </select>
							</td>

                            <td>

                            	<select id="planList{{idx}}_week" name="planList[{{idx}}].week" data-value="{{row.week}}" class="input-small ">
                                    <option value="">请选择</option>
                                    <c:forEach items="${fns:getDictList('week')}" var="style">
										<option value="${style.value}">${style.label}</option>
									</c:forEach>
                                </select>
							</td>

                            <td>
								<input id="planList{{idx}}_startDate" name="planList[{{idx}}].startDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
									value="{{row.startDate}}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
							</td>

                            <td>
								<input id="planList{{idx}}_endDate" name="planList[{{idx}}].endDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
									value="{{row.endDate}}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
							</td>

							<td>
								<input id="planList{{idx}}_remarks" name="planList[{{idx}}].remarks" type="text" value="{{row.remarks}}" maxlength="255" class="input-small "/>
							</td>

							<shiro:hasPermission name="userplan:cdbooPlan:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#planList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
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
			<shiro:hasPermission name="userplan:cdbooPlan:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>

	</form:form>
</body>
</html>