package com.jdkj.wx.service.impl;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jdkj.wx.common.util.ScoreUtil;
import com.jdkj.wx.entity.Config;
import com.jdkj.wx.entity.Employee;
import com.jdkj.wx.entity.User;
import com.jdkj.wx.mapper.UserMapper;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.service.IUserService;
@Service
public class UserServiceImpl extends BaseServiceImpl<User> implements IUserService {

	@Autowired
	protected UserMapper userMapper;
	@Override
	@Transactional
	public void add(User user) {
		userMapper.add(user);
	}

	//后台更新用户信息
	@Override
	@Transactional
	public void update(User user) {
		userMapper.updateUser(user);
	}

	@Override
	@Transactional
	public boolean remove(Serializable id) {
		try {
			userMapper.remove(id);
		}catch (Exception e) {
			return false;
		}
		return true;
	}

	@Override
	public User getById(Serializable id) {
		return userMapper.getById(id);
	}

	@Override
	public PageList<User> getAll(BaseQuery<User> query) {
		long count = userMapper.getCountAll(query);
		int row = query.getRows();
		long total = count%row!=0?count/row+1:count/row;
		PageList<User> pageList = new PageList<User>(total,userMapper.getAllQuery(query),query.getPage());
        return pageList;
	}

	/*更新用户信息*/
	@Override
	@Transactional
	public void updateUser(User user) {
		if(userMapper.selectUser(user.getId())<=0) {
			//初始化
			user.setMoney(new BigDecimal(0));
			user.setScore(0);
			user.setPhoneName("");
			user.setPhoneNum("");
			userMapper.add(user);
		}else {
			userMapper.update(user);
		}
		
	}
	
	

	@Override
	@Transactional
	public void updatePhone(User user) {
		userMapper.updatePhone(user);
		
	}

	@Override
	public String selectPhone(String userId) {
		return userMapper.selectPhone(userId);
		
	}

	@Override
	@Transactional
	public Map<String, Object> sign(String id) {
		
		Map<String, Object> map = new HashMap<>();
		Calendar nowTime =   Calendar.getInstance();//当前时间
		Date nowDate = nowTime.getTime();
		User user = userMapper.getTimes(id);
		Date oldDate = user.getCheckTime();
		if(oldDate!=null&&DateUtils.isSameDay(oldDate, nowDate)) {
			//同一天，不能再签到
			map.put("state", false);
			map.put("message", "今天已签到");
			map.put("times", user.getTimes());
			return map;
		}else {
			//不是同一天,签到并改变状态
			nowTime.add(Calendar.DATE, -1);//你要加减的日期 
			nowDate = nowTime.getTime();
			//判断昨天是否签到--连续签到
			if(oldDate!=null&&DateUtils.isSameDay(oldDate, nowDate)) {
				//昨天签到,操作数据库签到次数+1
				//总次数小于6次操作+1，达到7次，初始化为0
				int times = user.getTimes();
				if(times<6) {
					user.setTimes(times+1);
					user.setScore(ScoreUtil.val(times+1));
					map.put("times", times+1);
				}else {
					//等于大于6
					//再签到,初始化为0
					user.setTimes(0);
					map.put("times", 0);
					user.setScore(ScoreUtil.val(times+1));
				}
			
				try {
					userMapper.updateTimes(user);
					
					map.put("score", user.getScore());
					map.put("message", "签到成功！");
				}catch (Exception e) {
					map.put("state", false);
					map.put("message", "签到功能异常");
					return map;
				}
				
			}else {
				//未连续签到，作为第一次签到
				user.setTimes(1);
				map.put("times", 1);
				user.setScore(ScoreUtil.val(1));
				try {
					userMapper.updateTimes(user);
					map.put("score", user.getScore());
					map.put("message", "签到成功！");
				}catch (Exception e) {
					map.put("state", false);
					map.put("message", "签到功能异常");
					return map;
				}
			}
			map.put("state", true);
			return map;
		}
	}

	@Override
	public User getScore(String id) {
		return userMapper.getScore(id);
	}
	
	@Override
	public boolean checkWx() {
		try {
			if(userMapper.checkWx()<=0)
				return false;
		} catch (Exception e) {
		}
		return true;
	}

	@Override
	@Transactional
	public void updateWxConfig(Map<String, String> map) {
		userMapper.updateWxConfig(map);
	}

	@Override
	@Transactional
	public String getWxconfig() {
		return userMapper.getWxconfig();
	}

	@Override
	@Transactional
	public boolean updateMoney(User user) {
		try {
			userMapper.updateMoney(user);
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	
	/*  public static void main(String[] args) {
	    	Date date1 = new Date();
	    	Date date2 = new Date(119,1,28,1,22);
	    	Date date4 = new Date(119,2,1,11,22);
	    	Calendar rightNow =   Calendar.getInstance();//当前时间
	    	rightNow.setTime(date4);
	    	rightNow.add(Calendar.DATE, -1);//你要加减的日期 
	    	Date  date3=rightNow.getTime(); 
	    	System.out.println("date3:"+date3);
	    	System.out.println("date2:"+date2);
	    	System.out.println("date1:"+date1);
	    	System.out.println("date1:date3"+DateUtils.isSameDay(date1, date3));
	    	System.out.println("date1:date2"+DateUtils.isSameDay(date3, date2));
		}*/
}
