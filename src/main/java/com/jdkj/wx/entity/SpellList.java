package com.jdkj.wx.entity;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.jdkj.wx.page.Page;

public class SpellList extends Page{
	private Integer id;
	@JsonFormat(pattern ="yyyy-MM-dd HH:00",timezone = "GMT+8")
	@DateTimeFormat(pattern = "yyyy/MM/dd")//存日期时使用 
	private Date startTime;
	@JsonFormat(pattern ="yyyy-MM-dd HH:00",timezone = "GMT+8")
	@DateTimeFormat(pattern = "yyyy/MM/dd")//存日期时使用 
	private Date endTime;
	private BigDecimal price;
	private Integer num;
	/*	状态==1:进行中的活动
     * 状态==2：将要进行的活动
     * 状态==3：结束的活动
     * */
	private Integer state;
	private Goods goods;
	private List<User> user = new ArrayList<User>();
	private Seller seller;
	private Integer userListId;
	private long count;
	private String name;
	
	private boolean isJoin;
	
	
	public boolean getIsJoin() {
		return isJoin;
	}
	public void setIsJoin(boolean isJoin) {
		this.isJoin = isJoin;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getUserListId() {
		return userListId;
	}
	public void setUserListId(Integer userListId) {
		this.userListId = userListId;
	}
	public long getCount() {
		return count;
	}
	public void setCount(long count) {
		this.count = count;
	}
	public Seller getSeller() {
		return seller;
	}
	public void setSeller(Seller seller) {
		this.seller = seller;
	}
	public List<User> getUser() {
		return user;
	}
	public void setUser(List<User> user) {
		this.user = user;
	}
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
	@Override
	public String toString() {
		return "SpellList [id=" + id + ", startTime=" + startTime + ", endTime=" + endTime + ", price=" + price
				+ ", num=" + num + ", state=" + state + ", goods=" + goods + ", user=" + user + ", seller=" + seller
				+ ", userListId=" + userListId + ", count=" + count + ", name=" + name + ", isJoin=" + isJoin + "]";
	}
	
	
	
}
