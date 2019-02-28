package com.jdkj.wx.controller;

import java.io.File;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.jdkj.wx.entity.Advert;
import com.jdkj.wx.entity.Employee;
import com.jdkj.wx.entity.Order;
import com.jdkj.wx.entity.Permiss;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.AdvertQuery;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.EmployeeQuery;
import com.jdkj.wx.service.IAdvertService;

@Controller
@RequestMapping("/advert")
public class AdvertController extends BaseController {

    @Autowired
    private IAdvertService advertService;

    /*拿到轮播图*/
    @RequestMapping("/get")
    @ResponseBody
    public List<Advert> getAdvert() {
    	List<Advert> list= advertService.getAll();
    	return list;
    }
    
    /*拿到轮播图*/
    @RequestMapping("/index")
    public String index() {
    	return "wx/test";
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
            String path = ContextLoader.getCurrentWebApplicationContext().getServletContext().getRealPath("upload/imgs/advert"); //文件存储位置
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
                url="/upload/imgs/advert/"+fileName;
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
    public PageList<Advert> sysGetAll(Advert advert) {
    	return advertService.getAllByAdvert(advert);
    }
    
    @RequestMapping("/sys/get")
    @ResponseBody
    public Advert sysGetAdvert(Integer id) {
		return advertService.getById(id);
    }
    
    /*拿到轮播图*/
    @RequestMapping("/sys/index")
    public String sysGet() {
    	return "sys/advert/index";
    }
    
    /*跳转到添加页面*/
    @RequestMapping("/sys/add")
    public String sysAdd() {
    	return "sys/advert/add";
    }
    
    
    /*删除*/
    @RequestMapping("/sys/remove")
    public void sysRemove(Integer id,HttpServletResponse response) {
    	ResponseResult result =new ResponseResult();
    	try {
    		advertService.remove(id);
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
    public void sysSave(@RequestBody Advert advert,HttpServletResponse response) {
    	ResponseResult result =new ResponseResult();
    	try {
    		if(advert.getId()==null) {
        		//添加
    			advertService.add(advert);
        		result.setMessage("添加成功");
        	}else {
        		//修改
        		advertService.update(advert);
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
