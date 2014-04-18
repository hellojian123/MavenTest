package com.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.nutz.dao.Cnd;
import org.nutz.dao.FieldFilter;
import org.nutz.ioc.Ioc;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.view.JspView;
import org.nutz.trans.Atom;

import com.bean.Article;
import com.bean.NewsTemplate;
import com.dao.ArticleDao;
import com.dao.NewsTemplateDao;
import com.dao.UserDao;
import com.google.gson.Gson;
import com.sun.org.apache.bcel.internal.classfile.PMGClass;
import com.sun.org.apache.bcel.internal.generic.NEW;
import com.util.CheckSession;
import com.util.DataDispose;
import com.util.FilterHTMLTag;
import com.util.PageModel;
import com.util.SystemContext;

/**
 * 官网模块
 * @author Administrator
 *
 */
@SuppressWarnings("unchecked")
public class OfficialWebsite {
	/**
	 * 官网首页
	 * @param ioc
	 * @param req
	 * @return
	 */
	@At("/officialwebsite/index")
	public View manageIndex(Ioc ioc , HttpServletRequest req){
		final Object[] objs = new Object[4];
		final ArticleDao dao = new ArticleDao(ioc);
		NewsTemplateDao ntDao=new NewsTemplateDao(ioc);
		FieldFilter.create(Article.class, "(^id|title|previewImg|content$)").run(new Atom() {
			public void run() {
				objs[0] = dao.searchByPage(Article.class, Cnd.where("typeid", "=", "2").desc("modifyDate"), 1, 3);//六条行业动态
				objs[1] = dao.searchByPage(Article.class, Cnd.where("typeid", "=", "11").desc("modifyDate"), 1, 6);//六条媒体资讯
				objs[2] = dao.searchByPage(Article.class, Cnd.where("typeid", "=", "1").desc("modifyDate"), 1, 5);//五条公司新闻
				objs[3] = dao.searchByPage(Article.class, Cnd.where("typeid", "=", "3").desc("modifyDate"), 1, 5);//5条成功案例
			}
		});
		//公司介绍
		Article introduce=dao.findByCondition(Article.class, Cnd.where("typeid", "=",7));
		
		//查六条行业动态                                                                 
		List<Article> casus= (List<Article>)objs[0];
		//六条媒体资讯
		List<Article> information= (List<Article>)objs[1];
		//查五条公司新闻
		List<Article> companyNews= (List<Article>)objs[2];
		//两条成功案例
		List<Article> successfulCase= (List<Article>)objs[3];
													
		//查出在首页显示的滚动图片							
		List<NewsTemplate> bigImages= ntDao.search(NewsTemplate.class, Cnd.where("type", "=", "1"));
        //查出在首页显示的新闻图片
		List<NewsTemplate> pic= ntDao.search(NewsTemplate.class, Cnd.where("type", "=", "2"));
		
		req.setAttribute("typeid",0);
		req.setAttribute("introduce", introduce);	 //公司介绍
		req.setAttribute("information", information);//媒体资讯
		req.setAttribute("casus", casus);			 //行业动态
		req.setAttribute("companyNews", companyNews);//公司新闻
		req.setAttribute("successfulCase", successfulCase);//成功案例
		req.setAttribute("bigImages", bigImages);	 //首页滚动图片
		req.setAttribute("pic", pic);	 //首页滚动图片
		return new JspView("officialwebsite.index");
	}
	
	/**
	 * 进入成功案例
	 */
	@At("/intoSuccessCase")
	public View intoSuccessCase(@Param("curPage")Integer currentPage,Ioc ioc,HttpServletRequest req){
		final ArticleDao dao = new ArticleDao(ioc);
		final Object[] objs = new Object[1];
		final Integer pageSize=8;
		if(currentPage==null){currentPage=1;};
		final Integer tempCurrentPage=currentPage;
		int count = dao.searchCount(Article.class,Cnd.where("typeid", "=", 3));//获取指定类型的文章总数
		
		int maxPage = dao.maxPageSize(count, pageSize);
		FieldFilter.create(Article.class, "(^id|title|previewImg$)").run(new Atom() {
			public void run() {
				objs[0] = dao.searchByPage(Article.class, Cnd.where("typeid", "=", "3").desc("modifyDate"), tempCurrentPage, pageSize);//两条成功案例
			}
		});
		List<NewsTemplate> bigImages= dao.search(NewsTemplate.class, Cnd.where("type", "=", "2"));
		List<Article> successfulCase= (List<Article>)objs[0];
		PageModel<Article> pm = new PageModel<Article>(successfulCase, maxPage);
		req.setAttribute("currentPage", tempCurrentPage);
		req.setAttribute("pm", pm);
		Article article=new Article();
		article.setTypeid(3);
		req.setAttribute("article", article);
		req.setAttribute("bigImages", bigImages);
		return new JspView("officialwebsite.successCase");
	}
	
	/**
	 * ajax查询案例
	 */
	@At("/ajaxQueryCaseByPage")
	@Ok("json")
	public String ajaxQueryCaseByPage(@Param("currentPage")Integer currentPage,Ioc ioc,HttpServletRequest req){
		final Object[] objs = new Object[1];
		final ArticleDao dao = new ArticleDao(ioc);
		if(currentPage==null){currentPage=1;};
		final Integer currPage=currentPage;
		FieldFilter.create(Article.class, "(^id|title|previewImg$)").run(new Atom() {
			public void run() {
				objs[0] = dao.searchByPage(Article.class, Cnd.where("typeid", "=", "3").desc("modifyDate"), currPage, 3);//3条成功案例
			}
		});
		List<Article> successfulCase= (List<Article>)objs[0];
		Gson gson=new Gson();
		String jsonStr=gson.toJson(successfulCase);
		return jsonStr;
	}
	
	/**
	 * 根据Id查出于与之对应的文章列表
	 */
	@At("/queryArticleListById")
	public View queryArticleListById(@Param("curPage") Integer curPage,@Param("article.typeid")Integer typeid,Ioc ioc,HttpServletRequest request){
		curPage=DataDispose.getRightCurPage(curPage);
		int pageSize=SystemContext.PAGE_SIZE-2;//每页显示8条数据
		final ArticleDao dao = new ArticleDao(ioc);
		int count = dao.searchCount(Article.class,Cnd.where("typeid", "=", typeid));//获取指定类型的文章总数
		int maxPage = dao.maxPageSize(count, pageSize);
		if(curPage>maxPage){
			curPage=maxPage;
		}
		final Integer tempTypeId=typeid;
		final Integer tempCurrentPage=curPage;
		final Integer tempPageSize=pageSize;
		final Object[] objs = new Object[4];
		FieldFilter.create(Article.class, "(^id|title|modifyDate$)").run(new Atom() {
			public void run() {
					objs[0] =  dao.searchByPage(Article.class,Cnd.where("typeid", "=", tempTypeId).desc("modifyDate"), tempCurrentPage, tempPageSize);
				objs[1] =  dao.searchByPage(Article.class,Cnd.where("typeid", "=", 1).desc("modifyDate"), 1, 7);
				objs[2] =  dao.searchByPage(Article.class,Cnd.where("typeid", "=", 2).desc("modifyDate"), 1, 7);
			}
		}); 
		List<NewsTemplate> bigImages= dao.search(NewsTemplate.class, Cnd.where("type", "=", "2"));
		List<Article> articles=(List<Article>)objs[0];
		List<Article> companyNews=(List<Article>)objs[1];//公司新闻
		List<Article> hangyeNews=(List<Article>)objs[2];//行业动态
		
		PageModel<Article> pm = new PageModel<Article>(articles, maxPage);
		pm.setCurPage(curPage);
		Article article=dao.findByCondition(Article.class, Cnd.where("typeid", "=", typeid));
		request.setAttribute("article", article);
		request.setAttribute("pm", pm);
		request.setAttribute("companyNews", companyNews);
		request.setAttribute("hangyeNews", hangyeNews);
		request.setAttribute("bigImages", bigImages);
		return new JspView("officialwebsite.articleList");
	}
	
	/**
	 * 根据文章Id获取文章
	 */
	@At("/getArticleById")
	public View getArticleById(@Param("article.typeid") Integer articleId,Ioc ioc,HttpServletRequest req){
		ArticleDao dao = new ArticleDao(ioc);
		Article article=dao.find(articleId, Article.class);
		List<NewsTemplate> bigImages= dao.search(NewsTemplate.class, Cnd.where("type", "=", "2"));
		req.setAttribute("bigImages", bigImages);
		req.setAttribute("article", article);
		return new JspView("officialwebsite.articleDetail");
	}
	
	/**
	 * 根据文章类型Id获取文章
	 */
	@At("/getArticleByTypeid")
	public View getArticleByTypeid(@Param("article.typeid") Integer typeId,Ioc ioc,HttpServletRequest req){
		ArticleDao dao = new ArticleDao(ioc);
		Article article=dao.findByCondition(Article.class, Cnd.where("typeid", "=", typeId));
		List<NewsTemplate> bigImages= dao.search(NewsTemplate.class, Cnd.where("type", "=", "2"));
		req.setAttribute("bigImages", bigImages);
		req.setAttribute("article", article);
		return new JspView("officialwebsite.articleDetail");
	}
}

