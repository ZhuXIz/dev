package com.jdkj.wx.controller;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jdkj.wx.common.ResponseResult;
import com.jdkj.wx.entity.Order;
import com.jdkj.wx.entity.Goods;
import com.jdkj.wx.entity.Menu;
import com.jdkj.wx.entity.Order;
import com.jdkj.wx.entity.Seller;
import com.jdkj.wx.entity.SpellList;
import com.jdkj.wx.entity.User;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.OrderQuery;
import com.jdkj.wx.service.IGoodsService;
import com.jdkj.wx.service.IOrderService;
import com.jdkj.wx.service.IUserService;
/*订单状态
 * 0==全部完成
 * 1==进行中
 * 2==完成未评论
 * 3==被取消的（涉及金额自动退款）<---->显示退款中
 * 4==拼团任务（未完成/提示申请退款）
 * 5==下单未支付
 * 6==订单被取消，退款完成
 * 7==订单支付超时
 * --*/
@Controller
@RequestMapping("/order")
public class OrderController extends BaseController{

    @Autowired
    private IOrderService orderService;
    
    @Autowired
    private IGoodsService goodsService;
    
    @Autowired
    private IUserService userService;
    /*跳转到我的订单，自动检测订单是否超时，超时自动完成*/
    @RequestMapping("/index")
    public String pageToOrder(HttpSession session) {
    	//过期未支付的订单修改
    	orderService.updateIsValidTimeOut();
    	/*判断订单是否完成，若完成，修改订单状态为2*/
    	orderService.updateOrder(((User)session.getAttribute("user")).getId());
    	return "wx/order/index";
    }
    /*手动修改我的订单状态-----完成状态（2）就可以评论。*/
    @RequestMapping("/update")
    @ResponseBody
    public boolean updateOrder(HttpSession session,Integer orderId) {
//    	order.setUser((User)session.getAttribute("user"));
    	try {
    		orderService.updateOrderOk(orderId);
    	}catch (Exception e) {
    		return false;
		}
    	
    	return true;
    }
    
  //根据userId和goodsId修改状态--针对isValid=5-------已经下单未支付修改订单状态为5
    @RequestMapping("/upSpell")
    public void updateBySpell(HttpSession session,@ModelAttribute("order")Order order,HttpServletResponse response) {
    	order.setUserId(((User)session.getAttribute("user")).getId());
    	ResponseResult result = new ResponseResult();
    	try {
    		orderService.updateOrderSpell(order);
    		result.setCode(0);
    		result.setMessage("订单状态成功修改!");
    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("订单状态刷新异常!");
		}
    	writeJson(response, result);
    }
    
    //修改订单状态----------订单支付超时？
    @RequestMapping("/updateIsValid")
    public void updateIsValid(HttpSession session,@ModelAttribute("order")Order order,HttpServletResponse response) {
    	ResponseResult result = new ResponseResult();
    	try {
    		orderService.updateIsValid(order);
    		result.setCode(0);
    		result.setMessage("订单状态成功修改!");
    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("订单状态刷新异常!");
		}
    	writeJson(response, result);
    }
    
    
    /*查询我的订单*/
    @RequestMapping("/get")
    @ResponseBody
    public PageList<Order> getOrder(HttpSession session,@Param("query")OrderQuery query) {
    	query.setUserId(((User)session.getAttribute("user")).getId());
    	return orderService.getUserOrder(query);
    }
    
    /*取消我的订单***isValid改为0即为取消订单，1为有效订单，2为完成订单*/
    @RequestMapping("/cancel")
    @ResponseBody
    public boolean cancelOrder(@Param("orderId")Integer orderId,@Param("goodsId")Integer goodsId) {
    
    	try {
	    	orderService.cancelOrder(orderId);
	    	//取消订单减少商品已售
	    	goodsService.removeSoldNum(goodsId);
    	}catch (Exception e) {
    		return false;
		}
    	
    	return true;
    }
    @RequestMapping("/add")
    public String pageToOrder(int goodsId,String sellerId,Model m) {
    	m.addAttribute("goodsId", goodsId);
    	m.addAttribute("sellerId", sellerId);
    	
    	return "/wx/order/add";
    }
    /*查询订单是否存在*/
    @RequestMapping("/getState")
    @ResponseBody
    public void getOne(Integer goodsId,HttpSession session,HttpServletResponse response) {
    	Order order = new Order(new Goods(goodsId),(User)session.getAttribute("user"));
    	ResponseResult result = new ResponseResult();
    	Map<String, Object> map = new HashMap<String, Object>();
    	try {
    		boolean bool = goodsService.getNum(goodsId);
    		boolean bool2 = orderService.getOne(order);
    		result.setCode(0);
    		result.setMessage("查询成功");
    		map.put("goodsState", bool);
    		map.put("orderState", bool2);
    		result.setResult(map);
    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("查询失败");
		}
    	writeJson(response, result);
    }
    
    
    
    
    @RequestMapping("/save")
    public String save(HttpSession session,@ModelAttribute Order order) {
    	User user = (User)session.getAttribute("user");
    	String userId = user.getId();
    	order.setUserId(userId);
    	System.out.println(order);
    	try {
	    	orderService.add(order);
	    	//下单后
	    	//下单增加商品已售
	    	goodsService.addSoldNum(order.getGoodsId());
	    	//
	    	userService.updatePhone(user);
    	}catch (Exception e) {
			
		}
    	return "redirect:/order/index";
    }
    
    /*商家订单查询-----页面操作---完成订单、订单取消确认*/
    /*查询我的订单*/
    @RequestMapping("/seller")
    @ResponseBody
    public PageList<Order> getSellerOrder(HttpSession session,@Param("query")OrderQuery query) {
    	query.setUserId(((User)session.getAttribute("user")).getId());
    	PageList<Order> list = orderService.getSellerOrder(query);
    	return list;
    }
    
    
    
    
    

    /*********************************************后台管理***************************************************/
    @RequestMapping("/sys/getAll")
    @ResponseBody
    public PageList<Order> sysGetAll(Order order) {
    	return orderService.getAllByOrder(order);
    }
    
    
    @RequestMapping("/sys/index")
    public String sysGet() {
    	return "sys/order/index";
    }

    
    
    @RequestMapping("/sys/get")
    @ResponseBody
    public Order sysGetSpell(Integer id) {
		return orderService.getById(id);
    }
    
    /*删除*/
    @RequestMapping("/sys/remove")
    public void sysRemove(Integer id,HttpServletResponse response) {
    	ResponseResult result =new ResponseResult();
    	try {
    		orderService.remove(id);
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
    public void sysSave(@RequestBody Order order,HttpServletResponse response) {
    	ResponseResult result =new ResponseResult();
    	try {
    		if(order.getId()==null) {
        		//添加
    			orderService.add(order);
        	}else {
        		//修改
        		orderService.update(order);
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
