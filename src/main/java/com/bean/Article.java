package com.bean;

import java.io.Serializable;
import java.util.Date;
import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

@Table("t_article")
public class Article implements Serializable {

	private static final long serialVersionUID = -3053664411602554289L;
	/*
	 * 数据库ID
	 */
	@Id
	private Integer id;
	/*
	 * 文章标题
	 */
	@Column
	private String title;
	
	/*
	 * 文章内容
	 */
	@Column
	private String content;
	
	/**
	 * 文章预览图url
	 */
	@Column
	private String previewImg;//只有成功案例才享有此字段
	
	/*
	 * 文章关键字
	 */
	@Column
	private String keywords;
	
	/*
	 * 文章来源
	 */
	@Column
	private String source="";
	/*
	 * 文章作者
	 */
	@Column
	private String author;
	/*
	 * 修改日期
	 */
	@Column
	private Date modifyDate;
	/*
	 * 点击率
	 */
	@Column
	private int clickNum;
	/*
	 * 文章类型id
	 */
	@Column
	private int typeid;// 1公司新闻   2行业动态   3成功案例    4公司介绍    5人才招聘    6业务体系  7网站建设  8系统开发  9 APP开发  10业务流程
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public Date getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
	public int getClickNum() {
		return clickNum;
	}
	public void setClickNum(int clickNum) {
		this.clickNum = clickNum;
	}
	public int getTypeid() {
		return typeid;
	}
	public void setTypeid(int typeid) {
		this.typeid = typeid;
	}
	public String getKeywords() {
		return keywords;
	}
	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}
	public String getPreviewImg() {
		return previewImg;
	}
	public void setPreviewImg(String previewImg) {
		this.previewImg = previewImg;
	}
}
