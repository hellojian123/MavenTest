<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
	<div id="site_title"><a href="#">logo</a></div>
    	<div class="logom"><b>&nbsp;${webName}</b>
        <div id="templatemo_menu" class="ddsmoothmenu">
            <ul>
                 <li><a href="${ctx}/officialwebsite/index" <c:if test="${typeid==0}">class="selected radius1"</c:if>>首页</a></li>
                <li><a href="${ctx}/queryArticleListById?curPage=1&article.typeid=1"  <c:if test="${article.typeid==1||article.typeid==2}">class="selected radius1"</c:if> >新闻中心</a>
                   <ul>
                			<li><a href="${ctx}/queryArticleListById?curPage=1&article.typeid=1">公司新闻</a></li>
                			<li><a href="${ctx}/queryArticleListById?curPage=1&article.typeid=2">行业动态</a></li>
            	   </ul>
                </li>
                
               <li><a href="${ctx}/intoSuccessCase" <c:if test="${article.typeid==3}">class="selected radius1"</c:if>>成功案例</a></li>
                   
                <li><a href="${ctx}/getArticleByTypeid?article.typeid=4" <c:if test="${article.typeid==4}">class="selected radius1"</c:if>>业务体系</a></li>
                <li><a href="${ctx}/getArticleByTypeid?article.typeid=5" <c:if test="${article.typeid==5}">class="selected radius1"</c:if>>人才招聘</a></li>
                <li><a href="${ctx}/getArticleByTypeid?article.typeid=7" <c:if test="${article.typeid==6||article.typeid==7||article.typeid==8||article.typeid==9}">class="selected radius1"</c:if>>关于我们</a>
                    <ul>
                			<li><a href="${ctx}/getArticleByTypeid?article.typeid=7">公司介绍</a></li>
                            <li><a href="${ctx}/getArticleByTypeid?article.typeid=8">组织架构</a></li>
                			<li><a href="${ctx}/getArticleByTypeid?article.typeid=9">发展历程</a></li>
                			<li><a href="${ctx}/getArticleByTypeid?article.typeid=6">公司愿景</a></li>
            		</ul>
                </li>
                <li><a href="${ctx}/getArticleByTypeid?article.typeid=10" <c:if test="${article.typeid==10}">class="selected radius1"</c:if>>联系我们</a></li>
            </ul>
            <br style="clear: left" />
        </div> <!-- end of templatemo_menu -->
    </div>

