<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>${article.title}</title>
	 <link href="${ctx}/matter/css/templatemo_style.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/matter/${ctx}/matter/css/jquery.lightbox-0.5.css" />    
    <link href="/matter/${ctx}/matter/css/globaltext.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/${ctx}/matter/js/script.js"></script>
    <link rel="stylesheet" href="/${ctx}/matter/css/fenye.css" type="text/css" media="screen" />
    
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
    <link href="${ctx}/matter/css/ddsmoothmenu.css" rel="stylesheet" type="text/css" />
    <script src="${ctx}/matter/js/jquery.min.js" type="text/javascript"></script>
    <script src="${ctx}/matter/js/ddsmoothmenu.js" type="text/javascript"></script>


<script type="text/javascript">

    ddsmoothmenu.init({
        mainmenuid: "templatemo_menu", //menu DIV id
        orientation: 'h', //Horizontal or vertical menu: Set to "h" or "v"
        classname: 'ddsmoothmenu', //class added to menu's outer DIV
        //customtheme: ["#1c5a80", "#18374a"],
        contentsource: "markup" //"markup" or ["container_id", "path_to_menu_file"]
    })

</script>
    <script src="${ctx}/matter/js/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="${ctx}/matter/js/jquery.easing.1.3.js" type="text/javascript"></script>
    <script src="${ctx}/matter/js/jquery.timers-1.2.js" type="text/javascript"></script>
    <script src="${ctx}/matter/js/jquery.dualSlider.0.3.min.js" type="text/javascript"></script>
    <link href="${ctx}/matter/css/slimbox2.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/matter/css/list.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/matter/css/fenye.css" rel="stylesheet" type="text/css" />
    <script src="${ctx}/matter/js/slimbox2.js" type="text/javascript"></script>
    <link href="${ctx}/matter/css/count.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/matter/css/jquery.dualSlider.0.2.css" rel="stylesheet" type="text/css" />
</head>

<body id="sub">
<div id="templatemo_header_wrapper">
	<div id="templatemo_header" class="wrapper">
	<jsp:include page="head.jsp" />
</div>
</div>
<div id="templatemo_middle_wrapper">
	<div id="templatemo_middle" class="wrapper">
        <div id="templatemo_slider">
        	<div id="carousel">
            <div id="slider-image-frame">
                <div class="item item_1">
                         <c:forEach items="${bigImages }" var="bigImage" begin="0" end="0">
                   <img src="${bigImage.imgUrl }" alt="${bigImage.title }">
	            </c:forEach>
                    </div></div><!-- /backgrounds -->
			</div>
		</div>
        </div> <!-- END of templatemo_slider -->
        
    </div>
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
	                   		</a>
	                   </span>
	                    <div class="count_text">
	                       ${article.content}
	                    </div>
	                 </div>
	            </div>
	     </div>
	</div>

  <jsp:include page="bottom.jsp" />
</body>

</html>
