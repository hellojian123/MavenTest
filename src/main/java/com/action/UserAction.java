package com.action;

import javax.servlet.http.HttpServletRequest;

import org.nutz.ioc.Ioc;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.view.JspView;

import com.bean.User;


public class UserAction extends BaseAction{
	@At("/saveUser")
	public View saveUser(@Param("::user.")User user,Ioc ioc , HttpServletRequest request){
		User user2=dao.save(user);
		if(user2!=null){
			System.out.println("success");
		}else{
			System.out.println("failed");
		}
		return new JspView("page.index");
	}
}