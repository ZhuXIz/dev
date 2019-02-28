package com.jdkj.wx.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jdkj.wx.common.ResponseResult;
import com.jdkj.wx.entity.GoodsType;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.service.IGoodsTypeService;

@Controller
@RequestMapping("/type")
public class GoodsTypeController extends BaseController{

    @Autowired
    private IGoodsTypeService goodsTypeService;
    @RequestMapping("/sys/getAll")
    @ResponseBody
    public PageList<GoodsType> sysGetAll(GoodsType goodsType) {
    	return goodsTypeService.getAllByType(goodsType);
    }
    
    @RequestMapping("/sys/get")
    @ResponseBody
    public GoodsType sysGetAdvert(Integer id) {
		return goodsTypeService.getById(id);
    }
    
    /*拿到轮播图*/
    @RequestMapping("/sys/index")
    public String sysGet() {
    	return "sys/type/index";
    }
    
    
    
    /*删除*/
    @RequestMapping("/sys/remove")
    public void sysRemove(Integer id,HttpServletResponse response) {
    	ResponseResult result =new ResponseResult();
    	try {
    		goodsTypeService.remove(id);
    		result.setCode(0);
    		result.setMessage("删除成功");
    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("删除失败");
		}
		writeJson(response, result);
    }
    /*修改或添加*/
    @RequestMapping("/sys/save")
    public void sysSave(@RequestBody GoodsType goodsType,HttpServletResponse response) {
    	ResponseResult result =new ResponseResult();
    	try {
    		if(goodsType.getId()==null) {
        		//添加
    			goodsTypeService.add(goodsType);
        		result.setMessage("添加成功");
        	}else {
        		//修改
        		goodsTypeService.update(goodsType);
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
