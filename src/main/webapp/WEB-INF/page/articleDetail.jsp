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
	<title>${webName}</title>
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
					<p>${parentTitle}<span>SERVICE</span></p>
					<span>你现在的位置：首页>${parentTitle}>${article.title}</span>
					<div class="clear"></div>
				</div>
				<!-- - - - - - - - - - - - - - _cont_main ul - - - - - - - - - - - - - - - - -->
				<div class="content">
					<div class="content_tit">
						<h4>${article.title}</h4>
						<ul>
							<li>发布时间：<fmt:formatDate value="${article.modifyDate}" pattern="yyyy:MM:dd"/></li>
							<li>来源：<c:if test="${empty article.source}">原创</c:if><c:if test="${!empty article.source}">${article.source}</c:if></li>
							<li>编辑：${article.author}</li>
						</ul>
						<div class="clear"></div>
					</div>
					<p>
						${article.content}
					</p>
				</div>
				<div class="clear"></div>
			</div>
			<div class="clear"></div>
		</div>

		<jsp:include page="bottom.jsp"/>
	</div>
</body>
<script>   /*分享工具配置文件*/
var jiathis_config = {
	showClose:false,
	url:"www.baidu.com",
	title:'${webName}',
	summary:"haha",
	pic:"http://img2.yododo.com.cn/files/cms/20130805114223.jpg"
}
</script>
<script type="text/javascript" src="http://v1.jiathis.com/code/jiathis_r.js?move=0" charset="utf-8"></script>
<!-- JiaThis Button END -->
</html>
