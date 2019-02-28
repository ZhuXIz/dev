package com.jdkj.wx.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jdkj.wx.common.ResponseResult;
import com.jdkj.wx.common.WXConfig;
import com.jdkj.wx.common.WeiXinH5LogUtil;
import com.jdkj.wx.common.util.JsapiTicketUtil;
import com.jdkj.wx.common.util.WeixinUtil;
import com.jdkj.wx.entity.Advert;
import com.jdkj.wx.entity.Config;
import com.jdkj.wx.entity.User;
import com.jdkj.wx.service.IAdvertService;
import com.jdkj.wx.service.IGoodsService;
import com.jdkj.wx.service.ISpellListService;
import com.jdkj.wx.service.IUserService;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/wx")
public class WxController extends BaseController{
	@Autowired
    private IUserService userService;
	@Autowired
	private IAdvertService advertService;
	
	@Autowired
	private ISpellListService spellListService;
	
	@RequestMapping("/pay")
	public String pay() {
		return "wx/goods/pay";
	}
	
	@RequestMapping("/service")
    public String pageToService() {
		
    	return "wx/service";
    }
	@RequestMapping("/index")
    public String pageToHome(HttpSession session) {
		//session.setAttribute("user", new User("o85rZ1QhNUz6d3O_KtlhwghBdDdI"));
    	return "wx/index";
    }
	
	@RequestMapping("/check")
    public void check(HttpSession session,HttpServletResponse response) {
		User user = (User) session.getAttribute("user");
		
		ResponseResult result = new ResponseResult();
		try {
			if(user!=null) {
				boolean bool = spellListService.cue(user.getId());
				
				if(bool) {
					result.setCode(0);
					result.setMessage("您尚未在规定时间内完成拼团任务！请在订单页面申请退款！");
				}else {
					result.setCode(1);
					result.setMessage("没你的事");
				}
			}else {
				result.setCode(1);
				result.setMessage("用户未登录");
			}
			
		} catch (Exception e) {
			result.setCode(2);
			result.setMessage("后台异常！");
		}
		
		writeJson(response, result);
    }
	
	
	@RequestMapping("/fail")
    public String fail(HttpSession session) {
    	return "common/404";
    }
	
	@RequestMapping("/getWxConfig")
	@ResponseBody
    public Config getWxConfig(HttpSession session,String url) {
		Config conf =null;
		try {
			//查询是否过期acess_token   jsapiTicket
			if(userService.checkWx()) {
				Map<String, String> map = JsapiTicketUtil.getJSApiTicket();
				conf = WeixinUtil.getConfig(url,map.get("jsapiTicket"));
				userService.updateWxConfig(map);
			}else {
				conf = WeixinUtil.getConfig(url,userService.getWxconfig());
			}
			System.out.println("调用微信jsapi的凭证票为：" + conf);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conf;
    }
	
	
	
    /*查询用户是否存在，不存在则保留用户信息，存在则更新*/
    @RequestMapping("/login")
    private String userLogin(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException{
    	
    	User user = (User) session.getAttribute("user");
    	ResponseResult result = new ResponseResult();
    	Map<String, Object> map = new HashMap<String, Object>();
    	if(user==null) {
		    String code=request.getParameter("code");
			if(code==null) {
				result.setCode(1);
	    		result.setMessage("登陆失败");
			}
		//    	    String grant_type=request.getParameter("grant_type");
		//    	    String url = "https://api.weixin.qq.com/sns/oauth2/access_token?"
		//    			+ "appid="+appid+"&secret="+secret+"&code="+code+"&grant_type="+grant_type+"";
		    //System.out.println(WeiXinH5LogUtil.getOpenId(appid,secret,code));
			try {
				 JSONObject json = WeiXinH5LogUtil.getOpenId(WXConfig.APP_ID,WXConfig.APP_SECRET,code);
			    //存放user
			    String id = (String) json.get("openid");
			    String name = (String) json.get("nickname");
			    String imageUrl = (String) json.get("headimgurl");
			    User new_user = new User(id,name,imageUrl);
			    session.setAttribute("user", new_user);
		    	userService.updateUser(new_user);
		    	
		    	result.setCode(0);
		    	map.put("state", new_user);
			} catch (Exception e) {
				result.setCode(1);
				map.put("state", "获取user失败");
			}
		   
	    }
    	
    	try {
    		/*拿到轮播图*/
    		List<Advert> list= advertService.getAll();
    		session.setAttribute("advertList", list);
    		result.setMessage("成功拿到轮播图");
    	}catch (Exception e) {
    		map.put("state2", "获取轮播图失败");
		}
    	result.setResult(map);
    	writeJson(response, result);
    	return "/wx/wx/index";
    }
	    
    //退出
  	@RequestMapping("/logout")
  	public String logout(HttpSession session)throws Exception{
  		//清除session
  		session.invalidate();
  		//重定向到商品列表界面
  		return "redirect:";
  	}
  	
  	
}
