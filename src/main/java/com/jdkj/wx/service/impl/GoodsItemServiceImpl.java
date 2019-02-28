package com.jdkj.wx.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jdkj.wx.entity.GoodsItem;
import com.jdkj.wx.mapper.GoodsItemMapper;
import com.jdkj.wx.service.IGoodsItemService;
@Service
public class GoodsItemServiceImpl extends BaseServiceImpl<GoodsItem> implements IGoodsItemService {


	@Autowired
	protected GoodsItemMapper goodsItemMapper;
	@Override
	@Transactional
	public void add(GoodsItem goodsItem) {
		goodsItemMapper.add(goodsItem);
	}

	@Override
	@Transactional
	public void update(GoodsItem goodsItem) {
		goodsItemMapper.update(goodsItem);
	}

	@Override
	@Transactional
	public boolean remove(Serializable id) {
		try {
			goodsItemMapper.remove(id);
		}catch (Exception e) {
			return false;
		}
		return true;
	}

	@Override
	public GoodsItem getById(Serializable id) {
		return goodsItemMapper.getById(id);
	}

	@Override
	public List<GoodsItem> getAll() {
		return goodsItemMapper.getAll();
	}

	@Override
	public GoodsItem getById(int goodsId) {
		return goodsItemMapper.getByGoodsId(goodsId);
	}
}
