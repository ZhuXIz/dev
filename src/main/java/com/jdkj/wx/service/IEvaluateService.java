package com.jdkj.wx.service;

import java.util.List;

import com.jdkj.wx.entity.Evaluate;
import com.jdkj.wx.entity.Goods;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.EvaluateQuery;

public interface IEvaluateService extends IBaseService<Evaluate> {


	int getEvaluateCount(int goodsId);

	PageList<Evaluate> getEvaluate(EvaluateQuery query);

	boolean check(Evaluate eva);


}
