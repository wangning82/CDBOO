<%@ taglib prefix="shiro" uri="/WEB-INF/tlds/shiros.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fns" uri="/WEB-INF/tlds/fns.tld" %>
<%@ taglib prefix="fnc" uri="/WEB-INF/tlds/fnc.tld" %>
<%@ taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
<%@ taglib prefix="act" tagdir="/WEB-INF/tags/act" %>
<%@ taglib prefix="cms" tagdir="/WEB-INF/tags/cms" %>
<%@ taglib prefix="music" tagdir="/WEB-INF/tags/cdboo/music" %>
<%@ taglib prefix="pic" tagdir="/WEB-INF/tags/cdboo/pic" %>
<%@ taglib prefix="channel" tagdir="/WEB-INF/tags/cdboo/channel" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/cdboo/theme" %>
<%@ taglib prefix="userTimestep" tagdir="/WEB-INF/tags/cdboo/usertimestep" %>
<c:set var="ctx" value="${pageContext.request.contextPath}${fns:getAdminPath()}"/>
<c:set var="ctxc" value="${pageContext.request.contextPath}${fns:getClientPath()}"/>
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static"/>
