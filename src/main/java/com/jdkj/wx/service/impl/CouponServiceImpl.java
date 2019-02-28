package com.jdkj.wx.service.impl;

import java.io.Serializable;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jdkj.wx.entity.Coupon;
import com.jdkj.wx.mapper.CouponMapper;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.service.ICouponService;
@Service
public class CouponServiceImpl extends BaseServiceImpl<Coupon> implements ICouponService{
	@Autowired
	protected CouponMapper couponMapper;
	
	
	/*删除*/
	@Override
	@Transactional
	public boolean remove(Serializable id) {
		try {
			couponMapper.remove(id);
		}catch (Exception e) {
			return false;
		}
		return true;
	}

	/*修改*/
	@Override
	@Transactional
	public void update(Coupon spell) {
		try {
			couponMapper.update(spell);
		}catch (Exception e) {
		}
	}
	/*添加*/
	@Override
	@Transactional
	public void add(Coupon spell) {
		try {
			couponMapper.add(spell);
		}catch (Exception e) {
		}
	}
	
	/*查询所有优惠券活动*/
	@Override
	public PageList<Coupon> getAll(BaseQuery<Coupon> query) {
		long count = couponMapper.getCountAll();
		int row = query.getRows();
		long total = count%row!=0?count/row+1:count/row;
		PageList<Coupon> pageList = new PageList<Coupon>(total,couponMapper.getAll());
        return pageList;
	}
	
	@Override
	public Coupon getById(Serializable id) {
		return couponMapper.getById(id);
	}
}
