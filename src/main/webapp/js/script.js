/**
 * @fileOverview
 * js for nws website
 * @author zhaoyang <11919915@qq.com>
 * @version 2011-07-30
 */
 $(document).ready(function () {
/*左边展开、收起效果*/

$(".left_box dl dd").toggle(
	   function () {
            $(this).css("background-image", "url(images/left_hover.jpg)");
            $(this).parent().find("dt").slideDown(200);
            return false;
        },										
        function () {
            $(this).css("background-image", "");
			//$(this).parent().parent().find("dd").css("color","red");
            $(this).parent().find("dt").slideUp(200);
            return false;
        }
        
    );

$("#demo").toggle(
		   function () {
	            $(this).css("background-image", "url(images/left_hover.jpg)");
	            $(this).parent().find("dt").slideDown(200);
	            return false;
	        },										
	        function () {
	            $(this).css("background-image", "url(images/left_y.jpg)");
				//$(this).parent().parent().find("dd").css("color","red");
	            $(this).parent().find("dt").slideUp(200);
	            return false;
	        }
	        
	    );
 
});

 function fenyeComment(maxPage,curPage,url,args){
		var str = "";
		if(maxPage == 0){
			str = "没有评论";
			$("#fenye").empty();
			$("#fenye").append(str);
			return;
		}
		var tempPage = curPage - 1;
		
		if(curPage == 1){
			str += "<a href=\"javascript:void(0)\" class=\"noxz\">首页</a>";
			str += "<a href=\"javascript:void(0)\" class=\"noxz\">上一页</a>";
		}else{
			str += "<a href=\""+url+"?curPage=1";
			if(args != undefined && args != null && args != ""){
				str += "&"+args;
			}
			str += "\">首页</a>";
			
			str += "<a href=\""+url+"?curPage="+tempPage;
			if(args != null && args.length > 0){
				str += "&"+args;
			}
			str += "\">上一页</a>";
		}
		if(maxPage<=7){
			for(var i = 1;i<=maxPage;i++){
				if(i==curPage){
					str += "<b class=\"current\">"+i+"</b>";
				}else{
					str += "<a href=\""+url+"?curPage="+i;
					if(args != null && args.length > 0){
						str += "&"+args;
					}
					str += "\">"+i+"</a>";
				}
			}
		}else{
			var minCur = curPage - 4;
			var maxCur = curPage + 3;
			var topStr = "";
			var endStr = "";
			if(curPage >= 6){
				topStr = "<a href=\""+url+"?curPage="+1+"&"+args+"\">"+1+"</a>...";
				str += topStr;
			}
			if(curPage <= maxPage - 3){
				endStr = "...<a href=\""+url+"?curPage="+maxPage+"&"+args+"\">"+maxPage+"</a>";
			}
			for(var i = 1;i<=maxPage;i++){
				
				if(minCur > 1){
					
					if(i==curPage){
						str += "<b class=\"current\">"+i+"</b>";
					}else if(minCur < i && maxCur > i){
						str += "<a href=\""+url+"?curPage="+i+"&"+args+"\">"+i+"</a>";
					}
					
				}else if(i<=6 && curPage <= 6){
					if(i==curPage){
						str += "<b class=\"current\">"+i+"</b>";
					}else{
						str += "<a href=\""+url+"?curPage="+i+"&"+args+"\">"+i+"</a>";
					}
				}
			}
			str = str + endStr ;
		}
		
		if(curPage == maxPage){
			str += "<a href=\"javascript:void(0)\" class=\"noxz\">下一页</a>";
			str += "<a href=\"javascript:void(0)\" class=\"noxz\">末页</a>";
		}else{
			var curArgs = "";
			if(args != undefined && args != null && args != ""){
				curArgs = "&"+args;
			}
			str += "<a href=\""+url+"?curPage="+(++curPage)+curArgs+"\">下一页</a>";	
			str += "<a href=\""+url+"?curPage="+maxPage+curArgs+"\">末页</a>";
		}
		return str;
	}
 function fenyeCommentAjax(maxPage,curPage,url,args){
		var str = "";
		if(maxPage == 0){
			str = "没有评论";
			$("#fenye").empty();
			$("#fenye").append(str);
			return;
		}
		var tempPage = curPage - 1;
		
		if(curPage == 1){
			str += "<a href=\"javascript:void(0)\" class=\"noxz\">首页</a>";
			str += "<a href=\"javascript:void(0)\" class=\"noxz\">上一页</a>";
		}else{
			str += "<a href=\""+url+"1)";
			if(args != undefined && args != null && args != ""){
				str += "&"+args;
			}
			str += "\">首页</a>";
			
			str += "<a href=\""+url+tempPage +")";
			if(args != null && args.length > 0){
				str += "&"+args;
			}
			str += "\">上一页</a>";
		}
		if(maxPage<=7){
			for(var i = 1;i<=maxPage;i++){
				if(i==curPage){
					str += "<b class=\"current\">"+i+"</b>";
				}else{
					str += "<a href=\""+url+i +")"; 
					if(args != null && args.length > 0){
						str += "&"+args;
					}
					str += "\">"+i+"</a>";
				}
			}
		}else{
			var minCur = curPage - 4;
			var maxCur = curPage + 3;
			var topStr = "";
			var endStr = "";
			if(curPage >= 6){
				topStr = "<a href=\""+url+1+")"+"\">"+1+"</a>...";
				str += topStr;
			}
			if(curPage <= maxPage - 3){
				endStr = "...<a href=\""+url+maxPage+")"+"\">"+maxPage+"</a>";
			}
			for(var i = 1;i<=maxPage;i++){
				
				if(minCur > 1){
					
					if(i==curPage){
						str += "<b class=\"current\">"+i+"</b>";
					}else if(minCur < i && maxCur > i){
						str += "<a href=\""+url+i+")"+"\">"+i+"</a>";
					}
					
				}else if(i<=6 && curPage <= 6){
					if(i==curPage){
						str += "<b class=\"current\">"+i+"</b>";
					}else{
						str += "<a href=\""+url+i+")"+"\">"+i+"</a>";
					}
				}
			}
			str = str + endStr ;
		}
		
		if(curPage == maxPage){
			str += "<a href=\"javascript:void(0)\" class=\"noxz\">下一页</a>";
			str += "<a href=\"javascript:void(0)\" class=\"noxz\">末页</a>";
		}else{
			var curArgs = "";
			if(args != undefined && args != null && args != ""){
				curArgs = "&"+args;
			}
			str += "<a href=\""+url+(++curPage)+")"+"\">下一页</a>";	
			str += "<a href=\""+url+maxPage+")"+"\">末页</a>";
		}
		return str;
	}
 function getPageDomain(){
		//获取当前网址，如： http://localhost:8080/manage/admin/login.jsp
	    var completePath=window.document.location.href;
	    //获取主机地址之后的目录，如： manage/admin/login.jsp
	    var pathName=window.document.location.pathname;
	    var pos=completePath.indexOf(pathName);
	    //获取主机地址，如： http://localhost:8080
	    var hostPath=completePath.substring(0,pos);
	    //获取带"/"的项目名，如：/manage
	    var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
	    if(hostPath .indexOf("localhost") > -1 || hostPath.indexOf("127.0.0.") > -1
	    		|| hostPath .indexOf("10.0.0") > -1 || hostPath .indexOf("192.168.") > -1){
	    	 return(hostPath+projectName); 
	    }
	    return(hostPath);
	}