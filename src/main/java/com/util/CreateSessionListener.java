package com.util;

import java.util.List;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import org.nutz.dao.Cnd;
import org.nutz.dao.impl.NutDao;

import com.bean.FriendLinks;
import com.bean.NewsTemplate;
import com.dao.Init;

public class CreateSessionListener implements HttpSessionListener{
	
	/**
	 * session创建时执行
	 */
	public void sessionCreated(HttpSessionEvent event) {
		/*NutDao dao = Init.dao;
		//头部展示图片
		List<FriendLinks> friendLinks=dao.query(FriendLinks.class,Cnd.where("1", "=", "1"));
		List<NewsTemplate> headShow=dao.query(NewsTemplate.class, Cnd.where("type", "=", "1"));
		event.getSession().setAttribute("headShow", headShow);
		event.getSession().setAttribute("webName", "四川省东鹰信息技术有限公司");
		event.getSession().setAttribute("friendLinks", friendLinks);*/
	}
	
	/**
	 * 销毁session时执行
	 */
	public void sessionDestroyed(HttpSessionEvent arg0) {
		
	}

}
