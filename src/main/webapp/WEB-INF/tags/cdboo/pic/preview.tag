<!-- 图片预览标签，传path就能预览 -->
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="path" type="java.lang.String" required="true" description="图片路径"%>
<%@ attribute name="picwidth" type="java.lang.Integer" required="false" description="弹出窗口宽度"%>
<%@ attribute name="picheight" type="java.lang.Integer" required="false" description="弹出窗口高度"%>

<script type="text/javascript">
	function disPic(path){
		top.$.jBox.open("iframe:${ctx}/common/disPicFromPath?path="+path, "频道图片", $(top.document).width()-500,$(top.document).height()-200);
	}
</script>

<img src="${path}" width="${empty picwidth ? 200 : picwidth }" height="${empty picheight ? 200 : picheight }" onclick="disPic('${path}')"/>