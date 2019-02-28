package com.jdkj.wx.entity;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.jdkj.wx.page.Page;

/**
订单
*/
public class Order extends Page{

	private Integer id;
	/*订单关联商品*/
	private Goods goods;
	
	/*订单所属人*/
	private User user;
	/*下单时间*/
	@JsonFormat(pattern ="yyyy-MM-dd hh:mm",timezone = "GMT+8")
	@DateTimeFormat(pattern = "yyyy-MM-dd hh:00")//存日期时使用 
	private Date oTime;
	/*订单状态
	 * 0==全部完成
	 * 1==进行中
	 * 2==完成未评论
	 * 3==被取消的（涉及金额自动退款）<---->显示退款中
	 * 4==拼团任务（未完成/提示申请退款）
	 * 5==下单未支付
	 * 6==订单被取消，退款完成
	 * 7==订单支付超时超出商品活动期
	 * --*/
	private Integer isValid;
	/*商家id--*/
	private Seller seller;
	
	//订单：接受页面参数
	private Integer goodsId;
	private String sellerId;
	private String userId;
	private BigDecimal price;
	private String name;
	private String phoneNum;
	/*订单类型:
	 * 1==一般订单（个人订单）
	 * 2==拼团订单
	 * */
	private Integer type;
	private BigDecimal payPrice;

	
	public Order() {
		super();
	}


	public Order(Integer id, Integer isValid) {
		super();
		this.id = id;
		this.isValid = isValid;
	}


	public Order(Goods goods, User user) {
		super();
		this.goods = goods;
		this.user = user;
	}

	public Order(Goods goods, User user, Seller seller) {
		super();
		this.goods = goods;
		this.user = user;
		this.seller = seller;
	}




	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public Integer getGoodsId() {
		return goodsId;
	}


	public BigDecimal getPayPrice() {
		return payPrice;
	}


	public void setPayPrice(BigDecimal payPrice) {
		this.payPrice = payPrice;
	}


	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}


	public String getSellerId() {
		return sellerId;
	}


	public Integer getType() {
		return type;
	}


	public void setType(Integer type) {
		this.type = type;
	}


	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}




	public BigDecimal getPrice() {
		return price;
	}


	public void setPrice(BigDecimal price) {
		this.price = price;
	}


	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Goods getGoods() {
		return goods;
	}
	public void setGoods(Goods goods) {
		this.goods = goods;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Date getoTime() {
		return oTime;
	}
	public void setoTime(Date oTime) {
		this.oTime = oTime;
	}

	
	public Integer getIsValid() {
		return isValid;
	}
	public void setIsValid(Integer isValid) {
		this.isValid = isValid;
	}
	public Seller getSeller() {
		return seller;
	}
	public void setSeller(Seller seller) {
		this.seller = seller;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getPhoneNum() {
		return phoneNum;
	}


	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}


	@Override
	public String toString() {
		return "Order [id=" + id + ", goods=" + goods + ", user=" + user + ", oTime=" + oTime + ", isValid=" + isValid
				+ ", seller=" + seller + ", goodsId=" + goodsId + ", sellerId=" + sellerId + ", userId=" + userId
				+ ", price=" + price + ", name=" + name + ", phoneNum=" + phoneNum + ", type=" + type + "]";
	}


	




	
}
