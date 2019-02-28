package com.jdkj.wx.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jdkj.wx.common.Constant;
import com.jdkj.wx.common.ResponseResult;
import com.jdkj.wx.entity.Goods;
import com.jdkj.wx.entity.MyCollection;
import com.jdkj.wx.entity.User;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.MyCollQuery;
import com.jdkj.wx.service.IMyCollectionService;

@Controller
@RequestMapping("/coll")
public class MyCollController extends BaseController{

    @Autowired
    private IMyCollectionService myCollService;

    /*跳转到我的收藏*/
    @RequestMapping("/index")
    public String pageToEvalute() {
    	return "/wx/coll/index";
    }
    
    /*获取我的收藏，前端采用上滑加载下一页的数据，进行拼接*/
    @RequestMapping("/get")
    @ResponseBody
    public PageList<MyCollection> getMyColl(HttpSession session,MyCollQuery query) {
    	String userId = ((User)session.getAttribute("user")).getId();
    	query.setUserId(userId);
    	PageList<MyCollection> list = myCollService.getMyColl(query);
        return list;
    }
    
    /*取消收藏*/
    @RequestMapping("/remove")
    public void removeMyColl(HttpSession session,HttpServletResponse response,MyCollection coll) {
    	
    	ResponseResult result =new ResponseResult();
    	try {
    		if(coll.getId()==null) {
    			coll.setUser((User)session.getAttribute("user"));
        		myCollService.removeColl(coll);
    			
    		}else {
    			myCollService.removeCollById(coll);
    		}
    		result.setCode(0);
    		result.setMessage("取消收藏");
    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("取消收藏失败");
		}
		writeJson(response, result);
    }
    
    //刷新收藏状态
    @RequestMapping("/getState")
    public void updateMyColl(Model m,HttpServletResponse response,HttpSession session,int goodsId) {
    	ResponseResult result =new ResponseResult();
    	Map<String, Object> map =new HashMap<>();
    	try {
    		MyCollection coll = new MyCollection();
    		coll.setUser((User)session.getAttribute("user"));
        	coll.setGoods(new Goods(goodsId));
    		boolean bool = myCollService.getByGoodsId(coll);
        	
    		result.setCode(0);
    		result.setMessage("刷新收藏成功");
    		map.put("state", bool);
    		result.setResult(map);
    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("刷新收藏失败");
		}
    	writeJson(response, result);

    }
    
    /*添加收藏*/
    @RequestMapping("/add")
    public void addMyColl(HttpSession session,HttpServletResponse response,Integer goodsId) {
    	ResponseResult result =new ResponseResult();

    	try {
    		MyCollection coll = new MyCollection();
        	coll.setCollAddress(Constant.PRE_MYCOLL_ADDRESS+goodsId);
        	coll.setGoods(new Goods(goodsId));
        	coll.setUser((User)session.getAttribute("user"));
        	myCollService.add(coll);
        	
    		result.setCode(0);
    		result.setMessage("收藏成功");

    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("收藏失败");
		}
    	writeJson(response, result);

    }
    

}
