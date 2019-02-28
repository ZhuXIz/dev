package com.jdkj.wx.service;

import com.jdkj.wx.entity.Advert;
import com.jdkj.wx.page.PageList;

public interface IAdvertService extends IBaseService<Advert>{

	PageList<Advert> getAllByAdvert(Advert advert);

}
