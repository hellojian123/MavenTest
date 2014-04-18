<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<div class="half left"> 

         <ul class="templatemo_list">
         		<strong>
		<c:if test="${article.typeid==1||article.typeid==2||article.typeid==11}">新闻中心</c:if>
		<c:if test="${article.typeid==3}">成功案例</c:if>
		<c:if test="${article.typeid==4}">业务体系</c:if>
		<c:if test="${article.typeid==5}">人才招聘</c:if>
		<c:if test="${article.typeid==6||article.typeid==7||article.typeid==8||article.typeid==9}">关于东鹰</c:if>
		<c:if test="${article.typeid==10}">联系我们</c:if>
		</strong>
                 	<c:if test="${article.typeid==1||article.typeid==2||article.typeid==11}">
				       <li><a href="${ctx}/queryArticleListById?currentPage=1&article.typeid=1">公司新闻</a></li>
				       <li><a href="${ctx}/queryArticleListById?currentPage=1&article.typeid=2">行业动态</a></li>
				    </c:if>
				    <c:if test="${article.typeid==3}">
				       <li><a href="${ctx}/queryArticleListById?currentPage=1&article.typeid=3">成功案例</a></li>
				    </c:if>
				    <c:if test="${article.typeid==4}">
				       <li><a href="${ctx}/getArticleByTypeid?article.typeid=4">业务体系</a></li>
				    </c:if>
				    <c:if test="${article.typeid==5}">
				       <li><a href="${ctx}/getArticleByTypeid?article.typeid=5">人才招聘</a></li>
				    </c:if>
				    <c:if test="${article.typeid==6||article.typeid==7||article.typeid==8||article.typeid==9}">
				       <li><a href="${ctx}/getArticleByTypeid?article.typeid=7">公司介绍</a></li>
				       <li><a href="${ctx}/getArticleByTypeid?article.typeid=8">组织架构</a></li>
				       <li><a href="${ctx}/getArticleByTypeid?article.typeid=9">发展历程</a></li>
				       <li><a href="${ctx}/getArticleByTypeid?article.typeid=6">公司愿景</a></li>
				    </c:if>
				    <c:if test="${article.typeid==10}">
				       <li><a href="${ctx}/getArticleByTypeid?article.typeid=10" >联系我们</a></li>
				    </c:if>
                 
         </ul>
</div>