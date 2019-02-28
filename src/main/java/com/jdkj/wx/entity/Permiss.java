package com.jdkj.wx.entity;

import java.util.ArrayList;
import java.util.List;

import com.jdkj.wx.page.Page;

public class Permiss extends Page {
	private Integer id;
	private String name;
	private List<Menu> menu = new ArrayList<Menu>();
	private Integer menuId;
	





	public Integer getMenuId() {
		return menuId;
	}




	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
	}




	public Integer getId() {
		return id;
	}
	
	
	
	
	public List<Menu> getMenu() {
		return menu;
	}




	public void setMenu(List<Menu> menu) {
		this.menu = menu;
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
	
	
	
	
	@Override
	public String toString() {
		return "Premiss [id=" + id + ", name=" + name + "]";
	}


}
