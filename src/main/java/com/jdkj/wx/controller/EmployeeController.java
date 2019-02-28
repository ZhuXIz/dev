package com.jdkj.wx.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jdkj.wx.common.ResponseResult;
import com.jdkj.wx.entity.Employee;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.EmployeeQuery;
import com.jdkj.wx.service.IEmployeeService;

@Controller
@RequestMapping("/employee")
public class EmployeeController extends BaseController {

    @Autowired
    private IEmployeeService employeeService;

    @RequestMapping("/getAll")
    @ResponseBody
    public PageList<Employee> getAllEmployee(EmployeeQuery query) {
    	return employeeService.getAll(query);
    }
    
    
    @RequestMapping("/index")
    public String pageToIndex() {
    	return "wx/employee/index";
    }
    
    
    

    /*********************************************后台管理***************************************************/
    @RequestMapping("/sys/index")
    public String index(Model m,EmployeeQuery query) {
    	PageList<Employee> list= employeeService.getAll(query);
    	m.addAttribute("list",list);
    	return "sys/emp/index";
    }
    
    @RequestMapping("/sys/get")
    @ResponseBody
    public Employee sysGet(Integer id) {
    	return employeeService.getById(id);
    }
    
    /*跳转到添加页面*/
    @RequestMapping("/sys/add")
    public String sysAdd() {
    	return "sys/employee/add";
    }
    
    
    /*删除*/
    @RequestMapping("/sys/remove")
    public void sysRemove(Integer id,HttpServletResponse response) {
    	ResponseResult result =new ResponseResult();
    	try {
    		employeeService.remove(id);
    		result.setCode(0);
    		result.setMessage("操作成功");
    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("操作失败");
		}
		writeJson(response, result);
    }
    /*修改或添加*/
    @RequestMapping("/sys/save")
    public void sysSave(@RequestBody Employee employee,HttpServletResponse response) {
    	ResponseResult result =new ResponseResult();
    	System.out.println((employee.getId()==null)+"\n"+employee);
    	try {
    		if(employee.getId()==null) {
        		//添加
    			employeeService.add(employee);
        	}else {
        		//修改
        		employeeService.update(employee);
        	}
    		
    		result.setCode(0);
    		result.setMessage("操作成功");
    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("操作失败");
		}
		writeJson(response, result);
    }
}
