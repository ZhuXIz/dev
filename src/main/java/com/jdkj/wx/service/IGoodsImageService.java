package com.jdkj.wx.service;

import java.util.List;

import com.jdkj.wx.entity.GoodsImage;

public interface IGoodsImageService extends IBaseService<GoodsImage> {

	void add(List<GoodsImage> list);

	void removeByGoodsId(Integer id);


}
