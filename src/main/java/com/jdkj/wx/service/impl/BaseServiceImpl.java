package com.jdkj.wx.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jdkj.wx.entity.SpellList;
import com.jdkj.wx.mapper.BaseMapper;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.SpellListQuery;
import com.jdkj.wx.service.IBaseService;
@Service
public class BaseServiceImpl<T> implements IBaseService<T> {
	@Autowired
	protected BaseMapper<T> baseMapper;
	@Override
	@Transactional
	public void add(T t) {
		baseMapper.add(t);
	}

	@Override
	@Transactional
	public void update(T t) {
		baseMapper.update(t);
	}

	@Override
	@Transactional
	public boolean remove(Serializable id) {
		try {
			baseMapper.remove(id);
		}catch (Exception e) {
			return false;
		}
		return true;
	}

	@Override
	public T getById(Serializable id) {
		return baseMapper.getById(id);
	}
	
	@Override
	public List<T> getAll() {
		return baseMapper.getAll();
	}

	@Override
	public PageList<T> getAll(BaseQuery<T> query) {
		long count = baseMapper.getCount(query);
		int row = query.getRows();
		long total = count%row!=0?count/row+1:count/row;
		PageList<T> pageList = new PageList<T>(total,baseMapper.getAllQuery(query));
        return pageList;
	}

	public PageList<SpellList> getAll(SpellListQuery query) {
		// TODO Auto-generated method stub
		return null;
	}


}
