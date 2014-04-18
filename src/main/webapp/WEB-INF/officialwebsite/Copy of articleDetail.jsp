<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>${article.title}</title>
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link href="${ctx}/matter/css/templatemo_style.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/matter/css/list.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/matter/css/count.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="${ctx}/matter/css/jquery.lightbox-0.5.css" />    
    <link href="${ctx}/matter/css/globaltext.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/matter/css/globaltext.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${ctx}/matter/scripts/jquery.lightbox-0.5.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctx}/matter/css/jquery.lightbox-0.5.css" media="screen" />
    <script src="${ctx}/matter/scripts/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="${ctx}/matter/scripts/script.js" type="text/javascript"></script>
    <script src="${ctx}/matter/scripts/list.js" type="text/javascript"></script>
    <script src="${ctx}/matter/scripts/slides.min.jquery.js" type="text/javascript"></script>
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
	<div id="templatemo_wrapper">
		<jsp:include page="head.jsp"/>
	     <div id="templatemo_main"  class="wrapper">
	      <jsp:include page="left.jsp"/>
				<div class="col one_three">
	                <div class="count_t">
	                 <span class="lujin">您当前的位置：
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
	                   		</a>
	                   </span>
	                   <span class="s_l"> 发布时间:<fmt:formatDate value="${article.modifyDate}" pattern="yyyy-MM-dd"/></span> &nbsp; 
	                   <span>
	                   		<c:if test="${article.source==''}">原创</c:if>
				          	<c:if test="${article.source!=''}">${article.source}</c:if>
	                   </span>      	
	                </div>
	                <div class="count_c" style="word-wrap:break-word;">
	                        ${article.content}
	                </div>
	                <div class="bshare-custom"> 分享到：<a title="分享到QQ空间" class="bshare-qzone"></a><a title="分享到QQ好友" class="bshare-qqim"></a><a title="分享到有道笔记" class="bshare-youdaonote"></a><a title="分享到百度空间" class="bshare-baiduhi"></a><a title="分享到搜狐微博" class="bshare-sohuminiblog"></a><a title="分享到新浪微博" class="bshare-sinaminiblog"></a><a title="分享到人人网" class="bshare-renren"></a><a title="分享到腾讯微博" class="bshare-qqmb"></a><a title="分享到网易微博" class="bshare-neteasemb"></a><a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a><span class="BSHARE_COUNT bshare-share-count">0</span></div><script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=3&amp;lang=zh"></script><script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
	            </div>
	  	</div>
	  	<div class="clear h20"></div>
	</div> 
	<jsp:include page="bottom.jsp" />
</body>
</html>