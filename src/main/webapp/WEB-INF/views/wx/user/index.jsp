<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html class="pixel-ratio-1" style="font-size: 18px !important;">
<head>
<meta charset="UTF-8">

<title>资中优生活</title>
<c:import url="../../common/import3.jsp"></c:import>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/wx/home.css" />
<script type="text/javascript">
//定义该页面的名字
var pageName = 'user';
</script>
<style>
html, body {
	height: auto !important;
	background-color: #f5f5f5;
}

.personal-head {
	background: url("${pageContext.request.contextPath}/icons/homeBg.jpg")
		no-repeat;
	background-size: 100% 100%;
	background-position: center;
}

.personal-head .hascard .headmsg {
	padding-right: 0;
}

.headmsg .statu {
	height: 1.7857rem;
	/* background:rgba(255,255,255,0.2); */
	border-radius: 1.9286rem;
	/* padding:0 0.6429rem; */
	margin-top: 0.3571rem;
	display: -webkit-inline-box;
	display: -webkit-inline-flex;
	display: block;
	-webkit-box-align: center;
	-webkit-align-items: center;
	align-items: center;
}

.headmsg .balance {
	font-size: 1rem;
}

.headmsg .card-container {
	font-size: 1rem;
}

.headmsg .card-container .card_name {
	line-height: 1.3571rem;
}

.headmsg .card-container img {
	margin-left: 0.4rem;
	width: 2rem;
	vertical-align: text-top;
}

.uncard-balance {
	position: absolute;
	right: 1rem;
	top: 1rem;
	font-size: 0.7857rem;
	color: #333;
}

 .headcard {
	background: unset;
	background-color: #fff;
	box-shadow: 0px 0.0714rem 0.0714rem 0px rgba(213, 213, 213, 0.5);
}


/*# sourceMappingURL=my.css.map */
.headImage {
	width: 100px;
}

.qiandao{
	position: absolute;
	width:100%;
	height: 100%;
	font-size: 1rem;
	float:right;
	top: 50%;
	-webkit-transform: translateY(-50%);
	transform: translateY(-50%);
	text-align: center;
}
</style>
<script type="text/javascript">
$(function(){
	pushHistory();
	window.addEventListener("popstate", function(e) {
	
	}, false);
	function pushHistory() {
	var state = {
	title: "title",
	url: "#"
	};
	window.history.pushState(state, "title", "#");
	}
});
</script>
</head>
<body>

	<div class="personal-head">
		<!-- 关闭会员卡功能 -->
		<!-- 开通会员卡功能 -->
		<div class="hascard">
			<div class="headmsg">
				<img class="img-circle  headImage" src="${user.imageUrl}">
				<div class="name">
					<div>
						<span class="card-container"> 
						<img
							src="${pageContext.request.contextPath}/icons/VIP.png">
							<span class="card_name">${user.name}</span>
						</span>
					</div>

				</div>
				<a href="#" class="jifen" id="my_jifen">我的积分：0<i
					class="iconfont"></i></a>
			</div>
		</div>

	</div>
	<br />
	<!-- 头像 -->
	<div class="vipcard" >
		<div class="headcard">
			<div class="title">
				<!--  -->
				<i class="vip iconfont"></i> <span class="txt">超级会员</span>
			</div>
			<div class="hr"></div>
			<div class="rule" >会员专享特权·专属商品·好物折上折</div>
			
			<a class="goVip">
				<img src="${pageContext.request.contextPath}/icons/qiandao.png	">
             </a>
             
		</div>
	</div>
	
	<div style="padding-top: 20px; text-align: center;" >
		<img  id="scoreView" src="${pageContext.request.contextPath}/icons/score/0.png">
	</div>
	
	<br />
	<script type="text/javascript">
	$.ajax({
		type : 'get',
		async : false,
		url : "/wx/user/getScore",
		// 如果参数为json，加上这句
		contentType : "text/json",
		// 规定反参类型为text
		dataType : "json",
		success : function(msg) {
			if (msg.code==0) {
				if(typeof(msg.result.score)=='undefined')
					$("#my_jifen").text("我的积分:0");
				else{
					$("#my_jifen").text("我的积分:"+msg.result.score);
					$("#scoreView").attr("src","${pageContext.request.contextPath}/icons/score/"+msg.result.times+".png");
				}
					
			}else{
              alert("获取积分失败");
            }
		},
		error : function(msg) {
			alert("功能维护，请稍后再试！");
			console.log(msg);
		}
	});
	
	  $('.goVip').click(function(){
	    	$.ajax({
				type : 'get',
				async : false,
				url : "/wx/user/sign",
				// 如果参数为json，加上这句
				contentType : "text/json",
				// 规定反参类型为text
				dataType : "json",
				success : function(msg) {
					if (msg.code==0) {
						if(msg.result.state){
							alert(msg.result.message+"+"+msg.result.score);
							$("#my_jifen").text("我的积分:"+(parseInt($("#my_jifen").text().split(":")[1])+msg.result.score));
							$("#scoreView").attr("src","${pageContext.request.contextPath}/icons/score/"+msg.result.times+".png");
						}else{
							alert(msg.result.message);
						}
					}else{
						console.log(msg);
					}
					
				},
				error : function(msg) {
					alert("功能维护，请稍后再试！");
					console.log(msg);
				}
			});
	    })
	</script>

	<div class="personal-order">
		<div class="title">
			<div class="titlel">商户</div>
		</div>
		<div class="items">

			<a class="item" href="/wx/seller/index">
				<div class="icon">
					<img src="${pageContext.request.contextPath}/icons/seller.png">
				</div>
				<div class="name">商户后台</div>
			</a> 
			<a class="item" href="/wx/user/money">
				<div class="icon">
					<img src="${pageContext.request.contextPath}/icons/money.png">
				</div>
				<div class="name">钱包</div>
			</a>
			<a class="item"> 
			</a> 
			<a class="item"> 
			</a> 
		</div>
	</div>


	<div class="personal-order">
		<div class="title">
			<div class="titlel">更多服务</div>
		</div>
		<div class="items">
			<a class="item" href="/wx/order/index"> 
				<div class="icon">
					<img src="${pageContext.request.contextPath}/icons/order.png">
					<div class="name">订单</div>
				</div>
			</a> 
			<a class="item" href="/wx/spell/index"> 
				<div class="icon">
					<img src="${pageContext.request.contextPath}/icons/pintuan.png">
					<div class="name">拼团</div>
				</div>
			</a>
			<a class="item" href="/wx/coll/index"> 
				<div class="icon">
					<img src="${pageContext.request.contextPath}/icons/coll.png">
					<div class="name">我的收藏</div>
				</div>
			</a>
			
			<a class="item" id="wx-kefu"> 
				<div class="icon">
					<img src="${pageContext.request.contextPath}/icons/service.png">
					<div class="name">在线客服</div>
				</div>
			</a> 
			</div>
			
		<div class="items">
			
			<a class="item" href="/wx/contact/get"> 
				<div class="icon">
					<img src="${pageContext.request.contextPath}/icons/concat2.png">
					<div class="name">关于我们</div>
				</div>
			</a> 
			<a class="item" href="/wx/contact/getContact"> 
				<div class="icon">
					<img src="${pageContext.request.contextPath}/icons/concat.png">
					<div class="name">联系我们</div>
				</div>
			</a>
			
			
			<a class="item" > 
			</a> 
			<a class="item"> 
			</a> 
		</div>
	</div>



<div style="height: 100px"></div>



	<c:import url="../../common/footer.jsp"></c:import>
<script type="text/javascript">
	//定义该页面的名字
	var pageName = 'user';
	$("#home").removeClass("current");
	$("#rush").removeClass("current");
	$("#user").addClass("current");
	$("#user").click(function(){
		if(pageName=="user")
			return false;
	
	});
	
	 // 客服
   $('#wx-kefu').click(function(){
   	$.ajax({
			type : 'get',
			async : false,
			url : "/wx/contact/service",
			// 如果参数为json，加上这句
			contentType : "text/json",
			// 规定反参类型为text
			dataType : "json",
			success : function(msg) {
				if (msg) {
					$.alert({title:'长按识别二维码',text:'<img src="'+msg.service+'" class="img_ewm mt6"/><a class="font12 display-b color_37" href="tel:'+msg.phoneNum+'"><i class="iconfont font14 mr4 color_org">&#xe63e;</i>联系客服：<span class="color_org">'+msg.phoneNum+'</span></a>'});
				}
			},
			error : function(msg) {
				alert("网站维护，请稍后再试！");
				console.log(msg);
			}
		});
   	
   	
   	
   })

</script>
</body>
</html>