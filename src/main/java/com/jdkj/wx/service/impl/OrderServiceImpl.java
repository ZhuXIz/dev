package com.jdkj.wx.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jdkj.wx.entity.Order;
import com.jdkj.wx.entity.SpellList;
import com.jdkj.wx.entity.User;
import com.jdkj.wx.mapper.OrderMapper;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.OrderQuery;
import com.jdkj.wx.service.IOrderService;
@Service
public class OrderServiceImpl extends BaseServiceImpl<Order> implements IOrderService {

	@Autowired
	protected OrderMapper orderMapper;
	@Override
	@Transactional
	public void add(Order order) {
		orderMapper.add(order);
	}

	@Override
	@Transactional
	public void update(Order order) {
		orderMapper.update(order);
	}

	@Override
	@Transactional
	public boolean remove(Serializable id) {
		try {
			orderMapper.remove(id);
		}catch (Exception e) {
			return false;
		}
		return true;
	}
	@Override
	public Order getById(Serializable id) {
		return orderMapper.getById(id);
	}

	@Override
	public List<Order> getAll() {
		return orderMapper.getAll();
	}

	@Override
	public PageList<Order> getUserOrder(OrderQuery query) {
		long count = orderMapper.getCountByUserId(query.getUserId());
		int row = query.getRows();
		long total = count%row!=0?count/row+1:count/row;
		PageList<Order> pageList = new PageList<Order>(total,orderMapper.getOrder(query));
        return pageList;
	}

	@Override
	@Transactional
	public void cancelOrder(int orderId) {
		orderMapper.cancelOrder(orderId);
		
	}

	/*状态更新，过期订单状态修改*/
	@Override
	@Transactional
	public void updateOrder(String userId) {
		List<Integer> list = orderMapper.getOrderId(userId);
		if(!list.isEmpty()||list.size()>0)
			orderMapper.updateOrder(list);
	}
	/*状态更新，手动改状态*/
	@Override
	@Transactional
	public void updateUserOrder(Order order) {
		orderMapper.updateUserOrder(order);
	}
	/**
	 * 
	 * 商家部分订单处理
	 **/

	/*获取商家的订单*/
	@Override
	public PageList<Order> getSellerOrder(OrderQuery query) {
		long count = orderMapper.getCountByUserId(query.getUserId());
		int row = query.getRows();
		long total = count%row!=0?count/row+1:count/row;
		PageList<Order> pageList = new PageList<Order>(total,orderMapper.getSellerOrder(query));
        return pageList;
	}



	@Override
	public void updateOrderOk(Integer orderId) {
		orderMapper.updateOrderOk(orderId);
	}

	@Override
	public void updateOrderAllOk(Integer orderId) {
		// TODO Auto-generated method stub
		orderMapper.updateOrderAllOk(orderId);
	}

	@Override
	public boolean getOne(Order order) {
		if(orderMapper.getOne(order)<=0) 
			return true;
		return false;
		
	}

	
	//根据userId和goodsId修改状态--针对isValid=4\5
	@Override
	@Transactional
	public void updateOrderSpell(Order order) {
		try {
			orderMapper.updateOrderSpell(order);
		} catch (Exception e) {
			
		}
	}

	@Override
	@Transactional
	public void updateOrderIsValid() {
		try {
			orderMapper.updateOrderIsValid();
		} catch (Exception e) {
			
		}
		
	}
	@Override
	@Transactional
	public void updateOrderIsValid7() {
		try {
			orderMapper.updateOrderIsValid7();
		} catch (Exception e) {
			
		}
		
	}

	@Override
	public boolean updateIsValid(Order order) {
		try {
			orderMapper.updateIsValid(order);
			
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	@Override
	public List<User> getUserByThisGoods(Integer goodsId) {
		List<User> list = orderMapper.getUserByThisGoods(goodsId);
		if(list.size()<=0||list==null)
			return null;
		return list;
	}

	@Override
	public PageList<Order> getAllByOrder(Order order) {
		PageList<Order> pageList = new PageList<Order>();
		// 统计总记录数
		Integer count = orderMapper.getTotal(order);
		pageList.setCount(count);
		pageList.setRows(orderMapper.getAllByOrder(order));
        return pageList;
	}

	@Override
	public void updateIsValidTimeOut() {
		try {
			List<Integer> list = orderMapper.selectTimeOut();
			if(list==null||list.size()<=0)
				return;
			else {
				Order order = null;
				for (Integer id : list) {
					//6===状态：订单被取消
					order = new Order(id,6);
					orderMapper.updateIsValid(order);
				}
			}
		}catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	@Override
	public void updateIsValidTimeOutByUser(String userId) {
		try {
			List<Integer> list = orderMapper.selectTimeOutByUser(userId);
			if(list==null||list.size()<=0)
				return;
			else {
				Order order = null;
				for (Integer id : list) {
					//6===状态：超时未支付
					order = new Order(id,7);
					orderMapper.updateIsValid(order);
				}
			}
		}catch (Exception e) {
		}
	}

}
