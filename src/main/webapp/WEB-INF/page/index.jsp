<%--
  Created by IntelliJ IDEA.
  User: hejian
  Date: 14-4-21
  Time: 上午10:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>${webName}</title>
	<link rel="stylesheet" href="${ctx}/matter/css/reset.css" media="screen"  type="text/css"/>
	<link rel="stylesheet" href="${ctx}/matter/css/index.css" media="screen"  type="text/css"/>
	<link rel="stylesheet" href="${ctx}/matter/css/lrtk.css" type="text/css"/>

	<script type="text/javascript" src="${ctx}/matter/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="${ctx}/matter/js/case.js"></script>
	<script type="text/javascript" src="${ctx}/matter/js/global.js"></script>
	<script type="text/javascript" src="${ctx}/matter/js/tab.js"></script>
</head>

<body>
	<div class="wrap">
		<jsp:include page="head.jsp"/>
		<div id="service">
			<div class="tit no_border">
				<h3>服务与支持<span>/SERVICE</span></h3>
				<p>艾软科技为客户提供优质的解决方案和服务，我们善长网站设计、制作、开发。良好的服务态度及形象获得了许多客户及业内的好评。</p>
			</div>
			<ul>
				<li><a href="${ctx}/article/Service?typeid=7"><img src="${ctx}/matter/images/ser1.jpg" alt="" /><br><p>网站建设</p></a></li>
				<li><a href="${ctx}/article/Service?typeid=8"><img src="${ctx}/matter/images/ser1.jpg" alt="" /><br><p>客户端建设服务</p></a></li>
				<li class="no_margin"><a href="${ctx}/article/Service?typeid=9"><img src="${ctx}/matter/images/ser1.jpg" alt="" /><br><p>OA系统</p></a></li>
			</ul>
		</div><!--service end-->
		<div class="clear"></div>
		<!-- - - - - - - - - - - - - - service - - - - - - - - - - - - - - - - -->

		<!-- - - - - - - - - - - - - - show - - - - - - - - - - - - - - - - -->
		<div id="shower">
			<div class="tit">
				<h3>案例展示<span>/GALLERY</span></h3>
			</div>
			<div class="box">
				<div class="picbox">
					<ul class="piclist mainlist">
                        <c:forEach var="sucCase" items="${sucCase}" varStatus="status">
						    <li><a href="/" target="_blank" title="${sucCase.title}"><img src="${sucCase.previewImg}"/></a></li>
                        </c:forEach>
					</ul>
					<ul class="piclist swaplist"></ul>
				</div>
				<div class="og_prev"></div>
				<div class="og_next"></div>
			</div>
		</div>
		<div class="clear"></div>
		<!-- - - - - - - - - - - - - - show - - - - - - - - - - - - - - - - -->

		<!-- - - - - - - - - - - - - - news - - - - - - - - - - - - - - - - -->
		<div id="news">
			<div class="cop">
				<div class="tit">
					<h3>新闻动态<span>/NEWS</span></h3>
				</div>
				<ul>
                    <c:forEach var="newsList" items="${newsList}" varStatus="status">
					    <li><a href="${ctx}/article/getArticleById?articleId=${newsList.id}" target="_blank">${newsList.title}</a><span><fmt:formatDate value="${newsList.modifyDate}" pattern="hh-MM-ss"/></span></li>
                    </c:forEach>
				</ul>
			</div>
			<div class="comp">
				<div class="tit">
					<h3>公司简介<span>/COMPANY</span></h3>
				</div>
				<a href="" target="_blank"><img src="${ctx}/matter/images/comp.jpg" /></a>
				<p>
                    <c:if test="${fn:length(ht:delHTMLTag(compIntroduce.content)) > 80}">
                        ${fn:substring(ht:delHTMLTag(compIntroduce.content),0,80) }...
                    </c:if>
                    <c:if test="${fn:length(ht:delHTMLTag(compIntroduce.content)) <= 80}">
                        ${ht:delHTMLTag(compIntroduce.content)}
                    </c:if>
				</p>
			</div>
			<div class="clear"></div>
		</div>
		<div class="clear"></div>
		<jsp:include page="bottom.jsp"/>
	</div>
</body>
<!-- JiaThis Button BEGIN -->
<script type="text/javascript" src="http://v3.jiathis.com/code/jiathis_r.js" charset="utf-8"></script>
<!-- JiaThis Button END -->
</html>
