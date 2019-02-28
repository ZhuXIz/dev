package com.jdkj.wx.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jdkj.wx.entity.Advert;
import com.jdkj.wx.entity.Order;
import com.jdkj.wx.mapper.AdvertMapper;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.service.IAdvertService;
@Service
public class AdvertServiceImpl extends BaseServiceImpl<Advert> implements IAdvertService{
	

	@Autowired
	protected AdvertMapper advertMapper;
	@Override
	@Transactional
	public void add(Advert advert) {
		advertMapper.add(advert);
	}

	@Override
	@Transactional
	public void update(Advert advert) {
		advertMapper.update(advert);
	}

	@Override
	@Transactional
	public boolean remove(Serializable id) {
		try {
			advertMapper.remove(id);
		}catch (Exception e) {
			return false;
		}
		return true;
	}

	@Override
	public Advert getById(Serializable id) {
		return advertMapper.getById(id);
	}
	@Override
	public List<Advert> getAll() {
		return advertMapper.getAll();
	}

	@Override
	public PageList<Advert> getAll(BaseQuery<Advert> query) {
		long count = advertMapper.getCount(query);
		int row = query.getRows();
		long total = count%row!=0?count/row+1:count/row;
		PageList<Advert> pageList = new PageList<Advert>(total,advertMapper.getAllQuery(query),query.getPage());
        return pageList;
	}

	@Override
	public PageList<Advert> getAllByAdvert(Advert advert) {
		PageList<Advert> pageList = new PageList<Advert>();
		// 统计总记录数
		int count =advertMapper.getTotal(advert);
		pageList.setCount(count);
		pageList.setRows(advertMapper.getAllByAdvert(advert));
        return pageList;
	}
}
