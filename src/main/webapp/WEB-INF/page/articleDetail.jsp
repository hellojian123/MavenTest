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
	<title>无标题文档</title>
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
					<span>你现在的位置：首页>关于我们>最新动态</span>
					<div class="clear"></div>
				</div>

				<!-- - - - - - - - - - - - - - _cont_main ul - - - - - - - - - - - - - - - - -->
				<div class="content">
					<div class="content_tit">
						<h4>SEO搜索引擎优化排名报价收费标准简洁公式</h4>
						<ul>
							<li>发布时间：2013-08-14</li>
							<li>来源：优网络</li>
							<li>编辑：mym_moon</li>
						</ul>
						<div class="clear"></div>
					</div>

					<p>做SEO 的高人都不提倡关键词排名，提倡整体优化或者咨询顾问。但是客户一般都要求做排名，其他的没点功夫，他也不受你忽悠。所以，关键词排名报价标准是个必备的武器。

						　　前几年自个琢磨了很久，弄了个公式，还是比较方便，分享一下：

						　　用关键词：烟气分析仪，来举例
					</p>

					<p>第一步：在google输入：allintitle:烟气分析仪

					　　返回：约有23,400项符合allintitle:烟气分析仪的查询结果

					　　示例：;q=allintitle%3A%E7%83%9F%E6%B0%94%E5%88%86%E6%9E%90%E4%BB%AA&btnG=Google+%E6%90%9C%E7%B4%A2&meta=&aq=f
				  </p>
					<p>
						第二步：把23400拷贝，在google输入：(23,400开4次方)*1000
						　　这就是公式，用的是google的计算器.
						　　返回结果：(23 400开 4次方) * 1 000 = 12 368.1278
						　　这就是我的报价：12368元
					</p>
					<p>示例：;hl=zh-CN&newwindow=1&q=%2823%2C400%E5%BC%804%E6%AC%A1%E6%96%B9%29*1000&meta=&aq=f </p>
					<p>其中的1000是报价系数，可以根据你公司的实际情况，关键词的难易判断，等等灵活修改。</p>
					<p>仅供参考，你可以试试。</p>
					<p>　懂SEO 的人应该都能看出来，主要是考核收录的数量中标题中含有关键词的网页数量作为价格衡量标准的。不能准确描述关键词的价格和难度，但具有一定的参考性。</p>
					<p>另外，我在客户当面这样查价格的时候，客户以为是很权威，很信服，因为都是在google里操作。呵呵。</p>
					<p>首发在最近搞着玩的网站：网络公司联盟 </p>

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
