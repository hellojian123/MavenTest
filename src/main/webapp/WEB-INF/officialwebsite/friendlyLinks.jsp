<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
	 <div class="links">
                <span>友情链接:</span>
                <c:forEach items="${friendLinks}" var="link" >
                	<a href="http://${link.linkUrl}" target="_blank" title="${link.linkName}">${link.linkName}</a>	
                </c:forEach>
     </div>
     <div class="end">
     	<span class="gray">四川省风靡网络科技有限公司 提供技术支持</span><br />
        <span class="gray">ICP备案证书号：蜀ICP备13019000号</span><br />
        <span class="gray">&copy;Copyright :copyright: 2013-2014, All Rights Reserved</span><br/>
     </div>