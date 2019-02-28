package com.jdkj.wx.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jdkj.wx.entity.Evaluate;
import com.jdkj.wx.entity.Goods;
import com.jdkj.wx.mapper.EvaluateMapper;
import com.jdkj.wx.mapper.GoodsMapper;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.EvaluateQuery;
import com.jdkj.wx.service.IEvaluateService;
@Service
public class EvaluateServiceImpl extends BaseServiceImpl<Evaluate> implements IEvaluateService{

	@Autowired
	protected EvaluateMapper evaluateMapper;

	@Override
	@Transactional
	public void add(Evaluate evaluate) {

		//添加评论
		evaluateMapper.add(evaluate);
	}

	@Override
	@Transactional
	public void update(Evaluate evaluate) {
		evaluateMapper.update(evaluate);
	}

	@Override
	@Transactional
	public boolean remove(Serializable id) {
		try {
			evaluateMapper.remove(id);
		}catch (Exception e) {
			return false;
		}
		return true;
	}

	@Override
	public Evaluate getById(Serializable id) {
		return evaluateMapper.getById(id);
	}

	@Override
	public List<Evaluate> getAll() {
		return evaluateMapper.getAll();
	}

	@Override
	public PageList<Evaluate> getEvaluate(EvaluateQuery query) {
		long count = evaluateMapper.getEvaluateCount(query.getGoodsId());
		int row = query.getRows();
		long total = count%row!=0?count/row+1:count/row;
		PageList<Evaluate> pageList = new PageList<Evaluate>(total,evaluateMapper.getEvaluate(query));
        return pageList;
	}

	@Override
	public int getEvaluateCount(int goodsId) {
		return evaluateMapper.getEvaluateCount(goodsId);
	}

	@Override
	public boolean check(Evaluate eva) {
		try {
			if(evaluateMapper.check(eva)<=0)
				return true;
			return false;
		}catch (Exception e) {
			// TODO: handle exception
		}
		return false;
	}

}
