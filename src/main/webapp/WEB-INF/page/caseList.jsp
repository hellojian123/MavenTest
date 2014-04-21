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
	<link rel="stylesheet" href="${ctx}/matter/css/reset.css" media="screen" type="text/css"/>
	<link rel="stylesheet" href="${ctx}/matter/css/index.css" media="screen" type="text/css"/>
	<link rel="stylesheet" href="${ctx}/matter/css/style.css" media="screen" type="text/css"/>
	<link rel="stylesheet" href="${ctx}/matter/css/lrtk.css" type="text/css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/matter/js/fancybox/jquery.fancybox-1.3.4.css" media="screen" />

	<script type="text/javascript" src="${ctx}/matter/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="${ctx}/matter/js/global.js"></script>
	<script type="text/javascript" src="${ctx}/matter/js/tab.js"></script>
	<script type="text/javascript" src="${ctx}/matter/js/fancybox/jquery.mousewheel-3.0.4.pack.js"></script>
	<script type="text/javascript" src="${ctx}/matter/js/gallery.js"></script>
	<script type="text/javascript" src="${ctx}/matter/js/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
	<script>
		!window.jQuery && document.write('<script src="js/jquery-1.4.3.min.js"><\/script>');
	</script>
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
					<span>你现在的位置：首页>关于我们>最新动态</span>
					<div class="clear"></div>
				</div>
				<!-- - - - - - - - - - - - - - _cont_main ul - - - - - - - - - - - - - - - - -->
				<div class="content_gallery">
					<p>
						<a rel="example_group" href="${ctx}/matter/images/example/9_b.jpg" title="作品展示标题"><img alt="" src="${ctx}/matter/images/example/9_s.jpg" /></a>
						<a rel="example_group" href="${ctx}/matter/images/example/10_b.jpg" title="作品展示标题"><img alt="" src="${ctx}/matter/images/example/10_s.jpg" /></a>
						<a rel="example_group" href="${ctx}/matter/images/example/11_b.jpg" title="作品展示标题"><img alt="" src="${ctx}/matter/images/example/11_s.jpg" /></a>
						<a rel="example_group" href="${ctx}/matter/images/example/12_b.jpg" title="作品展示标题"><img class="last" alt="" src="${ctx}/matter/images/example/12_s.jpg" /></a>
					</p>
				</div>
				<div class="clear"></div>
				<!-- ------------------------分页list----------------------------------------------------------------->
				<div class="list">
					<a href="#">上一页</a>
					<a href="#"><span>1</span></a>
					<a href="#"><span>2</span></a>
					<a href="#"><span>3</span></a>
					<a href="#"><span>4</span></a>
					<a href="#"><span>5</span></a>
					<a href="#">下一页</a>
				</div>
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
