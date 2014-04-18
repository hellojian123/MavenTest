<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>出错啦！</title>
  </head>
  
  <body>
    	<script type="text/javascript" src="http://www.qq.com/404/search_children.js" charset="utf-8"></script>
  </body>
</html>
