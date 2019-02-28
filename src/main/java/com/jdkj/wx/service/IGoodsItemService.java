package com.jdkj.wx.service;

import java.util.List;

import com.jdkj.wx.entity.GoodsItem;

public interface IGoodsItemService extends IBaseService<GoodsItem> {
	GoodsItem getById(int goodsId);
}
