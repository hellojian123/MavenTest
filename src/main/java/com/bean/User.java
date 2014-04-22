package com.bean;

import java.io.Serializable;
import java.util.Date;

import org.nutz.dao.entity.annotation.*;

@Table("t_user")
public class User implements Serializable{
	private static final long serialVersionUID = 8763446770756204524L;
	@Id
	private Integer id;
	
	@Column
    @ColDefine(type = ColType.VARCHAR,width = 10)
	private String  name;	//真实姓名

	@Column
    @ColDefine(type = ColType.VARCHAR,width = 10)
	private String username;//用户名
	
	@Column
    @ColDefine(type = ColType.CHAR,width = 32)
	private String password;
	@Column
    @ColDefine(type = ColType.DATE)
	private Date birthday;
	
	@Column
    @ColDefine(type = ColType.VARCHAR,width = 30)
	private String address;
	
	@Column
    @ColDefine(type = ColType.VARCHAR,width = 30)
	private String email;
	
	/*
	 * 上次登录时间
	 */
	@Column
    @ColDefine(type = ColType.DATE)
	private Date lastLoginTime;
	/*
	 * 本次登录时间
	 */
	@Column
    @ColDefine(type = ColType.DATE)
	private Date currentLoginTime;
	/*
	 * 上次登录IP
	 */
	@Column
    @ColDefine(type = ColType.VARCHAR,width = 100)
	private String lastLoginIp;
	/*
	 * 本次登录IP
	 */
	@Column
    @ColDefine(type = ColType.VARCHAR,width = 100)
	private String currentLoginIp;
	
	/*
	 * 登录次数
	 */
	@Column
	private int loginNum;
	
	/*
	 * 用户类型	0普通用户	1管理员	2超级管理员
	 */
	@Column
	private int userType;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getLastLoginTime() {
		return lastLoginTime;
	}
	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}
	public String getLastLoginIp() {
		return lastLoginIp;
	}
	public void setLastLoginIp(String lastLoginIp) {
		this.lastLoginIp = lastLoginIp;
	}
	public int getUserType() {
		return userType;
	}
	public void setUserType(int userType) {
		this.userType = userType;
	}
	public Date getCurrentLoginTime() {
		return currentLoginTime;
	}
	public void setCurrentLoginTime(Date currentLoginTime) {
		this.currentLoginTime = currentLoginTime;
	}
	public String getCurrentLoginIp() {
		return currentLoginIp;
	}
	public void setCurrentLoginIp(String currentLoginIp) {
		this.currentLoginIp = currentLoginIp;
	}
	public int getLoginNum() {
		return loginNum;
	}
	public void setLoginNum(int loginNum) {
		this.loginNum = loginNum;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
}
