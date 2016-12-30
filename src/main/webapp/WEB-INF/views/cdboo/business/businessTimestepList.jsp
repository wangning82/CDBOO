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
<form:form id="searchForm" modelAttribute="businessTimestep" action="${ctx}/business/business/listTimestep" method="post" class="breadcrumb form-search">
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
            <input name="timestep.beginStarttime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                   value="<fmt:formatDate value="${businessTimestep.timestep.beginStarttime}" pattern="HH:mm:ss"/>"
                   onclick="WdatePicker({dateFmt:'HH:mm:ss',isShowClear:false});"/> -
            <input name="timestep.endStarttime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                   value="<fmt:formatDate value="${businessTimestep.timestep.endStarttime}" pattern="HH:mm:ss"/>"
                   onclick="WdatePicker({dateFmt:'HH:mm:ss',isShowClear:false});"/>
        </li>
        <li><label>结束时间：</label>
            <input name="timestep.beginEndtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                   value="<fmt:formatDate value="${businessTimestep.timestep.beginEndtime}" pattern="HH:mm:ss"/>"
                   onclick="WdatePicker({dateFmt:'HH:mm:ss',isShowClear:false});"/> -
            <input name="timestep.endEndtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                   value="<fmt:formatDate value="${businessTimestep.timestep.endEndtime}" pattern="HH:mm:ss"/>"
                   onclick="WdatePicker({dateFmt:'HH:mm:ss',isShowClear:false});"/>
        </li>
        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>行业名称</th>
        <th>时段编号</th>
        <th>时段名称</th>
        <th>频道编号</th>
        <th>频道名称</th>
        <th>开始时间</th>
        <th>结束时间</th>
        <th>风格</th>
        <th>星期</th>
        <th>开始日期</th>
        <th>结束日期</th>
        <th>更新时间</th>
        <th>备注信息</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="businessTimestep">
        <tr>
            <td><a href="${ctx}/business/business/businessTimestepForm?businessId=${businessTimestep.business.id}">
                    ${businessTimestep.business.name}
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
                    ${businessTimestep.timestep.starttime}
            </td>
            <td>
                    ${businessTimestep.timestep.endtime}
            </td>

            <td>
                    ${businessTimestep.musicStyle}
            </td>

            <td>
                    ${businessTimestep.week}
            </td>

            <td>
                <fmt:formatDate value="${businessTimestep.startDate}" pattern="yyyy-MM-dd"/>
            </td>
            <td>
                <fmt:formatDate value="${businessTimestep.endDate}" pattern="yyyy-MM-dd"/>
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