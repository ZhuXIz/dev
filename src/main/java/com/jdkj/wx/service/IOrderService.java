package com.jdkj.wx.service;

import java.util.List;

import com.jdkj.wx.entity.Order;
import com.jdkj.wx.entity.User;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.OrderQuery;

public interface IOrderService extends IBaseService<Order> {

	void updateOrderIsValid();
	void updateOrderIsValid7();
	void cancelOrder(int orderId);

	void updateOrder(String userId);
	PageList<Order> getUserOrder(OrderQuery query);
	PageList<Order> getSellerOrder(OrderQuery query);

	void updateUserOrder(Order order);
//改变状态为下单状态

	void updateOrderOk(Integer orderId);

	void updateOrderAllOk(Integer orderId);

	boolean getOne(Order order);

	List<User> getUserByThisGoods(Integer goodsId);
	
	//根据userId和goodsId修改状态--针对isValid=4\5
	void updateOrderSpell(Order order);

	boolean updateIsValid(Order order);
	PageList<Order> getAllByOrder(Order order);
	
	void updateIsValidTimeOut();
	void updateIsValidTimeOutByUser(String userId);
}
