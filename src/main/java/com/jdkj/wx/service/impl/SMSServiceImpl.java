package com.jdkj.wx.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jdkj.wx.common.Constant;
import com.jdkj.wx.entity.SMS;
import com.jdkj.wx.entity.Seller;
import com.jdkj.wx.mapper.SMSMapper;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.SMSQuery;
import com.jdkj.wx.service.ISMSService;
import com.github.qcloudsms.SmsSingleSender;
import com.github.qcloudsms.SmsSingleSenderResult;
import com.github.qcloudsms.httpclient.HTTPException;
import org.json.JSONException;

import java.io.IOException;
@Service
public class SMSServiceImpl extends BaseServiceImpl<SMS> implements ISMSService{
	@Autowired
	protected SMSMapper smsMapper;
	
	
	/*删除*/
	@Override
	@Transactional
	public boolean remove(Serializable id) {
		try {
			smsMapper.remove(id);
		}catch (Exception e) {
			return false;
		}
		return true;
	}

	/*修改*/
	@Override
	@Transactional
	public void update(SMS spell) {
		try {
			smsMapper.update(spell);
		}catch (Exception e) {
		}
	}
	/*添加*/
	@Override
	@Transactional
	public void sendOne(Seller seller) {
		try {
		    String[] params = {"5678"};//数组具体的元素个数和模板中变量个数必须一致，例如事例中templateId:5678对应一个变量，参数数组中元素个数也必须是一个
		    SmsSingleSender ssender = new SmsSingleSender(Constant.MS_APP_ID, Constant.MS_APP_KEY);
		    SmsSingleSenderResult result = ssender.sendWithParam("86", seller.getPhoneNum(),
		    		Constant.TEMPLATE_ID, params, Constant.SMS_SIGN, "", "");  // 签名参数未提供或者为空时，会使用默认签名发送短信
		    System.out.println(result);
		    smsMapper.add(new SMS(result.toString(),seller));
		} catch (HTTPException e) {
		    // HTTP响应码错误
		    e.printStackTrace();
		} catch (JSONException e) {
		    // json解析错误
		    e.printStackTrace();
		} catch (IOException e) {
		    // 网络IO错误
		    e.printStackTrace();
		}
	}
	
	/*查询所有优惠券活动*/
	@Override
	public PageList<SMS> getAll(BaseQuery<SMS> query) {
		long count = smsMapper.getCountAll();
		int row = query.getRows();
		long total = count%row!=0?count/row+1:count/row;
		PageList<SMS> pageList = new PageList<SMS>(total,smsMapper.getAllQuery(query));
        return pageList;
	}
	
	@Override
	public SMS getById(Serializable id) {
		return smsMapper.getById(id);
	}

	@Override
	public void sendMany(List<Seller> sellers) {
		// TODO Auto-generated method stub
		
	}
}
