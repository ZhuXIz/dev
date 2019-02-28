package com.jdkj.wx.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jdkj.wx.common.ResponseResult;
import com.jdkj.wx.common.util.MD5Util;
import com.jdkj.wx.entity.Employee;
import com.jdkj.wx.entity.Menu;
import com.jdkj.wx.service.IEmployeeService;
import com.jdkj.wx.service.IMenuService;

@Controller
@RequestMapping("/sys")
public class SysController extends BaseController {

    @Autowired
    private IEmployeeService employeeService;
    @Autowired
    private IMenuService menuService;

    /*首页*/
    @RequestMapping("/index")
    public String home() {
    	//初始化菜单
    	return "redirct:/login.jsp";
    }
    
    /*菜单首页*/
    @RequestMapping("/rightHome")
    public String menuHome() {
    	//初始化菜单
    	return "sys/home";
    }
    
    @RequestMapping("/getMenu")
    public void getMenu(HttpServletResponse response,HttpSession session) {
    	Employee emp= (Employee)session.getAttribute("employee");
    	ResponseResult result =new ResponseResult();
    	Map<String , Object> map = new HashMap<>();
    	try {
    		List<Menu> list= menuService.getMenuByRole(emp.getPermiss().getId());
    		result.setCode(0);
    		map.put("menu", list);
    		if(!list.isEmpty()) {
    			result.setMessage("获取到菜单");
    		}else
    			result.setMessage("获取菜单失败");
    		result.setResult(map);
    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("异常");
		}
		writeJson(response, result);
    }
    
    /*登陆*/
    @RequestMapping("/login")
    public void login(@Param("emp")Employee emp,HttpServletResponse response,HttpSession session) {
    	ResponseResult result =new ResponseResult();
    	Map<String , Object> map = new HashMap<>();
 
    	try {
    		emp = employeeService.check(emp);
    		result.setCode(0);
    		
    		if(emp!=null){
    			result.setMessage("成功登陆");
    			session.setAttribute("employee", emp);
    			map.put("state", true);
    		}else {
    			map.put("state", false);
    			result.setMessage("账号密码错误");
    		}
    			
    		result.setResult(map);
    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("异常");
		}
		writeJson(response, result);
    }
    
    
    @RequestMapping("/home")
    public String login(Employee emp) {
    	return "sys/index";
    }
    
  
}
