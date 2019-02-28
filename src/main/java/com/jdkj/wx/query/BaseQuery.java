package com.jdkj.wx.query;

public class BaseQuery<T> {
	private int page=1;
	private int rows=8;
	
	/*其他参数*/
	private String stringParam;
	private Integer intParam;
	private String keyWords="";
	
	
	
	public String getKeyWords() {
		return keyWords;
	}
	public void setKeyWords(String keyWords) {
		this.keyWords = keyWords;
	}
	public String getStringParam() {
		return stringParam;
	}
	public void setStringParam(String stringParam) {
		this.stringParam = stringParam;
	}
	public Integer getIntParam() {
		return intParam;
	}
	public void setIntParam(Integer intParam) {
		this.intParam = intParam;
	}
	public int getBegin() {
		return (page-1)*rows;
	}
	public int getEnd() {
		return rows;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public BaseQuery(int page, int rows) {
		super();
		this.page = page;
		this.rows = rows;
	}
	public BaseQuery() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "BaseQuery [page=" + page + ", rows=" + rows + ", stringParam=" + stringParam + ", intParam=" + intParam
				+ ", keyWords=" + keyWords + "]";
	}

}
