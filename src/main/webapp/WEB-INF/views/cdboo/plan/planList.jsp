<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>计划管理</title>
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
    <li class="active"><a href="${ctx}/plan/plan/list">计划列表</a></li>
    <shiro:hasPermission name="plan:plan:edit"><li><a href="${ctx}/business/business/businessTimestepForm">计划添加</a></li></shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="plan" action="${ctx}/plan/plan/save" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li><label>计划编号：</label>
            <form:input path="planNo" htmlEscape="false" maxlength="100" class="input-medium"/>
        </li>
        <li><label>计划名称：</label>
            <form:input path="planName" htmlEscape="false" maxlength="100" class="input-medium"/>
        </li>

        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>计划编号</th>
        <th>计划名称</th>
        <th>更新时间</th>
        <th>备注信息</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="plan">
        <tr>
            <td><a href="${ctx}/business/business/businessTimestepForm?businessId=${businessTimestep.business.id}">
                    ${plan.business.name}
            </a>
            </td>
            <td>
                    ${businessTimestep.timestep.timestepNo}
            </td>
            <td>
                    ${businessTimestep.timestep.timestepName}
            </td>
            <td>
                    ${businessTimestep.channel.channelNo}
            </td>
            <td>
                    ${businessTimestep.channel.channelName}
            </td>
            <td>
                <fmt:formatDate value="${businessTimestep.timestep.starttime}" pattern="HH:mm:ss"/>
            </td>
            <td>
                <fmt:formatDate value="${businessTimestep.timestep.endtime}" pattern="HH:mm:ss"/>
            </td>
            <td>
                <fmt:formatDate value="${businessTimestep.updateDate}" pattern="yyyy-MM-dd"/>
            </td>
            <td>
                    ${businessTimestep.remarks}
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>