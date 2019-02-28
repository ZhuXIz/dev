package com.jdkj.wx.common.payment;

import com.github.wxpay.sdk.WXPayConfig;
import org.apache.commons.io.IOUtils;

import java.io.ByteArrayInputStream;
import java.io.InputStream;

/** 配置我们自己的信息  */

public class OurWxPayConfig implements WXPayConfig {

    /** 加载证书  这里证书需要到微信商户平台进行下载*/
    private byte [] certData;

    public OurWxPayConfig() throws  Exception{
        InputStream certStream = Thread.currentThread().getContextClassLoader().getResourceAsStream("cert/apiclient_cert.p12");
        this.certData = IOUtils.toByteArray(certStream);
        certStream.close();
    }

    /** 设置我们自己的appid
     * 商户号
     * 秘钥
     * */

    @Override
    public String getAppID() {
        return "wx816d0f9d1eb55226";
    }

    @Override
    public String getMchID() {
        return "1518410901";
    }

    @Override
    public String getKey() {
        return "a32s1fa6sfas56f1a65sf1a635sf165a";
    }

    @Override
    public InputStream getCertStream() {
        return new ByteArrayInputStream(this.certData);
    }

    @Override
    public int getHttpConnectTimeoutMs() {
        return 0;
    }

    @Override
    public int getHttpReadTimeoutMs() {
        return 0;
    }
}