package com.jdkj.wx.entity;

import java.util.Date;

public class SMS {

	private Integer id;
	private String message;
	private Seller seller;
	private Date sendTime;
	
	
	
	public SMS(String message, Seller seller) {
		super();
		this.message = message;
		this.seller = seller;
	}
	public SMS() {
		super();
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}

 
	public Seller getSeller() {
		return seller;
	}
	public void setSeller(Seller seller) {
		this.seller = seller;
	}
	public Date getSendTime() {
		return sendTime;
	}
	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}
	
	
	
}
