package com.action;

import org.nutz.ioc.Ioc;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.view.JspView;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by hejian on 14-4-21.
 */
public class indexAction extends BaseAction  {
	/**
	 * 首页
	 */
	@At("/index")
	public View index(Ioc ioc , HttpServletRequest req){

		return new JspView("page.index");
	}
}
