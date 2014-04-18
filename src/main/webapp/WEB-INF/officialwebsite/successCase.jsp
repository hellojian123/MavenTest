<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>${webName}-展示页</title>
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="${ctx}/matter/css/templatemo_style.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
		.tch:hover{
			background-color:#D5D9E0 !important;	
		}
	</style>
    <script src="${ctx}/matter/js/script.js" type="text/javascript"></script>
    <link href="${ctx}/matter/css/fenye.css" rel="stylesheet" type="text/css" />
        <link href="${ctx}/matter/css/ddsmoothmenu.css" rel="stylesheet" type="text/css" />
    <script src="${ctx}/matter/js/jquery.min.js" type="text/javascript"></script>
    <script src="${ctx}/matter/js/ddsmoothmenu.js" type="text/javascript"></script>
    <link href="${ctx}/matter/css/jquery.dualSlider.0.2.css" rel="stylesheet" type="text/css" />
    <script src="${ctx}/matter/js/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="${ctx}/matter/js/jquery.easing.1.3.js" type="text/javascript"></script>
    <script src="${ctx}/matter/js/jquery.timers-1.2.js" type="text/javascript"></script>
    <script src="${ctx}/matter/js/jquery.dualSlider.0.3.min.js" type="text/javascript"></script>
    <link href="${ctx}/matter/css/intoSuccessCase.css" rel="stylesheet" type="text/css" />
    
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

<div id="templatemo_header_wrapper">
	<div id="templatemo_header" class="wrapper">
	<jsp:include page="head.jsp"/>
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
<div id="templatemo_main" class="wrapper">
	  <span class="lujin2">您当前的位置：
	                   		<a href="${ctx}/officialwebsite/index">首页</a>>>
	                   		<a href="javascript:void(0)">成功案例		</a>
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
               <h5>
               <c:if test="${fn:length(ht:delHTMLTag(article.title ))>15 }" >
	          ${fn:substring(ht:delHTMLTag(article.title ),0,15) }...
	    </c:if>
	    <c:if test="${fn:length(ht:delHTMLTag(article.title ))<=15 }" >
	         	  ${ht:delHTMLTag(article.title )}
	   	</c:if>
               </h5>
               
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

<jsp:include page="bottom.jsp"/>

</body>

</html>
