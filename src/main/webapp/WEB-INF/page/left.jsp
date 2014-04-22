<%--
  Created by IntelliJ IDEA.
  User: hejian
  Date: 14-4-21
  Time: 上午10:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglibs.jsp"%>

<div class="list_cont">
	<div class="list_nav">
		<c:if test="${typeid==1||typeid==2}"><%--新闻资讯--%>
			<ul>
				<li class="classfi no_border">${parentTitle}</li>
				<li><a href="${ctx}/article/queryArticleListById?typeid=1">公司新闻</a></li>
				<li><a href="${ctx}/article/queryArticleListById?typeid=2">行业动态</a></li>
			</ul>
		</c:if>
		<c:if test="${typeid==3}"><%--案列展示--%>
			<ul>
				<li class="classfi no_border">${parentTitle}</li>
				<li><a href="${ctx}/article/queryArticleListById?typeid=3">成功案例</a></li>

			</ul>
		</c:if>
		<c:if test="${typeid==6||typeid==10||typeid==5||typeid==7||typeid==8||typeid==9}"><%--服务支持--%>
			<ul>
				<li class="classfi no_border">${parentTitle}</li>
				<li><a href="${ctx}/article/queryArticleListById?typeid=6">业务体系</a></li>
				<li><a href="${ctx}/article/queryArticleListById?typeid=10">业务流程</a></li>
				<li><a href="${ctx}/article/queryArticleListById?typeid=5">人才招聘</a></li>
				<li><a href="${ctx}/article/queryArticleListById?typeid=7">网站建设</a></li>
				<li><a href="${ctx}/article/queryArticleListById?typeid=8">系统开发</a></li>
				<li><a href="${ctx}/article/queryArticleListById?typeid=9">APP开发</a></li>
			</ul>
		</c:if>
		<c:if test="${typeid==4}"><%--关于我们--%>
			<ul>
				<li class="classfi no_border">关于我们</li>
				<li><a href="${ctx}/article/queryArticleListById?typeid=4">公司介绍</a></li>
			</ul>
		</c:if>

	</div><!--list_nav end-->
	<!-- - - - - - - - - - - - - - list_tact - - - - - - - - - - - - - - - - -->
	<div class="list_tact">
		<ul>
			<li>联系方式：</li>
			<li class="classday">18628299230</li>
			<li class="classday">18284091520</li>
			<li>咨询时间：周一至周六</li>
			<li>09:00~18:00</li>
		</ul>
	</div><!--list_tact end-->
	<!-- - - - - - - - - - - - - - list_tact - - - - - - - - - - - - - - - - -->
</div>
