package com.jdkj.wx.service;

import java.util.Map;

import com.jdkj.wx.entity.Config;
import com.jdkj.wx.entity.User;

public interface IUserService extends IBaseService<User> {

	void updateUser(User userId);

	void updatePhone(User user);

	String selectPhone(String userId);

	Map<String, Object> sign(String string);

	boolean checkWx();

	void updateWxConfig(Map<String, String> map);

	String getWxconfig();

	User getScore(String id);
	boolean updateMoney(User user);
}
