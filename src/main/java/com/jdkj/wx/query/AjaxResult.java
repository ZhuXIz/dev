package com.jdkj.wx.query;

public class AjaxResult {

	//默认为成功
	private Boolean success = true;
	
	private String message = "操作成功！";

	public Boolean getSuccess() {
		return success;
	}

	public void setSuccess(Boolean success) {
		this.success = success;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.success = false;
		this.message = message;
	}

	//默认成功，并且提示信息是“操作成功！”
		public AjaxResult() {
		}

		//失败
		public AjaxResult(String message) {
			this.success = false;
			this.message = message;
		}

}