<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html class="pixel-ratio-1" style="font-size: 18px !important;">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:import url="../../common/import3.jsp"></c:import>
</head>
<script type="text/javascript">
var appId;
var timestamp;
var nonceStr;
var signature;
var url = encodeURIComponent(location.href.split('#')[0]);
var to_url = location.href.split('#')[0];
//url = url.replace("&from=singlemessage","");
//alert(url);
$.ajax({
	type : 'get',
	async : false,
	url : "/wx/wx/getWxConfig?url="+url,
	// 如果参数为json，加上这句
	contentType : "text/json",
	// 规定反参类型为text
	dataType : "json",
	success : function(msg) {
		console.log(msg);
		appId=msg.appid;
		timestamp=msg.timestamp;
		nonceStr=msg.nonceStr;
		signature=msg.signature;
	},
	error : function(msg) {
		alert("未知错误");
	}
});


function onBridgeReady(){
	   WeixinJSBridge.invoke(
	      'getBrandWCPayRequest', {
	         "appId":appId,     //公众号名称，由商户传入     
	         "timeStamp":timestamp,         //时间戳，自1970年以来的秒数     
	         "nonceStr":nonceStr, //随机串     
	         "package":"prepay_id=u802345jgfjsdfgsdg888",     
	         "signType":"MD5",         //微信签名方式：     
	         "paySign":signature //微信签名 
	      },
	      function(res){
	      if(res.err_msg == "get_brand_wcpay_request:ok" ){
	      // 使用以上方式判断前端返回,微信团队郑重提示：
	            //res.err_msg将在用户支付成功后返回ok，但并不保证它绝对可靠。
	      } 
	   }); 
	}
	if (typeof WeixinJSBridge == "undefined"){
	   if( document.addEventListener ){
	       document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
	   }else if (document.attachEvent){
	       document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
	       document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
	   }
	}else{
	   onBridgeReady();
	}

</script>
<body>
<input type="checkbox">
</body>
</html>