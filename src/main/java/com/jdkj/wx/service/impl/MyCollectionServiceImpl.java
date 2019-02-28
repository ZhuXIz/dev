package com.jdkj.wx.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jdkj.wx.entity.Evaluate;
import com.jdkj.wx.entity.MyCollection;
import com.jdkj.wx.entity.Order;
import com.jdkj.wx.mapper.MyCollectionMapper;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.MyCollQuery;
import com.jdkj.wx.service.IMyCollectionService;
@Service
public class MyCollectionServiceImpl extends BaseServiceImpl<MyCollection> implements IMyCollectionService {

	@Autowired
	protected MyCollectionMapper myCollectionMapper;
	@Override
	@Transactional
	public void add(MyCollection myCollection) {
			try {
				if(myCollectionMapper.checkHas(myCollection)<=0) {
					myCollectionMapper.add(myCollection);
				}else {
					myCollectionMapper.updateIsCollTrue(myCollection);
				}
			
			}catch (Exception e) {
				e.printStackTrace();
			}
	}

	@Override
	@Transactional
	public void update(MyCollection myCollection) {
		myCollectionMapper.update(myCollection);
	}

	@Override
	@Transactional
	public boolean remove(Serializable id) {
		try {
			myCollectionMapper.remove(id);
		}catch (Exception e) {
			return false;
		}
		return true;
	}
	@Override
	public MyCollection getById(Serializable id) {
		return myCollectionMapper.getById(id);
	}

	@Override
	public List<MyCollection> getAll() {
		return myCollectionMapper.getAll();
	}


	@Override
	@Transactional
	public boolean removeColl(MyCollection coll) {
		// TODO Auto-generated method stub
		try{
			myCollectionMapper.updateIsCollFalse(coll);
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	@Override
	@Transactional
	public boolean removeCollById(MyCollection coll) {
		// TODO Auto-generated method stub
		try{
			myCollectionMapper.updateIsCollFalseById(coll);
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public PageList<MyCollection> getMyColl(MyCollQuery query) {
		long count = myCollectionMapper.getCount(query.getUserId());
		int row = query.getRows();
		long total = count%row!=0?count/row+1:count/row;
		PageList<MyCollection> pageList = new PageList<MyCollection>(total,myCollectionMapper.getMyColl(query));
        return pageList;
	}

	@Override
	public boolean getByGoodsId(MyCollection coll) {
		
		if(myCollectionMapper.checkHas(coll)<=0) {
			return false;
		}else {
			return myCollectionMapper.getByGoodsId(coll);
		}
	
	}

}
