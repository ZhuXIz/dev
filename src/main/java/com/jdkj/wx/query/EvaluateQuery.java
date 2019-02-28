package com.jdkj.wx.query;

import com.jdkj.wx.entity.Order;

public class EvaluateQuery extends BaseQuery<Order>{

	private Integer goodsId;

	public Integer getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}
	
	
}
