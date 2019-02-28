package com.jdkj.wx.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jdkj.wx.common.ResponseResult;
import com.jdkj.wx.entity.Evaluate;
import com.jdkj.wx.entity.Goods;
import com.jdkj.wx.entity.Order;
import com.jdkj.wx.entity.User;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.EvaluateQuery;
import com.jdkj.wx.service.IEvaluateService;
import com.jdkj.wx.service.IOrderService;

@Controller
@RequestMapping("/evaluate")
public class EvaluateController extends BaseController {

    @Autowired
    private IEvaluateService evaluateService;
    @Autowired
    private IOrderService orderService;
    /*跳转到评论页面*/
    @RequestMapping("/index")
    public String pageToEvalute() {
        return "evaluate/index";
    }
    
    /*完成评论跳转到个人中心页面*/
    @RequestMapping("/save")
    public String addEvalute(HttpSession session,Model m,Evaluate eva) {
    	try {
    		eva.setUserId(((User)session.getAttribute("user")).getId());
    		//修改order状态为0
    		orderService.updateOrderAllOk(eva.getOrderId());
        	evaluateService.add(eva);
    	}catch (Exception e) {
    		
		}
    	
    	return "redirect:/user/index";
    }
    
    /*跳转到评论页面*/
    @RequestMapping("/add")
    public String saveEvalute(Model m,Integer goodsId,Integer orderId) {
    	m.addAttribute("goodsId", goodsId);
    	m.addAttribute("orderId", orderId);
    	return "wx/evaluate/add";
    	
    }

	@RequestMapping("/check")
    public void checgEvaluate(HttpServletResponse response,HttpServletRequest request,HttpSession session,@Param("goodsId")Integer goodsId) {
		System.out.println(goodsId);
		System.out.println(request.getParameter("goodsId"));
	    Evaluate eva = new Evaluate(goodsId,((User)session.getAttribute("user")).getId());
		ResponseResult result = new ResponseResult();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			boolean bool = evaluateService.check(eva);
			result.setCode(0);
			result.setMessage("查询成功");
			map.put("state", bool);
			result.setResult(map);
		}catch (Exception e) {
			result.setCode(1);
			result.setMessage("查询失败");
		}
		writeJson(response, result);
    }
    /*获取评论页，前端才用上滑加载下一页的数据，进行拼接*/
    @RequestMapping("/get")
    @ResponseBody
    public PageList<Evaluate> getEvaluate(EvaluateQuery query) {
    	PageList<Evaluate> list = evaluateService.getEvaluate(query);
        return list;
    }

    

    /*获取评论总数*/
    @RequestMapping("/getcount")
    @ResponseBody
    public int getEvaluateCount(int goodsId) {
    	
        return evaluateService.getEvaluateCount(goodsId);
    }
}
