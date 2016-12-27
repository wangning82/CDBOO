<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta charset="utf-8"> 
	<title></title>
	<link rel="stylesheet" href="${ctxStatic}/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js"></script>
	<script src="${ctxStatic}/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		 <div style="width: 100%; height: 100%; margin-right: auto; margin-left: auto;">
			 <div id="mycarousel" class="carousel slide" data-ride="carousel" data-interval="5000">
				  <ol class="carousel-indicators">
				  <c:if test="${not empty pathArray }">
					  	  <c:forEach items="${pathArray }" var="path" varStatus="status">
					  	  		<c:if test="${not empty path }">
						  	  		<c:if test="${status.index == 0 }">
										<li data-target="#mycarousel" data-slide-to="${status.index }" class="active"></li>
									</c:if>
									<c:if test="${status.index != 0 }">
										<li data-target="#mycarousel" data-slide-to="${status.index }"></li>
									</c:if>
					  	  		</c:if>
						  </c:forEach>
				  </c:if> 
				  </ol>
				 
				  <div class="carousel-inner" role="listbox">
				  	  <c:if test="${not empty pathArray }">
					  	  <c:forEach items="${pathArray }" var="path" varStatus="status">
					  	  		<c:if test="${not empty path }">
						  	  		<c:if test="${status.index == 0 }">
										<div class="item active">
										  <img src="${path }"/>
										</div>
									</c:if>
									<c:if test="${status.index != 0 }">
										<div class="item" >
								           	<img src="${path }"/>
								        </div>
									</c:if>
					  	  		</c:if>
						  </c:forEach>
				  	  </c:if>
				  </div>
				 
				   <!-- 轮播（Carousel）导航 -->
				    <a class="carousel-control left" href="#mycarousel" 
				        data-slide="prev">&lsaquo;
				    </a>
				    <a class="carousel-control right" href="#mycarousel" 
				        data-slide="next">&rsaquo;
				    </a>	
				</div>
		 </div>
	</div>
</body>
</html>