package com.jdkj.wx.entity;

/**
 * 收藏
 */
public class MyCollection {
	private Integer id;

	/* 收藏的网页地址 */
	private String collAddress;
	/* 收藏的商品 */
	private Goods goods;
	private Integer goodsId;
	/* 收藏属于哪个用户 */
	private User user;
	private boolean isColl;
	
	



	public Integer getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}

	public boolean getIsColl() {
		return isColl;
	}

	public void setIsColl(boolean isColl) {
		this.isColl = isColl;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}


	public String getCollAddress() {
		return collAddress;
	}

	public void setCollAddress(String collAddress) {
		this.collAddress = collAddress;
	}

	
	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "MyCollection [id=" + id + ",  collAddress=" + collAddress + ", goods="
				+ goods + ", user=" + user + ", isColl=" + isColl + "]";
	}

	
}
