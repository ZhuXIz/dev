package com.jdkj.wx.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jdkj.wx.entity.GoodsImage;
import com.jdkj.wx.mapper.GoodsImageMapper;
import com.jdkj.wx.service.IGoodsImageService;


@Service
public class GoodsImageServiceImpl extends BaseServiceImpl<GoodsImage> implements IGoodsImageService {

	@Autowired
	protected GoodsImageMapper goodsImageMapper;
	@Override
	@Transactional
	public void add(GoodsImage goodsImage) {
		for (String str : goodsImage.getImage().split(",")) {
			new GoodsImage(str,goodsImage.getGoods());
			goodsImageMapper.add(goodsImage);
		}
		
	}

	@Override
	@Transactional
	public void update(GoodsImage goodsImage) {
		goodsImageMapper.update(goodsImage);
	}

	@Override
	@Transactional
	public boolean remove(Serializable id) {
		try {
			goodsImageMapper.remove(id);
		}catch (Exception e) {
			return false;
		}
		return true;
	}
	@Override
	public GoodsImage getById(Serializable id) {
		return goodsImageMapper.getById(id);
	}

	@Override
	public List<GoodsImage> getAll() {
		return goodsImageMapper.getAll();
	}

	

	@Override
	@Transactional
	public void add(List<GoodsImage> list) {
		try {
			
			if(list.size()>0) {
				if(goodsImageMapper.getByGoodsId(list.get(0).getGoods().getId())!=null) {
					goodsImageMapper.removeByGoodsId(list.get(0).getGoods().getId());
				}
				goodsImageMapper.addAll(list);
			}
		}catch (Exception e) {
		}
		
	}

	@Override
	public void removeByGoodsId(Integer goodsId) {
		try {
			goodsImageMapper.removeByGoodsId(goodsId);
		}catch (Exception e) {
			// TODO: handle exception
		}
	}

}
