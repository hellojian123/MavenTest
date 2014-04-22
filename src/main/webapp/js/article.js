var articleid="";
var title="";
var content="";
var imgUrl="";
var articleType="";
var keywords="";
var source="";

/**
 * 客户端校验输入数据
 * @returns {boolean}
 */
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

/**
 * 根据多个id删除数据
 * @param {Object} prefix
 */
function delByIds(prefix){
	var args = location.search;   
    var reg = new RegExp('[\?&]?currentPage=([^&]*)[&$]?', 'gi');   
    var chk = args.match(reg);   
   	var currentPage = RegExp.$1;
	var ids="";
	var i=0;
	var arr = new Array();
	$("input[type='checkbox']").each(function(){
		if($(this).attr("checked")){
			if($(this).val()!="on"&&this.name=='xidx'){
				ids += $(this).val()+",";
				arr[i] = $(this).parent().parent();
				i++;
			}
		}
	});
	var dot = ids.lastIndexOf(",");
	if(dot==-1){
		alert("请先选择要删除的选项");
		return;
	}else{
		ids = ids.substring(0,dot);
	}
	if(window.confirm("选中了"+i+"条数据，确认删除？")){
		location.href=prefix+"/admin/article/batchDeleteArticleById?ids="+ids+"&currentPage="+currentPage;
	}
}
/**
 * 修改文章信息
 * @param {Object} prefix
 * @param {Object} id
 */
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


