package com.jdkj.wx.service;

import com.jdkj.wx.entity.Employee;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.EmployeeQuery;

public interface IEmployeeService extends IBaseService<Employee> {

	Employee check(Employee emp);
}
