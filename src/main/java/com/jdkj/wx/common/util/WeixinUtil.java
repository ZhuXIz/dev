package com.jdkj.wx.common.util;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.ThreadLocalRandom;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jdkj.wx.common.WXConfig;
import com.jdkj.wx.entity.Config;
/**
 * 微信分享api
 */
@Controller
@RequestMapping(value = "/weiChat")
public class WeixinUtil{
	
	// 获取config初始化参数
    public static Config getConfig(String url,String JSAPI_TICKET)throws Exception{
        Config config = new Config();
        config.setAppid(WXConfig.APP_ID);
        String timestamp = String.valueOf(System.currentTimeMillis()/1000);
        config.setTimestamp(timestamp);
        String nonceStr = String.valueOf(ThreadLocalRandom.current().nextInt(89999999)+10000000);
        config.setNonceStr(nonceStr);
        String signature = getSignature(JSAPI_TICKET,nonceStr,timestamp,url);
        config.setSignature(signature);
        config.setUrl(url);
        return config;
    }
	
 // 对参数进行签名
    public static String getSignature(String jsapi_ticket, String noncestr, String timestamp, String url) {
        Map<String, String> params = new HashMap();
        params.put("jsapi_ticket", jsapi_ticket);
        params.put("noncestr", noncestr);
        params.put("timestamp", timestamp);
        params.put("url", url);
        Map<String, String> sortParams = sortAsc(params);
        String string1 = mapJoin(sortParams, false);

        try {
            return DigestUtils.sha1Hex(string1.getBytes("UTF-8"));
        } catch (IOException var8) {
            return "";
        }
    }
    
 // 对参数进行排序，得到一个有序的参数列表

    public static Map<String, String> sortAsc(Map<String, String> map) {
        HashMap<String, String> tempMap = new LinkedHashMap();
        List<Entry<String, String>> infoIds = new ArrayList(map.entrySet());
        Collections.sort(infoIds, new Comparator<Entry<String, String>>() {
            public int compare(Entry<String, String> o1, Entry<String, String> o2) {
                return ((String)o1.getKey()).compareTo((String)o2.getKey());
            }
        });

        for(int i = 0; i < infoIds.size(); ++i) {
            Entry<String, String> item = (Entry)infoIds.get(i);
            tempMap.put(item.getKey(), item.getValue());
        }

        return tempMap;
    }
    
    
 // 组装参数，获得string1

    public static String mapJoin(Map<String, String> map, boolean valueUrlEncode) {
        StringBuilder sb = new StringBuilder();
        Iterator it = map.keySet().iterator();

        while(true) {
            String key;
            do {
                do {
                    if (!it.hasNext()) {
                        if (sb.length() > 0) {
                            sb.deleteCharAt(sb.length() - 1);
                        }

                        return sb.toString();
                    }

                    key = (String)it.next();
                } while(map.get(key) == null);
            } while("".equals(map.get(key)));

            try {
                String temp = key.endsWith("_") && key.length() > 1 ? key.substring(0, key.length() - 1) : key;
                sb.append(temp);
                sb.append("=");
                String value = (String)map.get(key);
                if (valueUrlEncode) {
                    value = URLEncoder.encode((String)map.get(key), "utf-8").replace("+", "%20");
                }

                sb.append(value);
                sb.append("&");
            } catch (UnsupportedEncodingException var7) {
                var7.printStackTrace();
            }
        }
    }
	
 // 最终方法是
    protected static char[] encodeHex(byte[] data, char[] toDigits) {
            int l = data.length;
            char[] out = new char[l << 1];
            int i = 0;

            for(int var5 = 0; i < l; ++i) {
                out[var5++] = toDigits[(240 & data[i]) >>> 4];
                out[var5++] = toDigits[15 & data[i]];
            }

            return out;
        }
    
    
    
	/*@RequestMapping("/config")
    public void getConfig(HttpServletRequest request, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
        String appId = WXConfig.APP_ID;
        // 获取页面路径(前端获取时采用location.href.split('#')[0]获取url)
        String url = request.getRequestURL().toString() + "/";
        // 获取ticket
        String jsapi_ticket = "";
        // 获取Unix时间戳(java时间戳为13位,所以要截取最后3位,保留前10位)
        String timeStamp = Long.toString(System.currentTimeMillis() / 1000);
        String noncestr = UUID.randomUUID().toString();
        // 注意这里参数名必须全部小写，且必须有序
        String sign = "jsapi_ticket=" + jsapi_ticket + "&noncestr=" + noncestr + "&timeStamp=" + timeStamp + "&url=" + url;

        String signature = SHA1(sign);
        // 组装完毕，回传
        Map<String, Object> ret = new HashMap<String, Object>();
        ret.put("appId", appId);
        ret.put("timestamp", timeStamp);
        ret.put("nonceStr", noncestr);
        ret.put("signature", signature);
        System.out.println(ret);
        try {
            JSONArray jsonArray = JSONArray.fromObject(ret);
            // System.out.println(jsonArray.toString());
            PrintWriter out = response.getWriter();
            out.print(jsonArray);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
	private String SHA1(String sign) {
        try {
            MessageDigest digest = java.security.MessageDigest.getInstance("SHA-1");
            digest.update(sign.getBytes());
            byte messageDigest[] = digest.digest();
            // Create Hex String
            StringBuffer hexString = new StringBuffer();
            // 字节数组转换为 十六进制 数
            for (int i = 0; i < messageDigest.length; i++) {
                String shaHex = Integer.toHexString(messageDigest[i] & 0xFF);
                if (shaHex.length() < 2) {
                    hexString.append(0);
                }
                hexString.append(shaHex);
            }
            return hexString.toString();

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return "";
    }*/
}
