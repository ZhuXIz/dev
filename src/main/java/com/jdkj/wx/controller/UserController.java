package com.jdkj.wx.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
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
import com.jdkj.wx.entity.User;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.UserQuery;
import com.jdkj.wx.service.IUserService;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController {

    @Autowired
    private IUserService userService;

    /*查询用户头像，昵称，跳转到个人中心*/
    @RequestMapping("/index")
    public String pageToUser(HttpSession session) {
//    	System.out.println(session.getAttribute("user"));
    	//session.setAttribute("user", new User("o85rZ1QhNUz6d3O_KtlhwghBdDdI"));
    	return "wx/user/index";
    }
    
    @RequestMapping("/money")
    public String pageToMoeny(HttpSession session,Model m) {
    	User user = (User) session.getAttribute("user");
    	m.addAttribute("userInfo", userService.getById(user.getId()));
    	return "wx/user/money";
    }

    /*查询用户是否存在，不存在则保留用户信息，存在则更新*/

  
    /*修改用户手机号*/
    @RequestMapping("/updatePhone")
    public String createPhone(@Param("user")User user) {
    	userService.updatePhone(user);
    	return "success";
    }
    
    /*查询用户的手机号，并跳转到手机号修改页面*/
    @RequestMapping("/phone")
    public String selectPhone(Model m,@Param("userId")String userId) {	
    	m.addAttribute("phone",userService.selectPhone(userId));
    	return "wx/user/phone";
    }
    
    /*********************************************签到***************************************************/
    @RequestMapping("/sign")
    public void doSign(HttpServletResponse response,HttpSession session) {
    	User user = (User)session.getAttribute("user");
    	ResponseResult result =new ResponseResult();
    	Map< String, Object> map = new HashMap<>();
    	if(user!=null) {
    		try {
        		map = userService.sign(user.getId());
        		result.setCode(0);
        		result.setResult(map);
        	}catch (Exception e) {
        		result.setCode(1);
        		result.setMessage("操作失败"+user);
    		}
    		
    	}else {
    		result.setCode(1);
    		result.setMessage("请登录后再签到！"+user);
    	}
		writeJson(response, result);
    }
    
    @RequestMapping("/getScore")
    public void getScore(HttpServletResponse response,HttpSession session) {
    	User user = (User)session.getAttribute("user");
    	ResponseResult result =new ResponseResult();
    	Map< String, Object> map = new HashMap<>();
    	if(user!=null) {
	    	try {
	    		User user2 = userService.getScore(user.getId());
	    		result.setCode(0);
	    		map.put("score", user2.getScore());
	    		map.put("times", user2.getTimes());
	    		//map.put("myUser", userService.getById(user.getId()));
	    		result.setResult(map);
	    	}catch (Exception e) {
	    		result.setCode(1);
	    		result.setMessage("操作失败");
			}
    	}else {
    		map.put("score", 0);
    	}
		writeJson(response, result);
		
    }
   
 

    /*********************************************后台管理***************************************************/
    @RequestMapping("/sys/index")
    public String sysGet(Model m,UserQuery query) {
    	PageList<User> list= userService.getAll(query);
    	m.addAttribute("list",list);
    	return "sys/user/index";
    }
    
    @RequestMapping("/sys/get")
    @ResponseBody
    public User sysGet(String id) {
    	return userService.getById(id);
    }
    
    /*跳转到添加页面*/
    @RequestMapping("/sys/add")
    public String sysAdd() {
    	return "sys/user/add";
    }
    
    
    /*删除*/
    @RequestMapping("/sys/remove")
    public void sysRemove(String id,HttpServletResponse response) {
    	ResponseResult result =new ResponseResult();
    	try {
    		userService.remove(id);
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
    public void sysSave(@RequestBody User user,HttpServletResponse response) {
    	ResponseResult result =new ResponseResult();
    	try {
    		System.out.println(user);
    		if(user.getId()==null) {
    			String id=new Date().getTime()+"X"+new Random().nextInt(1000);//新id
    			user.setId(id);
        		//添加
    			userService.add(user);
    			result.setMessage("添加成功");	
        	}else {
        		//修改
        		userService.update(user);
        		result.setMessage("修改成功");	
        	}
    		
    		result.setCode(0);
    		
    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("操作失败");
		}
		writeJson(response, result);
    }
    
    @ResponseBody
    @RequestMapping("/sys/uploadImg")
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
        	String returnUrl = request.getContextPath() +"/upload/imgs/user/";//存储路径
            String path = ContextLoader.getCurrentWebApplicationContext().getServletContext().getRealPath("upload/imgs/user"); //文件存储位置
            String fileF = fileName.substring(fileName.lastIndexOf("."), fileName.length());//文件后缀
            fileName=new Date().getTime()+"_"+new Random().nextInt(1000)+fileF;//新的文件名
 
            //先判断文件是否存在
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
            String fileAdd = sdf.format(new Date());
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
                url="/upload/imgs/user/"+fileName;
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
    
}
