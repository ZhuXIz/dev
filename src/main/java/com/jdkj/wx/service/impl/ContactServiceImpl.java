package com.jdkj.wx.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jdkj.wx.entity.Advert;
import com.jdkj.wx.entity.Contact;
import com.jdkj.wx.mapper.ContactMapper;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.service.IContactService;
@Service
public class ContactServiceImpl extends BaseServiceImpl<Contact> implements IContactService{
	

	@Autowired
	protected ContactMapper contactMapper;
	@Override
	@Transactional
	public void add(Contact contact) {
		
	}

	@Override
	@Transactional
	public void update(Contact contact) {
		contactMapper.update(contact);
	}

	@Override
	@Transactional
	public boolean remove(Serializable id) {
		try {
			contactMapper.remove(id);
		}catch (Exception e) {
			return false;
		}
		return true;
	}

	@Override
	public Contact getById(Serializable id) {
		return contactMapper.getById(id);
	}

	@Override
	public List<Contact> getAll() {
		return contactMapper.getAll();
	}

	public Contact get() {
		return contactMapper.get();
	}
	public Contact getContact() {
		return contactMapper.getContact();
	}
	
	@Override
	public PageList<Contact> getAll(BaseQuery<Contact> query) {
		long count = contactMapper.getCount(query);
		int row = query.getRows();
		long total = count%row!=0?count/row+1:count/row;
		PageList<Contact> pageList = new PageList<Contact>(total,contactMapper.getAllQuery(query),query.getPage());
        return pageList;
	}

	@Override
	public Contact getService() {
		return contactMapper.getService();
	}

	@Override
	public PageList<Contact> getAllByContact(Contact contact) {
		PageList<Contact> pageList = new PageList<Contact>();
		// 统计总记录数
		int count =contactMapper.getTotal(contact);
		pageList.setCount(count);
		pageList.setRows(contactMapper.getAllByContact(contact));
        return pageList;
	}
}
