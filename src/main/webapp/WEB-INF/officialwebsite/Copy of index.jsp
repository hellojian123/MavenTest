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


</head>
<body>

<jsp:include page="head.jsp" />

<div id="templatemo_middle_wrapper">
	<div id="templatemo_middle" class="wrapper">
        <div id="templatemo_slider">
        	<div id="carousel">
               

			
            <div id="slider-image-frame">
                <div class="backgrounds">
                     <div class="item item_1">
                         <img src="${bigImages[0].imgUrl }" alt="${bigImages[0].title }" />
                    </div><!-- /item -->
                    
                    <div class="item item_2">
                         <img src="${bigImages[1].imgUrl }" alt="${bigImages[1].title }" />
                    </div><!-- /item -->
                    
                    <div class="item item_3">
                        <img src="${bigImages[2].imgUrl }" alt="${bigImages[2].title }" />
                    </div><!-- /item -->
                </div><!-- /backgrounds -->
			</div>
		</div>
        </div> <!-- END of templatemo_slider -->
        
    </div>
   
</div>
<div id="templatemo_sevrice" class="sevrice">
     <div class="ser_tlt"><p>服务支持</p></div>
     <div class="ser_cont">
          <a href="javascript:void(0)" class="web">
                <span></span>
                <ul>
                   <li><h4>网站设计及开发</h4></li>
                   <li>提供网站设计及开发</li>
                </ul>
          </a>
     </div>
     <div class="ser_cont">
          <a  href="javascript:void(0)" class="app">
                <span></span>
                <ul>
                   <li><h4>APP设计开发</h4></li>
                   <li>提供APP设计开发</li>
                </ul>
          </a>
     </div>
     <div class="ser_cont">
          <a href="javascript:void(0)" class="site">
                <span></span>
                <ul>
                   <li><h4>整站建设与优化</h4></li>
                   <li>提供整站建设与优化</li>
                </ul>
          </a>
     </div>
     <div class="ser_cont">
          <a  href="javascript:void(0)" class="cehua">
                <span></span>
                <ul>
                   <li><h4>电子营销管理策划</h4></li>
                   <li>提供电子营销管理策划</li>
                </ul>
          </a>
     </div>
     
</div>
<div id="templatemo_main" class="wrapper">
  <div class="ser_tlt gengduo"><p>案例展示<a href="${ctx }/intoSuccessCase" target="_blank"><span>更多>></span></a></p></div>


<c:forEach items="${successfulCase}" var="successfulCase">
	<div class="col_0 one_third">
    	<h5>${successfulCase.title }</h5>
        <div class="img_frame img_frame_13 img_nom img_size"><span></span>
            <a href="${ctx}/getArticleByid?article.typeid=${successfulCase.id}" target="_blank"><img src="${successfulCase.previewImg }" alt="Image" /></a>
        </div>
        <p><c:if test="${fn:length(ht:delHTMLTag(successfulCase.content))>50 }" >
	          ${fn:substring(ht:delHTMLTag(successfulCase.content),0,50) }...
	    </c:if>
	    <c:if test="${fn:length(ht:delHTMLTag(successfulCase.content))<=50 }" >
	         	  ${ht:delHTMLTag(successfulCase.content)}...
	   	</c:if>
	    </p>
         
  </div>
    </c:forEach>
    
    <div class="clear"></div>
	
	
</div>

<div id="templatemo_bottom_wrapper">
	<div id="templatemo_bottom" class="wrapper main_news">
    
    	<div class="col1 one_fourth">
            <h4>公司新闻</h4>
            <a href="#"><p><img src="${ctx}/matter/images/a.jpg" alt="Image" />
			</p></a>
        </div>
        
    		<div class="col1 one_fourth gengduo">
            <span><a href="${ctx}/queryArticleListById?curPage=1&article.typeid=1">更多>></a></span>
            </br>
            <h4></h4>
            <ul class="footer_gallery">
            <c:forEach items="${companyNews}" var="companyNews">
              <li><a href="${ctx}/getArticleById?article.typeid=${companyNews.id}" target="_blank">
             <c:if test="${fn:length(ht:delHTMLTag(companyNews.title ))>10 }" >
	         	 ${fn:substring(ht:delHTMLTag(companyNews.title ),0,10) }...
	   			 </c:if>
	   			<c:if test="${fn:length(ht:delHTMLTag(companyNews.title ))<=10 }" >
	         	 ${ht:delHTMLTag(companyNews.title )}...
	   			 </c:if>
             
              </a></li>
            </c:forEach>
            </ul>
            <div class="clear"></div>
            
        </div>
        
        
        
    <div class="col1 one_fourth2 gengduo">
    	<h4>最新资讯<span ><a href="${ctx}/queryArticleListById?curPage=1&article.typeid=2">更多>></a></span></h4>
           
            <ul class="no_bullet">
           <c:forEach items="${casus}" var="casus">
            
                <li>
                    <span class="header"><a href="${ctx}/getArticleById?article.typeid=${casus.id}">${casus.title }</a></span>
             	<c:if test="${fn:length(ht:delHTMLTag(casus.content))>40 }" >
	         	 ${fn:substring(ht:delHTMLTag(casus.content),0,40) }...
	   			 </c:if>
	   			<c:if test="${fn:length(ht:delHTMLTag(casus.content))<=40 }" >
	         	 ${ht:delHTMLTag(casus.content)}...
	   			 </c:if>
              </li>
		</c:forEach>
            </ul>
            
    	</div>
    
    	<div class="col1 one_fourth no_margin_right gengduo">
    	<h4>Twitter</h4>
        <ul class="no_bullet">
        	<li><a href="#">@templatemo</a> at scelerisque urna in tellus varius ultricies.</li>
            <li>7*2小时服务电话：028-12345678</li>
            
        </ul>
    	</div>
        
        <div class="clear"></div>
    </div>
</div>
<jsp:include page="bottom.jsp" />
</body>
</html>