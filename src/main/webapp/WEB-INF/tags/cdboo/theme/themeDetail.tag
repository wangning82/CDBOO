<%@ tag language="java" pageEncoding="utf-8" import="com.cdboo.common.Constants"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="themeType" type="java.lang.String" required="true" description="风格代码"%>
<%@ attribute name="themeConcreteType" type="java.lang.String" required="true" description="风格明细代码"%>

<c:if test="${themeType eq Constants.THEMETYPE_THEME }">
	${fns:getDictLabel(themeConcreteType,'season_type', '')}
</c:if>
<c:if test="${themeType eq Constants.THEMETYPE_HOLIDAY }">
	${fns:getDictLabel(themeConcreteType,'holiday_type', '')}
</c:if>
<c:if test="${themeType eq Constants.THEMETYPE_STYLE }">
	${fns:getDictLabel(themeConcreteType,'style_type', '')}
</c:if>