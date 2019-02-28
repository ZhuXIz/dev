package com.jdkj.wx.service;

import java.util.List;

import com.jdkj.wx.entity.Evaluate;
import com.jdkj.wx.entity.MyCollection;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.MyCollQuery;

public interface IMyCollectionService extends IBaseService<MyCollection>{


	boolean removeColl(MyCollection coll);

	PageList<MyCollection> getMyColl(MyCollQuery query);

	boolean getByGoodsId(MyCollection coll);

	boolean removeCollById(MyCollection coll);

}
