<%--
  Created by IntelliJ IDEA.
  User: hejian
  Date: 14-4-21
  Time: 上午10:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>无标题文档</title>
	<link rel="stylesheet" href="${ctx}/matter/css/reset.css" media="screen"  type="text/css"/>
	<link rel="stylesheet" href="${ctx}/matter/css/index.css" media="screen"  type="text/css"/>
	<link rel="stylesheet" href="${ctx}/matter/css/style.css" media="screen"  type="text/css"/>
	<link rel="stylesheet" href="${ctx}/matter/css/lrtk.css" type="text/css"/>
	<link rel="stylesheet" href="${ctx}/matter/css/fenye.css" type="text/css"/>

	<script type="text/javascript" src="${ctx}/matter/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="${ctx}/matter/js/global.js"></script>
	<script type="text/javascript" src="${ctx}/matter/js/tab.js"></script>
	<script type="text/javascript" src="${ctx}/matter/js/script.js"></script>

</head>

<body>
	<div class="wrap">
		<jsp:include page="head.jsp"/>
		<div id="cont_main">
			<jsp:include page="left.jsp"/>
			<!-- - - - - - - - - - - - - - _cont_main - - - - - - - - - - - - - - - - -->
			<div class="_cont_main">
				<div class="main_header">
					<p>${parentTitle}<span>NEWS</span></p>
					<span>你现在的位置：首页>${parentTitle}</span>
					<div class="clear"></div>
				</div>
				<!-- - - - - - - - - - - - - - _cont_main ul - - - - - - - - - - - - - - - - -->
				<c:forEach items="${pm.result}" var="arti">
					<ul>
						<li><a href="${ctx}/article/getArticleById?articleId=${arti.id}" target="_blank"><h4>${arti.title}</h4></a><span><fmt:formatDate value="${arti.modifyDate}" pattern="yyyy-MM-dd"/> </span>
							<p>
								<c:if test="${fn:length(ht:delHTMLTag(arti.content)) > 90}">
									${fn:substring(ht:delHTMLTag(arti.content),0,90) }...
								</c:if>
								<c:if test="${fn:length(ht:delHTMLTag(arti.content)) <= 90}">
									${ht:delHTMLTag(arti.content)}
								</c:if>
								<br/>
								<a href="${ctx}/article/getArticleById?articleId=${arti.id}" target="_blank" style="float: right">[查看详情]</a>
								<div style="height: 5px"/>
							</p>
						</li>
					</ul>
					<div class="clear"></div>
				</c:forEach>
				<!-- - - - - - - - - - - - - - _cont_main  ul- - - - - - - - - - - - - - - - -->
				<!-- ------------------------分页list----------------------------------------------------------------->
				<div id="page" class="yahoo2" style="margin-top: 25px"></div>
				<script type="text/javascript">
					$("#page").html(fenyeComment("${pm.maxPage}","${currentPage}","${ctx}/article/queryArticleListById","typeid=${typeid}"));
				</script>
				<!-- ------------------------分页list----------------------------------------------------------------->
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
