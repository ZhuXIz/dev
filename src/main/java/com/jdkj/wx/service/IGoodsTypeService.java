package com.jdkj.wx.service;

import com.jdkj.wx.entity.GoodsType;
import com.jdkj.wx.page.PageList;

public interface IGoodsTypeService extends IBaseService<GoodsType> {

	PageList<GoodsType> getAllByType(GoodsType goodsType);

}
