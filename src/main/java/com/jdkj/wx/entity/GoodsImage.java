package com.jdkj.wx.entity;

/**
商品图片---标题图
*/
public class GoodsImage { 
	private Integer id;
	/*图片路径*/
	private String image;
	/*关联商品*/
	private Goods goods;

	
	public GoodsImage() {
		super();
	}
	public GoodsImage(String image, Goods goods) {
		super();
		this.image = image;
		this.goods = goods;
	}
	public Goods getGoods() {
		return goods;
	}
	public void setGoods(Goods goods) {
		this.goods = goods;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	@Override
	public String toString() {
		return "GoodsImage [id=" + id + ", image=" + image + ", goods=" + goods + "]";
	}
	
}
