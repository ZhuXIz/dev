package com.jdkj.wx.common.task;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.jdkj.wx.service.IGoodsService;
import com.jdkj.wx.service.IOrderService;
import com.jdkj.wx.service.ISpellListService;

@EnableScheduling  
@Component  
public class MyTask {  
	/*订单状态
	 * 0==全部完成
	 * 1==进行中
	 * 2==完成未评论
	 * 3==被取消的（涉及金额自动退款）<---->显示退款中
	 * 4==拼团任务（未完成/提示申请退款）
	 * 5==下单未支付
	 * 6==订单被取消，退款完成
	 * 7==订单支付超时
	 * --*/
	@Autowired
	private IGoodsService goodsService;
	@Autowired
	private ISpellListService spellService;
	@Autowired
	private IOrderService orderService;
	//0 0 9-22 * * ? *
	//0 3/59 9-22 * * ? *
	//每小时的零1分执行一次
	@Scheduled(cron = "0 1/59 9-22 * * ?")  
	public void execute(){
		//定时更新商品状态
		goodsService.updateGoodsState();
		//定时更新拼团状态
		spellService.updateState();
		//更新订单状态为4-------活动时间内为完成拼团可以前去订单页面退款
		orderService.updateOrderIsValid();
		//更新订单状态为7-------活动时间内未完成支付，自动取消
		orderService.updateOrderIsValid7();
		//超时未支付订单修改
		orderService.updateIsValidTimeOut();
		System.out.println("定时修改商品和拼团状态!");  
	}  
}  
