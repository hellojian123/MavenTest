<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>${webName}-展示页</title>
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link href="${ctx}/matter/css/templatemo_style.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="${ctx}/matter/css/jquery.lightbox-0.5.css" />    
	<link href="${ctx}/matter/css/gallery.css" rel="stylesheet" type="text/css" />
	<link href="${ctx}/matter/css/globaltext.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
		.tch:hover{
			background-color:#D5D9E0 !important;
			
		}
	</style>
	<script type="text/javascript" src="${ctx}/matter/scripts/jquery.lightbox-0.5.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctx}/matter/css/jquery.lightbox-0.5.css" media="screen" />
    <script src="${ctx}/matter/scripts/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="${ctx}/matter/scripts/script.js" type="text/javascript"></script>
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
           
           $(document).ready(function(){
           		
           		
           		$(".tch").click(function(){
	           		var nextPage=$(this).attr("nextPage");//获取下一页的页面 goodsId
	           		var totalStr="";
	           		var tf=false;
	           		$.getJSON("${ctx}/ajaxQueryCaseByPage",{currentPage:nextPage},function(data){
	           			if(data==''){
							alert("当前已经是最后一页！");
							tf=true;
							return false;
						}
	           			var tempData=$.parseJSON(data);
	           			//alert(tempData);
	           			$.each(data,function(index,item){
	           				//alert(item.title);
		           			var tempStr="<li>"+
				                    "<a href='${ctx}/getArticleById?article.typeid="+item.id+"' title='"+item.title+"'><span></span>"+         
				                        "<img src='"+item.previewImg+"' alt='"+item.title+"' />"+ 
				                    "</a>"+ 
				                    "<span>"+item.title+"</span>"+
				                "</li>";
								totalStr+=tempStr;
								tempStr="";
	           			});
						$("#gallery ul").append(totalStr);
	           		});
	           		if(tf){
						return false;
					}
					$(this).attr("nextPage",(parseInt(nextPage)+1));
           		});
           		//$(".tch").click();
           });
        
	</script>



</head>
<body id="sub">
<jsp:include page="head.jsp"/>
<div id="templatemo_main" class="wrapper">
	  <span class="lujin2">您当前的位置：
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
    <p></p>
		<div id="gallery">
		
		  <c:forEach items="${pm.result}" var="article" >
        <div class="gallery_box">
             <div class="img_frame img_frame_12 left photo"><a href="${ctx}/getArticleById?article.typeid=${article.id}" title="${article.title}">
             <img src="${article.previewImg}" alt="${article.title}" />
             <span>${article.title}</span></a>
            </div>
           
           <div class="half right">
                <h5>${article.title}</h5>
               
			</div>
            <div class="clear"></div>
        </div>
         </c:forEach>
         
	</div>
    
    
    <div id="page" class="yahoo2"></div>
					<script type="text/javascript">
						$("#page").html(fenyeComment("${pm.maxPage}","${currentPage}","${ctx}/intoSuccessCase"));
					</script>   
    
   
    <div class="clear"></div>
</div>

<jsp:include page="bottom.jsp" />
</body>
</html>