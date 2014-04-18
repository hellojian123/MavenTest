<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>${webName}</title>
    <meta http-equiv="X-UA-Compatible" content="IE=7" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta name="author" 	 content="${webName}">
	<meta name="copyright"   content="${webName}">
	<meta name="keywords" content="网络营销,电子商务,APP,网络中介,行业网站,搜索引擎关键词"/>
	<meta name="description" content="${webName}是全国网络营销技术实力最强、专业化程度最高、服务最优的互联网应用服务商之一，历经叁年的发展，云靡已经是网络营销、电子商务服务行业的领先者，公司不仅拥有一批从事网站系统研发、综合网络营销、电子商务平台运营、网络产品直销的精英，还聚集了一批高素质的管理人员、行业专家、决策者。" />
    
    <link href="${ctx}/matter/css/templatemo_style.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/matter/css/ddsmoothmenu.css" rel="stylesheet" type="text/css" />
    <script src="${ctx}/matter/js/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctx}/matter/js/ddsmoothmenu.js"></script>
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
    <script src="${ctx}/matter/js/jquery.dualSlider.0.3.min.js" type="text/javascript"></script>
    <link href="${ctx}/matter/css/slimbox2.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/matter/css/index.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/matter/css/img.css" rel="stylesheet" type="text/css" />
     <script src="${ctx}/matter/js/jquery-1.4.4.min.js" type="text/javascript"></script>
    <script src="${ctx}/matter/js/jquery.KinSlideshow-1.2.1.min.js" type="text/javascript"></script>
    <script src="${ctx}/matter/js/jQuery-jcImgScroll.js" type="text/javascript"></script>
    <script src="${ctx}/matter/js/index.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $pic("picChange").picChange({ changeStyle: "fade", time: 250, interTime: 5000, direction: "left" });

            function func() {
                $pic("picChange").picChange({
                    changeStyle: my_changeStyle,
                    time: my_time,
                    direction: my_direction,
                    isClick: my_isClick,
                    interTime: my_intertime
                });
                var tmpImg = document.getElementById("picChange").getElementsByTagName("img");
                var tmpLength = tmpImg.length;
                for (var n = 0; n < tmpLength; n++) {
                    tmpImg[n].style.top = "";
                    tmpImg[n].style.left = "";
                    setAlpha(tmpImg[n], 100);
                    if (n == 0)
                        tmpImg[n].style.display = "block";
                    else
                        tmpImg[n].style.display = "";
                }
            }
        });
    </script>
    <script src="${ctx}/matter/js/picChange-0.3.2.js" type="text/javascript"></script>
</head>

<body>

<div id="templatemo_header_wrapper">
	<div id="templatemo_header" class="wrapper">
    	<jsp:include page="head.jsp" />
</div>
</div>
<div id="templatemo_middle_wrapper">
	<div class="bannerIndexWrap">
            <div id="banner" class="jcImgScroll">
	            <ul>
	            <c:forEach items="${ pic}" var="img" begin="0" end="2">
                    <li><a href="${img.newsLink }" path="${img.imgUrl }" title="${img.title }"></a></li>
	            </c:forEach>
                </ul>
            </div>
     </div>
</div>
<div id="templatemo_bottom_wrapper">
	<div id="templatemo_bottom" class="wrapper main_news">
    	<div class="col1 one_fourth one_fourth_l ">
            <div id="win">
	            <ul id="picChange">
	            	<c:forEach items="${bigImages }" var="img" begin="0" end="3">
		            <li><img  src="${img.imgUrl }" title="${img.title }"></li>
	            	</c:forEach>
	            </ul>        
             </div>
        </div>     
    <div class="col1 one_fourth2 gengduo">
    	<h4>行业动态<span ><a href="${ctx}/queryArticleListById?curPage=1&article.typeid=2">更多>></a></span></h4>
           
            <ul class="no_bullet">         
            
             <c:forEach items="${casus}" var="casus">
                <li>
                   <a href="${ctx}/getArticleById?article.typeid=${casus.id}">
             	<c:if test="${fn:length(ht:delHTMLTag(casus.content))>27 }" >
	         	 ${fn:substring(ht:delHTMLTag(casus.content),0,27) }...
	   			 </c:if>
	   			<c:if test="${fn:length(ht:delHTMLTag(casus.content))<=27 }" >
	         	 ${ht:delHTMLTag(casus.content)}
	   			 </c:if>
	   			 </a>
              </li>
		</c:forEach>
            </ul>
            
    	</div>
    
    	<div class="col1 one_fourth no_margin_right gengduo">
    	<h4>服务支持</h4>
        <ul class="no_bullet no_bullet_f">
        	<li><img src="${ctx}/matter/images/service/web.png" /><div>网站设计及开发 <br /> <span>一站式个性化网站建设服务</span></div></li>
            <li><img src="${ctx}/matter/images/service/app.png" /><div>APP设计开发提供<br /> <span>IOS、Android应用开发，推广服务。</span></div></li>
            <li><img src="${ctx}/matter/images/service/site.png" /><div>整站建设与优化<br /> <span>详细的建站需求和经验丰富的项目团队。</span></div></li>
            <li><img src="${ctx}/matter/images/service/cehua.png" /><div>电子营销管理策划<br /> <span>基于互联网的品牌营销策略的定制。</span></div></li>
            
        </ul>
    	</div>
        
        <div class="clear"></div>
    </div>
</div>

<div id="templatemo_main" class="wrapper">
  <div class="ser_tlt gengduo"><p>风采展示<a href="${ctx}/intoSuccessCase" target="_blank"><span>更多>></span></a></p></div>
	
	<c:forEach items="${successfulCase}" var="successfulCase">
	
	<div class="col_0 one_third">
        <div class="img_frame">
            <a href="${ctx}/getArticleByid?article.typeid=${successfulCase.id}" target="_blank"><img src="${successfulCase.previewImg }" alt="Image" /></a>
        </div>
        <br />
        <a href="${ctx}/getArticleByid?article.typeid=${successfulCase.id}" title="" target="_blank">
      
        <c:if test="${fn:length(ht:delHTMLTag(successfulCase.title ))>15 }" >
	          ${fn:substring(ht:delHTMLTag(successfulCase.title ),0,15) }...
	    </c:if>
	    <c:if test="${fn:length(ht:delHTMLTag(successfulCase.title ))<=15 }" >
	         	  ${ht:delHTMLTag(successfulCase.title )}
	   	</c:if>
        
        </a>  
  </div>
  
	</c:forEach>
    
    <div class="clear"></div>
	
	
</div>

<jsp:include page="bottom.jsp" />

</body>

</html>
