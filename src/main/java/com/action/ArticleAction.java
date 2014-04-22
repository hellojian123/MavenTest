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
import com.util.PageModel;
import com.util.SystemContext;

public class ArticleAction extends BaseAction {
	
	
	/**
	 * 根据Id查出于与之对应的文章列表
	 */
	@At("/article/queryArticleListById")
	public View queryArticleListById1(@Param("currentPage") Integer currentPage,@Param("typeid") Integer typeid,Ioc ioc,HttpServletRequest request){
		if(currentPage==null){currentPage=1;}
		int pageSize=SystemContext.PAGE_SIZE+10;//每页显示十条数据
		int count = dao.searchCount(Article.class,Cnd.where("typeid", "=", typeid));//获取指定类型的文章总数
		int maxPage = dao.maxPageSize(count, pageSize);
		if(currentPage>maxPage){
			currentPage=maxPage;
		}
		final Integer tempTypeId=typeid;
		final Integer tempCurrentPage=currentPage;
		final Integer tempPageSize=pageSize;
		final Object[] objs = new Object[3];//与
		FieldFilter.create(Article.class, "(^id|title|parentTitle|typeid|previewImg|modifyDate$)").run(new Atom() {
			public void run() {
				objs[0] =  dao.searchByPage(Article.class,Cnd.where("typeid", "=", tempTypeId).desc("modifyDate"), tempCurrentPage, tempPageSize);//列表                                            
				objs[1] =  dao.searchByPage(Article.class,Cnd.where("typeid", "=", tempTypeId).desc("clickNum").desc("modifyDate"), 1, 10);//右边点击排行
			}
		});
		List<Article> articles=(List<Article>)objs[0];
		List<Article> articleHots=(List<Article>)objs[1];

		PageModel<Article> pm = new PageModel<Article>(articles, maxPage);
		pm.setCurPage(currentPage);

		request.setAttribute("articleHots", articleHots);

		request.setAttribute("articles",articles);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("typeid", typeid);
		request.setAttribute("pm", pm);
		return new JspView("page.articleList");
		
	}
	
	/**
	 * 模糊查询文章
	 */
	
	@At("/likeSearchArticle")
	public View likeSearchArticle(@Param("currentPage") Integer currentPage,@Param("typeid") Integer typeid,@Param("articleName")String articleName,Ioc ioc,HttpServletRequest request){
		if(currentPage==null){currentPage=1;}
		int pageSize=SystemContext.PAGE_SIZE;//每页显示十条数据
		Cnd cnd=Cnd.where("title", "LIKE", "%"+articleName+"%");
		
		if(typeid!=null){
			cnd.and("typeid", "=", typeid);
		}else{
			cnd.exps("typeid","=",2).or("typeid", "=", 3).or("typeid", "=", 4).or("typeid", "=", 5).or("typeid", "=", 10);
		}
		cnd.desc("modifyDate");
		int count = dao.searchCount(Article.class,cnd);//获取模糊查询到的文章数量
		int maxPage = dao.maxPageSize(count, pageSize);
		if(currentPage>maxPage){
			currentPage=maxPage;
		}
		final Integer tempTypeId=typeid;
		final Cnd tempCnd=cnd;
		final Integer tempCurrentPage=currentPage;
		final Integer tempPageSize=pageSize;
		final Object[] objs = new Object[3];//与
		FieldFilter.create(Article.class, "(^id|typeid|title|modifyDate$)").run(new Atom() {
			public void run() {
				objs[0] =  dao.searchByPage(Article.class,tempCnd, tempCurrentPage, tempPageSize);//列表              
				objs[1] =  dao.searchByPage(Article.class,Cnd.where("typeid", "=", tempTypeId).desc("clickNum").desc("modifyDate"), 1, 10);//右边点击排行
				//objs[2] =  dao.searchByPage(Article.class,Cnd.where("typeid", "=", 7).or("typeid", "=", 8).desc("clickNum").desc("modifyDate"), 1, 4);//图文
			}
		});
		//List<NewsTemplate> posters= dao.search(NewsTemplate.class, Cnd.where("type", "=", 8));
		
		List<Article> articles=(List<Article>)objs[0];
		List<Article> articleHots=(List<Article>)objs[1];
		//List<Article> imgAndArticle=(List<Article>)objs[2];
		PageModel<Article> pm = new PageModel<Article>(articles, maxPage);
		pm.setCurPage(currentPage);
		
		request.setAttribute("typeid", typeid);
		//request.setAttribute("mtxt", mtxt);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("articleName", articleName);
		request.setAttribute("totalCount", count);
		//request.setAttribute("imgAndArticle", imgAndArticle);
		request.setAttribute("articleHots", articleHots);
		request.setAttribute("articles", articles);
		//request.setAttribute("posters", posters);
		request.setAttribute("pm", pm);
		
		return new JspView("page.articleList");
	}
	
	/**
	 * 进入景观欣赏
	 */
	@At("/article/productShow")
	public View landscape(@Param("currentPage") Integer currentPage,Ioc ioc,HttpServletRequest request){
		if(currentPage==null){currentPage=1;}
		int pageSize=SystemContext.PAGE_SIZE+6;//每页显示十条数据
		int count = dao.searchCount(Article.class,Cnd.where("typeid", "=", 7));//获取指定类型的文章总数
		int maxPage = dao.maxPageSize(count, pageSize);
		if(currentPage>maxPage){
			currentPage=maxPage;
		}
		final Integer tempCurrentPage=currentPage;
		final Integer tempPageSize=pageSize;
		final Object[] objs = new Object[1];//与
		FieldFilter.create(Article.class, "(^id|title|previewImg|modifyDate$)").run(new Atom() {
			public void run() {
				objs[0] =  dao.searchByPage(Article.class,Cnd.where("typeid", "=", 7).desc("clickNum").desc("modifyDate"), tempCurrentPage, tempPageSize);//图文
			}
		});
		List<Article> products=(List<Article>)objs[0];
		PageModel<Article> pm = new PageModel<Article>(products, maxPage);
		pm.setCurPage(currentPage);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("products", products);
		request.setAttribute("pm", pm);
		
		return new JspView("page.productShow");
	}
	
	
	/**
	 * 根据文章Id获取文章
	 */
	@At("/article/getArticleById")
	public View getArticleById(@Param("articleId")Integer articleId,Ioc ioc,HttpServletRequest req){
		Article article=dao.find(articleId, Article.class);
		article.setClickNum(article.getClickNum()+1);
		dao.update(article);
		req.setAttribute("article", article);
		return new JspView("page.articleDetail");
	}

    @At("/article/Service")
    public View getService(@Param("typeid")Integer typeid,Ioc ioc,HttpServletRequest req){
        List<Article> atc=null;

        if (typeid==7){
            atc=dao.search(Article.class,Cnd.where("typeid","=",7));
        }
        if (typeid==8){
            atc=dao.search(Article.class,Cnd.where("typeid","=",8));
        }
        if (typeid==9){
            atc=dao.search(Article.class,Cnd.where("typeid","=",9));
        }
        Article article=atc.get(0);
        req.setAttribute("article", article);
        return new JspView("page.articleDetail");
    }
	
}




