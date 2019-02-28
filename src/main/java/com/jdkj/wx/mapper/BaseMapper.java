package com.jdkj.wx.mapper;

import java.io.Serializable;
import java.util.List;

import com.jdkj.wx.entity.Goods;
import com.jdkj.wx.entity.SpellList;
import com.jdkj.wx.query.BaseQuery;

public interface BaseMapper<T> {
	T getById(Serializable id);


	void add(T t);
	void remove(Serializable id);
	void update(T t);

	long getCount(BaseQuery<T> query);

	List<T> getAllQuery(BaseQuery<T> query);

	List<T> getAll();
}
