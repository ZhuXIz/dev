package com.jdkj.wx.entity;

public class Config {
	 private String appid;
     // 生成签名的时间戳
     private String timestamp;
     // 生成签名的随机串
     private String nonceStr;
     // 签名
     private String signature;
     private String url;
     
     
     
	public String getAppid() {
		return appid;
	}



	public void setAppid(String appid) {
		this.appid = appid;
	}



	public String getTimestamp() {
		return timestamp;
	}



	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}



	public String getNonceStr() {
		return nonceStr;
	}



	public void setNonceStr(String nonceStr) {
		this.nonceStr = nonceStr;
	}



	public String getSignature() {
		return signature;
	}



	public void setSignature(String signature) {
		this.signature = signature;
	}



	public String getUrl() {
		return url;
	}



	public void setUrl(String url) {
		this.url = url;
	}



	@Override
	public String toString() {
		return "Config [appid=" + appid + ", timestamp=" + timestamp + ", nonceStr=" + nonceStr + ", signature="
				+ signature + ", url=" + url + "]";
	}
     
     
}
