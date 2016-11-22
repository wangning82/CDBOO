<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>消息信息管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {

        });
        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
        function viewTerminal() {

        }

        function publish(id) {
            top.$.jBox.open("iframe:${ctx}/notice/cabinetmsNotice/terminalListFormEdit", "发布消息", $(top.document).width() - 800, $(top.document).height() - 400, {
                ajaxData: {id: id}, buttons: {"确定": "ok", "取消": "cancel"}, submit: function (v, h, f) {
                    if (v == 'ok') {
                        var formwin = h.find("#jbox-iframe")[0].contentWindow;
                        if(formwin.getTerminals() == ""){
                            alertx("您没有选择消息发布的终端");
                            return false;
                        }if(formwin.beginDate.value == ""){
                            alertx("请选择消息播放的开始时间");
                            return false;
                        }if(formwin.endDate.value == ""){
                            alertx("请选择消息播放的结束时间");
                            return false;
                        } else{
                            loading('正在提交，请稍等...');
                            // 执行保存
                            $("#id").val(id);
                            $("#beginDate").val(formwin.beginDate.value);
                            $("#endDate").val(formwin.endDate.value);
                            $("#terminalIds").val(formwin.getTerminals());
                            $("#publishForm").submit();
                            return true;
                        }
                    }
                    else if (v == 'cancel') {
                        top.$.jBox.close(true);
                        return false;
                    }
                }, loaded: function (h) {
                    $(".jbox-content", top.document).css("overflow-y", "hidden");
                }
            });
        }

        function view(id) {
            top.$.jBox.open("iframe:${ctx}/notice/cabinetmsNotice/terminalListFormView", "查看终端", $(top.document).width() - 800, $(top.document).height() - 400, {
                ajaxData: {id: id}, buttons: {"确定": "ok"}, submit: function (v, h, f) {
                    if (v == 'ok') {
                        return true;
                    }
                }, loaded: function (h) {
                    $(".jbox-content", top.document).css("overflow-y", "hidden");
                }
            });
        }

    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/notice/cabinetmsNotice/">消息信息列表</a></li>
    <shiro:hasPermission name="notice:cabinetmsNotice:edit">
        <li><a href="${ctx}/notice/cabinetmsNotice/form">消息信息添加</a></li>
    </shiro:hasPermission>
</ul>
<form:form id="publishForm" modelAttribute="cabin1etmsNotice" action="${ctx}/notice/cabinetmsNotice/publish" method="post">
    <input id="id" name="id" type="hidden">
    <input id="beginDate" name="beginDate" type="hidden">
    <input id="endDate" name="endDate" type="hidden">
    <input id="terminalIds" name="terminalIds" type="hidden">
</form:form>
<form:form id="searchForm" modelAttribute="cabinetmsNotice" action="${ctx}/notice/cabinetmsNotice/" method="post"
           class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li><label>消息名称：</label>
            <form:input path="noticeName" htmlEscape="false" maxlength="64" class="input-medium"/>
        </li>
        <li><label>消息内容：</label>
            <form:input path="noticeContent" htmlEscape="false" maxlength="200" class="input-medium"/>
        </li>
        <li><label>消息状态：</label>
            <form:select path="status" class="input-medium">
                <form:option value="" label=""/>
                <form:options items="${fns:getDictList('notice_status')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
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
        <th style="width: 20%;">消息名称</th>
        <th>消息内容</th>
        <th style="width: 8%;">消息状态</th>
        <th style="width: 8%;">创建者</th>
        <shiro:hasPermission name="notice:cabinetmsNotice:edit">
            <th style="width: 12%;">操作</th>
        </shiro:hasPermission>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="cabinetmsNotice">
        <tr>
            <td>
                <c:if test="${cabinetmsNotice.status == '1'}">
                    <a href="${ctx}/notice/cabinetmsNotice/form?id=${cabinetmsNotice.id}">
                            ${cabinetmsNotice.noticeName}
                    </a>
                </c:if>
                <c:if test="${cabinetmsNotice.status == '2'}">${cabinetmsNotice.noticeName}</c:if>
            </td>
            <td>
                <c:if test="${cabinetmsNotice.status == '1'}">
                    <a href="${ctx}/notice/cabinetmsNotice/form?id=${cabinetmsNotice.id}">
                        ${cabinetmsNotice.noticeContent}
                    </a>
                </c:if>
                <c:if test="${cabinetmsNotice.status == '2'}">${cabinetmsNotice.noticeContent}</c:if>
            </td>
            <td>
                    ${fns:getDictLabel(cabinetmsNotice.status, 'notice_status', '')}
            </td>
            <td>
                    ${cabinetmsNotice.createBy.name}
            </td>
            <shiro:hasPermission name="notice:cabinetmsNotice:edit">
                <td>
                    <c:if test="${cabinetmsNotice.status == '1'}">
                        <a href="${ctx}/notice/cabinetmsNotice/form?id=${cabinetmsNotice.id}">修改</a>
                        <a href="${ctx}/notice/cabinetmsNotice/delete?id=${cabinetmsNotice.id}"
                           onclick="return confirmx('确认要删除该消息信息吗？', this.href)">删除</a>
                        <a href="javascript:publish('${cabinetmsNotice.id}');">发布</a>
                    </c:if>
                    <c:if test="${cabinetmsNotice.status == '2'}">
                        <a href="${ctx}/notice/cabinetmsNotice/undoPublish?id=${cabinetmsNotice.id}"
                           onclick="return confirmx('确认要撤销该消息信息吗？', this.href)">撤销</a>
                        <a href="javascript:view('${cabinetmsNotice.id}');">查看终端</a>
                    </c:if>
                </td>
            </shiro:hasPermission>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>