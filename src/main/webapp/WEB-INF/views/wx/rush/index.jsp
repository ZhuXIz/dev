<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="pixel-ratio-1" style="font-size: 18px !important;">
<head>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/wx/home.css" />
<c:import url="../../common/import3.jsp"></c:import>
<!-- <style type="text/css">
@font-face{
	font-family: glyphicons-halflings-regular; /*这里是说明调用来的字体名字*/
	src: url('font/iconfont.ttf'); /*这里是字体文件路径*/
}
</style> -->

<script type="text/javascript">

//默认全部展示
var typeId=null;
var commonPage=1;
var countPage = 1;
//验证是否还有数据
var isHas =true;
var url;
var length=0;
var currentClick;
function changeType(clickObj,id,page){
	currentClick =clickObj;
	$('.goodsShow').html("");
	//点击后显示处理
	$(".typeParent").children(".active").removeClass("active");
	$(clickObj).addClass("active");
	console.log($(clickObj));
	if(id==null){
		url ="/wx/goods/moreType?page="+page;
	}else{
		if(id !=typeId){
			length = 0;
			$('.goodsShow').html("");
			$('.cue').html("");
			//初始化页面参数
			commonPage=1;
			//清空页面
			
		}else{
			if(page==1)
				return false;
		}
		typeId =id;
		url ="/wx/goods/moreType?page="+page+"&typeId="+typeId;
	}
		$.ajax({
			type: 'POST',
			async:false,
			url:url,
			// 如果参数为json，加上这句
			contentType:"text/json",
			// 规定反参类型为text
			dataType:"json",
			success: function(msg){
				if (msg) {
					length +=msg.rows.length;
					$.each(msg.rows,function(idx, obj) {
					
					countPage = msg.total;
					
					var titleName = obj.titleName;
					if(titleName.length>=16){
						titleName = titleName.substring(0,15)+"...";
					}
					
					var html="";
					var oldPrice;
					if(obj.oldPrice==null)
						oldPrice="";
					else
						oldPrice="￥"+obj.oldPrice;
					
					var titleHtml="";

					console.log();
					if(obj.isValid==0){
						titleHtml='<a href="/wx/goods/goods?goodsId='+ obj.id+ '"'+
						'class="item thin-border_b">'+
						'<div class="top">'+
							'<div class="top_pic image-box">'+
							'<img src="${pageContext.request.contextPath}'+obj.titleImage+'">'+
							'<div class="list-status __end"></div>'+
								'</div>'+
							'</div>';
					}else{
						titleHtml='<a href="/wx/goods/goods?goodsId='+ obj.id+ '"'+
						'class="item thin-border_b">'+
						'<div class="top">'+
							'<div class="top_pic image-box">'+
							'<img src="${pageContext.request.contextPath}'+obj.titleImage+'">'+
								'</div>'+
							'</div>';
					}
						
					
					html=titleHtml+'<div class="btm">'+
						'<div class="btm_tit">'+titleName+'</div>'+
						'<div class="btm-b">'+
						'	<div class="btm-info">'+
								'<div class="btm_price fmt-price">'+
								'	<div class="now color-pri">'+
									'	<span class="dollar">¥</span> <span class="price" style="font-weight: bold;">'+obj.price+'</span>'+
								'	</div>'+
								'	<div class="old">'+oldPrice+'</div>'+
								'</div>'+
								'<div class="btm_saled">已抢：'+obj.soldNum+'</div>'+
							'</div>'+
							'<div>'+
								'<button class="btm_button i-button bg-pri">立即开团</button>'+
							'</div>'+
						'</div>'+
					'</div>'+
				'</a>';
					/* 
					if(obj.isValid==true){
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
					"<div><button class='btm_button i-button bg-pri'>立即购买</button></div></div></div></a>"; */
					$('.noSelect').text("");
					$('.goodsShow').append(html);
					/* if(idx ==msg.rows.length-1){
						
						var itemHeight=parseInt($('.goodsShowLeft').css("height"));
						height = length%2>0?itemHeight*((length/2)+0.5):itemHeight*(length/2);
						
						$('.goodsShow').css("height",height+"px");
					}
						 */
					});
				}else{
					$('.noSelect').text("没有更多内容了>_<");
				}
			},error:function(msg){
				$('.noSelect').text("没有更多内容了>_<");
			}
		});
	//}
}


$(window).scroll(function(){
	
　　//判断是否滑动到页面底部
     if($(window).scrollTop() === $(document).height() - $(window).height()){
    	
           // TODO 滑动到底部时可请求下一页的数据并加载，加载可使用append方法
           if(commonPage<countPage){
        	   
	           //加载下一一个数据
	           commonPage++;
	           changeType(currentClick,typeId,commonPage);
	           
	           /* if(commonPage==countPage){
	        	   $('.cue').html("");
	        	   var html="<div>已经到底了>_<</div>";
					$('.cue').append(html);
	           } */
	           
           }
     }
});

window.onload = function (){
	changeType($("#all"),typeId,commonPage);
}

</script>

<script type="text/javascript">
function getGoods(goods){
	
	window.location.href = "/wx/goods/goods?goodsId="+goods.id;
}
</script>
<title>资中优生活</title>
</head>

<body class="bg_f5">
	<div id="main">

		<!-- 轮播图  320*240 -->
		<div id="carousel-example-generic" class="carousel slide"
			data-ride="carousel" data-interval="3000">

			<!-- Wrapper for slides -->
			<div class="carousel-inner" style="text-align: center">
				<div class="item active">
					<img style="width: 100%"
						src="${pageContext.request.contextPath}/upload/imgs/advert/title1.jpg" />
				</div>
				<div class="item">
					<img style="width: 100%"
						src="${pageContext.request.contextPath}/upload/imgs/advert/title2.jpg" />
				</div>
			</div>
		</div>
		
		
		<!-- 过度条 -->
		<div class="panel panel-warning" style="height: 1px; width: 100%;"></div>
		<div class="g-wrap-c" id="main">
			<div class="hd-head bottom-line" style="width: 100%; height: 100%;">
				<div id="ih-scroll" style="width: 102%; height: 100%;">
					<ul class="typeParent" style="width: 100%; height: 100%;" id="typeShow">
						<!-- <li id="all" class="type-item active"
							onclick="changeType(this,null,1);">全部</li>
						<li class="type-item" onclick="changeType(this,2,1);">美食</li>
						<li class="type-item" onclick="changeType(this,1,1);">旅游</li>
						<li class="type-item" onclick="changeType(this,3,1)">KTV</li>
						<li class="type-item" onclick="changeType(this,4,1)">服装</li>
						<li class="type-item" onclick="changeType(this,5,1)">其他</li> -->
					</ul>
				</div>
			</div>
		</div>
		<br />
		<script type="text/javascript">
			$("#typeShow").html('<li id="all" class="type-item active" onclick="changeType(this,null,1);">全部</li>');
			 $.ajax({
					type : 'POST',
					async : false,
					 url: "/wx/goods/getType",
					// 如果参数为json，加上这句
					contentType : "text/json",
					// 规定反参类型为text
					dataType : "json",
			        success: function(ret) {
			        	var type_html="";
		            	$.each(ret,function(index,obj){
		            		type_html=type_html+'<li class="type-item" onclick="changeType(this,'+obj.id+',1)">'+obj.genreName+'</li>';
		            	})
		            	$("#typeShow").append(type_html);
			        },
			        error: function(ret) {
			        	console.log(ret);
			        }
			    });
				
				function setGoodsType(obj,type){
					var text = $(obj).text();
					$('.goodsTypeDrop').html(text+"<b class='caret'></b>");
					$('#goodsType').val(type);
				}		
		</script>
		<div>
			<!-- 广告位暂时不是数组形式，保证广告位显示，或者该模板下 -->
			<!-- 砍价专区 -->
			<!-- 自定义功能区 -->
			<!-- end 排序区 -->
			<!-- 推荐信息展示 -->

			
			<div>
				<div class="i-section thin-border_b">

				<div class="diy-wrap diy-type2">
					<div class="diy-list goodsShow" >
						
					</div>
				</div>
			</div>
			</div>
			<div style="text-align: center; color: gray;" class="noSelect"></div>
		</div>
		<div class="cue"
			style="text-align: center; color: gray; height: 50px;"></div>


	</div>
	<c:import url="../../common/footer.jsp"></c:import>
	<script type="text/javascript">
//定义该页面的名字
var pageName = 'rush';
$("#home").removeClass("current");
$("#user").removeClass("current");
$("#rush").addClass("current");
$("#rush").click(function(){
	if(pageName=="rush")
		return false;

});
</script>
</body>
</html>