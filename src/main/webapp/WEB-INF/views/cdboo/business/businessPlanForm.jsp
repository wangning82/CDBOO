<%@ page contentType="text/html;charset=UTF-8" import="com.cdboo.common.Constants" %>
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
			
			themeChanged('${businessPlan.style}');
		});
		
		function themeChanged(style) {
			var themeType = '${Constants.THEMETYPE_THEME}';//0 主题
			var styleType = '${Constants.THEMETYPE_STYLE}';//2 风格
			var holidayType = '${Constants.THEMETYPE_HOLIDAY}';//1 节日
			var spotsType = '${Constants.THEMETYPE_SPOTS}';//3 插播
			
			if(style){
				if (style == spotsType) {
					//如果是插播，默认开启时间段选择，关闭日期选择，开启和插播相关的组件
					helpChangeDisStatus(true,false,true,true);
				} else if(style == holidayType){
					//如果是节日，默认开启时间段选择，关闭日期选择，关闭和插播相关的组件
					helpChangeDisStatus(true,false,false,false);
				}
				else if(style == themeType || style == styleType){
					//如果是主题和风格，默认开启日期选择，关闭时间段选择，开启业态选择，关闭和插播相关的组件
					helpChangeDisStatus(true,true,false,false);
				}
			}
			else{
				helpChangeDisStatus(true,true,false,false);
			}
		}
		
		/**
		切换组件显示帮助方法
		dateDisFlag:日期段选择显示隐藏控制，true为显示，false为隐藏
		weekDisFlag:星期选择显示隐藏控制，true为显示，false为隐藏
		intervalTimeDisFlag:间隔时间选择显示隐藏控制，true为显示，false为隐藏
		cycleIndexDisFlag:循环次数选择显示隐藏控制，true为显示，false为隐藏
		*/
		function helpChangeDisStatus(dateDisFlag,weekDisFlag,intervalTimeDisFlag,cycleIndexDisFlag){
			if(dateDisFlag){
				$("#startDateDiv").show();
				$("#endDateDiv").show();
			}
			else{
				$("#startDateDiv").hide();
				$("#endDateDiv").hide();
			}
			
			if(weekDisFlag){
				$("#weekDiv").show();
			}
			else{
				$("#weekDiv").hide();
			}
			
			if(intervalTimeDisFlag){
				$("#intervalTimeDiv").show();
			}
			else{
				$("#intervalTimeDiv").hide();
			}
			
			if(cycleIndexDisFlag){
				$("#cycleIndexDiv").show();
			}
			else{
				$("#cycleIndexDiv").hide();
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/businessplan/plan/listTimestep?business.id=${businessPlan.business.id }">行业计划列表</a></li>
		<li class="active"><a href="${ctx}/businessplan/plan/form">行业计划编辑</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="businessPlan" action="${ctx}/businessplan/plan/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden" value="${businessPlan.business.id }" name="business.id">
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">计划名称：</label>
			<div class="controls">
				<form:input path="planName" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">风格：</label>
			<div class="controls">
				<form:select path="style" class="input-xlarge " onchange="themeChanged(this.value)">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('theme_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group" id="weekDiv">
			<label class="control-label">周属性：</label>
			<div class="controls">
				<form:checkboxes path="weeks" items="${fns:getDictList('week')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
			</div>
		</div>
		
		<div class="control-group" id="startDateDiv">
			<label class="control-label">开始日期：</label>
			<div class="controls">
				<input name="startDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${businessPlan.startDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group" id="endDateDiv">
			<label class="control-label">结束日期：</label>
			<div class="controls">
				<input name="endDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${businessPlan.endDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group" id="cycleIndexDiv">
			<label class="control-label">循环次数：</label>
			<div class="controls">
				<select id="cycleIndex" name="cycleIndex" class="input-small ">
                  <option value="">请选择</option>
				  <c:forEach begin="1" end="20" step="1" var="rate">
					<option value="${rate}" <c:if test="${businessPlan.cycleIndex eq rate }">selected</c:if> >${rate}</option>
				  </c:forEach>
                </select>
			</div>
		</div>
		<div class="control-group" id="intervalTimeDiv">
			<label class="control-label">重复时间：</label>
			<div class="controls">
				<select id="intervalTime" name="intervalTime" class="input-small ">
                	<option value="">请选择</option>
					<c:forEach begin="1" end="60" step="1" var="minute">
						<option value="${minute}" <c:if test="${businessPlan.intervalTime eq minute }">selected</c:if> >${minute}</option>
					</c:forEach>
                </select>													                    	
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		
		<div class="form-actions">
			<shiro:hasPermission name="businessplan:plan:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="javascript:window.location.href='${ctx}/businessplan/plan/listTimestep?business.id=${businessPlan.business.id }'"/>
		</div>
	</form:form>
</body>
</html>