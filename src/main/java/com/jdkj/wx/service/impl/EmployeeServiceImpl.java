package com.jdkj.wx.service.impl;

import java.io.Serializable;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jdkj.wx.entity.Employee;
import com.jdkj.wx.mapper.EmployeeMapper;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.EmployeeQuery;
import com.jdkj.wx.service.IEmployeeService;
@Service
public class EmployeeServiceImpl extends BaseServiceImpl<Employee> implements IEmployeeService{
	@Autowired
	protected EmployeeMapper employeeMapper;
	
	
	/*删除*/
	@Override
	@Transactional
	public boolean remove(Serializable id) {
		try {
			employeeMapper.remove(id);
		}catch (Exception e) {
			return false;
		}
		return true;
	}

	/*修改*/
	@Override
	@Transactional
	public void update(Employee spell) {
		try {
			employeeMapper.update(spell);
		}catch (Exception e) {
		}
	}
	/*添加*/
	@Override
	@Transactional
	public void add(Employee spell) {
		try {
			employeeMapper.add(spell);
		}catch (Exception e) {
		}
	}
	
	/*查询所有员工*/
	@Override
	public PageList<Employee> getAll(BaseQuery<Employee> query) {
		long count = employeeMapper.getCountAll(query);
		int row = query.getRows();
		long total = count%row!=0?count/row+1:count/row;
		PageList<Employee> pageList = new PageList<Employee>(total,employeeMapper.getAllQuery(query),query.getPage());
        return pageList;
	}
	
	@Override
	public Employee getById(Serializable id) {
		return employeeMapper.getById(id);
	}

	@Override
	public Employee check(Employee emp) {
		Employee em = null;
		try {
			em = employeeMapper.check(emp);
			System.out.println(em);
			if(em==null) {
				return null;
			}
		} catch (Exception e) {
			
		}
		return em;
	}
}
