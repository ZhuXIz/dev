package com.jdkj.wx.service;

import java.util.List;

import com.jdkj.wx.entity.SMS;
import com.jdkj.wx.entity.Seller;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.SMSQuery;

public interface ISMSService extends IBaseService<SMS>{
	void sendOne(Seller seller);
	void sendMany(List<Seller> sellers);
}
