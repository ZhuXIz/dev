package com.jdkj.wx.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jdkj.wx.entity.Seller;
import com.jdkj.wx.entity.SpellList;
import com.jdkj.wx.mapper.GoodsMapper;
import com.jdkj.wx.mapper.SellerMapper;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.SellerQuery;
import com.jdkj.wx.service.ISellerService;
@Service
public class SellerServiceImpl extends BaseServiceImpl<Seller> implements ISellerService {

	@Autowired
	protected SellerMapper sellerMapper;
	@Autowired
	protected GoodsMapper goodsMapper;
	@Override
	@Transactional
	public void add(Seller seller) {
		sellerMapper.add(seller);
	}

	@Override
	@Transactional
	public void update(Seller seller) {
		sellerMapper.update(seller);
	}

	@Override
	@Transactional
	public boolean remove(Serializable id) {
		try {
			sellerMapper.remove(id);
			goodsMapper.removeBySellerId(id);
		}catch (Exception e) {
			return false;
		}
		return true;
	}

	@Override
	public Seller getById(Serializable id) {
		Seller seller= sellerMapper.getById(id);
		if(seller==null)
			return null;
		return seller;
	}

	@Override
	public List<Seller> getAll() {
		return sellerMapper.getAll();
	}

	@Override
	public boolean getBySellerId(String id) {
		try {
			if(sellerMapper.getBySellerId(id)<=0)
				return true;
			return false;
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}


	
	@Override
	public PageList<Seller> getAll(BaseQuery<Seller> query) {
		long count = sellerMapper.getCount(query);
		int row = query.getRows();
		long total = count%row!=0?count/row+1:count/row;
		PageList<Seller> pageList = new PageList<Seller>(total,sellerMapper.getAllQuery(query),query.getPage(),count);
        return pageList;
	}

	@Override
	@Transactional
	public boolean updatePass(String id) {
		try {
			sellerMapper.updatePass(id);
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}

	@Override
	public PageList<Seller> getAllBySeller(Seller seller) {
		PageList<Seller> pageList = new PageList<Seller>();
		// 统计总记录数
		Integer count = sellerMapper.getTotal(seller);
		pageList.setCount(count);
		pageList.setRows(sellerMapper.getAllBySeller(seller));
        return pageList;
	}
}
