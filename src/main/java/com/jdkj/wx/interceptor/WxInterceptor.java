package com.jdkj.wx.interceptor;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.jdkj.wx.entity.Employee;
import com.jdkj.wx.entity.User;

public class WxInterceptor implements HandlerInterceptor {
	//执行Handler方法之前执行
	
		//用于身份认证、身份授权
		//比如身份认证，如果认证通过表示当前用户没有登陆，需要此方法拦截不再向下执行
		@Override
		public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object handler) throws Exception {
			//判断session
			HttpSession session=request.getSession();
			//获取请求的url
			String url=request.getRequestURI();
			//判断url是否是公开地址(实际使用时将公开地址配置到配置文件中)
			
			
			
			
			//拦截包含sys的请求----------后台系统的请求
			if(url.indexOf("sys/")>=0){
				System.out.println(url+"000000000000"+(url.indexOf("sys/")>=0));
				if(url.indexOf("wx/sys/login")>=0){
					//如果要进行登录提交，放行
					return true;
				}
				//从session中取出用户份信息
				Employee employee =(Employee)session.getAttribute("employee");
				
				if(employee!=null){
//					request.getRequestDispatcher(url).forward(request, response);
					//身份存在，放行
					return true;
				}
				System.out.println("拦截转发");
				//执行这里表示用户身份需要验证，跳转到登录界面
				request.getRequestDispatcher("/login.jsp").forward(request, response);
				return false;
			}

			if(url.indexOf("wx/login")>=0){
				//如果要进行登录提交，放行
				return true;
			}
			
			
			//从session中取出用户份信息
			User user=(User)session.getAttribute("user");
			
			if(user!=null){
//				request.getRequestDispatcher(url).forward(request, response);
				//身份存在，放行
				return true;
			}
			
			
			//对商品页面请求做处理
			if(url.indexOf("goods/goods")>=0) {
				Integer goodsId = Integer.parseInt(request.getParameter("goodsId"));
				if((request.getParameter("userListId")!=null&&!request.getParameter("userListId").equals("null"))
						&&(request.getParameter("listId")!=null&&!request.getParameter("listId").equals("null"))
							&&(request.getParameter("userId")!=null&&!request.getParameter("userId").equals("null"))) {
					String userListId = request.getParameter("userListId");
					String listId = request.getParameter("listId");
					String userId = request.getParameter("userId");
					System.out.println(url+"?goodsId="+goodsId+"&userListId="+userListId+"&listId="+listId+"&userId="+userId);
					session.setAttribute("url",url+"?goodsId="+goodsId+"&userListId="+userListId+"&listId="+listId+"&userId="+userId);
				}else {
					if(goodsId!=null)
					session.setAttribute("url",url+"?goodsId="+goodsId);
				}
			}
			
			//分享的请求存放起来之后在登录后进行跳转
			//执行这里表示用户身份需要验证，跳转到登录界面
			request.getRequestDispatcher("/index.jsp").forward(request, response);
			
			//return false表示拦截，不向下执行
			//return true表示放行		
			return false;
		}
		
		//进入Handler方法之后，返回modelAndView之前执行
		//应用场景从modelAndView出发：将公用的模型数据(比如菜单导航)在这里
		//传到视图，也可以在这里统一指定视图
		@Override
		public void postHandle(HttpServletRequest request, HttpServletResponse response,
				Object handler, ModelAndView modelAndView) throws Exception {
			System.out.println("HandlerInterceptor1......postHandle");
			
		}
		
		//执行Handler完成执行此方法
		//应用场景：统一异常处理，统一日志处理
		@Override
		public void afterCompletion(HttpServletRequest request, HttpServletResponse response,
				Object handler, Exception ex)
				throws Exception {
			 
			System.out.println("HandlerInterceptor1......afterHandle");

		}
		
		public static String getRequestQueryString(HttpServletRequest request)  
	            throws IOException {  
	        String submitMehtod = request.getMethod();  
	        // GET  
	        if (submitMehtod.equals("GET")) {  
	            return new String(request.getQueryString().getBytes("iso-8859-1"),"utf-8");  
	        // POST  
	        } else {  
	            return getRequestPostStr(request);  
	        }  
	    }  
		public static String getRequestPostStr(HttpServletRequest request)  
	            throws IOException {  
	        byte buffer[] = getRequestPostBytes(request);  
	        String charEncoding = request.getCharacterEncoding();  
	        if (charEncoding == null) {  
	            charEncoding = "UTF-8";  
	        }  
	        return new String(buffer, charEncoding);  
	    }  
		 public static String getRequestJsonString(HttpServletRequest request)  
		            throws IOException {  
		        String submitMehtod = request.getMethod();  
		        // GET  
		        if (submitMehtod.equals("GET")) {  
		            return new String(request.getQueryString().getBytes("iso-8859-1"),"utf-8").replaceAll("%22", "\"");  
		        // POST  
		        } else {  
		            return getRequestPostStr(request);  
		        }  
		    }  

		    /**       
		     * 描述:获取 post 请求的 byte[] 数组 
		     * <pre> 
		     * 举例： 
		     * </pre> 
		     * @param request 
		     * @return 
		     * @throws IOException       
		     */  
		    public static byte[] getRequestPostBytes(HttpServletRequest request)  
		            throws IOException {  
		        int contentLength = request.getContentLength();  
		        if(contentLength<0){  
		            return null;  
		        }  
		        byte buffer[] = new byte[contentLength];  
		        for (int i = 0; i < contentLength;) {  

		            int readlen = request.getInputStream().read(buffer, i,  
		                    contentLength - i);  
		            if (readlen == -1) {  
		                break;  
		            }  
		            i += readlen;  
		        }  
		        return buffer;  
		    }  

	
}
