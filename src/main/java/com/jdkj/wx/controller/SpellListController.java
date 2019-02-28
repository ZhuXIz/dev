package com.jdkj.wx.controller;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jdkj.wx.common.ResponseResult;
import com.jdkj.wx.entity.SpellList;
import com.jdkj.wx.entity.User;
import com.jdkj.wx.entity.UserSpellList;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.SpellListQuery;
import com.jdkj.wx.service.ISpellListService;

@Controller
@RequestMapping("/spell")
public class SpellListController extends BaseController {

    @Autowired
    private ISpellListService spellListService;

    
    //拿到我的所有拼团活动
    @RequestMapping("/getAll")
    @ResponseBody
    public PageList<SpellList> getAllSpell(SpellListQuery query) {
    	return spellListService.getAll(query);
    }
    
  //拿到我的所有拼团活动
    @RequestMapping("/getMySpell")
    @ResponseBody
    public PageList<SpellList> getMySpell(SpellListQuery query,HttpSession seesion) {
    	query.setUserId(((User)seesion.getAttribute("user")).getId());
    	return spellListService.getByUserIdAll(query);
    }
    
    @RequestMapping("/get")
    @ResponseBody
    public SpellList getOneSpell(Serializable id) {
    	return spellListService.getById(id);
    }
    
    /*查询当前商品是否有拼团活动*/
    @RequestMapping("/getByGoods")
    @ResponseBody
    public SpellList getByGoods(Integer goodsId) {
    	SpellList spell = spellListService.getByGoodsId(goodsId);
    	if(spell == null)
    		return null;
    	return spell;
    }
    /**************************我的团购*************************/
    /*查询我是否在团购---有则返回拼团信息、拼团成功了多少人*/
    @RequestMapping("/getSpellIsOpen")
    @ResponseBody
    public SpellList getSpellIsOpen(Integer listId,HttpSession session,HttpServletResponse response) {
    	UserSpellList userSpell =new UserSpellList(listId,((User)session.getAttribute("user")).getId());
    	SpellList list;
    	try {
    		boolean bool = spellListService.check(userSpell);
    		//刷新状态
    		
    		if(bool) {
    			list = spellListService.getByUserId(userSpell);
    			return list;
    		}
    	}catch (Exception e) {
		}
    	return null;
    }
    
    //刷新拼团状态
    @RequestMapping("/updateState")
    public void updateState(@ModelAttribute SpellList list,HttpSession session,HttpServletResponse response) {
    	ResponseResult result = new ResponseResult();
    	try {
    		boolean bool = spellListService.updateState(list);
    		result.setCode(0);
    		if(bool)
    			result.setMessage("更新拼团状态更新");
    		else
    			result.setMessage("更新拼团状态失败");
    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("更新拼团状态失败");
		}
    	writeJson(response, result);
    }
    
    /**************************我要开团*************************/
    /*我要开团*/
    @RequestMapping("/open")
    public void addSpell(Integer listId,HttpSession session,HttpServletResponse response) {
    	UserSpellList userSpell =new UserSpellList(listId,((User)session.getAttribute("user")).getId());
    	ResponseResult result = new ResponseResult();
    	Map<String, Object> map = new HashMap<String, Object>();
    	try {
    		boolean bool = spellListService.addSpell(userSpell);
    		result.setCode(0);
    		if(bool)
    			result.setMessage("开团成功");
    		else
    			result.setMessage("开团失败");
			map.put("state", bool);
    		result.setResult(map);
    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("拼团失败");
		}
    	writeJson(response, result);
    }
    
    
    /**************************拿到朋友的团购*************************/
    /*查询我是否在团购---有则返回拼团信息、拼团成功了多少人*/
    @RequestMapping("/getSpellByUser")
    @ResponseBody
    public SpellList getSpellByUser(Integer id,Integer listId,String userId,HttpServletResponse response) {
    	UserSpellList userSpell =new UserSpellList(listId,userId,id);
    	SpellList list;
    	try {
    		
    		boolean bool = spellListService.check(userSpell);
    		if(bool) {
    			list = spellListService.getByUserId(userSpell);
    			return list;
    		}
    		
    	}catch (Exception e) {
		}
    	return null;
    }
  	
    /**************************加入朋友的开团*************************/
    @RequestMapping("/join")
    public void joinSpell(Integer id,Integer listId,HttpSession session,HttpServletResponse response) {
    	UserSpellList userSpell =new UserSpellList(listId,((User)session.getAttribute("user")).getId(),id);
    	ResponseResult result = new ResponseResult();
    	Map<String, Object> map = new HashMap<String, Object>();
    	try {
    		boolean bool = spellListService.addSpell2(userSpell);
    		result.setCode(0);
    		
			map.put("state", bool);
			if(bool)
				result.setMessage("拼团成功");
			else
				result.setMessage("拼团失败，您已参加过该商品的拼团!");
    		result.setResult(map);
    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("拼团失败");
		}
    	writeJson(response, result);
    }
    
    
    
    @RequestMapping("/index")
    public String pageToIndex() {
    	return "wx/spell/index";
    }
    
    
    /*********************************************后台管理***************************************************/
    @RequestMapping("/sys/getAll")
    @ResponseBody
    public PageList<SpellList> sysGetAll(SpellList spellList) {
    	System.out.println("spellList:"+spellList);
    	return spellListService.getAllBySpell(spellList);
    }
    
    
    @RequestMapping("/sys/index")
    public String sysGet() {
    	return "sys/spell/index";
    }
    
    /*****************************************/
    
    @RequestMapping("/sys/getItem")
    public void sysGetItem(HttpServletResponse response,UserSpellList userList) {
    	ResponseResult result = new ResponseResult();
    	Map<String,Object> map = new HashMap<String, Object>();
    	
    	try {
			//拿到该拼团的子团队
    		PageList<UserSpellList> list = spellListService.getSpellItem(userList);
    		result.setCode(0);
    		result.setMessage("成功获取");
    		map.put("list", list);
    		result.setResult(map);
		} catch (Exception e) {
			result.setCode(1);
    		result.setMessage("获取失败");
		}
    	writeJson(response, result);
    	
    }
    
    @RequestMapping("/sys/group")
    public void sysGroup(HttpServletResponse response,Integer id) {
    	ResponseResult result = new ResponseResult();
    	Map<String,Object> map = new HashMap<String, Object>();
    	
    	try {
			//拿到该拼团的子团队
    		List<User> list = spellListService.getUserGroup(id);
    		result.setCode(0);
    		result.setMessage("成功获取");
    		map.put("list", list);
    		result.setResult(map);
		} catch (Exception e) {
			result.setCode(1);
    		result.setMessage("获取失败");
		}
    	writeJson(response, result);
    	
    }
    
    
    @RequestMapping("/sys/get")
    @ResponseBody
    public SpellList sysGetSpell(Integer id) {
		return spellListService.getById(id);
    }
    
    /*删除*/
    @RequestMapping("/sys/remove")
    public void sysRemove(Integer id,HttpServletResponse response) {
    	ResponseResult result =new ResponseResult();
    	try {
    		spellListService.remove(id);
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
    public void sysSave(@RequestBody SpellList spell,HttpServletResponse response) {
    	ResponseResult result =new ResponseResult();
    	System.out.println("spell:"+spell);
    	try {
    		if(spell.getId()==null) {
        		//添加
    			spellListService.add(spell);
    			result.setMessage("添加成功");
        	}else {
        		//修改
        		spellListService.update(spell);
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
