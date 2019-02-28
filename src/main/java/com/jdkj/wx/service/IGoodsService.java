package com.jdkj.wx.service;

import java.util.List;

import com.jdkj.wx.common.ResponseResult;
import com.jdkj.wx.entity.Goods;
import com.jdkj.wx.entity.GoodsType;
import com.jdkj.wx.entity.MyCollection;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.GoodsQuery;

public interface IGoodsService extends IBaseService<Goods> {
	List<Goods> getFirst();
	List<Goods> getMore(BaseQuery<Goods> query);
	PageList<Goods> getMoreByType(GoodsQuery query);
	List<GoodsType> getGoodsType();
	boolean updateState(Goods goods);
	void updateBrowNum(int goodsId);
	PageList<Goods> getSellerGoods(GoodsQuery query);
	boolean removeSellerGoods(int goodsId);
	//修改payType状态
	void updatePayType(Goods goods);
	void updateValidByNum(int goodsId);
	void addSoldNum(Integer goodsId);
	void removeSoldNum(Integer goodsId);
	boolean getNum(Integer goodsId);
	boolean getBySellerId(String id);
	void updateGoodsState();
	List<Goods> getSellerGoods(Integer sellerId);
	
	void updateGoods(Goods goods);
	//bootStrap
	PageList<Goods> getAllGoodsBySeller(Goods goods);
	PageList<Goods> getAllGoods(Goods goods);
	Goods getGoodsTime(Integer goodsId);
	ResponseResult addAll(Goods goods);
}
