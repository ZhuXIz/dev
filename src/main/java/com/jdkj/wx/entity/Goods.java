package com.jdkj.wx.entity;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.jdkj.wx.page.Page;



/**
商品
*/

public class Goods extends Page{

	private Integer id;
	/*商家*/
	private Seller seller;
	/*支付类型*/
	private Integer payType;
	/*商品类型*/
	private GoodsType goodsType;
	/*商品名*/
	private String titleName;
	/*活动发布时间*/
	/*活动开始时间*/
	@JsonFormat(pattern ="yyyy-MM-dd HH:mm",timezone = "GMT+8")
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")//存日期时使用 
	private Date publish;
	/*活动开始时间*/
	@JsonFormat(pattern ="yyyy-MM-dd HH:00",timezone = "GMT+8")
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:00")//存日期时使用  
	private Date preTime;
	/*活动有效期止*/
	@JsonFormat(pattern ="yyyy-MM-dd HH:00",timezone = "GMT+8")
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:00")//存日期时使用  
	private Date sufTime;
	/*原始价位*/
	private BigDecimal oldPrice;
	/*目前价位*/
	private BigDecimal price;
	/*售出数量*/
	private Integer soldNum;
	/*剩余数量*/
	private Integer resNum;
	/*浏览数量*/
	private Integer browNum;
	
	/*是否是推荐商家(1<==>推荐，0<==>不推荐)*/
	private Boolean isRecommend;
	/*是否过期(1<==>不过期，0<==>过期,2<==>即将开始)*/
	private Integer isValid;
	/*首页标题图*/
	private String titleImage;
	/*商品展示图轮播图*/
	private List<GoodsImage> images = new ArrayList<GoodsImage>();
	private SpellList spellList;
	private String itemSrc;
	private String sellerId;
	private String sufTimeStr;
	private String preTimeStr;

	
	
	
	public void setSufTimeStr(String sufTimeStr) {

		SimpleDateFormat dateFormat = new SimpleDateFormat("", Locale.SIMPLIFIED_CHINESE);
		dateFormat.applyPattern("yyyy-MM-dd HH:mm");
		Date date=null;
		try {
			date = dateFormat.parse(sufTimeStr);
			System.out.println(date.toString());
		} catch (ParseException e) {
			e.printStackTrace();
		}

		this.sufTime = date;
	}
	public void setPreTimeStr(String preTimeStr) {

		SimpleDateFormat dateFormat = new SimpleDateFormat("", Locale.SIMPLIFIED_CHINESE);
		dateFormat.applyPattern("yyyy-MM-dd HH:mm");
		Date date=null;
		try {
			date = dateFormat.parse(preTimeStr);
			System.out.println(date.toString());
		} catch (ParseException e) {
			e.printStackTrace();
		}

		this.preTime = date;
	}
	
	
	public String getSellerId() {
		return sellerId;
	}
	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}
	public String getSufTimeStr() {
		return sufTimeStr;
	}
	public String getPreTimeStr() {
		return preTimeStr;
	}
	public String getItemSrc() {
		return itemSrc;
	}
	public void setItemSrc(String itemSrc) {
		this.itemSrc = itemSrc;
	}
	public Goods(Seller seller) {
		super();
		this.seller = seller;
	}
	public Goods(Integer id) {
		super();
		this.id = id;
	}
	
	public Goods(Integer id, Integer payType) {
		super();
		this.id = id;
		this.payType = payType;
	}
	public Goods() {
		super();
	}
	public String getTitleImage() {
		return titleImage;
	}
	public void setTitleImage(String titleImage) {
		this.titleImage = titleImage;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Seller getSeller() {
		return seller;
	}
	public void setSeller(Seller seller) {
		this.seller = seller;
	}
	
	public Integer getPayType() {
		return payType;
	}
	public void setPayType(Integer payType) {
		this.payType = payType;
	}
	public GoodsType getGoodsType() {
		return goodsType;
	}
	public void setGoodsType(GoodsType goodsType) {
		this.goodsType = goodsType;
	}
	public String getTitleName() {
		return titleName;
	}
	public void setTitleName(String titleName) {
		this.titleName = titleName;
	}

	public BigDecimal getOldPrice() {
		return oldPrice;
	}
	public void setOldPrice(BigDecimal oldPrice) {
		this.oldPrice = oldPrice;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public Integer getSoldNum() {
		return soldNum;
	}
	public void setSoldNum(Integer soldNum) {
		this.soldNum = soldNum;
	}
	public Integer getResNum() {
		return resNum;
	}
	public void setResNum(Integer resNum) {
		this.resNum = resNum;
	}
	public Integer getBrowNum() {
		return browNum;
	}
	public void setBrowNum(Integer browNum) {
		this.browNum = browNum;
	}

	
	public Date getPreTime() {
		return preTime;
	}
	@DateTimeFormat(pattern = "yyyy-MM-dd hh:00")//存日期时使用 
	public void setPreTime(Date preTime) {
		this.preTime = preTime;
	}
	public Date getSufTime() {
		return sufTime;
	}
	@DateTimeFormat(pattern = "yyyy-MM-dd hh:00")//存日期时使用 
	public void setSufTime(Date sufTime) {
		this.sufTime = sufTime;
	}
	public Boolean getIsRecommend() {
		return isRecommend;
	}
	public void setIsRecommend(Boolean isRecommend) {
		this.isRecommend = isRecommend;
	}
	
	public List<GoodsImage> getImages() {
		return images;
	}
	public void setImages(List<GoodsImage> images) {
		this.images = images;
	}


	public Integer getIsValid() {
		return isValid;
	}
	public void setIsValid(Integer isValid) {
		this.isValid = isValid;
	}
	
	public Date getPublish() {
		return publish;
	}
	public void setPublish(Date publish) {
		this.publish = publish;
	}
	public SpellList getSpellList() {
		return spellList;
	}
	public void setSpellList(SpellList spellList) {
		this.spellList = spellList;
	}
	@Override
	public String toString() {
		return "Goods [id=" + id + ", seller=" + seller + ", payType=" + payType + ", goodsType=" + goodsType
				+ ", titleName=" + titleName + ", publish=" + publish + ", preTime=" + preTime + ", sufTime=" + sufTime
				+ ", oldPrice=" + oldPrice + ", price=" + price + ", soldNum=" + soldNum + ", resNum=" + resNum
				+ ", browNum=" + browNum + ", isRecommend=" + isRecommend + ", isValid=" + isValid + ", titleImage="
				+ titleImage + ", images=" + images + ", spellList=" + spellList + ", itemSrc=" + itemSrc
				+ ", sellerId=" + sellerId + ", sufTimeStr=" + sufTimeStr + ", preTimeStr=" + preTimeStr
				+ ", getLimit()=" + getLimit() + ", getPage()=" + getPage() + ", getOffset()=" + getOffset()
				+ ", getKeyWords()=" + getKeyWords() + "]";
	}

	

}
