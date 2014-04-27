package com.util;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


public class DeleteImgByHtml {
	
	/**
	 * 删除文章中的图片 返回删除失败的图片集合
	 */
	public static List<String> deleteArticleImgs(HttpSession session,String htmlStr) {
		List<String> faildImgSrcs=new ArrayList<String>();//统计删除失败的图片集合
		List<String> imgSrcs=getImgStr(htmlStr);//获取文章中的图片路径
		for (String imgSrc : imgSrcs) {
			String path=session.getServletContext().getContextPath();//项目名
			String projectPath=session.getServletContext().getRealPath("/");//项目路径
			String realPath=projectPath.substring(0, projectPath.length()-path.length());//项目所在的web容器路径
			String imgRealPath=realPath.substring(0, realPath.length()-1)+imgSrc;//图片路径
			String newImgSrc=imgRealPath.replace("/", File.separator).replace("\\", File.separator);//处理不同系统 文件夹路径分隔符不同的问题
			File file=new File(newImgSrc);
			if(file.exists()){
				file.delete();
			}else{
				faildImgSrcs.add(newImgSrc);
			}
		}
		return faildImgSrcs;
	}
	
	/**
	 * 从html代码中获取图片标签的src路径
	 */
	public static List<String> getImgStr(String htmlStr) {
		String regxpForImgTag = "<\\s*img\\s*(?:[^>]*)src\\s*=\\s*([^>]+)";
		String img = "";
		Pattern p_image;
		Matcher m_image;
		List<String> pics = new ArrayList<String>();
		p_image = Pattern.compile(regxpForImgTag,  
	            Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
		m_image = p_image.matcher(htmlStr);
		while (m_image.find()) {
			img = img + "," + m_image.group();
			Matcher m = p_image.matcher(img);
			while (m.find()) {
				String tempSrc= m.group(1);
				String src=tempSrc.substring(1, tempSrc.length()-10);
				pics.add(src);
			}
		}
		return pics;
	}
	
	/**
	 * 根据存储在数据库中的图片路径删除服务器上的图片(客户端上传到服务器的图片，如首页滚动大图或文章预览图)
	 * @param imgSrc 图片路径
	 */
	public static void deletePicture(HttpServletRequest req, String imgSrc){
		String path = System.getProperty("user.dir");
		String webappName = path.substring(path.lastIndexOf("\\"));
		String realPic = path+"/target/"+webappName+imgSrc;
		/*
		String path=req.getServletContext().getContextPath();//项目名
		String pathPic = req.getSession().getServletContext().getRealPath("/");
		String realPic=pathPic.substring(0, pathPic.length()-(path.length()+1))+imgSrc;
		*/
		String newImgSrc=realPic.replace("/", File.separator).replace("\\", File.separator);//处理不同系统 文件夹路径分隔符不同的问题
		File file = new File(newImgSrc);
		if(file.exists()){
			file.delete();
		}

	}
	
	/**
	 * 判断指定图片是否存在于指定集合中  存在返回false 不存在返回true
	 * @param imgList	图片集合
	 * @param img		图片
	 * @return
	 */
	public static Boolean isNewImg(List<String> imgList,String img){
		for (String string : imgList) {
			if(string.equals(img)){
				return false;
			}
		}
		return true;
	}
	
	/**
	 * 指定图片在图片集合中没有   就删除指定图片
	 * @param oldImgList 文章中原有的图片集合
	 * @param newImgList 从前台获取的文章中最新的图片集合
	 */
	public static void delOldArticleImgs(List<String> oldImgList,List<String> newImgList,HttpServletRequest req){
		
		for (String oldImg : oldImgList) {
			if(isNewImg(newImgList,oldImg)){
				deletePicture(req, oldImg);
			}
		}
	}
	
}






