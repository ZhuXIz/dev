package com.jdkj.wx.entity;

/**
商品详细介绍，广告语、海报
*/
public class GoodsItem {
	private Integer id;
	/*详细的文字介绍*/
	private String text;
	/*海报图片*/
	private String image;
	/*关联商品-----呈现文字图片的叠加*/
	private Goods goods;
	/*拓展需要（商品详细用html表示）*/
	private String htmlSrc;
	
	
	
	public GoodsItem(Goods goods, String htmlSrc) {
		super();
		this.goods = goods;
		this.htmlSrc = htmlSrc;
	}



	public GoodsItem() {
		super();
	}



	public Integer getId() {
		return id;
	}



	public void setId(Integer id) {
		this.id = id;
	}



	public String getText() {
		return text;
	}



	public void setText(String text) {
		this.text = text;
	}



	public String getImage() {
		return image;
	}



	public void setImage(String image) {
		this.image = image;
	}



	public Goods getGoods() {
		return goods;
	}



	public void setGoods(Goods goods) {
		this.goods = goods;
	}



	public String getHtmlSrc() {
		return htmlSrc;
	}



	public void setHtmlSrc(String htmlSrc) {
		this.htmlSrc = htmlSrc;
	}



	@Override
	public String toString() {
		return "GoodsItem [id=" + id + ", text=" + text + ", image=" + image + ", htmlSrc=" + htmlSrc + "]";
	}

	
	
}
