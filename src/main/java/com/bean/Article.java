package com.bean;

import org.nutz.dao.entity.annotation.*;

import java.io.Serializable;
import java.util.Date;

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
    @ColDefine(type=ColType.VARCHAR,width=30)
	private String title;
	
	/*
	 * 文章内容
	 */
	@Column
    @ColDefine(type=ColType.TEXT)
	private String content;

    /**文章所属模块名称**/
    @Column
    @ColDefine(type=ColType.VARCHAR,width = 10)
    private String parentTitle;
	/**
	 * 文章预览图url
	 */
	@Column
    @ColDefine(type=ColType.VARCHAR,width = 60)
	private String previewImg;//只有成功案例才享有此字段
	
	/*
	 * 文章关键字
	 */
	@Column
    @ColDefine(type=ColType.VARCHAR,width = 20)
	private String keywords;
	
	/*
	 * 文章来源
	 */
	@Column
    @ColDefine(type=ColType.VARCHAR,width = 10)
	private String source="";
	/*
	 * 文章作者
	 */
	@Column
    @ColDefine(type=ColType.VARCHAR,width = 10)
	private String author;
	/*
	 * 修改日期
	 */
	@Column
    @ColDefine(type=ColType.DATE)
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
	/**
	 * 文章所属分类名字
	 */

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
    public String getParentTitle() {return parentTitle;}
    public void setParentTitle(String parentTitle) {this.parentTitle = parentTitle;}
}
