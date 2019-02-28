package com.jdkj.wx.entity;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Coupon {
	private Integer id;
	@JsonFormat(pattern ="yyyy-MM-dd hh:00",timezone = "GMT+8")
	@DateTimeFormat(pattern = "yyyy/MM/dd")//存日期时使用 
	private Date startTime;
	@JsonFormat(pattern ="yyyy-MM-dd hh:00",timezone = "GMT+8")
	@DateTimeFormat(pattern = "yyyy/MM/dd")//存日期时使用 
	private Date endTime;
	/*抵扣价格*/
	private BigDecimal price;
	/*优惠券人数*/
	private Integer num;
	/*状态：是否可用*/
	private Integer state;
	private Goods goods;
	private List<User> user = new ArrayList<User>();
	private Seller seller;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Goods getGoods() {
		return goods;
	}
	public void setGoods(Goods goods) {
		this.goods = goods;
	}
	public List<User> getUser() {
		return user;
	}
	public void setUser(List<User> user) {
		this.user = user;
	}
	public Seller getSeller() {
		return seller;
	}
	public void setSeller(Seller seller) {
		this.seller = seller;
	}
	@Override
	public String toString() {
		return "Coupon [id=" + id + ", startTime=" + startTime + ", endTime=" + endTime + ", price=" + price + ", num="
				+ num + ", state=" + state + ", goods=" + goods + ", user=" + user + ", seller=" + seller + "]";
	}
	
	
	
}
