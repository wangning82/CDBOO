<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>行业时段管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#no").focus();
            $("#inputForm").validate({
                rules: {
                    loginName: {remote: "${ctx}/sys/user/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')}
                },
                messages: {
                    loginName: {remote: "用户登录名已存在"},
                    confirmNewPassword: {equalTo: "输入与上面相同的密码"}
                },
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

        function addRow(list, idx, tpl, row){
            $(list).append(Mustache.render(tpl, {
                idx: idx, delBtn: true, row: row
            }));

            $(list+idx).find("select").each(function(){
                $(this).val($(this).attr("data-value"));
            });
            $(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
                var ss = $(this).attr("data-value").split(',');
                for (var i=0; i<ss.length; i++){
                    if($(this).val() == ss[i]){
                        $(this).attr("checked","checked");
                    }
                }
            });
        }
        function delRow(obj, prefix){
            var id = $(prefix+"_id");
            var delFlag = $(prefix+"_delFlag");
            if (id.val() == ""){
                $(obj).parent().parent().remove();
            }else if(delFlag.val() == "0"){
                delFlag.val("1");
                $(obj).html("&divide;").attr("title", "撤销删除");
                $(obj).parent().parent().addClass("error");
            }else if(delFlag.val() == "1"){
                delFlag.val("0");
                $(obj).html("&times;").attr("title", "删除");
                $(obj).parent().parent().removeClass("error");
            }
        }


    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/business/business/listTimestep">时段列表</a></li>
    <shiro:hasPermission name="business:timestep:edit"><li class="active"><a href="${ctx}/business/business/businessTimestepForm">行业时段添加</a></li></shiro:hasPermission>
</ul><br/>
<form:form id="inputForm" modelAttribute="businessTimestepModel" action="${ctx}/business/business/businessTimestepSave" method="post" class="form-horizontal">
    <sys:message content="${message}"/>

    <input type="hidden" name="delFlag" value="0" />
    <div class="control-group">
        <label class="control-label">行业:</label>
        <div class="controls">
            <sys:treeselect id="businessId" name="businessId" value="${business.id}" labelName="business.name"
                            labelValue="${business.name}"
                            title="行业" url="/business/business/treeData" cssClass="required" />
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">行业时段：</label>
        <div class="controls">
            <table id="contentTable" class="table table-striped table-bordered table-condensed">
                <thead>
                <tr>
                    <th class="hide"></th>
                    <th>时段</th>
                    <th>频道</th>
                    <th>名称</th>
                    <th>备注</th>
                    <shiro:hasPermission name="business:timestep:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
                </tr>
                </thead>
                <tbody id="businessTimestepList">
                </tbody>
                <shiro:hasPermission name="business:timestep:edit"><tfoot>
                <tr><td colspan="16"><a href="javascript:" onclick="addRow('#businessTimestepList', businessTimestepRowIdx, businessTimestepTpl);businessTimestepRowIdx = businessTimestepRowIdx + 1;" class="btn">新增</a></td></tr>
                </tfoot></shiro:hasPermission>
            </table>
            <script type="text/template" id="businessTimestepTpl">//<!--
						<tr id="businessTimestepList{{idx}}">
							<td class="hide">
								<input id="businessTimestepList{{idx}}_id" name="businessTimestepList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="businessTimestepList{{idx}}_delFlag" name="businessTimestepList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>

							<td>
								<select id="businessTimestepList{{idx}}_timestep.id" name="businessTimestepList[{{idx}}].timestep.id" data-value="{{row.timestep.id}}" class="input-small ">
									<option value="">请选择</option>
									<c:forEach items="${timestepList}" var="timestep">
										<option value="${timestep.id}">${timestep.timestepName}</option>
									</c:forEach>
								</select>
							</td>

                            <td>
								<select id="businessTimestepList{{idx}}_channel.id" name="businessTimestepList[{{idx}}].channel.id" data-value="{{row.channel.id}}" class="input-small ">
									<option value="">请选择</option>
									<c:forEach items="${channelList}" var="channel">
										<option value="${channel.id}">${channel.channelName}</option>
									</c:forEach>
								</select>
							</td>

							<td>
								<input id="businessTimestepList{{idx}}_name" name="businessTimestepList[{{idx}}].name" type="text" value="{{row.name}}" maxlength="255" class="input-small "/>
							</td>

							<td>
								<input id="businessTimestepList{{idx}}_remarks" name="businessTimestepList[{{idx}}].remarks" type="text" value="{{row.remarks}}" maxlength="255" class="input-small "/>
							</td>

							<shiro:hasPermission name="business:timestep:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#businessTimestepList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
            </script>
            <script type="text/javascript">
                var businessTimestepRowIdx = 0, businessTimestepTpl = $("#businessTimestepTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
                $(document).ready(function() {
                    var data = ${fns:toJson(businessTimestepModel.businessTimestepList)};
                    for (var i = 0; i < data.length; i++) {
                        addRow('#businessTimestepList', businessTimestepRowIdx, businessTimestepTpl, data[i]);
                        businessTimestepRowIdx = businessTimestepRowIdx + 1;
                    }
                });
            </script>
        </div>
    </div>

    <div class="form-actions">
        <shiro:hasPermission name="sys:user:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>