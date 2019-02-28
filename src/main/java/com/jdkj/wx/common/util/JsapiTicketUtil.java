package com.jdkj.wx.common.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.Map;

import com.jdkj.wx.common.WXConfig;

import net.sf.json.JSONObject;

public class JsapiTicketUtil {

	/***
	 * 模拟get请求
	 * 
	 * @param url
	 * @param charset
	 * @param timeout
	 * @return
	 */
	public static String sendGet(String url, String charset, int timeout) {
		String result = "";
		try {
			URL u = new URL(url);
			try {
				URLConnection conn = u.openConnection();
				conn.connect();
				conn.setConnectTimeout(timeout);
				BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), charset));
				String line = "";
				while ((line = in.readLine()) != null) {

					result = result + line;
				}
				in.close();
			} catch (IOException e) {
				return result;
			}
		} catch (MalformedURLException e) {
			return result;
		}

		return result;
	}

	/***
	 * 获取acess_token 来源www.vxzsk.com
	 * 
	 * @return
	 */
	public static String getAccessToken() {
		String appid = WXConfig.APP_ID;// 应用ID
		String appSecret = WXConfig.APP_SECRET;// (应用密钥)
		String url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + appid + "&secret="
				+ appSecret + "";
		String backData = sendGet(url, "utf-8", 10000);
		String accessToken = (String) JSONObject.fromObject(backData).get("access_token");
		return accessToken;
	}

	/***
	 * 获取jsapiTicket 来源 www.vxzsk.com
	 * 
	 * @return
	 */
	public static Map<String, String> getJSApiTicket() {
		Map<String, String> map = new HashMap<String, String>();
		// 获取token
		String acess_token = JsapiTicketUtil.getAccessToken();

		String urlStr = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=" + acess_token
				+ "&type=jsapi";
		String backData = sendGet(urlStr, "utf-8", 10000);
		String jsapiTicket = (String) JSONObject.fromObject(backData).get("ticket");
		map.put("jsapiTicket", jsapiTicket);
		map.put("acess_token", acess_token);
		return map;
	}

	public static void main(String[] args) throws Exception {
		Map<String, String> map = JsapiTicketUtil.getJSApiTicket();
		System.out.println("调用微信jsapi的凭证票为：" + WeixinUtil.getConfig("sss",map.get("jsapiTicket")));
	}
}
