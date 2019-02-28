package com.jdkj.wx.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.ibatis.annotations.Param;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.converter.WordToHtmlConverter;
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
import com.jdkj.wx.entity.GoodsImage;
import com.jdkj.wx.entity.GoodsType;
import com.jdkj.wx.entity.MyCollection;
import com.jdkj.wx.entity.Seller;
import com.jdkj.wx.entity.User;
import com.jdkj.wx.page.GoodsPage;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.GoodsQuery;
import com.jdkj.wx.service.IEvaluateService;
import com.jdkj.wx.service.IGoodsImageService;
import com.jdkj.wx.service.IGoodsService;
import com.jdkj.wx.service.IGoodsTypeService;
import com.jdkj.wx.service.IOrderService;
import com.jdkj.wx.service.ISellerService;
import com.jdkj.wx.service.ISpellListService;

@Controller
@RequestMapping("/goods")
public class GoodsController extends BaseController{

    @Autowired
    private IGoodsService goodsService;
    @Autowired
    private IGoodsTypeService goodsTypeService;
    @Autowired
    private IEvaluateService evaluateService;
    @Autowired
    private IGoodsImageService goodsImageService;
    @Autowired
    private IOrderService orderService;
    /*抢购页*/
    @RequestMapping("/index")
    public String pageToRush() {
    	
        return "wx/rush/index";
    }
   
    
    /*防止频繁添加促销活动*/
    @RequestMapping("/check")
    public void check(HttpServletResponse response,HttpSession session) {
    	ResponseResult result = new ResponseResult();
    	Map<String, Object> map = new HashMap<String, Object>();
    	try {
    		boolean bool = goodsService.getBySellerId(((User)session.getAttribute("user")).getId());
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
    
/*    @InitBinder
    public void initBinder(WebDataBinder binder) {
	    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	    dateFormat.setLenient(true);
	    binder.registerCustomEditor(Date.class, new CustomDateEditor(
	    dateFormat, true));
    }
*/
    
    /*首页展示数据*/
    @RequestMapping("/show")
    @ResponseBody
    public List<Goods> getHomeGoods() {
    	List<Goods> list = goodsService.getFirst();
    	if(list.size()==0 || list ==null) 
    		return null;

        return list;
    }
    
    @RequestMapping(value= {"/getType","/sys/getType"})
    @ResponseBody
    public List<GoodsType> getType() {
    	List<GoodsType> list = goodsTypeService.getAll();
    	if(list.size()==0 || list ==null) 
    		return null;

        return list;
    }
    
    /*商品后台展示数据*/
    @RequestMapping("/get")
    @ResponseBody
    public PageList<Goods> getSellerGoods(HttpSession session,GoodsQuery query) {
    	User user = (User)session.getAttribute("user");
    	query.setSellerId(user.getId());
    	PageList<Goods> pageList = goodsService.getSellerGoods(query);
    	if(pageList.getRows().size()==0 || pageList.getRows() ==null) 
    		return null;
        return pageList;
    }
    /*商品后台展示数据*/
    @RequestMapping("/remove")
    @ResponseBody
    public boolean removeSellerGoods(int goodsId) {
    	boolean state = goodsService.removeSellerGoods(goodsId);
    	
        return state;
    }
    
    //刷新拼团状态
    @RequestMapping("/updateState")
    public void updateState(@ModelAttribute Goods goods,HttpSession session,HttpServletResponse response) {
    	ResponseResult result = new ResponseResult();
    	try {
    		boolean bool = goodsService.updateState(goods);
    		result.setCode(0);
    		if(bool)
    			result.setMessage("更新商品状态成功");
    		else
    			result.setMessage("更新商品状态失败");
    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("更新商品状态失败");
		}
    	writeJson(response, result);
    }

    /*更多商品*/
    @RequestMapping("/more")
    @ResponseBody
    public List<Goods> getMore(BaseQuery<Goods> query) {
    	List<Goods> list = goodsService.getMore(query);
    	if(list.size()==0 || list ==null) 
     		return null;
         return list;
    }
    
    /*查询订单是否存在*/
    @RequestMapping("/getState")
    @ResponseBody
    public void getNum(Integer goodsId,HttpServletResponse response) {
    	
    	ResponseResult result = new ResponseResult();
    	Map<String, Object> map = new HashMap<String, Object>();
    	try {
    		boolean bool = goodsService.getNum(goodsId);
    		if(!bool)
    			goodsService.updateValidByNum(goodsId);
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
    
    /*更多分类商品*/
    @RequestMapping("/moreType")
    @ResponseBody
    public PageList<Goods> getMoreByType(@Param("query")GoodsQuery query) {
    	System.out.println("typeId:"+(query.getTypeId()==null)+"page:"+query.getPage());
    	PageList<Goods> pageList = goodsService.getMoreByType(query);
    	if(pageList.getRows().size()==0 || pageList.getRows() ==null) 
    		return null;
    	return pageList;
    }
    
    /*更多商品分类*/
   /* @RequestMapping("/type")
    @ResponseBody
    public GoodsType getType(Model m) {
    	List<GoodsType> list = goodsService.getGoodsType();
    	m.addAttribute("list",list);
    	System.out.println(list);
    	return "success";
    }*/
    /*当前商品所有信息*/
    @RequestMapping("/getGoods")
    @ResponseBody
    public GoodsPage getGoods(int goodsId,HttpSession session) {
    	
    	//查询是否收藏
    	MyCollection coll = new MyCollection();
    	coll.setUser((User)session.getAttribute("user"));
    	coll.setGoods(new Goods(goodsId));
    	GoodsPage goodsPage=null;
    	Integer evaluateCount = null;
    	Goods goods = null;
    	try {
    		//查询评论总数evaluateCount
        	evaluateCount = evaluateService.getEvaluateCount(goodsId);
        	
        	goods = goodsService.getById(goodsId);
        	System.out.println("goodsId:"+goodsId+"\ngoods:"+goods);
        	goodsPage = new GoodsPage(0,goods, evaluateCount, coll);

    	}catch (Exception e) {
    		goodsPage = new GoodsPage(1,goods, evaluateCount, coll);
    		return goodsPage;
		}
    	return goodsPage;
    }
    
    
    
    /*当前商品下过单的用户*/
    @RequestMapping("/getUser")
    public void getUserGoods(Integer goodsId,HttpServletResponse response) {
    	ResponseResult result = new ResponseResult();
    	Map<String, Object> map = new HashMap<String, Object>();
    	try {
    		List<User> user = orderService.getUserByThisGoods(goodsId);
    		result.setCode(0);
    		result.setMessage("查询成功");
    		map.put("user", user);
    		result.setResult(map);
    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("查询失败");
		}
    	writeJson(response, result);
    }
    
    
    @RequestMapping("/goods")
    public String getGoods(Model m,Integer goodsId) {
    	try {
    		//添加浏览量
        	goodsService.updateBrowNum(goodsId);
        	//查询数量是否超出，改变状态
        	goodsService.updateValidByNum(goodsId);
    		
    	}catch (Exception e) {
			e.printStackTrace();
		}
    	
    	return "wx/goods/index";
    }
  
    /*添加商品*/
    /*跳转到添加商家信息页面*/
    @RequestMapping("/add")
    public String pageToAddGoods(HttpServletResponse response,HttpSession session,Model m,HttpServletRequest request) {
    	User user = (User)session.getAttribute("user");
    	Goods goods = new Goods(new Seller(user.getId()));
    	//System.err.println(request.getParameter("goodsId")==null);
    	if(request.getParameter("goodsId")!=null) {
    		int goodsId = Integer.parseInt(request.getParameter("goodsId"));
	    	goods = goodsService.getById(goodsId);
    	}
    	m.addAttribute("goods", goods);

    	return "wx/goods/add";
    }
    

    /*添加商家后跳转到index*/
    @RequestMapping("/save")
    public String saveGoods(HttpSession session,@ModelAttribute Goods goods,@ModelAttribute GoodsImage goodsImage) {
    	if(goods.getId()==null) {
    		Goods good = goods;
        	if(good.getResNum()==0||good.getResNum()==null)
        		good.setResNum(0);
        	try {
        		goodsService.add(good);
            	List<GoodsImage> list = new ArrayList<GoodsImage>();
            	System.out.println(goods);
            	if(!goodsImage.getImage().trim().equals("")) {
            		for (String img : goodsImage.getImage().split(",")) {
            			GoodsImage image= new GoodsImage(img,new Goods(good.getId()));
        				list.add(image);
        			}
            	}
            	goodsImageService.add(list);
        	}catch (Exception e) {
    			e.printStackTrace();
    		}
    	}else {
    		Goods good = goods;
    		
        	if(good.getResNum()==0||good.getResNum()==null)
        		good.setResNum(0);
        	try {
        		goodsService.update(good);
            	List<GoodsImage> list = new ArrayList<GoodsImage>();
            	//System.out.println(goods);
            	if(!goodsImage.getImage().trim().equals("")) {
            		for (String img : goodsImage.getImage().split(",")) {
            			GoodsImage image= new GoodsImage(img,new Goods(good.getId()));
        				list.add(image);
        			}
            	}
            	
            	goodsImageService.add(list);
        	}catch (Exception e) {
    			e.printStackTrace();
    		}
    	}
    	return "redirect:/seller/index";
    }
    
    @RequestMapping("/sys/getTime")
    public void getGoodsTime(@Param("goodsId") Integer goodsId,HttpServletResponse response) {
    	ResponseResult result = new ResponseResult();
    	Map<String, Object> map = new HashMap<String, Object>();
    	try {
    		Goods goods = goodsService.getGoodsTime(goodsId);
    		if(goods!=null) {
    			result.setCode(0);
    			map.put("goods", goods);
    			result.setMessage("拿到商品活动时间段");
    			result.setResult(map);
    		}else {
    			result.setCode(1);
    			result.setMessage("未获取到商品活动时间段");
    		}
    			
    	}catch (Exception e) {
    		result.setCode(2);
    		result.setMessage("后台逻辑错误");
		}
    	writeJson(response, result);
    }
    
    @ResponseBody
    @RequestMapping(
    		value={"/uploadImg","sys/uploadImg"})
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
        	String returnUrl = request.getContextPath() +"/upload/imgs/goods/";//存储路径
            String path = ContextLoader.getCurrentWebApplicationContext().getServletContext().getRealPath("upload/imgs/goods"); //文件存储位置
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
                url="/upload/imgs/goods/"+fileName;
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
    @ResponseBody
    @RequestMapping(value={"/upload","sys/upload"})
    public void docToHtml(@RequestParam(value="file",required=false)MultipartFile file,HttpServletRequest request,HttpServletResponse response) throws Exception {

	    String path = ContextLoader.getCurrentWebApplicationContext().getServletContext().getRealPath("upload");
	    String fileName =new Date().getTime()+"_"+new Random().nextInt(1000);
	    //图片存放地址
	    String imagePathStr = path+"/html/image/";
	    //word文件存放地址
	    String docPath = path+"/";
	    String docName = fileName+".doc";
	    //html存放位置
	    String htmlPath=path+"/html/";
	    String targetFileName=htmlPath+fileName+".html";//新的文件名
	    String htmlName="/upload/html/"+fileName+".html";//返回的文件名
	    
	    File htmlF =new File(htmlPath); 
	    File docF =new File(docPath); 
	    File ImageF =new File(imagePathStr); 
        //如果文件夹不存在则创建    
        if(!htmlF .exists()&&!htmlF .isDirectory()){
        	System.out.println("应该创建html的文件夹");
        	//file1 .mkdir(); 
        	htmlF.mkdirs();
        }
        if(!docF .exists()&&!docF .isDirectory()){
        	System.out.println("应该创建doc的文件夹");
        	//file1 .mkdir(); 
        	docF.mkdirs();
        }
        if(!ImageF .exists()&&!ImageF .isDirectory()){
        	System.out.println("应该创建html的文件夹");
        	//file1 .mkdir(); 
        	ImageF.mkdirs();
        }
        

        //将doc存入文件夹
        File targetFile = new File(docF, docName);
        try {
        	//将上传的文件写到服务器上指定的文件。
            file.transferTo(targetFile);
        }catch (Exception e) {
			e.printStackTrace();
		}
	    HWPFDocument wordDocument = new HWPFDocument(new FileInputStream(docPath+docName));
	    org.w3c.dom.Document document = DocumentBuilderFactory.newInstance().newDocumentBuilder().newDocument();
	    WordToHtmlConverter wordToHtmlConverter = new WordToHtmlConverter(document);
	    //保存图片，并返回图片的相对路径
	    wordToHtmlConverter.setPicturesManager((content, pictureType, name, width, height) -> {
	        try (FileOutputStream out = new FileOutputStream(imagePathStr + name)) {
	            out.write(content);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return "/upload/html/image/"+name;
	    });
	    wordToHtmlConverter.processDocument(wordDocument);
	    org.w3c.dom.Document htmlDocument = wordToHtmlConverter.getDocument();
	    DOMSource domSource = new DOMSource(htmlDocument);
	    StreamResult streamResult = new StreamResult(new File(targetFileName));
	    TransformerFactory tf = TransformerFactory.newInstance();
	    Transformer serializer = tf.newTransformer();
	    serializer.setOutputProperty(OutputKeys.ENCODING, "utf-8");
	    serializer.setOutputProperty(OutputKeys.INDENT, "yes");
	    serializer.setOutputProperty(OutputKeys.METHOD, "html");
	    serializer.transform(domSource, streamResult);
	    
	    Map<String, Object> map = new HashMap<String, Object>();
	    ResponseResult result = new ResponseResult();
        result.setCode(0);
        result.setMessage("图片上传成功");
        map.put("url", htmlName);
        result.setResult(map);
	    writeJson(response, result);
	}
    
    
    
    

    /*********************************************后台管理***************************************************/
    @RequestMapping("/sys/index")
    public String sysGet(Model m,BaseQuery<Goods> query) {
    	PageList<Goods> list= goodsService.getAll(query);
    	m.addAttribute("list",list);
    	return "sys/goods/index";
    }
    
    /*跳转到添加页面*/
    @RequestMapping("/sys/add")
    public String sysAdd() {
    	return "sys/goods/add";
    }
    
    
    @RequestMapping("/sys/get")
    @ResponseBody
    public Goods sysGet(Integer id) {
    	return goodsService.getById(id);
    }
    @RequestMapping("/sys/getGoods")
    @ResponseBody
    public PageList<Goods> getGoods(Goods goods) {
    	PageList<Goods> list = goodsService.getAllGoods(goods);
    	System.out.println("goods："+goods);
    	return list;
    }
   
    
    /*删除*/
    @RequestMapping("/sys/remove")
    public void sysRemove(Integer id,HttpServletResponse response) {
    	ResponseResult result =new ResponseResult();
    	try {
    		goodsService.remove(id);
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
    public void sysSave(@RequestBody Goods goods,HttpServletResponse response) {
    	ResponseResult result =new ResponseResult();
    	System.out.println("goods:"+goods);
    	Goods good = goods;
    	try {
    		if(good.getId()==null) {
        		//添加
    			good.setSoldNum(0);
    			goodsService.add(good);
    			result.setMessage("添加成功");
    			
    			
				List<GoodsImage> list = good.getImages();
				for (GoodsImage goodsImage : list) {
					goodsImage.setGoods(new Goods(good.getId()));
				}
				goodsImageService.add(list);
        	}else {
        		//修改
        		goodsService.updateGoods(good);
        		result.setMessage("修改成功");
        		
        		List<GoodsImage> list = good.getImages();
				for (GoodsImage goodsImage : list) {
					goodsImage.setGoods(new Goods(good.getId()));
				}
				goodsImageService.add(list);
        	}
    		
    		result.setCode(0);
    		
    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("操作失败");
		}
		writeJson(response, result);
    }
    
    
    
    /*修改或添加*/
    @RequestMapping("/sys/saveAll")
    public void sysSaveAll(@RequestBody Goods goods,HttpServletResponse response) {
    	System.out.println("goods:"+goods);
    	ResponseResult result =goodsService.addAll(goods);
		writeJson(response, result);
    }
}
