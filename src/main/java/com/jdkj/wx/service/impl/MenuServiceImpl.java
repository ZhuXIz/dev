package com.jdkj.wx.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jdkj.wx.entity.Menu;
import com.jdkj.wx.mapper.MenuMapper;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.service.IMenuService;
@Service
public class MenuServiceImpl extends BaseServiceImpl<Menu> implements IMenuService{
	@Autowired
	protected MenuMapper menuMapper;
	
	
	/*删除*/
	@Override
	@Transactional
	public boolean remove(Serializable id) {
		try {
			menuMapper.remove(id);
		}catch (Exception e) {
			return false;
		}
		return true;
	}

	/*修改*/
	@Override
	@Transactional
	public void update(Menu spell) {
		try {
			menuMapper.update(spell);
		}catch (Exception e) {
		}
	}
	/*添加*/
	@Override
	@Transactional
	public void add(Menu spell) {
		try {
			menuMapper.add(spell);
		}catch (Exception e) {
		}
	}
	
	/*查询所有优惠券活动*/
	@Override
	public PageList<Menu> getAll(BaseQuery<Menu> query) {
		long count = menuMapper.getCountAll();
		int row = query.getRows();
		long total = count%row!=0?count/row+1:count/row;
		PageList<Menu> pageList = new PageList<Menu>(total,menuMapper.getAllQuery(query));
        return pageList;
	}
	
	@Override
	public Menu getById(Serializable id) {
		return menuMapper.getById(id);
	}

	@Override
	public List<Menu> show() {
		List<Menu> list = menuMapper.show();
		System.out.println("菜单"+list);
		return list;
	}
	
	@Override
	public List<Menu> getMenuByRole(Integer id) {
		List<Menu> list = menuMapper.getMenuByRole(id);
		System.out.println("菜单"+list);
		return list;
	}
	
	@Override
	public List<Menu> getMenu(Integer id) {
		List<Menu> list = menuMapper.getMenu(id);
		System.out.println("菜单"+list);
		return list;
	}

	@Override
	public PageList<Menu> getAllParentByMenu(Menu menu) {
		PageList<Menu> pageList = new PageList<Menu>();
		// 统计总记录数
		Integer count = menuMapper.getTotal(menu);
		pageList.setCount(count);
		pageList.setRows(menuMapper.getAllParentByMenu(menu));
        return pageList;
	}

	@Override
	public PageList<Menu> getAllItem(Menu menu) {
		PageList<Menu> pageList = new PageList<Menu>();
		// 统计总记录数
		Integer count = menuMapper.getItemTotal(menu);
		pageList.setCount(count);
		pageList.setRows(menuMapper.getAllItem(menu));
        return pageList;
	}

	@Override
	public void updateParentUrl(Integer id) {
		try {
			menuMapper.updateParentUrl(id);
		}catch (Exception e) {
			
		}
		
	}

	@Override
	public List<Menu> getAllMenu() {
		// TODO Auto-generated method stub
		return menuMapper.getAllMenu();
	}

	@Override
	public int checkItem(Integer id) {
		// TODO Auto-generated method stub
		return menuMapper.checkItem(id);
	}
	
}
