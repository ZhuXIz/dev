package com.jdkj.wx.entity;

import com.jdkj.wx.page.Page;

public class UserSpellList extends Page {
	private Integer listId;
	private String userId;
	private Integer goodsId;
	private Integer id;
	private Integer cue;
	private Integer count;

	public UserSpellList(Integer listId, Integer id) {
		super();
		this.listId = listId;
		this.id = id;
	}



	public UserSpellList(Integer listId, String userId, Integer id) {
		super();
		this.listId = listId;
		this.userId = userId;
		this.id = id;
	}







	public Integer getCue() {
		return cue;
	}



	public void setCue(Integer cue) {
		this.cue = cue;
	}



	public UserSpellList(Integer listId, String userId) {
		super();
		this.listId = listId;
		this.userId = userId;
	}



	public Integer getId() {
		return id;
	}



	public void setId(Integer id) {
		this.id = id;
	}



	public Integer getGoodsId() {
		return goodsId;
	}



	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}



	public UserSpellList() {
		super();
	}
	public Integer getListId() {
		return listId;
	}
	public void setListId(Integer listId) {
		this.listId = listId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}



	public Integer getCount() {
		return count;
	}



	public void setCount(Integer count) {
		this.count = count;
	}



	@Override
	public String toString() {
		return "UserSpellList [listId=" + listId + ", userId=" + userId + ", goodsId=" + goodsId + ", id=" + id
				+ ", cue=" + cue + ", count=" + count + "]";
	}






}
