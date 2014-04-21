<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<style type="text/css">
			body{
				display: none;
			}
		</style>
		<title>文章管理</title>
		<%@include file="/common/common.jsp"%>
		<script type="text/javascript" src="${ctx}/js/page.js"></script>
		<script type="text/javascript" src="${ctx}/js/article.js"></script>
		<script type="text/javascript" src="${ctx}/js/FilterHtml.js"></script>
		<script type="text/javascript" src="${ctx}/date/WdatePicker.js"></script>
		<script type="text/javascript" src="${ctx}/js/article.js"></script>
		<script charset="utf-8" src="${ctx}/editor/kindeditor.js"></script>
		<script charset="utf-8" src="${ctx}/editor/lang/zh_CN.js"></script>
        <script type="text/javascript" src="${ctx}/js/ajaxfileupload.js"></script>
		<script type="text/javascript">
		var editor;
		KindEditor.ready(function(K){
				editor = K.create('#content', {
					uploadJson : '${ctx}/editor/jsp/upload_json.jsp',
					fileManagerJson : '${ctx}/editor/jsp/file_manager_json.jsp',
					allowPreviewEmoticons : true,
					allowFileManager : true,
                    height:"280%"
				});
		});
		var articleid="";
		var title="";
		var content="";
		var imgUrl="";
		var articleType="";
		var keywords="";
		var source="";
		function validate(){
				title=$("#title").val();
				content=editor.html();
				var main=$("#main").css("display");
				if(main=="block"){//说明当前显示的是文章类型主模块
					articleType=$("#articleType").val();
				}else{
					articleType=$("#articleTypeMinor").val();
				}
				if($.trim(title)==""){
					alert("标题不能为空！");
					return false;
				}
				if($.trim(content)==""){
					alert("内容不能为空！");
					return false;
				}
				var display=$("#previewImgP").css("display");
				if($.trim(display)=='block'){
					imgUrl=$("#imgUrlAddress").attr("src");
					if(imgUrl==""){
						alert("请上传该成功案例的预览图！");
						return false;
					}
				}
				if($.trim(title).length>30){
					alert("标题字数不能超过30个！");
					return false;
				}
				if(articleType=="0"){
					alert("请选择文章所属模块！");
					return false;
				}
				keywords=$("#keywords").val();
				source=$("#source").val();
				return true;
		}
		
		function saveOrUpdateArticle(){
			if(validate()){
				articleid=$("#articleid").val();
				$.post("${ctx}/admin/article/saveOrUpdateArticle",{"article.id":articleid,"article.title":title,"article.content":content,"article.previewImg":imgUrl,"article.typeid":articleType,"article.keywords":keywords,"article.source":source},function(data){
					if(data=="0"){
						alert("添加成功！");
					}else if(data=="1"){
						alert("添加失败！");
					}else if(data=="2"){
						alert("更新成功！");
					}else if(data=="3"){
						alert("更新失败！");
					}
					location.href="${ctx}/admin/article?currentPage=${currentPage}";
				});

			}
		}
		
			$(document).ready(function(){
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
						//$("#role").html("添加新文章");
						return false; 
					}
				);
				$('tbody tr:even').addClass("alt-row");
				$('.check-all').click(
					function(){
						$(this).parent().parent().parent().parent().find("input[type='checkbox']").attr('checked', $(this).is(':checked'));   
					}
				);
				
				$(".close").click(
					function () {
						$(this).parent().fadeTo(400, 0, function () { // Links with the class "close" will close parent
							$(this).slideUp(400);
						});
						return false;
					}
				);
				//给导航名赋值   使其选中
				$("#selectArticleType").val(${menuTypeId});
				
				$(".deleteArticle").click(function(){
					var articleId=$(this).attr("articleId");
					var articleTitle=$(this).attr("articleTitle");
			    	var sure=confirm("确认删除标题为"+articleTitle+"的文章吗？");
					if(sure){
						$.post("${ctx}/admin/article/deleteArticleById",{articleId:articleId},function(data){
								if(data=="0"){
									alert("删除成功！");
									location.href="${ctx}/admin/article?currentPage=${currentPage}";
								}else{
									alert("删除失败！");
								}
						});
					}
					return false;
				});
				$("#articleType").change(function(){
					var type=$(this).val();
					if(type==3){//显示预览图地址
						$("#previewImgP").css("display","block");
					}else{//隐藏预览图地址
						$("#previewImgP").css("display","none");
					}
					//alert(type);
				});
				document.body.style.display="block";
			});	
			
			function edit(prefix,id,editor){
				var url=prefix+"/admin/article/find";
				$.getJSON(url,{"id":id},function(data){
						data=$.parseJSON(data);
						$("#articleid").val(data.id);
						$("#title").val(data.title);
						editor.html(data.content);
						$("#keywords").val(data.keywords);
						$("#imgUrlAddress").attr("src",data.previewImg);
						$("#source").val(data.source);
						if(data.typeid!=1&&data.typeid!=2&&data.typeid!=3&&data.typeid!=11){// 除公司新闻   行业动态  成功案例以外的其他新闻
							$("#articleTypeMinor").val(data.typeid);
							$('#main').css('display','none');
							$('#minor').css('display','block');
						}else{//公司新闻   行业动态  媒体资讯   成功案例 
							$("#articleType").val(data.typeid);
							$('#minor').css('display','none');
							$('#main').css('display','block');
							if(data.typeid==3){
								$("#previewImgP").css("display","block");
							}
						}
						var a = $('.content-box ul.content-box-tabs li a');
						$(a).parent().siblings().find("a").removeClass('current');
						$(a).addClass('current');
						$("#role").html("修改文章");
						$(".default-tab").removeClass('current');
						$("#tab1").hide(); 
						$("#tab2").show();
				});
			}
        function uploadimage(file){
            var id = $("#foodId").val();
            $.ajaxFileUpload({
                url:'${ctx}/editor/jsp/upload_json.jsp',
                secureuri:false,
                fileElementId:"previewImgUrl",
                dataType: 'json',
                success: function (data, status)
                {
                    if(data.error==0){//成功
                        $("#imgUrlAddress").attr("src",data.url);
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
		<style type="text/css">
			label{
				float: left;
			}
		</style>
	</head>
	<body style="background-image: none;">
			<div id="main-content" style="width: 100%;height: 120%;margin-left: 0px;">
				<div class="content-box">
					<div class="content-box-header">
						<h3>
							文章管理
						</h3>
						<ul class="content-box-tabs">
							<li>
								<a href="#tab1" class="default-tab">文章信息列表</a>
							</li>
							<li>
								<a href="#tab2" id="role">添加新文章</a>
							</li>
						</ul>

						<div class="clear"></div>

					</div>
					<div class="content-box-content">
						<div class="tab-content default-tab" id="tab1">
							<div class="notification attention png_bg">
								<a href="#" class="close">
                                    <img src="${ctx}/images/icons/cross_grey_small.png" title="Close this notification" alt="close" />
								</a>
								<div>
								<form action="${ctx}/admin/article" method="get">
									<input type="hidden" name="currentPage" value="${currentPage}">
									导航名
									<select id="selectArticleType" name="selectArticleType">
											<option value="0">不限</option>
											<option value="1">公司新闻</option>
											<option value="2">行业动态</option>
											<option value="3">成功案例</option>
											<option value="4">公司介绍</option>
											<option value="5">人才招聘</option>
											<option value="6">业务体系</option>
											<option value="7">网站建设</option>
											<option value="8">系统开发</option>
											<option value="9">APP开发</option>
											<option value="10">业务流程</option>
										</select>
									 时间<input class="Medium-input" type="text" onClick="WdatePicker()" id="pubtime" name="date" size="8" value="${date}" />
										<input type="submit" value="  查  询 " class="button"/>
									</form>
									</input>
								</div>
							</div>

							<table>

								<thead>
									<tr>
										<th>
											<input class="check-all" type="checkbox" />
										</th>
										<th>
											序号
										</th>
										<th>
											文章标题
										</th>
										<th>
											关键字
										</th>
										<th>
											所属模块
										</th>
										<th>
											创建时间
										</th>
										<th>
											操作
										</th>
									</tr>

								</thead>

								<tfoot>
									<tr>
										<td colspan="7">
											<div class="bulk-actions align-left">
												<a class="button" href="javascript:delByIds('${ctx}');">删除选定</a>
											</div>
											<!-- 分页信息 -->
											<div class="pagination"> 
												<c:if test="${pm.result ne null}">
												<script>
													var pg = new showPages('pg');
													pg.pageCount = ${pm.maxPage};
													pg.argName = 'currentPage';
													pg.printHtml();  
												</script>
												</c:if>
											</div>
											<!-- End .pagination -->
											<div class="clear"></div>
										</td>
									</tr>
								</tfoot>
								<!-- 数据展示 -->
								<tbody id="datalist">
									<c:choose>
										<c:when test="${pm.result eq null}">
											<tr>
												<td colspan="7">没有文章分类信息，请先添加</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="article" items="${pm.result}" varStatus="status">
												<tr id="r${article.id}">
													<td><input type="checkbox" name="xidx" value="${article.id}"/></td>
													<td>${status.index+1}</td>
													<td>${fn:substring(article.title,0,10)}</td>
													<td>${fn:substring(article.keywords,0,8)}</td>
													<td>
														<c:if test="${article.typeid==1}">公司新闻</c:if>
														<c:if test="${article.typeid==2}">行业动态</c:if>
														<c:if test="${article.typeid==3}">成功案例</c:if>
														<c:if test="${article.typeid==4}">公司介绍</c:if>
														<c:if test="${article.typeid==5}">人才招聘</c:if>
														<c:if test="${article.typeid==6}">业务体系</c:if>
														<c:if test="${article.typeid==7}">网站建设</c:if>
														<c:if test="${article.typeid==8}">系统开发</c:if>
														<c:if test="${article.typeid==9}">APP开发</c:if>
														<c:if test="${article.typeid==10}">业务流程</c:if>
													</td>
													<td>
														<fmt:formatDate value="${article.modifyDate}" pattern="yyyy/MM/dd"/>
													</td>												
													<td>
															<a href="javascript:void(0)" class="deleteArticle" articleId="${article.id}" articleTitle="${article.title}" title="删除文章">
																<img src="${ctx}/images/icons/cross.png" alt="删除文章" />
															</a>
														<a href="javascript:edit('${ctx}',${article.id},editor)" title="修改文章"><img src="${ctx}/images/icons/hammer_screwdriver.png" alt="修改文章" /></a>
													</td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
									
								</tbody>

							</table>

						</div>
						<!-- End #tab1 -->

						<div class="tab-content" id="tab2">
								<fieldset>
								<form action="${ctx}/admin/article/add" method="post" id="mainform">
									<input type="hidden" value="" id="articleid"/>
									<p>
										<label style="color: red;">
											文章标题：
										</label>
										<input class="text-input small-input" type="text" id="title" name="a.title" />

										<span class="input-notification attention png_bg">输入文章的标题信息</span>
										<br />
									</p>
									<p>
										<label style="color: red;">
											文章内容：
										</label>
										<span class="input-notification attention png_bg"> 文章内容在网站上属于哪个模块</span>
											<textarea style="width:100%;height:400px" id="content">
												
											</textarea>
										<br/>
									</p>										
									<p id="main">
										<label style="color: red;">
											所属模块：
										</label>
										<select id="articleType" name="color">
                                            <option value="0">不限</option>
                                            <option value="1">公司新闻</option>
                                            <option value="2">行业动态</option>
                                            <option value="3">成功案例</option>
                                            <option value="4">公司介绍</option>
                                            <option value="5">人才招聘</option>
                                            <option value="6">业务体系</option>
                                            <option value="7">网站建设</option>
                                            <option value="8">系统开发</option>
                                            <option value="9">APP开发</option>
                                            <option value="10">业务流程</option>
										</select>
										<span class="input-notification attention png_bg"> 文章内容在网站上属于哪个模块</span><br/>
									</p>
									
									<p id="minor" style="display:none">
										<label style="color: red;">
											所属模块：
										</label>
										<select id="articleTypeMinor" name="color" disabled="disabled">
                                            <option value="1">公司新闻</option>
                                            <option value="2">行业动态</option>
                                            <option value="3">成功案例</option>
                                            <option value="4">公司介绍</option>
                                            <option value="5">人才招聘</option>
                                            <option value="6">业务体系</option>
                                            <option value="7">网站建设</option>
                                            <option value="8">系统开发</option>
                                            <option value="9">APP开发</option>
                                            <option value="10">业务流程</option>
										</select>
										<span class="input-notification attention png_bg"> 文章内容在网站上属于哪个模块</span><br/>
									</p>
									<%--<p id="previewImgP" style="display:none">

										<label>
											&nbsp;&nbsp;&nbsp;预览图：
										</label>
										<input class="text-input Medium-input" type="text" id="previewImgUrl" />
										<span class="input-notification information png_bg">该成功案列的预览图地址</span><br/>
									</p>--%>
									<p>
										<label>
											&nbsp;&nbsp;&nbsp;关键字：
										</label>
										<input class="text-input Medium-input" type="text" id="keywords" name="keywords" />
										<span class="input-notification information png_bg">文章的关键字信息,以逗号分隔</span>
										<br />
									</p>
									<p>
										<label>
											文章来源：
										</label>
										<input class="text-input Medium-input" type="text" id="source" name="a.source" />
										<span class="input-notification information png_bg">文章的来源信息,默认为原创</span>
										<br/>
									</p>
                                    <P id="previewImgP" style="display:none">
                                        <label style="color: red;">
                                            上传预览图：
                                        </label>
                                        <input style="width:137px;"  class="testInput" name="previewImgUrl" id="previewImgUrl" type="file" value='${poster.imgUrl}'/>
                                        <input class="button setBtnWidth" type="button" value="上传" onclick="uploadimage()" style="width:50px;" id="uploadImg" foodId="${food.id}"/><br/>
                                        <img src="" width="725px" height="150px" style="border:1px #555 solid;" id="imgUrlAddress"  />
                                    </P>
									<p>
											<input class="button" type="button" style="width:90px;margin-left:70px;" onclick="saveOrUpdateArticle()" value="保存"/>
									</p>
									</form>
								</fieldset>
								<div class="clear"></div>
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
