package com.jdkj.wx.entity;

import com.jdkj.wx.page.Page;

/**
广告轮播图
*/
public class Advert extends Page{
	private Integer	id;
	private String	img;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	@Override
	public String toString() {
		return "Advert [id=" + id + ", img=" + img + "]";
	}
	
	

}
