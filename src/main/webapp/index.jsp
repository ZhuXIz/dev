<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script type="text/javascript">
//http://192.168.43.13:8080/wx/wxLogin.jsp
var redirect_urls= encodeURIComponent("http://ceshi.kkfngu.com/wx/wxLogin.jsp");
/* var redirect_urls= encodeURIComponent("http://192.168.1.3:8080/wx/wxLogin.jsp"); */
var urls =  "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxab389d5d9b83cc0d&redirect_uri="+redirect_urls+"&response_type=code&scope=snsapi_userinfo&state=STATE&connect_redirect=1#wechat_redirect";

var user="<%=session.getAttribute("user")%>"; 
if(user!="null"){
	window.location.href = '/wx/wx/index';
}else{
	window.location.href = urls;
}
</script>
<head>
<meta charset="UTF-8">
<title>用户登录验证</title>
</head>
<body>

</body>
</html>