<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>歌曲信息管理</title>
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
		
		function pathSelectedCallBack(selectedVal){
			if(selectedVal){
				$.ajax({
			        type: "post",
			        async: false,
			        url: "${ctx}/music/cdbooMusic/getMusicInfo",
			        data: {
			        	path: selectedVal
			        },
			        dataType: "json",
			        success: function (data) {
						var dataObj = eval(data);
						$('#musicName').val(dataObj.songName);//歌曲名称
						$('#actor').val(dataObj.artist);//歌手
						$('#special').val(dataObj.album);//专辑
						$('#duration').val(dataObj.duration);//专辑时长
			        }
			   });
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/music/cdbooMusic/">歌曲信息列表</a></li>
		<li class="active"><a href="${ctx}/music/cdbooMusic/form?id=${cdbooMusic.id}">歌曲信息<shiro:hasPermission name="music:cdbooMusic:edit">${not empty cdbooMusic.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="music:cdbooMusic:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cdbooMusic" action="${ctx}/music/cdbooMusic/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">音乐编号：</label>
			<div class="controls">
				<form:input path="musicNo" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
			</div>
		</div>		
		<div class="control-group">
			<label class="control-label">音乐名称：</label>
			<div class="controls">
				<form:input id="musicName" path="musicName" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">艺人：</label>
			<div class="controls">
				<form:input id="actor" path="actor" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">专辑：</label>
			<div class="controls">
				<form:input id="special" path="special" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">时长：</label>
			<div class="controls">
				<form:input readonly="true" id="duration" path="duration" htmlEscape="false"  class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">音量：</label>
			<div class="controls">
				<select name="volume" id="volume" class="input-xlarge ">
					<option value="">请选择</option>
					<c:forEach items="${fns:getVolumeList() }" var="volume">
						<option value="${volume.value }" <c:if test="${volume.value eq cdbooMusic.volume}">selected</c:if> >${volume.lable }</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">音乐类型：</label>
			<div class="controls">
				<form:select path="musicOwner" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('owner_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上传音乐：</label>
			<div class="controls">
				<input type="hidden" id="path" name="path" value="${cdbooMusic.path }" required>
				<sys:ckfinder input="path" type="media"  uploadPath="/music" selectMultiple="false" maxWidth="100" maxHeight="100"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="1000" class="input-xxlarge "/>
			</div>
		</div>
<%-- 		<div class="control-group">
			<label class="control-label">状态位显示：</label>
			<div class="controls">
				<form:input path="status" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div> --%>
		<div class="form-actions">
			<shiro:hasPermission name="music:cdbooMusic:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>