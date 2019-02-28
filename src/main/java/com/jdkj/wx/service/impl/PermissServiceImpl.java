package com.jdkj.wx.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jdkj.wx.entity.Menu;
import com.jdkj.wx.entity.Permiss;
import com.jdkj.wx.mapper.PermissMapper;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.service.IPermissService;
@Service
public class PermissServiceImpl extends BaseServiceImpl<Permiss> implements IPermissService{
	@Autowired
	protected PermissMapper permissMapper;
	
	
	/*删除*/
	@Override
	@Transactional
	public boolean remove(Serializable id) {
		try {
			permissMapper.remove(id);
		}catch (Exception e) {
			return false;
		}
		return true;
	}

	/*修改*/
	@Override
	@Transactional
	public void update(Permiss permiss) {
		try {
			permissMapper.update(permiss);
		}catch (Exception e) {
		}
	}
	/*添加*/
	@Override
	@Transactional
	public void add(Permiss permiss) {
		try {
			permissMapper.add(permiss);
		}catch (Exception e) {
		}
	}
	@Override
	public List<Permiss> getAll() {
		return permissMapper.getAll();
	}
	
	/*查询所有优惠券活动*/
	@Override
	public PageList<Permiss> getAll(BaseQuery<Permiss> query) {
		long count = permissMapper.getCount(query);
		int row = query.getRows();
		long total = count%row!=0?count/row+1:count/row;
		PageList<Permiss> pageList = new PageList<Permiss>(total,permissMapper.getAllQuery(query));
        return pageList;
	}
	
	@Override
	public Permiss getById(Serializable id) {
		return permissMapper.getById(id);
	}

	@Override
	@Transactional
	public boolean addMenu(Permiss permiss) {
		try {
			permissMapper.addMenu(permiss);
		}catch (Exception e) {
			return false;
		}
		return true;
	}

	@Override
	@Transactional
	public boolean removeMenu(Permiss permiss) {
		try {
			permissMapper.removeMenu(permiss);
		}catch (Exception e) {
			return false;
		}
		return true;
	}

	@Override
	public PageList<Permiss> getAllByPer(Permiss permiss) {
		PageList<Permiss> pageList = new PageList<Permiss>();
		// 统计总记录数
		Integer count = permissMapper.getTotal(permiss);
		pageList.setCount(count);
		pageList.setRows(permissMapper.getAllByPer(permiss));
        return pageList;
	}

	@Override
	public List<Menu> getMenu(Integer id) {
		List<Menu> list = new ArrayList<Menu>();
		try {
			list = permissMapper.getMenu(id);
		}catch (Exception e) {
			return null;
		}
		return list;
	}

	@Override
	public void removeMenu(Integer id) {
		try {
			permissMapper.removeAllMenu(id);
		}catch (Exception e) {
			
		}
		
	}

	@Override
	public void addAllMenu(Permiss permiss) {
		List<Object> list = new ArrayList<Object>();
		Map<String,Object> map = null;
		try {
			for (Menu menu : permiss.getMenu()) {
				map = new HashMap<String,Object>();
				map.put("pId", permiss.getId());
				map.put("mId", menu.getId());
				list.add(map);
				System.out.println("mapmapmap"+map.toString());
			}
			System.out.println("listlistlistlistlistlistlistlist"+list);
			permissMapper.addAllMenu(list);
		}catch (Exception e) {
			
		}
	}

}
