<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=7" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>
    	<c:if test="${article.typeid==1}">公司新闻</c:if>
    	<c:if test="${article.typeid==2}">行业动态</c:if>
    	<c:if test="${article.typeid==3}">成功案例</c:if>
    	<c:if test="${article.typeid==4}">业务体系</c:if>
    	<c:if test="${article.typeid==5}">人才招聘</c:if>
    	<c:if test="${article.typeid==6}">公司愿景</c:if>
    	<c:if test="${article.typeid==7}">公司介绍</c:if>
    	<c:if test="${article.typeid==8}">组织结构</c:if>
    	<c:if test="${article.typeid==9}">发展历程</c:if>
    	<c:if test="${article.typeid==10}">联系我们</c:if>
    </title>
    <link href="${ctx}/matter/css/templatemo_style.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/matter/css/list.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/matter/css/jquery.lightbox-0.5.css" />    
    <link href="${ctx}/matter/css/globaltext.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${ctx}/matter/scripts/jquery.lightbox-0.5.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctx}/matter/css/jquery.lightbox-0.5.css" media="screen" />
    <script src="${ctx}/matter/scripts/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="${ctx}/matter/scripts/script.js" type="text/javascript"></script>
    <script src="${ctx}/matter/scripts/list.js" type="text/javascript"></script>
    <script src="${ctx}/matter/scripts/slides.min.jquery.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctx}/js/script.js"></script>
    <link rel="stylesheet" href="${ctx}/css/fenye.css" type="text/css" media="screen" />
    
    <script type="text/javascript">
        $(function () {
            var startSlide = 1;
            if (window.location.hash) {
                startSlide = window.location.hash.replace('#', '');
            }
            $('#slides').slides({
                preload: true,
                preloadImage: 'img/loading.gif',
                generatePagination: true,
                play: 3000,
                pause: 2500,
                hoverPause: true,
                start: startSlide,
                animationComplete: function (current) {
                    window.location.hash = '#' + current;
                }
            });
        });
	</script>
</head>
<body id="sub">
		<jsp:include page="head.jsp"/>
	<div id="templatemo_wrapper">
	     <div id="templatemo_main" class="wrapper">
		   <jsp:include page="left.jsp"/>	
	       		<div class="col_allw301">
	                 <div class="C_text_herd">
	                   <span class="lujin1">您当前的位置：
	                   		<a href="${ctx}/officialwebsite/index">首页</a>>>
	                   		<a href="javascript:void(0)">
	                   				<c:if test="${article.typeid==1}">公司新闻</c:if>
									<c:if test="${article.typeid==2}">行业动态</c:if>
									<c:if test="${article.typeid==3}">成功案例</c:if>
									<c:if test="${article.typeid==4}">业务体系</c:if>
									<c:if test="${article.typeid==5}">人才招聘</c:if>
									<c:if test="${article.typeid==6}">公司愿景</c:if>
									<c:if test="${article.typeid==7}">公司介绍</c:if>
									<c:if test="${article.typeid==8}">组织结构</c:if>
									<c:if test="${article.typeid==9}">发展历程</c:if>
									<c:if test="${article.typeid==10}">联系我们</c:if>
									<c:if test="${article.typeid==11}">媒体资讯</c:if>
	                   		</a>
	                   </span>
	                    <div class="col one_three">
	                  <ul>	
	                  
		        	      <c:forEach var="article" items="${pm.result}" varStatus="status">
		        	      	  <li><span>[<fmt:formatDate value="${article.modifyDate}" pattern="yyyy-MM-dd"/>]</span>&nbsp;
		        	      	  <a href="${ctx}/getArticleById?article.typeid=${article.id}">${article.title}</a></li>
						  </c:forEach>
	                  </ul>  
	                  </div>
	                   <div class="clear"></div>
	                <div id="page" class="yahoo2" style="margin-bottom:5px;"></div>
	                 <div class="clear"></div>
	                   <div class="clear"></div>
	                   
	                   
	                 </div>
	                  
					<script type="text/javascript">
						$("#page").html(fenyeComment("${pm.maxPage}","${pm.curPage}","${ctx}/queryArticleListById","article.typeid=${article.typeid}"));
					</script>   
	            </div>
	     </div>
	</div>
	<jsp:include page="bottom.jsp" />
</body>
</html>