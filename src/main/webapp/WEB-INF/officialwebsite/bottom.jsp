<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>



<script>    window._bd_share_config = { "common": { "bdSnsKey": {}, "bdText": "", "bdMini": "2", "bdMiniList": false, "bdPic": "", "bdStyle": "0", "bdSize": "16" }, "slide": { "type": "slide", "bdImg": "6", "bdPos": "right", "bdTop": "180.5"} }; with (document) 0[(getElementsByTagName('head')[0] || body).appendChild(createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion=' + ~(-new Date() / 36e5)];</script>

<div id="templatemo_footer_wrapper">
    <div class="foot_nav">
  			 <span>友情链接:</span>
                <c:forEach items="${friendLinks }" var="sfdl">
	                <a href="http://${sfdl.linkUrl}" target="_blank" title="${sfdl.linkName}">${sfdl.linkName}</a>
                </c:forEach>
    </div>
    
	<div id="templatemo_footer" class="wrapper">  
                                                地址：四川省成都市锦江区红星路3段99号银石广场1304号
               <a href="#" target="_blank"><img src="${ctx}/matter/images/templatemo_logo1.png" /></a>
                                                电话(TEL)：028-86381666 传真(FAX)：68951888<br/>
                                                版权所有©2014-2015 四川省成都市锦江区红星路3段99号银石广场1304号. 保留所有权利.<br/>
    </div>
</div>