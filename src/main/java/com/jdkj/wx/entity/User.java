package com.jdkj.wx.entity;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
用户
*/
public class User {
	private String id;
	/*昵称*/
	private String name;
	/*昵称*/
	private String phoneName;
	/*电话号码*/
	private String phoneNum;
	/*头像地址*/
	private String imageUrl;
	/*地址*/
	private String address;
	/*连续签到次数*/
	private Integer times;
	/*分数*/
	private Integer score;
	private Date  checkTime;
	private BigDecimal  money;
	/*收藏*/
	private List<MyCollection> coll = new ArrayList<MyCollection>();
	/*订单*/
	private List<Order> order = new ArrayList<Order>();
	
	/*拼团活动*/
	private List<SpellList> list = new ArrayList<SpellList>();
	
	

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Integer getTimes() {
		return times;
	}

	public Date getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}

	public void setTimes(Integer times) {
		this.times = times;
	}

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public List<SpellList> getList() {
		return list;
	}

	public void setList(List<SpellList> list) {
		this.list = list;
	}

	public User(String id, String name, String imageUrl) {
		super();
		this.id = id;
		this.name = name;
		this.imageUrl = imageUrl;
	}
	
	
	public String getPhoneName() {
		return phoneName;
	}


	public void setPhoneName(String phoneName) {
		this.phoneName = phoneName;
	}


	public User(String id) {
		super();
		this.id = id;
	}

	public User() {
		super();
	}

	public User(Integer times, Integer score) {
		super();
		this.times = times;
		this.score = score;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	
	
	public List<MyCollection> getColl() {
		return coll;
	}
	public void setColl(List<MyCollection> coll) {
		this.coll = coll;
	}
	public List<Order> getOrder() {
		return order;
	}
	public void setOrder(List<Order> order) {
		this.order = order;
	}

	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", phoneName=" + phoneName + ", phoneNum=" + phoneNum
				+ ", imageUrl=" + imageUrl + ", address=" + address + ", times=" + times + ", score=" + score
				+ ", checkTime=" + checkTime + ", money=" + money + ", coll=" + coll + ", order=" + order + ", list="
				+ list + "]";
	}

}
