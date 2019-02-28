<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html class="pixel-ratio-1" style="font-size: 18px !important;">
<head>

<c:import url="../common/import3.jsp"></c:import>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/wx/home.css" />
<title>资中优生活</title>
</head>



<script type="text/javascript">
//支付
$.ajax({
	type: 'POST',
	async:false,
	url:"/wx/pay?subject=士大夫犯得上犯得上&totalAmount=0.01",
	// 如果参数为json，加上这句
	contentType:"text/json",
	// 规定反参类型为text
	dataType:"json",
	success: function(msg){
		console.log(msg);
		console.log("sign:"+msg.sign);
      console.log("sb:"+msg.sb);
      
      var redirect_urls= encodeURIComponent("http://ceshi.kkfngu.com/wx/notify");
      console.log("mwebUrl:"+msg.mwebUrl);
      
      //拼接&redirect_url  支付回调
	},error:function(msg){
		console.log(msg.message);
	}
}); 










$.ajax({
	type: 'POST',
	async:false,
	url:"/wx/wx/check",
	// 如果参数为json，加上这句
	contentType:"text/json",
	// 规定反参类型为text
	dataType:"json",
	success: function(msg){
		if(msg.code==0)
			alert(msg.message);
		console.log(msg.message);
	},error:function(msg){
		console.log(msg.message);
	}
});

</script>
<body class="bg_f5">
<div id="main">
	<!-- 搜索 -->
	<!-- <div class="i-search">
		<a href="/Home/Act/search.html" class="search"> <span
			class="iconfont"></span>请输入搜索内容
		</a>
		
	</div> -->
	<!-- 轮播 -->
	<div id="carousel-example-generic" class="carousel slide"
		data-ride="carousel" data-interval="3000">

		<!-- Wrapper for slides -->
		<div class="carousel-inner" style="text-align: center">
		<c:if test="${ advertList==null||advertList.size()==0}">
			<div class="item active">
				<img style="width: 100%" src="${pageContext.request.contextPath}/upload/imgs/advert/eat.jpg" />
			</div>
			<div class="item">
				<img style="width: 100%" src="${pageContext.request.contextPath}/upload/imgs/advert/drink.jpg" />
			</div>
			<div class="item">
				<img style="width: 100%" src="${pageContext.request.contextPath}/upload/imgs/advert/play.jpg" />
			</div>
			<div class="item">
				<img style="width: 100%" src="${pageContext.request.contextPath}/upload/imgs/advert/happy.jpg" />
			</div>
		</c:if>
		
		<c:if test="${ advertList!=null&&advertList.size()!=0}">
			<c:forEach items="${ advertList}" var="advert"
				varStatus="advertStatu">
				<c:if test="${advertStatu.index==0 }">
					<div class="item active">
						<img style="width: 100%"
						src="${pageContext.request.contextPath}${advert.img}" />
					</div>
				</c:if>
				<c:if test="${advertStatu.index!=0 }">
					<div class="item">
						<img style="width: 100%"
						src="${pageContext.request.contextPath}${advert.img}" />
					</div>
				</c:if>
				
			</c:forEach>
		</c:if>
			
	</div>
	<!-- 功能区 -->

	<div>
		<!-- 广告位暂时不是数组形式，保证广告位显示，或者该模板下 -->
		<!-- 砍价专区 -->
		<!-- 自定义功能区 -->
		<!-- end 排序区 -->

		<div>
			<div class="i-section thin-border_b">
				<div class="i-tabs-wrap">
					<div class="i-title">
						<div class="tit">精品推荐</div>
						<div class="center"></div>
					</div>
					<div class="i-tabs thin-border border-pri color-pri">
						<div class="item bg-pri" >最新</div>
					</div>
				</div>
				<div>
					<div class="diy-wrap diy-type5" data-img="2" id="recomend-list">
						<div class="diy-list goodsShow" id="rec_list">
					<!-- 推荐信息展示 -->
						</div>
					</div>

				</div>
			</div>
		</div>

	</div>




</div>
<!--********************底部导航-->
<div class="shop-mes">
    <p class="font10">资中优生活</p>
</div>
<c:import url="../common/footer.jsp"></c:import>


<script type="text/javascript">
var pageName = 'home';
$("#user").removeClass("current");
$("#rush").removeClass("current");
$("#home").addClass("current");
$("#home").click(function(){
	if(pageName=="home")
		return false;
　　});
</script>
<script>

     // 推荐内容加载
    //定义该页面的名字
	
	
	//$("#home").addClass("current");
	window.onload = function() {
		$.ajax({
			type : 'get',
			async : false,
			url : "/wx/goods/show",
			// 如果参数为json，加上这句
			contentType : "text/json",
			// 规定反参类型为text
			dataType : "json",
			success : function(msg) {
				var titleName;
				if (msg) {
					$.each(msg,function(idx, obj) {
						if(obj.id==null)
							return true;
					titleName = obj.titleName;
					if(titleName!=null&&titleName.length>=18){
						titleName = titleName.substring(0,17)+".....";
					}
					
					var html;
					var titleHtml="";
					
					//alert(obj.isValid);
					if(obj.isValid==1||obj.isValid==2){
						titleHtml="<a href='/wx/goods/goods?goodsId="+ obj.id+ "'class='item thin-border_b'>"+
						"<div class='top'><div class='top_pic image-box'>"+
						"<img class='titleImage' src='${pageContext.request.contextPath}"+obj.titleImage+"'/></div></div>";
					}else{
						titleHtml="<a href='/wx/goods/goods?goodsId="+ obj.id+ "'class='item thin-border_b'>"+
						"<div class='top'><div class='top_pic image-box'>"+
						"<img class='titleImage' src='${pageContext.request.contextPath}"+obj.titleImage+"'/>"+
						"<div class='list-status __end'></div></div></div>";
					}
					html = titleHtml+
					"<div class='btm'><div class='btm_tit'>"+titleName+"</div><div class='btm-b'><div class='btm-info'>"+
					"<div class='btm_price fmt-price'><div class='now color-pri'><span class='dollar'>¥<em>"+obj.price+"</em></span>"+
					"</div></div><div class='btm_saled'>已抢:"+obj.soldNum+"</div></div>"+
					"</div></div></a>";
			
					$('.goodsShow').append(html);
					});
				}
			},
			error : function(msg) {
				alert("网站维护，请稍后再试！");
				console.log(msg);
			}
		});
	}
	
	
	
   </script>


<div class="suspension-container">


	<div class="wx-kefu" style="" id="wx-kefu">
		<img src="${pageContext.request.contextPath}/icons/service.png" alt=""
			class="" width="55">
	</div>
	<script type="text/javascript">
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
</div>



</body>
</html>