package com.jdkj.wx.query;

import com.jdkj.wx.entity.Goods;

public class GoodsQuery extends BaseQuery<Goods>{
	private Integer typeId;
	private Integer id;
	private String sellerId;
	
	
	public String getSellerId() {
		return sellerId;
	}

	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}

	public Integer getTypeId() {
		return typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "GoodsQuery [typeId=" + typeId + ", id=" + id + ", sellerId=" + sellerId + "]";
	}

}
