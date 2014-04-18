<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<style type="text/css">
				.testInput{width:190px;}
				.newsContent{width:1010px;height:230px;border:2px #E6E6E6 solid;margin-bottom:10px;}
				.newsContent p{font-weight:bold;}
				.setBtnWidth{width:100px;}
				.caption{height:230px;width:310px;text-align:center;float:left;}
                .imgPreview{height:230px;width:682px;text-align:center;float:left;}
				.imgPreview img{height:230px;width:600px;float:right;}
				.tupianword{font-size:15px;font-weight:bold;color:red;height:230px;width:80px;float:left;margin-top:12px;}
                .selectBoxCount{text-align: center;margin-bottom: 15px;}
			</style>
		<title>更新首页图片</title>
		<%@include file="/common/common.jsp"%>
		<script type="text/javascript" src="${ctx}/js/jquery.MetaData.js"></script>
		<script type="text/javascript" src="${ctx}/js/jquery.MultiFile.pack.js"></script>
		<script type="text/javascript" src="${ctx}/js/page.js"></script>
		<script type="text/javascript" src="${ctx}/js/article.js"></script>
		<script type="text/javascript" src="${ctx}/js/FilterHtml.js"></script>
		<script type="text/javascript" src="${ctx}/js/jquery-1.8.3.min.js"></script>
		<script charset="utf-8" src="${ctx}/editor/kindeditor.js"></script>
		<script charset="utf-8" src="${ctx}/editor/lang/zh_CN.js"></script>
		<script type="text/javascript" src="${ctx}/js/ajaxfileupload.js"></script>
		
		<script type="text/javascript">
			$(document).ready(function(){
				$(window.parent.document.getElementById("childIframe")).height(1800);
				$('.content-box .content-box-content div.tab-content').hide();
				$('ul.content-box-tabs li a.default-tab').addClass('current');
				$('.content-box-content div.default-tab').show();
				$('.content-box ul.content-box-tabs li a').click( // When a tab is clicked...
					function() {
						$(this).parent().siblings().find("a").removeClass('current'); // Remove "current" class from all tabs
						$(this).addClass('current'); // Add class "current" to clicked tab
						var currentTab = $(this).attr('href'); // Set variable "currentTab" to the value of href of clicked tab
						$(currentTab).siblings().hide(); // Hide all content divs
						$(currentTab).show(); // Show the content div with the id equal to the id of clicked tab
						$("#articleid").val(0);
						$("#title").val('');
						//$("#role").html("更新广告内容");
						return false;
					}
				);
                window.onload=function(){
                   var bigImage=$('#selectBigImageCount option').length;
                   var newsPic=$('#selectNewsPicCount option').length;

                    for(var i=0;i < bigImage;i++)
                    {
                        if($("#selectBigImageCount").get(0).options[i].text == ${bigImageCount})
                        {
                             $("#selectBigImageCount").get(0).options[i].selected = true;
                              break;
                         }
                    }
                    for(var i=0;i < newsPic;i++)
                    {
                        if($("#selectNewsPicCount").get(0).options[i].text == ${newsPicCount})
                        {
                             $("#selectNewsPicCount").get(0).options[i].selected = true;
                              break;
                         }
                    }

                }
                $('#selectBigImageCount').change(function(){
                     var value=$("#selectBigImageCount").find("option:selected").text();
                     window.location.href="${ctx}/admin/changeBigImageCount?count="+value;
                });
                $('#selectNewsPicCount').change(function(){
                    var value=$("#selectNewsPicCount").find("option:selected").text();
                    window.location.href="${ctx}/admin/changeNewsPicCount?count="+value;
                });

			});

			function update(th){
				//var testInput = $(th).parent().find(".testInput");
				//获取新闻说明文字
				var title = $(th).parent().find("input[name=title]").val();
				//获取新闻预览图片
				var imgUrl = $(th).parent().find("input[name=imgUrlAddress]").val();
                if(imgUrl==""){
                    imgUrl=$("#"+id).attr("src");
                }
				
				//获取新闻图片所指向的链接
				var newsLink = $(th).parent().find("input[name=newsLink]").val();
				
				//获取新闻id
				var id = $(th).parent().find("input[name=id]").val();
				
				//获取新闻类型
				var type = $(th).parent().find("input[name=type]").val();

				$.post("${ctx}/admin/updateNews",{"nt.id":id,"nt.title":title,"nt.type":type,"nt.newsLink":newsLink,"nt.imgUrl":imgUrl},function(data){
					if(data=="0"){
						alert("更新成功！");
                        //显示预览图
                        $("#"+id).attr("src",imgUrl);
					}else if(data=="1"){
						alert("更新失败！");
					}
				});
			}
			
		function uploadimage(file){
			$.ajaxFileUpload({
				url:'${ctx}/editor/jsp/upload_json.jsp',
				secureuri:false,
				fileElementId:file+"",
				dataType: 'json',				
				success: function (data, status)
				{
					if(data.error==0){//成功
						$("#"+file+"Address").val(data.url);
						alert("上传成功！");
					}else{//失败
						alert(data.message);
					}
				},
				error: function (data, status, e)
				{
					alert(e);
				}
			});
			return false;
		}
		
		function uploadPosterImage(file){
			$.ajaxFileUpload({
				url:'${ctx}/editor/jsp/upload_json.jsp',
				secureuri:false,
				fileElementId:file+"",
				dataType: 'json',			
				dir:'image',
				success: function (data, status)
				{
					if(data.error==0){//成功
						$("#"+file+"File").val(data.url);
						alert("上传成功！");
					}else{//失败
						alert(data.message);
					}
				},
				error: function (data, status, e)
				{
					alert(e);
				}
			});
			return false;
		}

		</script>
	</head>
	<body style="background-image: none;">
			<!-- Wrapper for the radial gradient background -->
			<div id="main-content" style="width: 100%;height: 100%;margin-left: 0px;">
				<div class="content-box">
					<div class="content-box-header">
						<h3>更新首页滚动图片和首页新闻图片</h3>
						<ul class="content-box-tabs">
							<li>
                                <a href="#tab1" class="${tab1_default}" id="role">更新首页滚动大图</a>
							</li>
							<li>
                                <a href="#tab2" class="${tab2_default}">更新新闻图片</a>
							</li>
						</ul>
						<div class="clear"></div>
					</div>
					<div class="content-box-content">
						<div class="tab-content ${tab1_default}" id="tab1">
                            <div class="selectBoxCount">请选择首页滚动大图个数
                                <select id="selectBigImageCount" name="selectBigImageCount">
                                    <option>1</option>
                                    <option>2</option>
                                    <option>3</option>
                                    <option>4</option>
                                </select></div>
                            <c:forEach items="${nts}" var="nt" varStatus="st">
                                <div class="newsContent">
                                    <div class="caption">
                                        <br/>
                                        <span style="font-weight:bold;margin-top:200px;font-size:15px;color:red;">图${st.index+1}</span>
                                        <p>
                                            图片说明文字：<input class="testInput" name="title" type="text" value='${nt.title}'/>
                                        </p>
                                        <p>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;预览图片：<input style="width:137px;"  class="testInput" name="imgUrl" id="imgUrl${st.index}" type="file" value='${nt.imgUrl}'/>
                                            <input type="hidden" id="imgUrl${st.index}Address" name="imgUrlAddress"/>
                                            <input class="button setBtnWidth" type="button" value="上传" onclick="uploadimage('imgUrl${st.index}')" style="width:50px;" id="uploadImg${st.index}"/>
                                        </p>
                                        <p>
                                            图片指向链接：<input class="testInput" name="newsLink" type="text" value='${nt.newsLink}'/>
                                        </p>
                                        <input type="hidden" name="id" value="${nt.id}"/>
                                        <input type="hidden" name="type" value="${nt.type}"/>
                                        <input class="button setBtnWidth" type="button" value="更新" onclick="update(this)"/>
                                    </div>
                                    <div class="imgPreview">
                                        <div class="tupianword">图片预览：</div>
                                        <img src="${nt.imgUrl}" id="${nt.id}" alt="" />
                                    </div>
                                </div>
                            </c:forEach>
						</div>
						<div class="tab-content ${tab2_default}" id="tab2">

                            <div class="selectBoxCount">请选择新闻图片个数
                                <select id="selectNewsPicCount" name="selectNewsPicCount">
                                    <option>1</option>
                                    <option>2</option>
                                    <option>3</option>
                                    <option>4</option>
                                    <option>5</option>
                                    <option>6</option>
                                </select></div>
                            <c:forEach items="${pts}" var="nt" varStatus="st">
                                <div class="newsContent">
                                    <div class="caption">
                                        <br/>
                                        <span style="font-weight:bold;margin-top:200px;font-size:15px;color:red;">图${st.index+1}</span>
                                        <p>
                                            图片说明文字：<input class="testInput" name="title" type="text" value='${nt.title}'/>
                                        </p>
                                        <p>
                                            图片预览地址:
                                            <input type="text" class="testInput" value="${nt.imgUrl}" id="imgUrl${st.index}PosterAddressFile" name="imgUrlAddress"/>
                                        </p>
                                        <p>
                                            图片指向链接：<input class="testInput" name="newsLink" type="text" value='${nt.newsLink}'/>
                                        </p>
                                        <input type="hidden" name="id" value="${nt.id}"/>
                                        <input type="hidden" name="type" value="${nt.type}"/>
                                        <input class="button setBtnWidth" type="button" value="更新" onclick="update(this)"/>
                                    </div>
                                    <div class="imgPreview">
                                        <div class="tupianword">图片预览：</div>
                                        <img src="${nt.imgUrl}" id="${nt.id}" alt="" />
                                    </div>
                                </div>
                            </c:forEach>

						</div>
					</div>
				</div>
				<jsp:include page="bottom.jsp" />
			</div>
			<script type="text/javascript">
				load('${ctx}');
			</script>
	</body>
</html>
