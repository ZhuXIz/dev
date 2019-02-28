package com.jdkj.wx.common;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import net.sf.json.JSONObject;



public class WeiXinH5LogUtil {

	
	
    /**********************************微信******************************************/
    
    
	
	private static final Logger logger = LoggerFactory.getLogger(WeiXinH5LogUtil.class);
	private static final Object GET_USERINFO_URL = "https://api.weixin.qq.com/sns/userinfo";
	/**
	 * 获取微信  AccessToken
	 * @author guoliangwen 2018年6月22日 下午2:46:20
	 * @param code 
	 * @param secret2 
	 * @param appid
	 * @param secret
	 * @param code
	 * @return
	 */
	public static String getAccessToken(String appid, String secret, String code) {
        String url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="+appid+"&secret="+secret+"&code="+code+"&grant_type=authorization_code";
        DefaultHttpClient client = new DefaultHttpClient();
        HttpGet get = new HttpGet(url);
        //JsonParser jsonparer = new JsonParser();// 初始化解析json格式的对象
        String result = null;
        try {
            HttpResponse res = client.execute(get);
            HttpEntity entity = res.getEntity();
            result = EntityUtils.toString(entity, "UTF-8");
            return  result;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 关闭连接 ,释放资源
            client.getConnectionManager().shutdown();
            return result;
        }
    }
	
	/**
	 * 获取用户信息
	 * @author guoliangwen 2018年6月22日 下午2:59:33
	 * @param access_token
	 * @param openid
	 * @return
	 */
	public static String getUserInfo(String access_token, String openid) {
        String turl = String.format("%s?access_token=%s&openid=%s", GET_USERINFO_URL,access_token,openid);
        DefaultHttpClient client = new DefaultHttpClient();
        HttpGet get = new HttpGet(turl);
        //JsonParser jsonparer = new JsonParser();// 初始化解析json格式的对象
        String result = null;
        try {
            HttpResponse res = client.execute(get);
            HttpEntity entity = res.getEntity();
            result = EntityUtils.toString(entity, "UTF-8");
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 关闭连接 ,释放资源
            client.getConnectionManager().shutdown();
            return result;
        }
    }
	
	public static JSONObject getOpenId(String appid, String secret,String code) {
		String accessToken = getAccessToken(appid,secret,code);
		JSONObject tokenJson = JSONObject.fromObject(accessToken);
		logger.info("tokenJson : "+tokenJson);
		String info = getUserInfo(tokenJson.getString("access_token"), tokenJson.getString("openid"));
		logger.info("info: "+info);
		return JSONObject.fromObject(info);
	}


}
