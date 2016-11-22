<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>节目管理管理</title>
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

		function openPreview(id) {

			top.$.jBox.open("iframe:${ctx}/program/program/preview", "预览界面内容", $(top.document).width(), $(top.document).height(), {
				ajaxData: {id: id},
				buttons: {"确定":"ok","取消":"cancel" },
				submit: function(v, h, f) {
					if (v == 'ok') {
						loading('正在提交，请稍等...');
						return true;
					} else if (v == 'cancel') {
						top.$.jBox.close(true);
						return false;
					}
				},
				loaded: function(h) {
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
		}

	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/program/program/">节目管理列表</a></li>
		<shiro:hasPermission name="program:program:edit"><li><a href="${ctx}/program/program/form">节目管理添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="program" action="${ctx}/program/program/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>节目名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>模版名称：</label>
				<form:select path="modelName" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('template_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>状态：</label>
				<form:select path="status" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('program_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>创建时间：</label>
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${program.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${program.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>节目名称</th>
				<th>模版名称</th>
				<th>状态</th>
				<th>创建者</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="program:program:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="program">
			<tr>
				<td><a href="${ctx}/program/program/form?id=${program.id}">
					${program.name}
				</a></td>
				<td>
					${fns:getDictLabel(program.modelName, 'template_type', '')}
				</td>
				<td>
					${fns:getDictLabel(program.status, 'program_status', '')}
				</td>
				<td>
					${program.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${program.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${program.remarks}
				</td>
				<shiro:hasPermission name="program:program:edit"><td>
    				<c:if test="${program.status == '1'}">
						<a href="${ctx}/program/program/form?id=${program.id}">修改</a>
					</c:if>
					<c:if test="${program.status == '1' || program.status == '2'}">
						<a href="${ctx}/program/program/delete?id=${program.id}" onclick="return confirmx('确认要删除该节目管理吗？', this.href)">删除</a>
					</c:if>
					<c:if test="${program.status == '1'}">
						<a href="${ctx}/program/program/submit?id=${program.id}" onclick="return confirmx('确认要提交该节目管理吗？', this.href)">提交</a>
					</c:if>
					<a href="${ctx}/program/program/preview?id=${program.id}">预览</a>
					<a href="javascript:openPreview('${program.id}');">弹出预览</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>