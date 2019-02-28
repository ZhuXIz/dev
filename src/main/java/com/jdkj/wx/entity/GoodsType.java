package com.jdkj.wx.entity;

import com.jdkj.wx.page.Page;

/**
商品分类(旅游<==>1、美食<==>2、KTV<==>3、衣服<==>4、其他生活服务<==>5)
*/
public class GoodsType  extends Page{
	private Integer id;
	private String genreName;
	
	

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getGenreName() {
		return genreName;
	}
	public void setGenreName(String genreName) {
		this.genreName = genreName;
	}
	@Override
	public String toString() {
		return "GoodsType [id=" + id + ", genreName=" + genreName + "]";
	}

	
}
