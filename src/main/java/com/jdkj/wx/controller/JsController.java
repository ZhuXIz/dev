package com.jdkj.wx.controller;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jdkj.wx.common.WXConfig;
import com.jdkj.wx.common.util.SignUtil;
 
 
@Controller
@RequestMapping("/test")
public class JsController {
 
	private static final String CORPID=WXConfig.APP_ID;
	private static final String CORPSECRET=WXConfig.APP_SECRET;
	
	@RequestMapping("/getAccessToken")
	public void getAccessToken(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String urlStr = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid="+CORPID+"&corpsecret="+CORPSECRET;  
        processUrl(response, urlStr);  
	}
	
	@RequestMapping("/getTsapiTicket")
	public void getTsapiTicket(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String access_token = request.getParameter("access_token");
		String urlStr = "https://qyapi.weixin.qq.com/cgi-bin/get_jsapi_ticket?access_token="+access_token;  
		processUrl(response, urlStr);  
	}
	@RequestMapping("/getJsSdkSign")
	public void getJsSdkSign(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String noncestr = request.getParameter("noncestr");
		String tsapiTicket = request.getParameter("jsapi_ticket");
		String timestamp = request.getParameter("timestamp");
		String url = request.getParameter("url");
		String jsSdkSign = SignUtil.getJsSdkSign(noncestr, tsapiTicket, timestamp, url);
		PrintWriter out = response.getWriter();
		out.print(jsSdkSign);
	}
	
	private void processUrl(HttpServletResponse response, String urlStr) {
		URL url;
		try {
			url = new URL(urlStr);
			URLConnection URLconnection = url.openConnection();  
			HttpURLConnection httpConnection = (HttpURLConnection)URLconnection;  
			int responseCode = httpConnection.getResponseCode();  
			if (responseCode == HttpURLConnection.HTTP_OK) {  
				InputStream urlStream = httpConnection.getInputStream();  
				BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(urlStream));  
				String sCurrentLine = "";  
				String sTotalString = "";  
				while ((sCurrentLine = bufferedReader.readLine()) != null) {  
					sTotalString += sCurrentLine;  
				}  
				PrintWriter out = response.getWriter();
				out.print(sTotalString);
			}else{
				System.err.println("失败");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

