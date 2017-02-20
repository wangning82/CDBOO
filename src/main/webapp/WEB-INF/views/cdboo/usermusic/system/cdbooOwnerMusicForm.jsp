<%@ page contentType="text/html;charset=UTF-8" import="com.cdboo.common.Constants" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户曲库信息管理</title>
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
		
		function userTreeselectCallBack(v, h, f){
			$('#tb').empty();
			
			var userId = $('#userId').val();
			var owner_type_public = '${Constants.MUSICOWNER_PUBLIC}';
			var owner_type_private = '${Constants.MUSICOWNER_PRIVATE}';
			
			$.ajax({
		        type: "post",
		        async: false,
		        url: "getMusicList",
		        data: {
		            userId: userId
		        },
		        dataType: "json",
		        success: function (data) {
					var dataArray = eval(data);
		        	var tpl = $("#musicTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
					for (var i = 0; i < dataArray.length; i++) {
						var entity = dataArray[i];
						var musicOwner = entity.musicOwner;
						if(musicOwner == owner_type_public){
							entity.musicOwner = '公有';
						}
						if(musicOwner == owner_type_private){
							entity.musicOwner = '私有';
						}
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
		<li><a href="${ctx}/usermusic/cdbooOwnerMusic/">用户曲库信息列表</a></li>
		<li class="active"><a href="${ctx}/usermusic/cdbooOwnerMusic/form?id=${cdbooOwnerMusic.id}">用户曲库信息<shiro:hasPermission name="usermusic:cdbooOwnerMusic:edit">${not empty cdbooOwnerMusic.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="usermusic:cdbooOwnerMusic:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cdbooOwnerMusic" action="${ctx}/usermusic/cdbooOwnerMusic/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">用户：</label>
			<div class="controls">
				<!-- 如果是修改，则用户锁定，不能编辑 -->
				<c:if test = "${not empty cdbooOwnerMusic.id}">
					<sys:treeselect disabled="disabled" id="user" name="user.id" value="${cdbooOwnerMusic.user.id}" labelName="user.name" labelValue="${cdbooOwnerMusic.user.name}"
						title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true" />
				</c:if>
				<!-- 如果是新增，则用户不锁定，允许编辑 -->
				<c:if test = "${empty cdbooOwnerMusic.id}">
					<sys:treeselect id="user" name="user.id" value="${cdbooOwnerMusic.user.id}" labelName="user.name" labelValue="${cdbooOwnerMusic.user.name}"
						title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true" />
				</c:if>
				
				&nbsp;
				<input id="assignButton" class="btn btn-primary" type="button" value="分配音乐" onclick="openMappingWin()"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">音乐列表：</label>
			<div class="controls">
				<music:musicListTag musicIdElementName="musicIds" musicList="${cdbooOwnerMusic.musicList }"></music:musicListTag>
			</div>
		</div>
		
		<div class="form-actions">
			<shiro:hasPermission name="usermusic:cdbooOwnerMusic:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="javascript:window.location.href='${ctx}/usermusic/cdbooOwnerMusic/'"/>
		</div>
	</form:form>
</body>
</html>