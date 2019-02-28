package com.jdkj.wx.page;

import java.util.ArrayList;
import java.util.List;

public class PageList<T> {
	private long total = 0;
	private List<T> rows = new ArrayList<>();
	private int currPage=1;
	private long count;
	
	
	
	public PageList(long total, List<T> rows, int currPage, long count) {
		super();
		this.total = total;
		this.rows = rows;
		this.currPage = currPage;
		this.count = count;
	}

	public int getCurrPage() {
		return currPage;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}

	public void setTotal(long total) {
		this.total = total;
	}

	public long getTotal() {
		return total;
	}


	public long getCount() {
		return count;
	}

	public void setCount(long count) {
		this.count = count;
	}

	public List<T> getRows() {
		return rows;
	}

	public void setRows(List<T> rows) {
		this.rows = rows;
	}

	
	public PageList(long total, List<T> rows, int currPage) {
		super();
		this.total = total;
		this.rows = rows;
		this.currPage = currPage;
	}

	public PageList(long total, List<T> rows) {
		super();
		this.total = total;
		this.rows = rows;
	}

	public PageList() {
		super();
	}
	
}
