package com.jdkj.wx.service;

import com.jdkj.wx.entity.Contact;
import com.jdkj.wx.page.PageList;

public interface IContactService extends IBaseService<Contact>{

	Contact get();

	Contact getContact();
	Contact getService();

	PageList<Contact> getAllByContact(Contact contact);

}
