package com.jdkj.wx.query;

import com.jdkj.wx.entity.Order;

public class MyCollQuery extends BaseQuery<Order>{

	private String userId;
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
}
