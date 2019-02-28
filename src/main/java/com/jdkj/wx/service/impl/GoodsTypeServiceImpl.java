package com.jdkj.wx.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jdkj.wx.entity.Advert;
import com.jdkj.wx.entity.GoodsType;
import com.jdkj.wx.mapper.GoodsTypeMapper;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.service.IGoodsTypeService;
@Service
public class GoodsTypeServiceImpl extends BaseServiceImpl<GoodsType> implements IGoodsTypeService{

	@Autowired
	protected GoodsTypeMapper goodsTypeMapper;
	@Override
	@Transactional
	public void add(GoodsType goodsType) {
		goodsTypeMapper.add(goodsType);
	}

	@Override
	@Transactional
	public void update(GoodsType goodsType) {
		goodsTypeMapper.update(goodsType);
	}

	@Override
	@Transactional
	public boolean remove(Serializable id) {
		try {
			goodsTypeMapper.remove(id);
		}catch (Exception e) {
			return false;
		}
		return true;
	}

	@Override
	public GoodsType getById(Serializable id) {
		return goodsTypeMapper.getById(id);
	}

	@Override
	public List<GoodsType> getAll() {
		return goodsTypeMapper.getAll();
	}

	@Override
	public PageList<GoodsType> getAllByType(GoodsType goodsType) {
		PageList<GoodsType> pageList = new PageList<GoodsType>();
		// 统计总记录数
		int count =goodsTypeMapper.getTotal(goodsType);
		pageList.setCount(count);
		pageList.setRows(goodsTypeMapper.getAllByType(goodsType));
        return pageList;
	}
}
