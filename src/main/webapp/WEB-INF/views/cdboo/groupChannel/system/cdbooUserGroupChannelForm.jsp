<%@ page contentType="text/html;charset=UTF-8" import="com.cdboo.common.Constants" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>频道信息管理</title>
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
		
		function linkChannelInfo(groupChannelId){
			$.ajax({
		        type: "post",
		        async: false,
		        url: "${ctx}/channel/cdbooChannel/getGroupChannelInfo",
		        data: {
		        	groupChannelId: groupChannelId
		        },
		        dataType: "json",
		        success: function (data) {
					var dataObj = eval(data);
					var dataArray = dataObj.childChannelList;
		        	var tpl = $("#channelTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
					for (var i = 0; i < dataArray.length; i++) {
						var entity = dataArray[i];
						//alert(entity.id+":"+entity.name+":"+entity.actor+":"+entity.special+":"+entity.musicOwner+":"+entity.volume)
						$('#tb').append(Mustache.render(tpl, {row: entity}));
					}
		        }
		   });
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/channel/groupChannel/user/">频道信息列表</a></li>
		<li class="active"><a><c:if test = "${not empty cdbooUserGroup.user.id && not empty cdbooUserGroup.cdbooChannel.id}">组合频道信息查看</c:if><c:if test = "${empty cdbooUserGroup.user.id && empty cdbooUserGroup.cdbooChannel.id}">组合频道信息添加</c:if></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cdbooUserGroup" action="${ctx}/channel/groupChannel/user/save" method="post" class="form-horizontal">
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">用户：</label>
			<div class="controls">
				<!-- 如果是修改，则用户锁定，不能编辑 -->
				<c:if test = "${not empty cdbooUserGroup.user.id && not empty cdbooUserGroup.cdbooChannel.id}">
					${cdbooUserGroup.user.name}
				</c:if>
				<!-- 如果是新增，则用户不锁定，允许编辑 -->
				<c:if test = "${empty cdbooUserGroup.user.id && empty cdbooUserGroup.cdbooChannel.id}">
					<sys:treeselect id="user" name="user.id" value="${cdbooUserChannel.user.id}" labelName="user.name" labelValue="${cdbooUserChannel.user.name}"
						title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true" />
				</c:if>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">组合频道：</label>
			<div class="controls">
				<c:if test = "${empty cdbooUserGroup.user.id && empty cdbooUserGroup.cdbooChannel.id}">
					<form:select id="channelId" path="cdbooChannel.id" class="input-xlarge " onchange="linkChannelInfo(this.value)">
						<form:option value="" label="请选择"/>
						<form:options items="${cdbooUserGroup.channelList}" itemLabel="channelName" itemValue="id" htmlEscape="false"/>
					</form:select>
				</c:if>
				<c:if test = "${not empty cdbooUserGroup.user.id && not empty cdbooUserGroup.cdbooChannel.id}">
					${cdbooUserGroup.cdbooChannel.channelName}
				</c:if>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">子频道列表：</label>
			<div class="controls">
				<table id="contentTable" class="table table-striped table-bordered table-condensed">
					<thead>
						<tr>
							<th>频道编号</th>
							<th>频道名称</th>
							<th>频道图片</th>
							<th>风格类型</th>
							<th>风格类型明细</th>
							<th>频道版本</th>
							<th>创建时间</th>
						</tr>
					</thead>					
					<tbody id="tb">
						<c:forEach items="${cdbooUserGroup.groupChildList}" var="cdbooChannel" varStatus="status">
							<tr>
								<td>
									${cdbooChannel.channelNo}
								</td>
								<td>
									${cdbooChannel.channelName}
								</td>
								<td>
									<pic:preview path="${cdbooChannel.photoPath}" ></pic:preview>
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
								</td>
								<td>
									${cdbooChannel.channelVersion}
								</td>
								<td>
									<fmt:formatDate value="${cdbooChannel.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>	
			</div>
		</div>
		
		<div class="form-actions">
			<c:if test = "${empty cdbooUserGroup.user.id && empty cdbooUserGroup.cdbooChannel.id}">
				<shiro:hasPermission name="channel:groupChannel:user:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			</c:if>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	
	<script type="text/template" id="channelTpl">//<!--
		<tr>
			<td>{{row.channelNo}}<input type="hidden" name = 'channelIds' value="{{row.id}}"></td>
			<td>{{row.channelName}}</td>
			<td><img src="{{row.photoPath}}" width="200" height="200" onclick="disPic('{{row.photoPath}}')"/></td>
			<td>{{row.themeType}}</td>
			<td>{{row.themeConcreteType}}</td>
			<td>{{row.channelVersion}}</td>
			<td>{{row.createDate}}</td>
		</tr>//-->
	</script>
</body>
</html>