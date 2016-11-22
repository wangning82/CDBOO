<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>首页</title>
    <meta name="decorator" content="default"/>
    <link href="${ctxStatic}/jerichotab/css/index.css" rel="stylesheet" type="text/css">
    <style type="text/css">
        html, body, table {
            width: 100%;
            text-align: center;
            padding: 0px;
            background: url(${ctxStatic}/cabinet/images/bjj.jpg) #5dbcf8;
            background-size: cover;
            background-position: center top;
            background-repeat: no-repeat;
            margin-left: 0px;
            margin-top: 0px;
            margin-right: 0px;
            margin-bottom: 0px;
        }

        .yuan {
            width: 40px;
            height: 40px;
            background: #9bcc5f;
            border-radius: 25px;
            line-height: 40px;
            color: #FFFFFF;
            font-size: 14px;
        }

        .yuan1 {
            width: 40px;
            height: 40px;
            background: #fcc56e;
            border-radius: 25px;
            line-height: 40px;
            color: #FFFFFF;
            font-size: 14px;
        }

        .yuan2 {
            width: 40px;
            height: 40px;
            background: #f26029;
            border-radius: 25px;
            line-height: 40px;
            color: #FFFFFF;
            font-size: 14px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {

        });

    </script>
</head>
<body>
<div style=" height:80px;"></div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tbody>
    <tr>

        <td width="20%">
            <div style=" background:url(${ctxStatic}/cabinet/images/tubiao1.png); height:260px; width:272px; margin:0 auto;">
                <div style=" height:45px;"></div>
                <div class="yuan" style="margin-left:220px;">${free}</div>
            </div>
            <div style=" line-height:45px; color:#FFFFFF; font-size:24px;">空闲终端</div>
        </td>
        <td width="15%">&nbsp;</td>
        <td width="16%">
            <div style=" background:url(${ctxStatic}/cabinet/images/tubiao2.png); height:260px; width:272px; margin:0 auto;">
                <div style=" height:45px;"></div>
                <div class="yuan1" style="margin-left:220px;">${playing}</div>
            </div>
            <div style=" line-height:45px; color:#FFFFFF; font-size:24px;">播放终端</div>
        </td>
        </td>
        <td width="16%">&nbsp;</td>
        <td width="20%">
            <div style=" background:url(${ctxStatic}/cabinet/images/tubiao3.png); height:260px; width:272px; margin:0 auto;">
                <div style=" height:45px;"></div>
                <div class="yuan2" style="margin-left:220px;">${closed}</div>
            </div>
            <div style=" line-height:45px; color:#FFFFFF; font-size:24px;">关闭终端</div>
        </td>
        </td>

    </tr>
    </tbody>
</table>
<div style=" background:url(${ctxStatic}/cabinet/images/bjj.png);background-size: cover; height:100%; width:900px;"></div>
</body>
</html>