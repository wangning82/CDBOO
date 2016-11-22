<%@ page contentType="text/html;charset=UTF-8" import="com.cabinetms.common.Constants"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>节目策略管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		//查看终端
		function seeTerm(id){
			// 正常打开	
			top.$.jBox.open("iframe:${ctx}/programtactic/cabinetmsProgramTactic/termListOnly", "选择终端", $(top.document).width()-200,$(top.document).height()-240, {
				ajaxData:{id: id},buttons:{"确定":"ok" }, submit:function(v, h, f){
					if(v == 'ok'){
						top.$.jBox.close(true);
						return false;
					}
				}, loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
		}
		
		//全局节目列表索引
		var globalProgramArrayindex = 0;
		//全局节目列表数组
		var globalProgramArray = new Array();
		//全局节目列表数量
		var globalProgramArrayLength = 0;
		
		//根据时间部分组织一个date对象，用于后面算时间差
		function getDIYDate(time){
			var timeStr = time.toString();
			var hours = timeStr.substring(0,2);
			var minutes = timeStr.substring(2,4);
			var seconds = timeStr.substring(4,6);
			var now = new Date();
			var returnDate = new Date(now.getFullYear(),now.getMonth(),now.getDate(),hours,minutes,seconds);
			//alert(returnDate.Format("yyyy-MM-dd hh:mm:ss"))
			return returnDate;
		}
		
		/**
			检查是否走过了seconds秒
		*/
		function checkTime(seconds,startDateTime){
			var now = new Date();
			var startDate = new Date(startDateTime.substring(0,4),parseInt(startDateTime.substring(4,6))-1,startDateTime.substring(6,8),startDateTime.substring(8,10),startDateTime.substring(10,12),startDateTime.substring(12,14));
			//alert("now:"+now.Format("yyyyMMddhhmmss")+";StartDate:"+startDate.Format("yyyyMMddhhmmss"))
			//alert("now:"+now.getTime()+";StartDate:"+startDate.getTime())
			//alert("cha:"+((now.getTime()-startDate.getTime())/1000))
			var nowDifferenceSeconds = differenceSeconds(startDate,now);
			//alert("nowSecond:"+nowDifferenceSeconds+";seconds:"+seconds)
			if(nowDifferenceSeconds<=seconds){
				return true;
			}
			return false;
		}
		
		//算时间差，秒为单位
		function differenceSeconds(startTime,endTime){
			var milliseconds=endTime.getTime()-startTime.getTime();
			var seconds=Math.round(milliseconds/1000);
			return seconds;
		}
		
		/*
			预览方法
		*/
		function preview(tacticId){
			
			//alert(tacticId)
			
			/******重置全局变量 Start******/
			globalProgramArrayindex = 0;
			globalProgramArray = new Array();
			globalProgramArrayLength = 0;
			/******重置全局变量 End******/
			
			$.ajax({
				type: 'POST',
				async: false,
				url: "${ctx}/programtactic/cabinetmsProgramTactic/getProgramList",
				dataType: "json",
				data: {
					id: tacticId
				},
				success: function(data, textStatus) {
					globalProgramArrayLength = data.length;
					globalProgramArray = data;
				}
			});
			
			/* for(var i=0;i<globalProgramArray.length;i++){
				alert(globalProgramArray[i].id+";"+globalProgramArray[i].starttime+";"+globalProgramArray[i].endtime);
			} */
			
			if(globalProgramArrayLength>0){
				var programObj = globalProgramArray[0];
				var id = programObj.id;
				var startTime = programObj.starttime;
				var endTime = programObj.endtime;
				
				// 正常打开	
				top.$.jBox.open("iframe:${ctx}/program/program/preview", "策略预览", $(top.document).width()-200,$(top.document).height()-240, {
					ajaxData:{id: id},buttons:{"关闭":"ok" }, submit:function(v, h, f){
						if(v == 'ok'){
							top.$.jBox.close(true);
							return false;
						}
					}, loaded:function(h){
						$(".jbox-content", top.document).css("overflow-y","hidden");
					}
				});
				
				var newStartTime = getDIYDate(startTime);
				var newEndTime = getDIYDate(endTime);
				var seconds = differenceSeconds(newStartTime,newEndTime);
				var now = new Date().Format("yyyyMMddhhmmss");
				time(seconds,now); 
			}
			else{
				top.$.jBox.alert("没有节目可以预览","提示");
			}
		}
		
		//js函数递归调用，每隔100毫秒检查一次时间，用于切换预览内容
		function time(seconds,now){  
			if(!checkTime(seconds,now)){
				//alert(";startTime:"+startTime+";endTime:"+endTime)
				if(globalProgramArrayindex == globalProgramArrayLength-1){
					top.$.jBox.close(true);
					return;
				}
				var programObj = globalProgramArray[++globalProgramArrayindex];
				
				var id = programObj.id;
				var startTime = programObj.starttime;
				var endTime = programObj.endtime;
				
				var newStartTime = getDIYDate(startTime);
				var newEndTime = getDIYDate(endTime);
				seconds = differenceSeconds(newStartTime,newEndTime);
				now = new Date().Format("yyyyMMddhhmmss");
				
				top.$.jBox.getIframe().src="${ctx}/program/program/preview?id="+id;
			}
			window.setTimeout("time('"+seconds+"','"+now+"')", 100);
		}
		
		//策略对象
		function CabinetmsProgramTactic(id,termList){
			this.id = id;
			this.termList = termList;
		}
		
		//发布函数
		function release(id){
			// 正常打开	
			top.$.jBox.open("iframe:${ctx}/programtactic/cabinetmsProgramTactic/termList", "选择终端", $(top.document).width()-200,$(top.document).height()-240, {
				ajaxData:{id: id},buttons:{"确定":"ok","取消":"cancel" }, submit:function(v, h, f){
					if(v == 'ok'){
						
						loading('正在提交，请稍等...');
						
						/***************invoice array Start***************/
						var termList = h.find("iframe")[0].contentWindow.getData();
						/***************invoice array end***************/
						
						var cabinetmsProgramTactic = new CabinetmsProgramTactic(id,termList);
						
						var saveTermListTpl = $("#saveTermListTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						
						$("#releaseForm").append(Mustache.render(saveTermListTpl, {
							row: cabinetmsProgramTactic
						}));
						
						//alert($("#releaseForm").html())
						
						// 执行保存
						$("#releaseForm").submit();
						return true;
					}
					else if(v == 'cancel'){
						top.$.jBox.close(true);
						return false;
					}
				}, loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
		}
	</script>
</head>
<body>
	<form:form id="releaseForm" modelAttribute="cabinetmsProgramTactic" action="${ctx}/programtactic/cabinetmsProgramTactic/release" method="post" class="form-horizontal">
		<script type="text/template" id="saveTermListTpl">
		//<!--
		<input type="text" name="id" id="id" value="{{row.id}}">
		{{#row.termList}}
			<input name="termList[{{idx}}].id" type="text" value="{{id}}"/>
		{{/row.termList}}
		//-->
		</script>	
	</form:form>
	
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/programtactic/cabinetmsProgramTactic/">节目策略列表</a></li>
		<shiro:hasPermission name="programtactic:cabinetmsProgramTactic:edit"><li><a href="${ctx}/programtactic/cabinetmsProgramTactic/form">节目策略添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cabinetmsProgramTactic" action="${ctx}/programtactic/cabinetmsProgramTactic/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>策略名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>创建时间：</label>
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${cabinetmsProgramTactic.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${cabinetmsProgramTactic.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>策略状态：</label>
				<form:select path="status" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('programStrategyType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>策略名称</th>
				<th>开始时间</th>
				<th>结束时间</th>
				<th>创建时间</th>
				<th>备注信息</th>
				<th>策略状态</th>
				<shiro:hasPermission name="programtactic:cabinetmsProgramTactic:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cabinetmsProgramTactic">
			<tr>
				<td><a href="${ctx}/programtactic/cabinetmsProgramTactic/form?id=${cabinetmsProgramTactic.id}">
					${cabinetmsProgramTactic.name}
				</a></td>
				<td>
					${cabinetmsProgramTactic.starttimeparam}
				</td>
				<td>
					${cabinetmsProgramTactic.endtimeparam}
				</td>
				<td>
					<fmt:formatDate value="${cabinetmsProgramTactic.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${cabinetmsProgramTactic.remarks}
				</td>
				<td>
					${fns:getDictLabel(cabinetmsProgramTactic.status, 'programStrategyType', '')}
				</td>
				<shiro:hasPermission name="programtactic:cabinetmsProgramTactic:edit">
					<td>
					<!-- 待提交状态可以编辑 -->
					<c:if test="${cabinetmsProgramTactic.status eq '1' }">
    					<a href="${ctx}/programtactic/cabinetmsProgramTactic/form?id=${cabinetmsProgramTactic.id}">修改</a>
					</c:if>
					<!-- 待提交状态和待发布状态可以删除 -->
					<c:if test="${cabinetmsProgramTactic.status eq '1' or cabinetmsProgramTactic.status eq '2'}">
    					<a href="${ctx}/programtactic/cabinetmsProgramTactic/delete?id=${cabinetmsProgramTactic.id}" onclick="return confirmx('确认要删除该节目策略吗？', this.href)">删除</a>
					</c:if>
					<!-- 待提交状态可以提交 -->
					<c:if test="${cabinetmsProgramTactic.status eq '1' }">
    					<a href="${ctx}/programtactic/cabinetmsProgramTactic/updateStatus?id=${cabinetmsProgramTactic.id}&status=2" onclick="return confirmx('确认要提交该节目策略吗？', this.href)">提交</a>
					</c:if>
					<!-- 待发布状态可以发布 -->
					<c:if test="${cabinetmsProgramTactic.status eq '2' }">
    					<a href="#" onclick="release('${cabinetmsProgramTactic.id}')">发布</a>
					</c:if>
					<!-- 已发布状态可以撤销 和查看终端-->
					<c:if test="${cabinetmsProgramTactic.status eq '3' }">
						<a href="${ctx}/programtactic/cabinetmsProgramTactic/cancel?id=${cabinetmsProgramTactic.id}" onclick="return confirmx('确认要撤销该节目策略吗？', this.href)">撤销</a>
						<a href="#" onclick="seeTerm('${cabinetmsProgramTactic.id}')">查看终端</a>
					</c:if>
					<a href="#" onclick="preview('${cabinetmsProgramTactic.id}')">预览</a>
					</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>