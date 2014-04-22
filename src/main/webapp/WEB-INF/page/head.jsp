<%--
  Created by IntelliJ IDEA.
  User: hejian
  Date: 14-4-21
  Time: 上午10:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglibs.jsp"%>

<script type="text/javascript">
	$(function(){
		var $window = $(window),window_width = $window.width();
		$('#js_banner, #js_banner_img li').width(window_width);
		var urlParam = G.util.parse.url(),startFrame = 0;
		if (urlParam.search && ('banner' in urlParam.search)){
			startFrame = (parseInt(urlParam.search['banner'])-1) || 0;
		}
		new $.Tab({/*添加圆点按钮*/
			target: $('#js_banner_img li'),
			effect: 'slide3d',
			animateTime: 1000,
			stay: 4000,
			playTo: startFrame,
			autoPlay: true,
			merge: true,
			prevBtn: $('#js_banner_pre'),
			nextBtn: $('#js_banner_next')
		});
		$('#js_banner_img').css('left','-' + (window_width * startFrame) + 'px');
	});
</script>

<!-- - - - - - - - - - - - - - Header - - - - - - - - - - - - - - - - -->
<header id="header">
	<a href="" target="_self"><img src="${ctx}/matter/images/logo.jpg" alt="logo" /></a>
	<nav id="navigation" >
		<ul>
			<li ><a href="${ctx}/index">网站首页</a></li>
			<li><a href="${ctx}/article/queryArticleListById?typeid=1">新闻资讯</a></li>
			<li><a href="${ctx}/article/queryArticleListById?typeid=3">案例展示</a></li>
			<li><a href="${ctx}/article/queryArticleListById?typeid=6">服务支持</a></li>
			<li><a href="${ctx}/article/queryArticleListById?typeid=4">关于我们</a></li>
		</ul>
	</nav><!--/ #navigation-->
	<div class="clear"></div>
</header><!--/ #header-->

<!-- 代码开始 -->
<div id="js_banner" class="banner">
	<ul id="js_banner_img" class="banner_img clear">
		<li class="bgli01" style=" background:#2a95bb url(${indexPic[0].imgUrl}) center no-repeat;">
			<div class="banner_inner">
				<div class="child child2" >
                    <a href="${indexPic[0].newsLink}" target="_blank"><!--<img src="images/banner2-0.jpg" />--></a></div>
			</div>
			<div class="clear"></div>
		</li>
        <li class="bgli02" style=" background:#2a95bb url(${indexPic[1].imgUrl}) center no-repeat;">
			<div class="banner_inner">
				<div class="child child2" >
                    <a href="${indexPic[1].newsLink}" target="_blank"><!--<img src="images/banner2-0.jpg" />--></a></div>
			</div>
			<div class="clear"></div>
		</li>
        <li class="bgli03" style=" background:#2a95bb url(${indexPic[2].imgUrl}) center no-repeat;">
			<div class="banner_inner">
				<div class="child child2" >
                    <a href="${indexPic[2].newsLink}" target="_blank"><!--<img src="images/banner2-0.jpg" />--></a></div>
			</div>
			<div class="clear"></div>
		</li>
        <li class="bgli04" style=" background:#2a95bb url(${indexPic[3].imgUrl}) center no-repeat;">
			<div class="banner_inner">
				<div class="child child2" >
                    <a href="${indexPic[3].newsLink}" target="_blank"><!--<img src="images/banner2-0.jpg" />--></a></div>
			</div>
			<div class="clear"></div>
		</li>


	</ul>
</div>
<!-- 代码结束 -->
