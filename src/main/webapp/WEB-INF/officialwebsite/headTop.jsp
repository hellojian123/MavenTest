<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<jsp:include page="head.jsp"/>
<div id="templatemo_middle_sub">
	<div id="example">
		<div id="slides">
			<div class="slides_container">
				<c:forEach items="${headShow}" var="gg">
					<div class="slide">
	                       <img src="${gg.imgUrl}" />
					</div>
				</c:forEach>	
			</div>
			<a href="javascript:void(0)" class="prev"><img src="${ctx}/matter/images/img/arrow-prev.png" width="24" height="43" alt="ArrowPrev"/></a>
			<a href="javascript:void(0)" class="next"><img src="${ctx}/matter/images/img/arrow-next.png" width="24" height="43" alt="ArrowNext"/></a>
		</div>
	</div>
</div>