package com.jdkj.wx.test;

import org.junit.Test;

import com.riversoft.weixin.open.oauth2.OpenOAuth2s;

import junit.framework.Assert;

public class OpenOAuth2sTest {

	 @Test
	    public void testAuthenticationUrl(){
	        String url = OpenOAuth2s.defaultOpenOAuth2s().authenticationUrl("http://hostname.com");
	        Assert.assertNotNull(url);
	    }
}
