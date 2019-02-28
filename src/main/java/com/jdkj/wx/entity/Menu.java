package com.jdkj.wx.entity;

import java.util.ArrayList;
import java.util.List;

import com.jdkj.wx.page.Page;

public class Menu  extends Page{
	private Integer id;
	private String url;
	private String name;
	private String icon;
	private Integer pid;
	private List<Menu> menus = new ArrayList<>();
	
	private List<Permiss> premiss = new ArrayList<Permiss>();

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public List<Menu> getMenus() {
		return menus;
	}

	public void setMenus(List<Menu> menus) {
		this.menus = menus;
	}

	public List<Permiss> getPremiss() {
		return premiss;
	}

	public void setPremiss(List<Permiss> premiss) {
		this.premiss = premiss;
	}

	@Override
	public String toString() {
		return "Menu [id=" + id + ", url=" + url + ", name=" + name + ", icon=" + icon + ", pid=" + pid + ", menus="
				+ menus + ", premiss=" + premiss + "]";
	}

	

}
