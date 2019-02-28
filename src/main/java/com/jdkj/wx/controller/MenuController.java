package com.jdkj.wx.controller;

import java.io.File;
import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.multipart.MultipartFile;

import com.jdkj.wx.common.ResponseResult;
import com.jdkj.wx.entity.Employee;
import com.jdkj.wx.entity.Goods;
import com.jdkj.wx.entity.Menu;
import com.jdkj.wx.entity.Order;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.MenuQuery;
import com.jdkj.wx.service.IMenuService;

@Controller
@RequestMapping("/menu")
public class MenuController extends BaseController {

    @Autowired
    private IMenuService menuService;

    @RequestMapping("/getAll")
    @ResponseBody
    public PageList<Menu> getAllMenu(MenuQuery query) {
    	return menuService.getAll(query);
    }
    
    @RequestMapping("/get")
    @ResponseBody
    public Menu getOneMenu(Serializable id) {
    	return menuService.getById(id);
    }
    
    @RequestMapping("/index")
    public String pageToIndex() {
    	return "wx/menu/index";
    }
    
    @ResponseBody
    @RequestMapping(value= {
    		"/sys/uploadImg","/uploadImg"
    })
    public void uploadPicture(@RequestParam(value="file",required=false)MultipartFile file,HttpServletRequest request,HttpServletResponse response){
        ResponseResult result = new ResponseResult();
		Map<String, Object> map = new HashMap<String, Object>();
        File targetFile=null;
        String url="";//返回存储路径
        int code=1;
        System.out.println(file);
        String fileName=file.getOriginalFilename();//获取文件名加后缀
        if(fileName!=null&&fileName!=""){   
            //String returnUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() +"/upload/imgs/";//存储路径
        	//String returnUrl = request.getContextPath() +"/upload/imgs/advert/";//存储路径
            String path = ContextLoader.getCurrentWebApplicationContext().getServletContext().getRealPath("upload/imgs/menu"); //文件存储位置
            String fileF = fileName.substring(fileName.lastIndexOf("."), fileName.length());//文件后缀
            fileName=new Date().getTime()+"_"+new Random().nextInt(1000)+fileF;//新的文件名
 
            //先判断文件是否存在
            //SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
            //String fileAdd = sdf.format(new Date());
            //获取文件夹路径
            File file1 =new File(path); 
            
           
            //如果文件夹不存在则创建    
            if(!file1 .exists()&&!file1 .isDirectory()){
            	System.out.println("应该创建一个文件夹");
            	//file1 .mkdir(); 
            	file1.mkdirs();
            }
            //将图片存入文件夹
            targetFile = new File(file1, fileName);
            try {
            	//将上传的文件写到服务器上指定的文件。
                file.transferTo(targetFile);
                //url=returnUrl+fileAdd+"/"+fileName;
                url="/upload/imgs/menu/"+fileName;
                code=0;
                result.setCode(code);
                result.setMessage("图片上传成功");
                map.put("url", url);
                System.out.println("returnUrl:"+url);
                result.setResult(map);
            } catch (Exception e) {
                e.printStackTrace();
                result.setMessage("系统异常，图片上传失败");
            }
        }
       writeJson(response, result);
    }
    

    /*********************************************后台管理***************************************************/
    @RequestMapping("/sys/getAll")
    @ResponseBody
    public PageList<Menu> sysGetAll(Menu menu) {
    	return menuService.getAllParentByMenu(menu);
    }
    
    
    @RequestMapping("/sys/getAllItem")
    @ResponseBody
    public PageList<Menu> sysGetAllItem(Menu menu) {
    	return menuService.getAllItem(menu);
    }
    
    @RequestMapping("/sys/checkItem")
    @ResponseBody
    public void sysCheckItem(Integer id,HttpServletResponse response) { 
    	ResponseResult result = new ResponseResult();
    	try {
    		int count = menuService.checkItem(id);
    		if(count>0) {
    			result.setCode(0);
        		result.setMessage("请先删除子菜单");
    		}else {
    			result.setCode(1);
    		}
    		
    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("操作失败");
		}
		writeJson(response, result);
    }
    
    @RequestMapping("/sys/index")
    public String sysGet() {
    	return "sys/menu/index";
    }

    
    
    @RequestMapping("/sys/get")
    @ResponseBody
    public Menu sysGetSpell(Integer id) {
		return menuService.getById(id);
    }
    
    
    @RequestMapping("/sys/show")
    @ResponseBody
    public List<Menu> sysShow(HttpSession session) {
    	Employee emp= (Employee)session.getAttribute("employee");
    	List<Menu> list= menuService.getMenu(emp.getId());
    	return list;
    }
    
    
    
    /*删除*/
    @RequestMapping("/sys/remove")
    public void sysRemove(Integer id,HttpServletResponse response) {
    	ResponseResult result =new ResponseResult();
    	try {
    		menuService.remove(id);
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
    public void sysSave(@RequestBody Menu menu,HttpServletResponse response) {
    	System.out.println("Menu"+menu);
    	ResponseResult result =new ResponseResult();
    	try {
    		if(menu.getId()==null) {
        		//添加
    			menuService.add(menu);
    			//子菜单添加！上级菜单链接将清楚
    			if(menu.getPid()!=null||menu.getPid()!=0)
    				menuService.updateParentUrl(menu.getPid());
    			result.setMessage("添加成功");
        	}else {
        		//修改
        		menuService.update(menu);
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
