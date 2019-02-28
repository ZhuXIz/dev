package com.jdkj.wx.common;

public class Constant {
	public static final String PRE_MYCOLL_ADDRESS = "/wx/goods/goods?goodsId=";
	public static final int MS_APP_ID = 1400174314;
	public static final String MS_APP_KEY = "164f5f587690fcb356704c7b2d9cf073";

	// 短信模板ID，需要在短信应用中申请
	public static final int TEMPLATE_ID = 7839; // NOTE: 这里的模板ID`7839`只是一个示例，真实的模板ID需要在短信控制台中申请
	//templateId7839对应的内容是"您的验证码是: {1}"
	// 签名
	public static final String SMS_SIGN = "腾讯云"; // NOTE: 这里的签名"腾讯云"只是一个示例，真实的签名需要在短信控制台中申请，另外签名参数使用的是`签名内容`，而不是`签名ID`
}
