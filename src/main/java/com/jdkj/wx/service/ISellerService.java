package com.jdkj.wx.service;

import com.jdkj.wx.entity.Seller;
import com.jdkj.wx.page.PageList;

public interface ISellerService extends IBaseService<Seller> {

	boolean getBySellerId(String id);


	boolean updatePass(String id);


	PageList<Seller> getAllBySeller(Seller seller);

}
