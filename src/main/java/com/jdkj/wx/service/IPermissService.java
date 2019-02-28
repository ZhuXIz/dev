package com.jdkj.wx.service;

import java.util.List;

import com.jdkj.wx.entity.Menu;
import com.jdkj.wx.entity.Permiss;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.PermissQuery;

public interface IPermissService extends IBaseService<Permiss> {
	boolean addMenu(Permiss permiss);
	boolean removeMenu(Permiss permiss);
	PageList<Permiss> getAllByPer(Permiss permiss);
	List<Menu> getMenu(Integer id);
	void removeMenu(Integer id);
	void addAllMenu(Permiss permiss);
}
