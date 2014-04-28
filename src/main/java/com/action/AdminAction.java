package com.action;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.nutz.Nutz;
import org.nutz.dao.Cnd;
import org.nutz.ioc.Ioc;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import com.util.CheckSession;
import org.nutz.mvc.view.JspView;
import com.bean.Article;
import com.bean.FriendLinks;
import com.bean.NewsTemplate;
import com.bean.User;
import com.google.gson.Gson;
import com.util.DeleteImgByHtml;
import com.util.MD5;
import com.util.PageModel;
import com.util.SystemContext;

public class AdminAction extends BaseAction{
	
	/**
	 * 获取管理员的username
	 */
	private String getAdminName(HttpServletRequest req){
		return ((User)(req.getSession().getAttribute("admin"))).getUsername();
	}
	
	/**
	 * 进入管理员登陆页面
	 */
	@At("/admin")
	public View manageIndex(Ioc ioc , HttpServletRequest req){
		return new JspView("admin.login");
	}
	
	/**
	 * 管理员登陆处理
	 * @param username 用户名
	 * @param password 密码
	 */
	@At("/admin/login")
	public View login(@Param("username") String username,@Param("password") String password,Ioc ioc,HttpServletRequest req){
		if(username==null||password==null){
			return new JspView("admin.login");
		}
		password=new MD5().getMD5ofStr(password);
		User user=dao.findByCondition(User.class, Cnd.where("username", "=", username).and("password", "=", password));
		if(user!=null){
			if(user.getUserType()==0){
				req.setAttribute("error", "您只是普通用户,没有权限进入后台管理系统！");
				return new JspView("admin.login");
			}
			user.setLoginNum(user.getLoginNum()+1);
			user.setLastLoginTime(user.getCurrentLoginTime());
			user.setCurrentLoginTime(new Date());
			user.setLastLoginIp(user.getCurrentLoginIp());
			user.setCurrentLoginIp(req.getRemoteAddr());
			dao.update(user);
			req.getSession().setAttribute("admin", user);
			return new JspView("admin.index");
		}else{
			req.setAttribute("error", "用户名或者密码错误！");
			return new JspView("admin.login");
		}
	}
	/**
	 * 保存链接
	 * @return
	 */
	@At("/admin/saveLink")
	@Ok("raw")
	@Filters(@By(type=CheckSession.class, args={"admin", "/goAdmin.jsp"}))
	public String saveLink(@Param("linkName")String linkName,@Param("linkUrl")String linkUrl, Ioc ioc) {
		try{
			FriendLinks link=new FriendLinks();
			link.setLinkName(linkName);
			link.setLinkUrl(linkUrl);
			if(dao.save(link)!=null){
				return "0";
			}else{
				return "1";
			}
		}catch(Exception e){
			e.printStackTrace();
			return "";
		}
	}
	/**
	 * 根据编号删除链接
	 */
	@At("/admin/deleteLinkById")
	@Ok("raw")
	@Filters(@By(type=CheckSession.class, args={"admin", "/goAdmin.jsp"}))
	public String deleteLinkById(@Param("id")Integer id, Ioc ioc) {
		if(dao.delById(id,FriendLinks.class)){
			return "0";
		}else{
			return "1";
		}
	}
	/**
	 * 根据id修改密码
	 * @return
	 */
	@At("/admin/user/updatepwdUI")
	public View toupdatepwd(){
		return new JspView("admin.updatepwd");
	}
	/**
	 * 友情链接管理
	 */
	@At("/admin/friendLinksUI")
	@Filters(@By(type=CheckSession.class, args={"admin", "/goAdmin.jsp"}))
	public View friendLinksUI(Ioc ioc,HttpServletRequest req){
		List<FriendLinks> links =dao.search(FriendLinks.class, Cnd.where("1", "=", "1"));
		req.setAttribute("links", links);
		return new JspView("admin.friendLinks");
	}
	
	/**
	 * 根据id修改密码
	 * @Ok("raw")意为ajax返回数据
	 */
	@At("/admin/user/updatepwd")
	@Ok("raw")
	@Filters(@By(type=CheckSession.class, args={"admin", "/goAdmin.jsp"}))
	public String updatepwd(@Param("userId")Integer userId,@Param("newPwd")String newPwd,@Param("oldpwd") String oldpwd, Ioc ioc,HttpServletRequest req){
		User userTemp=dao.find(userId, User.class);
		oldpwd=new MD5().getMD5ofStr(oldpwd);
		if(!userTemp.getPassword().equals(oldpwd)){
			return "1";
		}
		newPwd=new MD5().getMD5ofStr(newPwd);
		userTemp.setPassword(newPwd);
		dao.update(userTemp);
		return "0";
	}
	
	/**
	 * 分页查询用户
	 * @return
	 */
	@At("/admin/userManagerUI")
	@Filters(@By(type=CheckSession.class, args={"admin", "/goAdmin.jsp"}))
	public View findAll(@Param("currentPage") Integer currentPage,Ioc ioc,HttpServletRequest request){
		if(currentPage==null){currentPage=1;}
		int pageSize=SystemContext.PAGE_SIZE;//每页显示十条数据
		int count = dao.searchCount(User.class);//获取总用户数
		int maxPage = dao.maxPageSize(count, pageSize);
		if(currentPage>maxPage){
			currentPage=maxPage;
		}
		List<User> users =  dao.searchByPage(User.class, currentPage, pageSize, "userType");
		
		PageModel<User> pm = new PageModel<User>(users, maxPage);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("pm", pm);
		return new JspView("admin.userManager");
	}
	
	@At("/admin/saveOrUpdateUser")
	@Ok("raw")
	@Filters(@By(type=CheckSession.class, args={"admin", "/goAdmin.jsp"}))
	public String saveOrUpdateUser(@Param("::user.")User user,Ioc ioc,HttpServletRequest req){
		if(user.getId()==null){//保存
			user.setPassword(new MD5().getMD5ofStr("123456"));
			if(dao.save(user)!=null){
				return "0";//保存成功
			}else{
				return "1";//保存失败
			}
		}else{
			if(dao.update(user)){
				return "2";//更新成功
			}else{
				return "3";//更新失败
			}
		}
	}
	
	/**
	 * 根据用户id删除用户
	 * @param userId 
	 */
	@At("/admin/user/deleteUserById")
	@Ok("raw")
	@Filters(@By(type=CheckSession.class, args={"admin", "/goAdmin.jsp"}))
	public String deleteUserById(@Param("userId")Integer userId,Ioc ioc,HttpServletRequest req){
		if(dao.delById(userId, User.class)){
			return "0";
		}else{
			return "1";
		}
	}
	
	/**
	 * 根绝用户id更新用户类型
	 * @param id
	 * @param userType
	 */
	@At("/admin/user/updateUserTypeById")
	@Ok("raw")
	@Filters(@By(type=CheckSession.class, args={"admin", "/goAdmin.jsp"}))
	public String updateUserTypeById(@Param("id")Integer id,@Param("userType")Integer userType,Ioc ioc,HttpServletRequest req){
		User user=new User();
		user.setId(id);
		user.setUserType(userType);
		if(dao.update(user)){
			return "0";
		}else{
			return "1";
		}
	}
	
	/**
	 * 分页查询文章
	 * @param currentPage 当前页
	 * @param ioc
	 * @param req
	 * @return
	 */
	@At("/admin/article")
	@Filters(@By(type=CheckSession.class, args={"admin", "/goAdmin.jsp"}))
	public View queryArticleByCondition(@Param("currentPage")Integer currentPage,@Param("selectArticleType")Integer menuTypeId,@Param("date")String date,Ioc ioc,HttpServletRequest req) {
		if(currentPage==null||currentPage==0){currentPage=1;}
		if(menuTypeId==null){menuTypeId=0;}
		if(date==null){date="";}
		int pageSize=SystemContext.PAGE_SIZE;//每页显示十条数据 
		int count=0;//满足条件的数据总数
		Cnd cnd=null;
		if(menuTypeId==0){//用户选择的导航名是不限
			if(date.equals("")){//没有填写日期就直接查
				cnd=Cnd.where("1", "=", "1");
			}else{//用户选择的导航名是不限同时还选择了查询日期
				cnd=Cnd.where("modifyDate", "=", date);
			}
		}else{//用户选择了导航吗名
			if(date.equals("")){//用户选择了导航名但是没有选择日期
				cnd=Cnd.where("typeid", "=", menuTypeId);
			}else{//用户选择了导航名同时还选择了日期
				cnd=Cnd.where("typeid", "=", menuTypeId).and("modifyDate", "=", date);
			}
		}
		cnd.desc("typeid").desc("modifyDate");
		count = dao.searchCount(Article.class,cnd);//获取总文章数
		int maxPage = dao.maxPageSize(count, pageSize);
		if(currentPage>maxPage){
			currentPage=maxPage;
		}
		List<Article> articles =  dao.searchByPage(Article.class,cnd, currentPage, pageSize);
		PageModel<Article> pm = new PageModel<Article>(articles, maxPage);
		req.setAttribute("pm", pm);
		req.setAttribute("menuTypeId", menuTypeId);
		req.setAttribute("date", date);
		req.setAttribute("currentPage", currentPage);
		return new JspView("admin.article");
	}
	
	
	/**
	 *  更新首页新闻图片和滚动图片
	 * @param ioc
	 * @param req
	 * @return
	 */
	@At("/admin/queryNewsAndPosterList")
	@Filters(@By(type=CheckSession.class, args={"admin", "/goAdmin.jsp"}))
	public View queryNewsAndPosterList(Ioc ioc,HttpServletRequest req) {
        queryNewsAndPoster(ioc,req);
		req.setAttribute("tab1_default", "default-tab");
		return new JspView("admin.updateNewsAndPoster");
	}
	
	@At("/admin/updateNews")
	@Ok("raw")
	public String updateNews(@Param("::nt.")NewsTemplate nt, Ioc ioc,HttpServletRequest req){
        //如果用户改变图片，则删除上一张图片
        NewsTemplate oldNt=dao.find(nt.getId(), NewsTemplate.class);
        if(null!=nt.getImgUrl()&&null!=oldNt.getImgUrl()&&!nt.getImgUrl().equals(oldNt.getImgUrl())){
           DeleteImgByHtml.deletePicture(req, oldNt.getImgUrl());
        }

		if(dao.update(nt)){
			return "0";
		}else{
			return "1";
		}
	}

	/**
	 * 查询所有文章
	 * @param ioc
	 * @param req
	 * @return
	 */
	@At("/admin/queryAllArticle")
	@Filters(@By(type=CheckSession.class, args={"admin", "/goAdmin.jsp"}))
	public View queryAllArticle(Ioc ioc,HttpServletRequest req){
		return queryArticleByCondition(1,0,null,ioc,req);
	}
	
	/**
	 * 保存或更新文章
	 * @param article 文章实体
	 * @return
	 */
	@At("/admin/article/saveOrUpdateArticle")
	@Ok("raw")
	@Filters(@By(type=CheckSession.class, args={"admin", "/goAdmin.jsp"}))
	public String saveOrUpdateArticle(@Param("::article.")Article article,Ioc ioc,HttpServletRequest req){
		article.setAuthor(getAdminName(req));
		article.setModifyDate(new Date());
		if(article.getId()==null){//保存
			if(dao.save(article)!=null){
				return "0";//保存成功
			}else{
				return "1";//保存失败
			}
		}else{

            //如果用户改变图片，则删除上一张预览图片
            Article oldArticle=dao.find(article.getId(), Article.class);
            if(article.getPreviewImg()!=null&&oldArticle.getPreviewImg()!=null&&!article.getPreviewImg().equals(oldArticle.getPreviewImg())){
                DeleteImgByHtml.deletePicture(req,oldArticle.getPreviewImg());
            }

			//更新之后删除文章内容中的图片
			Article article2 = dao.find(article.getId(), Article.class);
			List<String> oldDetailList =DeleteImgByHtml.getImgStr(article2.getContent());	//	数据库中的图片标签的src路径
			List<String> newDetailList =DeleteImgByHtml.getImgStr(article.getContent());	//这是更新过后详细信息中图片标签的src路径
			DeleteImgByHtml.delOldArticleImgs(oldDetailList, newDetailList, req);
			if(dao.update(article)){
				return "2";//更新成功
			}else{
				return "3";//更新失败
			}
		}
	}
	
	@At("/admin/article/deleteArticleById")
	@Ok("raw")
	@Filters(@By(type=CheckSession.class, args={"admin", "/goAdmin.jsp"}))
	public String deleteArticleById(@Param("articleId")Integer articleId,Ioc ioc,HttpServletRequest req){
		Article article = dao.find(articleId,Article.class);
		if(article != null){
            //删除预览图片
            if(null!=article.getPreviewImg()){
               DeleteImgByHtml.deletePicture(req,article.getPreviewImg());
            }
            //删除文章内容中的图片
			DeleteImgByHtml.deleteArticleImgs(req.getSession(),article.getContent());
		}
		if(dao.delById(articleId,Article.class)){
			return "0";//删除成功
		}else{
			return "1";//删除失败
		}
	}
	/**
	 * 根据id查找数据
	 * @return
	 */
	@At("/admin/article/find")
	@Ok("json")
	public String getArticleById(@Param("id") int id, Ioc ioc) {
		Article article = dao.find(id, Article.class);
		Gson gson=new Gson();
		return gson.toJson(article);
	}
	
	/**
	 * 根据id号批量删除文章
	 * @param ids 文章id
	 * @throws java.io.IOException
	 */
	@At("/admin/article/batchDeleteArticleById")
	@Filters(@By(type=CheckSession.class, args={"admin", "/goAdmin.jsp"}))
	public View batchDeleteArticleById(@Param("ids")String ids,@Param("currentPage")Integer currentPage,@Param("menuTypeId")Integer menuTypeId,@Param("date")String date,Ioc ioc,
			HttpServletRequest req,HttpServletResponse rep) throws IOException {
				if(ids!=null&&!"".equals(ids)){
					String[] arr=ids.split(",");
					for(String id:arr){
                        Article article = dao.find(Integer.parseInt(id), Article.class);
                        if(null!=article){
                        //删除预览图片
                        if(null!=article.getPreviewImg()){
                           DeleteImgByHtml.deletePicture(req,article.getPreviewImg());
                        }
                        //删除详情图片
					    DeleteImgByHtml.deleteArticleImgs(req.getSession(),article.getContent());
                        }
					}
				}
		
		dao.deleteByIds(Article.class, ids);
		return queryArticleByCondition(currentPage,menuTypeId,date,ioc,req);
	}
	
	/**
	 * 向session中存放一个值
	 * @param name 属性名
	 * @param value 属性值
	 */
	@At("/admin/saveValueToSession")
	public void saveValueToSession(@Param("name")String name,@Param("value")String value,HttpServletRequest req){
		req.getSession().setAttribute(name, value);
	}
	
	/**
	 * 删除session中指定name的值
	 * @param name
	 * @param req
	 */
	@At("/admin/removeValueByName")
    @Filters(@By(type=CheckSession.class, args={"admin", "/goAdmin.jsp"}))
	public void removeValueByName(@Param("name")String name,HttpServletRequest req){
		req.getSession().removeAttribute(name);
	}
	
	/**
	 * 注销用户
	 */
	@At("/admin/logout")
	@Ok("redirect:/admin/login")
	public void logout(HttpServletRequest req){
		req.getSession().invalidate();
	}

    /**
     * 更改首页滚动大图的图片个数
     * @return
     */
    @At("/admin/changeBigImageCount")
    @Filters(@By(type=CheckSession.class, args={"admin", "/goAdmin.jsp"}))
    public View changeBigImageCount(@Param("count") int newCount, Ioc ioc,HttpServletRequest request){
        changeNewsPicOrBigImage(newCount,"1",ioc,request);
        queryNewsAndPoster(ioc, request);
        request.setAttribute("tab1_default", "default-tab");
        request.setAttribute("tab2_default","");
        return new JspView("admin.updateNewsAndPoster");
    }

    /**
     * 查询首页滚动图片和新闻
     * @param ioc
     * @param req
     */
    private void queryNewsAndPoster(Ioc ioc,HttpServletRequest req){
        //首页滚动图片
        List<NewsTemplate> nts=dao.search(NewsTemplate.class, Cnd.where("type", "=", "1"));
        if(nts.size()==0){//如果数据库中没有记录，则添加一条
            addNewsAndPoster("1");
            nts=dao.search(NewsTemplate.class, Cnd.where("type", "=", "1"));//增加成功后重新查一次
        }
        //首页新闻图片
        List<NewsTemplate> pts=dao.search(NewsTemplate.class, Cnd.where("type", "=", "2"));
        if(pts.size()==0){//如果数据库中没有记录，则添加一条
            addNewsAndPoster("2");
            pts=dao.search(NewsTemplate.class, Cnd.where("type", "=", "2"));//增加成功后重新查一次
        }
        req.setAttribute("nts", nts);
        req.setAttribute("bigImageCount", nts.size());
        req.setAttribute("pts", pts);
        req.setAttribute("newsPicCount", pts.size());
    }

    /**
     * 增加一个新闻或滚动大图
     */
    private void addNewsAndPoster(String type){
        NewsTemplate nt=new NewsTemplate();
        nt.setType(Integer.parseInt(type));
        nt.setTitle("");
        nt.setNewsLink("");
        nt.setImgUrl("");
        dao.save(nt);
    }

    /**
     * 更改首页滚动图和新闻个数
     * @param newCount
     * @param type
     * @param ioc
     */
    private void changeNewsPicOrBigImage(int newCount,String type,Ioc ioc,HttpServletRequest request){
        List<NewsTemplate> oldList=dao.search(NewsTemplate.class, Cnd.where("type", "=", type).desc("id"));
        int oldCount=oldList.size();
        if(newCount!=oldCount){
            if(newCount>oldCount){//如果原来的图片个数少于用户选中的图片个数则增加
                for(int i=0;i<newCount-oldCount;i++){
                    addNewsAndPoster(type);
                }
            }
            if(newCount<oldCount){//如果原来的图片个数多于用户选中的图片个数则将多余的删除
                StringBuilder sb=new StringBuilder();
                for(int i=0;i<oldCount-newCount;i++){
                    sb.append(oldList.get(i).getId());
                    sb.append(",");
                    if(type=="1"){//如果是首页滚动图
                        NewsTemplate oldNt=dao.find(oldList.get(i).getId(), NewsTemplate.class);
						System.out.println(oldNt.getImgUrl()+"-----------------------------");
						DeleteImgByHtml.deletePicture(request, oldNt.getImgUrl());
                    }
                }
                sb.delete(sb.length()-1,sb.length());
                dao.deleteByIds(NewsTemplate.class, sb.toString());

            }
        }
    }
    /**
     *更改首页新闻的个数
     * @return
     */
    @At("/admin/changeNewsPicCount")
    public View changeNewsPicCount(@Param("count") int newCount, Ioc ioc,HttpServletRequest request){
        changeNewsPicOrBigImage(newCount,"2",ioc,request);
        queryNewsAndPoster(ioc, request);
        request.setAttribute("tab2_default", "default-tab");
        request.setAttribute("tab1_default","");
        return new JspView("admin.updateNewsAndPoster");
    }
}
