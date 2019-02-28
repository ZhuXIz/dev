<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<script type="text/javascript">
var redirect_urls= encodeURIComponent("http://192.168.43.13:8080/wx/pay3.jsp");
var urls =  "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxd5f05ec829f479d3&redirect_uri="+redirect_urls+"&response_type=code&scope=snsapi_userinfo&state=STATE&connect_redirect=1#wechat_redirect"
window.location.href = urls;
<%-- var user="<%=session.getAttribute("user")%>"; 
if(user!="null"){
	window.location.href = '/wx/wx/index';
}else{
	window.location.href = urls;
} --%>
</script>
  <head>
    <title>支付测试</title>
  </head>
  <body>
  </body>
</html>
