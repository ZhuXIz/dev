package com.jdkj.wx.entity;

public class Employee {
	private Integer id;
	private String name;
	private Permiss permiss;
	private String pwd;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Permiss getPermiss() {
		return permiss;
	}
	public void setPermiss(Permiss permiss) {
		this.permiss = permiss;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	@Override
	public String toString() {
		return "Employee [id=" + id + ", name=" + name + ", permiss=" + permiss + ", pwd=" + pwd + "]";
	}
	
	
}
