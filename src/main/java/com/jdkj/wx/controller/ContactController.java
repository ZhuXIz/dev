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
import com.jdkj.wx.entity.Contact;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.service.IContactService;

@Controller
@RequestMapping("/contact")
public class ContactController extends BaseController {

    @Autowired
    private IContactService contactService;

    /*拿到联系我们*/
    @RequestMapping("/getContact")
    public String getContact(Model m) {
    	Contact contact= contactService.getContact();
    	m.addAttribute("contact", contact);
    	return "wx/contact/contact";
    }
    
    /*拿到客服*/
    @RequestMapping("/service")
    @ResponseBody
    public Contact getService() {
    	return contactService.getService();
    }
    
    /*修改*/
    @RequestMapping("/update")
    public Contact updateContact() {
    	Contact contact= contactService.get();
    	return contact;
    }
    
    /*拿到关于我们*/
    @RequestMapping("/get")
    public String get(Model m) {
    	Contact contact= contactService.get();
    	m.addAttribute("contact", contact);
    	return "wx/contact/index";
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
            String path = ContextLoader.getCurrentWebApplicationContext().getServletContext().getRealPath("upload/imgs/contact"); //文件存储位置
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
                url="/upload/imgs/contact/"+fileName;
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
    public PageList<Contact> sysGetAll(Contact contact) {
    	return contactService.getAllByContact(contact);
    }
    
    
    @RequestMapping("/sys/index")
    public String index() {
    	return "sys/contact/index";
    }
    
    /*拿到轮播图*/
    @RequestMapping("/sys/get")
    @ResponseBody
    public Contact sysGet(Integer id) {
    	return contactService.getById(id);
    }
    
    
    
    /*删除*/
    @RequestMapping("/sys/remove")
    public void sysRemove(Serializable id,HttpServletResponse response) {
    	ResponseResult result =new ResponseResult();
    	try {
    		contactService.remove(id);
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
    public void sysSave(@RequestBody Contact contact,HttpServletResponse response) {
    	ResponseResult result =new ResponseResult();
    	try {
    		if(contact.getId()==null) {
        		//添加
    			contactService.add(contact);
        	}else {
        		//修改
        		contactService.update(contact);
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
