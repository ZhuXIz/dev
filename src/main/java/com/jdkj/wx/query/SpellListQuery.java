package com.jdkj.wx.query;

import com.jdkj.wx.entity.SpellList;

public class SpellListQuery extends BaseQuery<SpellList>{

	private Integer goodsId;
	private String userId;

	private String sellerId;
	

	
	public String getSellerId() {
		return sellerId;
	}



	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}



	public Integer getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	
}
