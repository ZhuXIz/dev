package com.jdkj.wx.entity;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
商品评价
*/
public class Evaluate {

	private Integer id;
	/*评论人*/
	private User user;
	/*评论信息*/
	private String message;
	/*评论时间*/
	@JsonFormat(pattern ="yyyy年MM月dd日 HH时mm分",timezone = "GMT+8")
	private Date eTime;
	private Goods goods;
	
	private Integer goodsId;
	private String userId;
	private Integer orderId;
	
	
	public Evaluate(Integer goodsId, String userId) {
		super();
		this.goodsId = goodsId;
		this.userId = userId;
	}

	public Integer getOrderId() {
		return orderId;
	}
	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
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
	public Evaluate(User user, Goods goods) {
		super();
		this.user = user;
		this.goods = goods;
	}
	public Evaluate() {
		super();
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
	
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Date geteTime() {
		return eTime;
	}
	public void seteTime(Date eTime) {
		this.eTime = eTime;
	}
	@Override
	public String toString() {
		return "Evaluate [id=" + id + ", user=" + user + ", message=" + message + ", eTime=" + eTime + ", goods="
				+ goods + "]";
	}
	
	

}
