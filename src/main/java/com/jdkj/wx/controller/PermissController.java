package com.jdkj.wx.controller;

import java.io.Serializable;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jdkj.wx.common.ResponseResult;
import com.jdkj.wx.entity.Menu;
import com.jdkj.wx.entity.Permiss;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.service.IMenuService;
import com.jdkj.wx.service.IPermissService;

@Controller
@RequestMapping("/permiss")
public class PermissController extends BaseController {

    @Autowired
    private IPermissService permissService;
    @Autowired
    private IMenuService menuService;
    @RequestMapping("/sys/getAll")
    @ResponseBody
    public List<Permiss> getAllPermiss() {
    	return permissService.getAll();
    }
    
    @RequestMapping("/get")
    @ResponseBody
    public Permiss getOnePermiss(Serializable id) {
    	return permissService.getById(id);
    }
    
    @RequestMapping("/index")
    public String pageToIndex() {
    	return "wx/permiss/index";
    }
    
    
    @RequestMapping("/addMenu")
    public void addMenu(HttpServletResponse response,Permiss permiss) {
    	ResponseResult result =new ResponseResult();
    	try {
    		permissService.addMenu(permiss);
    		result.setCode(0);
    		result.setMessage("添加成功");
    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("添加失败");
		}
		writeJson(response, result);
    }
    

    @RequestMapping("/removeMenu")
    public void removeMenu(HttpServletResponse response,Permiss permiss) {
    	ResponseResult result =new ResponseResult();
    	try {
    		permissService.removeMenu(permiss);
    		result.setCode(0);
    		result.setMessage("取消成功");
    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("取消失败");
		}
		writeJson(response, result);
    }
    
    
    
    
    
    
    

    /*********************************************后台管理***************************************************/
    @RequestMapping("/sys/getAllRole")
    @ResponseBody
    public PageList<Permiss> sysGetAll(Permiss permiss) {
    	return permissService.getAllByPer(permiss);
    }
    @RequestMapping("/sys/getAllPer")
    @ResponseBody
    public List<Permiss> sysGetAllPer() {
    	return permissService.getAll();
    }
    
    @RequestMapping("/sys/getAllMenu")
    @ResponseBody
    public List<Menu> sysGetAllMenu() {
    	return menuService.getAllMenu();
    }
    @RequestMapping("/sys/get")
    @ResponseBody
    public Permiss sysGetSpell(Integer id) {
		return permissService.getById(id);
    }
    
    @RequestMapping("/sys/getMenu")
    @ResponseBody
    public List<Menu> sysGetMenu(Integer id) {
		return permissService.getMenu(id);
    }
    
    @RequestMapping("/sys/index")
    public String sysGet() {
    	return "sys/permiss/index";
    }
    
    
    /*跳转到添加页面*/
    @RequestMapping("/sys/add")
    public String sysAdd() {
    	return "sys/permiss/add";
    }
    
    
    /*删除*/
    @RequestMapping("/sys/remove")
    public void sysRemove(Integer id,HttpServletResponse response) {
    	ResponseResult result =new ResponseResult();
    	try {
    		permissService.remove(id);
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
    public void sysSave(@RequestBody Permiss permiss,HttpServletResponse response) {
    	ResponseResult result =new ResponseResult();
    	try {
    		if(permiss.getId()==null) {
        		//添加
    			permissService.add(permiss);
    			permissService.addAllMenu(permiss);
    			result.setMessage("添加成功");
        	}else {
        		//先删除再添加
        		permissService.removeMenu(permiss.getId());
        		//添加
        		permissService.addAllMenu(permiss);
        		//修改
        		permissService.update(permiss);
        		result.setMessage("修改成功");
        	}
    		
    		result.setCode(0);
    		
    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("操作失败");
		}
		writeJson(response, result);
    }
}
