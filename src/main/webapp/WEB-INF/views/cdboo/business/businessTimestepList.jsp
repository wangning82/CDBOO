<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>时段管理</title>
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
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/business/business/listTimestep">时段列表</a></li>
    <shiro:hasPermission name="business:timestep:edit"><li><a href="${ctx}/business/business/businessTimestepForm">行业时段添加</a></li></shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="businessTimestep" action="${ctx}/timestep/timestep/" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li><label>时段编号：</label>
            <form:input path="timestep.timestepNo" htmlEscape="false" maxlength="100" class="input-medium"/>
        </li>
        <li><label>时段名称：</label>
            <form:input path="timestep.timestepName" htmlEscape="false" maxlength="100" class="input-medium"/>
        </li>
        <li><label>开始时间：</label>
            <input name="beginStarttime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                   value="<fmt:formatDate value="${timestep.beginStarttime}" pattern="yyyy-MM-dd"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/> -
            <input name="endStarttime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                   value="<fmt:formatDate value="${timestep.endStarttime}" pattern="yyyy-MM-dd"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
        </li>
        <li><label>结束时间：</label>
            <input name="beginEndtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                   value="<fmt:formatDate value="${timestep.beginEndtime}" pattern="yyyy-MM-dd"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/> -
            <input name="endEndtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                   value="<fmt:formatDate value="${timestep.endEndtime}" pattern="yyyy-MM-dd"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
        </li>
        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>时段编号</th>
        <th>时段名称</th>
        <th>开始时间</th>
        <th>结束时间</th>
        <th>更新时间</th>
        <th>备注信息</th>
        <shiro:hasPermission name="business:timestep:edit"><th>操作</th></shiro:hasPermission>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="timestep">
        <tr>
            <td><a href="${ctx}/timestep/timestep/form?id=${timestep.id}">
                    ${timestep.timestepNo}
            </a></td>
            <td>
                    ${timestep.timestepName}
            </td>
            <td>
                    ${timestep.starttime}
            </td>
            <td>
                    ${timestep.endtime}
            </td>
            <td>
                <fmt:formatDate value="${timestep.updateDate}" pattern="yyyy-MM-dd"/>
            </td>
            <td>
                    ${timestep.remarks}
            </td>
            <shiro:hasPermission name="business:timestep:edit"><td>
                <a href="${ctx}/timestep/timestep/form?id=${timestep.id}">修改</a>
                <a href="${ctx}/timestep/timestep/delete?id=${timestep.id}" onclick="return confirmx('确认要删除该时段吗？', this.href)">删除</a>
            </td></shiro:hasPermission>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>