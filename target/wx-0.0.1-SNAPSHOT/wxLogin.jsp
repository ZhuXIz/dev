<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>

<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>

<script type="text/javascript">
function getQueryString (name){
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
	var r = window.location.search.substr(1).match(reg);
	if (r != null) return unescape(r[2]); return null;
}

var code = getQueryString('code');
console.log("**********"+code);

	if(code != null){
		var parameters = {};
		parameters.code = code;
		parameters.grant_type="authorization_code";
		$.ajax({
			type: 'POST',
			data:parameters,
			async:false,
			url:"/wx/wx/login?",
			success: function(msg){
				console.log(msg);
				if (msg) {//根据返回值进行跳转
					var url="<%=session.getAttribute("url")%>"; 
					if(url=="null"){
						window.location.href = '/wx/wx/index';
					}else{
						window.location.href = url;
					}
					 //window.location.href = '/wx/wx/index';
				 }
			},error:function(msg){
				//console.log(url);
				console.log(msg);
			}
		});
	
	}else{
		window.location.replace("/wx/wx/fail");
	}
	
	

	/* var time =1;
	setInterval(function(){
		//document.getElementById("time").innerHTML=time+"<a href='wx/index'>跳过</a>";
		if(time>0){
			console.log(time--);
		}else{
			window.location.replace("wx/index");
		}
	},1000);  */ 

</script>
<style>
 	/* img {
	    max-width: 100%;
	    height: auto;
	}
	
	html,body{height: 100%;width: 100%;margin:0;padding:0;}
	body{
		background:url(http://www.runoob.com/wp-content/uploads/2016/04/trolltunga.jpg)no-repeat;
	    width:100%;
	    height:100%;
	    background-size:100% 100%;
	    position:absolute;
	    filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='http://www.runoob.com/wp-content/uploads/2016/04/trolltunga.jpg',sizingMethod='scale');
	}
	div{
		width: 20px;
		height: 20px;
		margin: 0px 0px 600px 0px;
	}  */
	
</style>
</head>
<body>
<div> 
	<font id="time" size="10px"/>
</div>
 
</body>
</html>