<%@ page contentType="text/html;charset=UTF-8" import="com.cabinetms.common.Constants"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>节目策略管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					var rowSize = $('#cabinetmsProgramTacticDetailList tr').size();
					if(rowSize<=0){
						top.$.jBox.alert("请填写节目后提交","提示");
						return;
					}
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
		function addRow(isAdd,list, idx, tpl, row){
			$(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: true, row: row,isAdd:isAdd
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
		<li><a href="${ctx}/programtactic/cabinetmsProgramTactic/">节目策略生成列表</a></li>
		<li class="active"><a href="${ctx}/programtactic/cabinetmsProgramTactic/form?id=${cabinetmsProgramTactic.id}">节目策略生成<shiro:hasPermission name="programtactic:cabinetmsProgramTactic:edit">${not empty cabinetmsProgramTactic.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="programtactic:cabinetmsProgramTactic:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cabinetmsProgramTactic" action="${ctx}/programtactic/cabinetmsProgramTactic/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden" name="status" value="<%=Constants.STATUS_WAIT_SUBMIT%>"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">策略名称：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">开始时间：</label>
			<div class="controls">
				<input name="starttimeparam" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="${cabinetmsProgramTactic.starttimeparam}"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">结束时间：</label>
			<div class="controls">
				<input name="endtimeparam" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="${cabinetmsProgramTactic.endtimeparam}"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
			<div class="control-group">
				<label class="control-label">节目策略明细表：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th style="width: 30%">节目</th>
								<th style="width: 30%">开始时间</th>
								<th style="width: 30%">结束时间</th>
								<shiro:hasPermission name="programtactic:cabinetmsProgramTactic:edit"><th style="width: 5%">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="cabinetmsProgramTacticDetailList">
						</tbody>
						<shiro:hasPermission name="programtactic:cabinetmsProgramTactic:edit"><tfoot>
							<tr><td colspan="8"><a href="javascript:" onclick="addRow('Y','#cabinetmsProgramTacticDetailList', cabinetmsProgramTacticDetailRowIdx, cabinetmsProgramTacticDetailTpl);cabinetmsProgramTacticDetailRowIdx = cabinetmsProgramTacticDetailRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="cabinetmsProgramTacticDetailTpl">//<!--
						<tr id="cabinetmsProgramTacticDetailList{{idx}}">
							<td class="hide">
								<input id="cabinetmsProgramTacticDetailList{{idx}}_id" name="cabinetmsProgramTacticDetailList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="cabinetmsProgramTacticDetailList{{idx}}_delFlag" name="cabinetmsProgramTacticDetailList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<select id="cabinetmsProgramTacticDetailList{{idx}}_program" data-value="{{row.program.id}}" name="cabinetmsProgramTacticDetailList[{{idx}}].program.id" class="input-medium required">
									<option value="">请选择</option>
									{{^isAdd}}
										{{#row.programList}}
											<option value="{{id}}">{{name}}</option>
                                    	{{/row.programList}}
									{{/isAdd}}
									{{#isAdd}}
										<c:forEach items="${programList }" var="program">
											<option value="${program.id}">${program.name}</option>
										</c:forEach>
									{{/isAdd}}
								</select>
							</td>
							<td>
								<input id="cabinetmsProgramTacticDetailList{{idx}}_starttimeparam" name="cabinetmsProgramTacticDetailList[{{idx}}].starttimeparam" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
									value="{{row.starttimeparam}}" onclick="WdatePicker({dateFmt:'HH:mm:ss',isShowClear:false});"/>
							</td>
							<td>
								<input id="cabinetmsProgramTacticDetailList{{idx}}_endtimeparam" name="cabinetmsProgramTacticDetailList[{{idx}}].endtimeparam" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
									value="{{row.endtimeparam}}" onclick="WdatePicker({dateFmt:'HH:mm:ss',isShowClear:false});"/>
							</td>
							<shiro:hasPermission name="programtactic:cabinetmsProgramTactic:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#cabinetmsProgramTacticDetailList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var cabinetmsProgramTacticDetailRowIdx = 0, cabinetmsProgramTacticDetailTpl = $("#cabinetmsProgramTacticDetailTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(cabinetmsProgramTactic.cabinetmsProgramTacticDetailList)};
							for (var i=0; i<data.length; i++){
								addRow(null,'#cabinetmsProgramTacticDetailList', cabinetmsProgramTacticDetailRowIdx, cabinetmsProgramTacticDetailTpl, data[i]);
								cabinetmsProgramTacticDetailRowIdx = cabinetmsProgramTacticDetailRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
		<div class="form-actions">
			<c:if test="${cabinetmsProgramTactic.id == null || cabinetmsProgramTactic.status == '1'}">
				<shiro:hasPermission name="programtactic:cabinetmsProgramTactic:edit">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
				</shiro:hasPermission>
			</c:if>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>