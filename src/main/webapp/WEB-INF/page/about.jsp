<%--
  Created by IntelliJ IDEA.
  User: hejian
  Date: 14-4-21
  Time: 下午3:10
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
	<%--<script type="text/javascript" src="http://api.map.baidu.com/api?key=&v=1.1&services=true"></script>--%>
<body>
	<div class="wrap">
		<jsp:include page="head.jsp"/>
		<div id="cont_main">
			<jsp:include page="left.jsp"/>
			<!-- - - - - - - - - - - - - - _cont_main - - - - - - - - - - - - - - - - -->
			<div class="_cont_main">
				<div class="main_header">
					<p>${parentTitle}<span>COMPANY</span></p>
					<span>你现在的位置：首页>关于我们>${parentTitle}</span>
					<div class="clear"></div>
				</div>
				<!-- - - - - - - - - - - - - - _cont_main ul - - - - - - - - - - - - - - - - -->
				<div class="content">
					<div class="content_tit">
						<h4>${article.title}</h4>
						<div class="clear"></div>
					</div>
					<p>
						${article.content}
					</p>
				</div>
				<div class="clear"></div>
				<!-- - - - - - - - - - - - - - map- - - - - - - - - - - - - - - - -->

				<div class="dv2">
					<div style="margin-left: -20px;">
						<ul class="no_border">
							<li >业务咨询：0755-61829391、0755-61829392、0755-33133167、0755-33133168</li>
							<li style="padding-top: 10px">客服邮箱：kefu@tiandixin.net/kefu@heartcom.cn</li>
							<li style="padding-top: 10px">公司地址：成都市一环路东段</li>
							<li style="padding-top: 10px">邮编：610000</li>
						</ul>
					</div>
					<div align="center" class="div_tel">
						<div style="width: 798px; height: 350px; border: #ccc solid 1px;" id="dituContent">
						</div>
					</div>
				</div>
				<script type="text/javascript" src="http://api.map.baidu.com/api?key=&v=1.1&services=true"></script>

				<script type="text/javascript">
					//创建和初始化地图函数：
					function initMap(){
						createMap();//创建地图
						setMapEvent();//设置地图事件
						addMapControl();//向地图添加控件
						addMarker();//向地图中添加marker
					}

					//创建地图函数：
					function createMap(){
						var map = new BMap.Map("dituContent");//在百度地图容器中创建一个地图
						var point = new BMap.Point(104.100032,30.65044);//定义一个中心点坐标
						map.centerAndZoom(point,18);//设定地图的中心点和坐标并将地图显示在地图容器中
						window.map = map;//将map变量存储在全局
					}

					//地图事件设置函数：
					function setMapEvent(){
						map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
						map.enableScrollWheelZoom();//启用地图滚轮放大缩小
						map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
						map.enableKeyboard();//启用键盘上下左右键移动地图
					}

					//地图控件添加函数：
					function addMapControl(){
						//向地图中添加缩放控件
						var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
						map.addControl(ctrl_nav);
						//向地图中添加缩略图控件
						var ctrl_ove = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:1});
						map.addControl(ctrl_ove);
						//向地图中添加比例尺控件
						var ctrl_sca = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
						map.addControl(ctrl_sca);
					}

					//标注点数组
					var markerArr = [{title:"成都艾软信息技术有限公司",content:"成都市东恒国际1栋<br/>电话：18284091520",point:"104.100032|30.65044",isOpen:1,icon:{w:23,h:25,l:46,t:21,x:9,lb:12}}
					];
					//创建marker
					function addMarker(){
						for(var i=0;i<markerArr.length;i++){
							var json = markerArr[i];
							var p0 = json.point.split("|")[0];
							var p1 = json.point.split("|")[1];
							var point = new BMap.Point(p0,p1);
							var iconImg = createIcon(json.icon);
							var marker = new BMap.Marker(point,{icon:iconImg});
							var iw = createInfoWindow(i);
							var label = new BMap.Label(json.title,{"offset":new BMap.Size(json.icon.lb-json.icon.x+10,-20)});
							marker.setLabel(label);
							map.addOverlay(marker);
							label.setStyle({
								borderColor:"#808080",
								color:"#333",
								cursor:"pointer"
							});

							(function(){
								var index = i;
								var _iw = createInfoWindow(i);
								var _marker = marker;
								_marker.addEventListener("click",function(){
									this.openInfoWindow(_iw);
								});
								_iw.addEventListener("open",function(){
									_marker.getLabel().hide();
								})
								_iw.addEventListener("close",function(){
									_marker.getLabel().show();
								})
								label.addEventListener("click",function(){
									_marker.openInfoWindow(_iw);
								})
								if(!!json.isOpen){
									label.hide();
									_marker.openInfoWindow(_iw);
								}
							})()
						}
					}
					//创建InfoWindow
					function createInfoWindow(i){
						var json = markerArr[i];
						var iw = new BMap.InfoWindow("<b class='iw_poi_title' title='" + json.title + "'>" + json.title + "</b><div class='iw_poi_content'>"+json.content+"</div>");
						return iw;
					}
					//创建一个Icon
					function createIcon(json){
						var icon = new BMap.Icon("http://app.baidu.com/map/images/us_mk_icon.png", new BMap.Size(json.w,json.h),{imageOffset: new BMap.Size(-json.l,-json.t),infoWindowOffset:new BMap.Size(json.lb+5,1),offset:new BMap.Size(json.x,json.h)})
						return icon;
					}
					initMap();//创建和初始化地图
				</script>

				<!-- - - - - - - - - - - - - - map- - - - - - - - - - - - - - - - -->
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
