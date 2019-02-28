package com.jdkj.wx.service;

import java.util.List;

import com.jdkj.wx.entity.Menu;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.MenuQuery;

public interface IMenuService extends IBaseService<Menu> {

	List<Menu> show();

	List<Menu> getMenuByRole(Integer id);
	
	List<Menu> getMenu(Integer id);

	PageList<Menu> getAllParentByMenu(Menu menu);

	PageList<Menu> getAllItem(Menu menu);

	void updateParentUrl(Integer pid);

	List<Menu> getAllMenu();

	int checkItem(Integer id);
}
