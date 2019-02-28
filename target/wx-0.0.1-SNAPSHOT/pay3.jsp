<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
			url:"/wx/getOpenId?",
			success: function(msg){
				console.log(msg);
				if (msg) {//根据返回值进行跳转
					 window.location.href = '/wx/pay';
				 }
			},error:function(msg){
				console.log(url);
				console.log(msg);
			}
		});
	
	}else{
		window.location.replace("/wx/wx/fail");
	}
	
	</script>

</head>
<body>
<a style="font-size: 20px" href="/wx/pay">支付</a>
</body>
</html>