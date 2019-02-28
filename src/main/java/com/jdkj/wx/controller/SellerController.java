package com.jdkj.wx.controller;

import java.io.File;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.multipart.MultipartFile;

import com.jdkj.wx.common.ResponseResult;
import com.jdkj.wx.entity.Goods;
import com.jdkj.wx.entity.Seller;
import com.jdkj.wx.entity.User;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.GoodsQuery;
import com.jdkj.wx.service.IGoodsService;
import com.jdkj.wx.service.ISellerService;

@RequestMapping("/seller")
@Controller
public class SellerController extends BaseController {
		
	  	@Autowired
	    private ISellerService sellerService;
	  	@Autowired
	    private IGoodsService goodsService;

	    /*跳转到商户后台****一个账号一个商家*/
	    @RequestMapping("/index")
	    public String pageToSeller() {
	    	//User user = (User) session.getAttribute("user");
	    	//session.setAttribute("seller", sellerService.getById(user.getId()));
	    	return "wx/seller/index";
	    }
	    @RequestMapping("/get")
	    @ResponseBody
	    public Seller selectSeller(HttpSession session) {
	    	User user = (User) session.getAttribute("user");
	    	Seller seller = sellerService.getById(user.getId());
	    	return seller;
	    }
	    
	    /*防止添加多个商家*/
	    @RequestMapping("/check")
	    public void check(HttpServletResponse response,HttpSession session) {
	    	ResponseResult result = new ResponseResult();
	    	Map<String, Object> map = new HashMap<String, Object>();
	    	try {
	    		boolean bool = sellerService.getBySellerId(((User)session.getAttribute("user")).getId());
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
	
	    /*跳转到添加商家信息页面*/
	    @RequestMapping("/add")
	    public String pageToAddSeller(HttpSession session,Model m) {
	    	try {
		    	User user = (User) session.getAttribute("user");
		    	Seller seller = sellerService.getById(user.getId());
		    	m.addAttribute("seller", seller);
	    	}catch (Exception e) {
				return "redirect:/seller/index";
			}
	    	
	    	return "wx/seller/add";

	    }
	    /*跳转到商家展示*/
	    @RequestMapping("/list")
	    public String pageToSellerList() {

	    	return "wx/seller/list";
	    	
	    }
	    
	    
	    @ResponseBody
	    @RequestMapping("/uploadImg")
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
	        	//String returnUrl = request.getContextPath() +"/upload/imgs/seller/";//存储路径
	            String path = ContextLoader.getCurrentWebApplicationContext().getServletContext().getRealPath("upload/imgs/seller"); //文件存储位置
	            String fileF = fileName.substring(fileName.lastIndexOf("."), fileName.length());//文件后缀
	            fileName=new Date().getTime()+"_"+new Random().nextInt(1000)+fileF;//新的文件名
	 
	            //获取文件夹路径
	            File file1 =new File(path+"/"); 
	            
	           
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
	                url="/upload/imgs/seller/"+fileName;
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

	    /*添加商家后跳转到index*/
	    @RequestMapping("/save")
	    public void saveSeller(HttpServletResponse response,HttpSession session,@RequestBody Seller seller) {
	    	ResponseResult result = new ResponseResult();
	    	try {
		    	if(seller.getId()==null||seller.getId().trim().equals("" )) {
		    		User user = (User) session.getAttribute("user");
		    		seller.setIsValid(false);
			    	seller.setId(user.getId());
			    	sellerService.add(seller);
		    	}else {
		    		sellerService.update(seller);
		    	}
		    	result.setCode(0);
		    	result.setMessage("操作成功");
	    	}catch (Exception e) {
	    		result.setCode(0);
		    	result.setMessage("操作失败");
			}
	    	writeJson(response, result);
	    }
	
	    /*修改商家信息*/
	    @RequestMapping("/update")
	    public String updateSeller(Seller seller) {
	    	sellerService.update(seller);
	    	return "wx/seller/index";
	    }
	
	    /*删除商家信息*/
	    @RequestMapping("/remove")
	    public String deleteSeller(HttpSession session) {
	    	User user = (User) session.getAttribute("user");
	    	sellerService.remove(user.getId());
	    	return "redirect:/seller/index";
	    }
	    
	    
	    
	    
	    
	    
	    

	    /*********************************************后台管理***************************************************/
	    @RequestMapping("/sys/index")
	    public String sysGet() {
	    	/*PageList<Seller> list= sellerService.getAll(query);
	    	m.addAttribute("list",list);*/
	    	return "sys/seller/index";
	    }
	    @RequestMapping("/sys/getAll")
	    @ResponseBody
	    public PageList<Seller> sysTest(Seller seller) {
	    	System.out.println("seller:"+seller);
	    	return sellerService.getAllBySeller(seller);
	    }
	    
	    @RequestMapping("/sys/get")
	    @ResponseBody
	    public Seller sysGet(String id) {
	    	//System.out.println("000000000000000000000000000000000"+id);
	    	return sellerService.getById(id);
	    }
	    
	    
	    @RequestMapping("/sys/getGoods")
	    @ResponseBody
	    public PageList<Goods> getGoods(Goods goods) {
	    	return goodsService.getAllGoodsBySeller(goods);
	    }
	    
	    @RequestMapping("/sys/pass")
	    public void sysPass(String id,HttpServletResponse response) {
	    	ResponseResult result =new ResponseResult();
	    	try {
	    		boolean bool= sellerService.updatePass(id);
	    		if(bool) {
	    			result.setCode(0);
		    		result.setMessage("操作成功");
	    		}else {
	    			result.setCode(1);
		    		result.setMessage("操作失败");
	    		}
	    		
	    	}catch (Exception e) {
	    		result.setCode(1);
	    		result.setMessage("操作失败");
			}
			writeJson(response, result);
	    	
	    }
	    
	    /*跳转到添加页面*/
	    @RequestMapping("/sys/add")
	    public String sysAdd() {
	    	return "sys/seller/add";
	    }
	    
	    
	    /*删除*/
	    @RequestMapping("/sys/remove")
	    public void sysRemove(String id,HttpServletResponse response) {
	    	ResponseResult result =new ResponseResult();
	    	try {
	    		sellerService.remove(id);
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
	    public void sysSave(@RequestBody Seller seller,HttpServletResponse response) {
	    	ResponseResult result =new ResponseResult();
	    	System.out.println(seller);
	    	try {
	    		if(seller.getId()==null) {
	        		//添加
	    			String id=new Date().getTime()+"X"+new Random().nextInt(1000);//新id
	    			seller.setId(id);
	    			seller.setIsValid(true);
	    			sellerService.add(seller);
	    			result.setMessage("添加成功");
	        	}else {
	        		//修改
	        		sellerService.update(seller);
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
	    public void sysUploadImg(@RequestParam(value="file",required=false)MultipartFile file,HttpServletRequest request,HttpServletResponse response){
	        ResponseResult result = new ResponseResult();
			Map<String, Object> map = new HashMap<String, Object>();
	        File targetFile=null;
	        String url="";//返回存储路径
	        int code=1;
	        System.out.println(file);
	        String fileName=file.getOriginalFilename();//获取文件名加后缀
	        if(fileName!=null&&fileName!=""){   
	            //String returnUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() +"/upload/imgs/";//存储路径
	        	//String returnUrl = request.getContextPath() +"/upload/imgs/seller/";//存储路径
	            String path = ContextLoader.getCurrentWebApplicationContext().getServletContext().getRealPath("upload/imgs/seller"); //文件存储位置
	            String fileF = fileName.substring(fileName.lastIndexOf("."), fileName.length());//文件后缀
	            fileName=new Date().getTime()+"_"+new Random().nextInt(1000)+fileF;//新的文件名
	 
	            //获取文件夹路径
	            File file1 =new File(path+"/"); 
	            
	           
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
	                url="/upload/imgs/seller/"+fileName;
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
