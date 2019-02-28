package com.jdkj.wx.service;

import java.io.Serializable;
import java.util.List;

import com.jdkj.wx.entity.Employee;
import com.jdkj.wx.entity.SpellList;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.SpellListQuery;

public interface IBaseService<T> {
	T getById(Serializable id);
	List<T> getAll();
	PageList<T> getAll(BaseQuery<T> query);

	void add(T t);
	boolean remove(Serializable id);
	void update(T t);

	
}
