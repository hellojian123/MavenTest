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
	<title>${webName}</title>
	<link rel="stylesheet" href="${ctx}/matter/css/reset.css" media="screen" type="text/css"/>
	<link rel="stylesheet" href="${ctx}/matter/css/index.css" media="screen" type="text/css"/>
	<link rel="stylesheet" href="${ctx}/matter/css/style.css" media="screen" type="text/css"/>
	<link rel="stylesheet" href="${ctx}/matter/css/lrtk.css" type="text/css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/matter/js/fancybox/jquery.fancybox-1.3.4.css" media="screen" />
	<link rel="stylesheet" href="${ctx}/matter/css/fenye.css" type="text/css"/>

	<script type="text/javascript" src="${ctx}/matter/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="${ctx}/matter/js/global.js"></script>
	<script type="text/javascript" src="${ctx}/matter/js/tab.js"></script>
	<script type="text/javascript" src="${ctx}/matter/js/fancybox/jquery.mousewheel-3.0.4.pack.js"></script>
	<script type="text/javascript" src="${ctx}/matter/js/gallery.js"></script>
	<script type="text/javascript" src="${ctx}/matter/js/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
	<script type="text/javascript" src="${ctx}/matter/js/script.js"></script>
	<script type="text/javascript">
		$(function(){
			//案列展示预览图显示
			$(".div_liulan a img").each(function(index,item){
				var imgSrc = $(this).attr("src");
				var img = new Image();
				img.src = imgSrc;
				if(img.complete){
					dealWith(img,$(item));
					img = null;
				}else{
					img.onload=function(){
						dealWith(img,$(item));
						img = null;
					};
				}
			});
		});
		//处理预览图样式
		function dealWith(obj,selc){
			var originalHeight = obj.height;   //图片原始高度
			var originalWidth = obj.width;		//图片原始宽度
			selc.css({height:function(){return originalHeight+"px";},
				/*width:function(){return originalWidth+"px";}*/});
		};
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
					<p>${parentTitle}<span>GALLERY</span></p>
					<span>你现在的位置：首页>${parentTitle}</span>
					<div class="clear"></div>
				</div>
				<!-- - - - - - - - - - - - - - _cont_main ul START- - - - - - - - - - - - - - - - -->
				<div class="content_gallery">
					<p>
						<c:forEach items="${articles}" var="caseImg">
							<div class="div_liulan">
								<a rel="example_group" href="${caseImg.previewImg}" title="作品展示标题"><img id="img_liulan" alt="" src="${caseImg.previewImg}" /></a>
							</div>
						</c:forEach>
					</p>
				</div>
				<div class="clear"></div>
				<!-- - - - - - - - - - - - - - _cont_main ul END!- - - - - - - - - - - - - - - - -->
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
