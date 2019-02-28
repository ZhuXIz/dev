package com.jdkj.wx.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.jdkj.wx.page.Page;

/**
商家
*/
public class Seller extends Page{
	private String id;
	/*商家名*/
	private String name;
	/*联系人*/
	private String phoneName;
	/*联系电话*/
	private String phoneNum;
	/*发布时间*/
	private String onTime;
	/*地图坐标*/
	private String address;
	/*地址(文字)*/
	private String addressStr;
	/*商品打折消息*/
	private List<Goods> goods = new ArrayList<Goods>();
	/*商家介绍文字*/
	private String introduceText;
	/*商家介绍图片*/
	private String introduceImage;
	private boolean isValid;
	
	public Seller(String id) {
		super();
		this.id = id;
	}
	public Seller() {
		super();
	}
	public String getAddressStr() {
		return addressStr;
	}
	public void setAddressStr(String addressStr) {
		this.addressStr = addressStr;
	}
	public String getPhoneName() {
		return phoneName;
	}
	public void setPhoneName(String phoneName) {
		this.phoneName = phoneName;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOnTime() {
		return onTime;
	}
	public void setOnTime(String onTime) {
		this.onTime = onTime;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public List<Goods> getGoods() {
		return goods;
	}
	public void setGoods(List<Goods> goods) {
		this.goods = goods;
	}
	public String getIntroduceText() {
		return introduceText;
	}
	public void setIntroduceText(String introduceText) {
		this.introduceText = introduceText;
	}
	public String getIntroduceImage() {
		return introduceImage;
	}
	public void setIntroduceImage(String introduceImage) {
		this.introduceImage = introduceImage;
	}
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public boolean getIsValid() {
		return isValid;
	}
	public void setIsValid(boolean isValid) {
		this.isValid = isValid;
	}
	@Override
	public String toString() {
		return "Seller [id=" + id + ", name=" + name + ", phoneName=" + phoneName + ", phoneNum=" + phoneNum
				+ ", onTime=" + onTime + ", address=" + address + ", addressStr=" + addressStr + ", goods=" + goods
				+ ", introduceText=" + introduceText + ", introduceImage=" + introduceImage + ", isValid=" + isValid
				+ "]";
	}
	
}
