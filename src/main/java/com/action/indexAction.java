package com.action;

import com.bean.Article;
import org.nutz.dao.Cnd;
import org.nutz.dao.FieldFilter;
import org.nutz.ioc.Ioc;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.view.JspView;
import org.nutz.trans.Atom;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by hejian on 14-4-21.
 */
public class indexAction extends BaseAction  {
	/**
	 * 首页
	 */
	@At("/index")
	public View index(Ioc ioc , HttpServletRequest req){
        final  Object objs[]=new Object[2];
        FieldFilter.create(Article.class, "(^id|title|modifyDate$)").run(new Atom() {
            public void run() {
                objs[0]=dao.searchByPage(Article.class, Cnd.where("typeid", "=", 1).or("typeid","=",2).desc("modifyDate"), 1, 6);//新闻和动态5
            }
        });
        FieldFilter.create(Article.class, "(^id|title|thumbnails|previewImg$)").run(new Atom() {
            public void run() {
                objs[1]=dao.searchByPage(Article.class, Cnd.where("typeid", "=", 3).and("previewImg","!=","").desc("modifyDate"), 1, 8);//案例展示
            }
        });

        List<Article>  newsList= (List<Article>) objs[0];
        List<Article>  sucCase= (List<Article>) objs[1];
        Article compIntroduce =dao.findByCondition(Article.class, Cnd.where("typeid", "=", 4));//公司
        req.setAttribute("newsList",newsList);
        req.setAttribute("sucCase",sucCase);
        req.setAttribute("compIntroduce",compIntroduce);
        return new JspView("page.index");
	}
}
