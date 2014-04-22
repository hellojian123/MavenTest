<%--
  Created by IntelliJ IDEA.
  User: hejian
  Date: 14-4-21
  Time: 上午10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>${webName}-${article.title}</title>
	<link rel="stylesheet" href="${ctx}/matter/css/reset.css" media="screen"  type="text/css"/>
	<link rel="stylesheet" href="${ctx}/matter/css/index.css" media="screen"  type="text/css"/>
	<link rel="stylesheet" href="${ctx}/matter/css/style.css" media="screen"  type="text/css"/>
	<link rel="stylesheet" href="${ctx}/matter/css/lrtk.css" type="text/css"/>

	<script type="text/javascript" src="${ctx}/matter/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="${ctx}/matter/js/global.js"></script>
	<script type="text/javascript" src="${ctx}/matter/js/tab.js"></script>
</head>

<body>
	<div class="wrap">
		<jsp:include page="head.jsp"/>
		<div id="cont_main">
			<jsp:include page="left.jsp"/>
			<!-- - - - - - - - - - - - - - _cont_main - - - - - - - - - - - - - - - - -->
			<div class="_cont_main">
				<div class="main_header">
					<p>最新动态<span>NEWS</span></p>
					<span>你现在的位置：首页><c:if test="${article.typeid==7}">网站建设</c:if>
                                              <c:if test="${article.typeid==8}">系统开发</c:if>
                                               <c:if test="${article.typeid==9}">APP开发</c:if>
                                                <c:if test="${article.typeid==1}">最新动态</c:if>>
                                            <c:if test="${fn:length(ht:delHTMLTag(article.title)) > 10}">
                                                ${fn:substring(ht:delHTMLTag(article.title),0,10) }...
                                            </c:if>
											<c:if test="${fn:length(ht:delHTMLTag(article.title)) <= 10}">
                                                ${ht:delHTMLTag(article.title)}
                                            </c:if></span>
					<div class="clear"></div>
				</div>

				<!-- - - - - - - - - - - - - - _cont_main ul - - - - - - - - - - - - - - - - -->
				<div class="content">
					<div class="content_tit">
						<h4>${article.title}</h4>
						<ul>
							<li>发布时间：
                                <fmt:formatDate value="${article.modifyDate}" pattern="hh:MM:ss"/></li>
							<li>来源：<c:if test="${empty article.source}">原创</c:if>
                                     <c:if test="${!empty article.source}">${article.source}</c:if>
                            </li>
							<li>编辑：${article.author}</li>
						</ul>
						<div class="clear"></div>
					</div>

					<p>
                       ${ ht:delHTMLTag(article.content)}
					</p>

				</div>
				<div class="clear"></div>
			</div>
			<div class="clear"></div>
		</div>

		<jsp:include page="bottom.jsp"/>
	</div>
</body>
<!-- JiaThis Button BEGIN -->
<script type="text/javascript" src="http://v3.jiathis.com/code/jiathis_r.js" charset="utf-8"></script>
<!-- JiaThis Button END -->
</html>