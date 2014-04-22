package com.bean;

import java.io.Serializable;

import org.nutz.dao.entity.annotation.*;

@Table("t_newsAndPoster")
public class NewsTemplate implements Serializable {
	private static final long serialVersionUID = 8104366207698775954L;
	@Id
	private int id;
	@Column
    @ColDefine(type = ColType.VARCHAR,width = 30)
	private String title;//图片标题
	@Column
    @ColDefine(type = ColType.VARCHAR,width = 60)
	private String imgUrl;//图片地址
	@Column
    @ColDefine(type = ColType.VARCHAR,width = 200)
	private String newsLink;//图片所指向的链接
	@Column
	private int type;//图片类型，1为首页滚动图片,2首页新闻图片

	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	public String getNewsLink() {
		return newsLink;
	}
	public void setNewsLink(String newsLink) {
		this.newsLink = newsLink;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
}
