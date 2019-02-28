package com.jdkj.wx.entity;

import com.jdkj.wx.page.Page;

public class Contact extends Page{
	private Integer id;
	//公司介绍---(html)
	private String introduce;
	//公司名字
	private String companyName;
	//公司地址
	private String companyAddress;
	//公司相关链接（官网）
	private String companyUrl;
	//联系电话
	private String phoneNum;
	//联系客服(二维码)
	private String service;
	//联系人
	private String phoneName;
	//联系时间上班时间
	private String onTime;
	public Integer getId() {
		return id;
	}
	
	
	public String getService() {
		return service;
	}


	public void setService(String service) {
		this.service = service;
	}


	public void setId(Integer id) {
		this.id = id;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getCompanyAddress() {
		return companyAddress;
	}
	public void setCompanyAddress(String companyAddress) {
		this.companyAddress = companyAddress;
	}
	public String getCompanyUrl() {
		return companyUrl;
	}
	public void setCompanyUrl(String companyUrl) {
		this.companyUrl = companyUrl;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public String getPhoneName() {
		return phoneName;
	}
	public void setPhoneName(String phoneName) {
		this.phoneName = phoneName;
	}
	public String getOnTime() {
		return onTime;
	}
	public void setOnTime(String onTime) {
		this.onTime = onTime;
	}


	@Override
	public String toString() {
		return "Contact [id=" + id + ", introduce=" + introduce + ", companyName=" + companyName + ", companyAddress="
				+ companyAddress + ", companyUrl=" + companyUrl + ", phoneNum=" + phoneNum + ", service=" + service
				+ ", phoneName=" + phoneName + ", onTime=" + onTime + "]";
	}
	

}
