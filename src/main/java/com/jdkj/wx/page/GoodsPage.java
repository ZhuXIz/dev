package com.jdkj.wx.page;

import com.jdkj.wx.entity.Goods;
import com.jdkj.wx.entity.MyCollection;

public class GoodsPage {
	private int code;
	private Goods goods;
	private Integer evaluateCount;
	private MyCollection coll;
	
	
	

	public GoodsPage(Goods goods, Integer evaluateCount, MyCollection coll) {
		super();
		this.goods = goods;
		this.evaluateCount = evaluateCount;
		this.coll = coll;
	}
	
	public GoodsPage() {
		super();
	}

	public GoodsPage(int code, Goods goods, Integer evaluateCount, MyCollection coll) {
		super();
		this.code = code;
		this.goods = goods;
		this.evaluateCount = evaluateCount;
		this.coll = coll;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public Goods getGoods() {
		return goods;
	}
	public void setGoods(Goods goods) {
		this.goods = goods;
	}
	public Integer getEvaluateCount() {
		return evaluateCount;
	}
	public void setEvaluateCount(Integer evaluateCount) {
		this.evaluateCount = evaluateCount;
	}
	public MyCollection getColl() {
		return coll;
	}
	public void setColl(MyCollection coll) {
		this.coll = coll;
	}
	
	
}
