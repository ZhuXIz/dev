<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资中优生活</title>
<c:import url="../../common/import.jsp"></c:import>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/show.css">
<style type="text/css">
body, button, input, select, textarea {
    font: 12px/16px Verdana, Helvetica, Arial, sans-serif;
}
p{
    width:100%;
    padding-top:3px;
    margin-top:10px;
    overflow:hidden;
}
input#address{
	width:300px;
}
#container {
   width:100%;
   height: 300px;
   margin-top: 20px;
    margin-bottom: 20px;
    
}
</style>
<!-- **************地图接口*********** -->
<script charset="utf-8" src="https://map.qq.com/api/js?v=2.exp&key=2ZXBZ-CTX3J-EPVFZ-KRXCX-2PVVZ-N4BPQ"></script>
<script>

function init() {
	
	 var goodsHtml;
	    $.ajax({
			type : 'get',
			async : false,
			url : "/wx/goods/getGoods?goodsId="+goodsId,
			// 如果参数为json，加上这句
			contentType : "text/json",
			// 规定反参类型为text
			dataType : "json",
			success : function(msg) {
				console.log(msg);
				if(msg.code==0){
					console.log(msg.goods);
					if(msg.goods.id==null||typeof(msg.goods)=="undefined")
						return true;
					$.each(msg.goods.images,function(index,obj){
						console.log(obj.image);
						
						if(index==0){
							html="<div class='item active'><img style='width: 100%;height:350px' src='${pageContext.request.contextPath}"+obj.image+"'/></div>";
						}else{
							html="<div class='item'><img style='width: 100%;height:350px' src='${pageContext.request.contextPath}"+obj.image+"'/></div>";
						}
						$('.carousel-inner').append(html);
					});
					$('.titleName').html(msg.goods.titleName);
					var soldNum =msg.goods.soldNum;
					var resNum =msg.goods.resNum;
					var browNum =msg.goods.browNum;
					if(soldNum==null)
						soldNum=0;
					if(resNum==null||resNum==0)
						resNum="无限制";
					if(browNum==null)
						browNum=0;
					$('.browNum').html(browNum);
			    	$('.res').html("<span class='sold'><span class='soldSpan'>已售:"+soldNum+"&nbsp;&nbsp;&nbsp;总数:"+resNum+
					"&nbsp;</span><span class='oldPrice'></span><span class='price'></span></span>");
			    	if(msg.goods.oldPrice!=null)
						$('.oldPrice').html("￥"+msg.goods.oldPrice);
			    	if(msg.goods.price!=null)
						$('.price').html("￥"+msg.goods.price);
			    	else
			    		$('.price').html("");
					
			    	
			    	
					$('.time').html("活动时间:"+msg.goods.preTime+"--"+msg.goods.sufTime);
					if(msg.goods.seller!=null||typeof(msg.goods.seller)=="undefined"){
	                    $('.sellerName').html("商家名字:"+msg.goods.seller.name);
						$('.sellerOnTime').html("营业时间:"+msg.goods.seller.onTime);
						$('.sellerPhoneNum').html("商家电话:"+msg.goods.seller.phoneNum+"<a href='tel:"+msg.goods.seller.phoneNum+"'>"+
								"<img class='phone' src='${pageContext.request.contextPath}/icons/phone2.png'></a>");
						$('.sellerAddr').html("地址:"+msg.goods.seller.addressStr);
						$('.sellerAddress').val(msg.goods.seller.address);
						console.log(msg.goods.seller);
	                  }
					console.log(msg.goods.seller);
					
					
					
					if(msg.goods.isValid==false){
						$('.buy').html('');
						$('#buy').attr("href","#")
						$('.buy').append("活动已结束");
						$(".buy").parent().css("background","gray");
					}else{
						if(msg.goods.payType==1){
							$('.buy').html('');
							$('#buy').attr("href","/wx/order/add?goodsId="+msg.goods.id+"&sellerId="+msg.goods.seller.id);
							$('.buy').append("立即下单");
							$(".buy").parent().css("background","yellow");
						}
							
						if(msg.goods.payType==2){
							$('.buy').html('');
							$('#buy').attr("href","javascript:alert('敬请期待');")
							$('.buy').append("立即支付");
							$(".buy").parent().css("background","yellow");
						}
					}
					//检查剩余优惠数量还有多少
			    	if(soldNum>=resNum){
			    		$('.buy').html('');
						$('#buy').attr("href","#")
						$('.buy').append("活动已结束");
						$(".buy").parent().css("background","gray");
			    	}
					
					$('.message').html("<div class='messageLeft'><span id='item' onclick='getItem("+msg.goods.id+")'>商品详情</span></div>"+
							"<div class='messageRight'><span id='evaluate' onclick='getEvaluate("+msg.goods.id+",1)'>商品评价("+msg.evaluateCount+")</span></div>");
					console.log(msg.goods.itemSrc);
					$("#page").load(msg.goods.itemSrc);
					
					
				}
			},
			error : function(msg) {
				alert("查询异常");
			}
		});
	    
	
	
	var add = $("#address").val();
	if(add!=""){
		strs=add.split(","); 
		var center = new qq.maps.LatLng(strs[0],strs[1]);
	}
	else{
		var center = new qq.maps.LatLng(29.76416, 104.85212);
	}
		
    map = new qq.maps.Map(document.getElementById('container'),{
        center: center,
        zoom: 15
    });
    
    commonMarker = new qq.maps.Marker({
        position: center,
        map: map
 	});
    
    //检查是否已经下过单
    $.ajax({
		type : 'get',
		async : false,
		url : "/wx/order/getState?goodsId="+goodsId,
		// 如果参数为json，加上这句
		contentType : "text/json",
		// 规定反参类型为text
		dataType : "json",
		success : function(msg) {
			if(msg.code==0){
				console.log(msg);
				if(msg.result.orderState==false){
					$('.buy').html('');
					$('#buy').attr("href","#")
					$('.buy').append("已下单");
					$(".buy").parent().css("background","red");
				}
			}
		},
		error : function(msg) {
			alert("未知错误");
		}
	});
    
    
    
    
    $.ajax({
		type : 'get',
		async : false,
		url : "/wx/coll/getState?goodsId="+goodsId,
		// 如果参数为json，加上这句
		contentType : "text/json",
		// 规定反参类型为text
		dataType : "json",
		success : function(msg) {
			if(msg.code==0){
				console.log(msg.message);
				if(msg.result.state){
					$('.myColl').addClass("glyphicon-heart");
				}else{
					$('.myColl').addClass("glyphicon-heart-empty");
				}
				commonState=msg.result.state;
			}else{
				console.log(msg.message);
			}
			
		},
		error : function(msg) {
			
			console.log("收藏刷新异常");
		}
	});
   
}

var goodsId =<%= request.getParameter("goodsId")%>;
var commonState;


function coll(obj){
	if(!commonState){
		$(obj).removeClass("glyphicon-heart-empty");
		$(obj).addClass("glyphicon-heart");
		$.ajax({
			type : 'get',
			async : false,
			url : "/wx/coll/add?goodsId="+goodsId,
			// 如果参数为json，加上这句
			contentType : "text/json",
			// 规定反参类型为text
			dataType : "json",
			success : function(msg) {
				if (msg.code==0) {
					commonState = true;
					alert(msg.message);
				}else{
					alert(msg.message);
				}
			},
			error : function(msg) {
				alert(msg.message);
			}
		});
	}else{
		//取消收藏
		$(obj).removeClass("glyphicon-heart");
		$(obj).addClass("glyphicon-heart-empty");
		$.ajax({
			type : 'get',
			async : false,
			url : "/wx/coll/remove?goodsId="+goodsId,
			// 如果参数为json，加上这句
			contentType : "text/json",
			// 规定反参类型为text
			dataType : "json",
			success : function(msg) {
				if (msg.code==0) {
					commonState = false;
					alert(msg.message);
				}
			},
			error : function(msg) {
				alert(msg.message);
			}
		});
	}
	
}
var commonHtml;
var commonPage=1;
var countPage = 1;

var isGetItem =false;
var isGetEva =true;
var isGetWin = false;
function getItem(goodsId){
	if(isGetItem){
		$('.cue').html("");
		$("#page").html("");
		$(".messageRight").css("color","black");
		$(".messageLeft").css("color","gray");
		$("#page").html(commonHtml);
		isGetWin=false;
		commonPage=1;
		isGetItem=false;
		isGetEva=true;
	}
}
function getEvaluate(id,page){
	
	if(isGetEva){
		
		goodsId= id;
		if(page==1){
			commonHtml = $("#page").html();
			$("#page").html("");
			$(".messageLeft").css("color","black");
			$(".messageRight").css("color","gray");
		}
		isGetItem=true;
		isGetEva=false;
		isGetWin=true;
		$.ajax({
			type : 'get',
			async : false,
			url : "/wx/evaluate/get?goodsId="+id+"&page="+page,
			// 如果参数为json，加上这句
			contentType : "text/json",
			// 规定反参类型为text
			dataType : "json",
			success : function(msg) {
				if (msg) {
					console.log(msg);
					countPage = msg.total;
					$.each(msg.rows,function(index,obj){
						if(obj.user==null)
							return false;
						var name = obj.user.name;
						if(name.trim()=="")
							name="匿名用户";
						//拼接评论页面
						var html ="<div class='evaContent' style='width: 100%'>"+
						"<div class='evaName'><span>"+name+"</span></div>"+
						"<div class='evaMsg'><span>"+obj.message+"</span></div>"+
						"<div class='evaTime'><span>"+obj.eTime+"&nbsp;&nbsp;</span></div>"+
						"<div class='panel panel-warning' style='height: 1px; width: 100%;'></div>"+
						"</div>";
						$('#page').append(html);
					})
				}
			},
			error : function(msg) {
				alert("没有评论");
			}
		});
		
	}
}

$(window).scroll(function(){
	
	　　//判断是否滑动到页面底部
	     if($(window).scrollTop() === $(document).height() - $(window).height()){
	    	if(isGetWin){
	           // TODO 滑动到底部时可请求下一页的数据并加载，加载可使用append方法
	           if(commonPage<countPage){
	        	   
		           //加载下一一个数据
		           commonPage++;
		           isGetEva = true;
		           getEvaluate(goodsId,commonPage);
		           
		           if(commonPage==countPage){
		        	   $('.cue').html("");
		        	   var html="<div>已经到底了>_<</div>";
					   $('.cue').append(html);
		           }
		           
	           }
	    	}
	     }
	});
	

function formatTime(val) {
    if (val != null) {
            var date = new Date(val);
            console.log(date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate());
            //$(obj).val(date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate());
        }
}

</script>


</head>
<body onload="init()">
<div class="goodsContent">
</div>

<!-- 轮播图  320*240-->
    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel" data-interval="3000">
      <!-- Wrapper for slides -->
      <div class="carousel-inner" style="text-align:center">
      
      	 	
      </div>     
 </div>
     
     
      <!--       标题 -->
        <div class="panel-heading goodsTitle">
	         	<span class="titleName">
	   				
	   			</span>
	   			<div class="titleRight">
	   				<div class="brow">
			   			<span class="glyphicon glyphicon-eye-open" style="font-size: 15px">
			   				 
			   			</span><br/>
			   			<span class="browNum"></span>
						
		   			</div>
		   			<div class="coll" style="font-size: 15px">
		   					<div class="collImg">
			   					<span class="myColl glyphicon" onclick="coll(this)"></span>
			   				</div>
			   				<span>
			   					收藏 
							</span>
					</div>
	   			</div>
		 </div>
		 <br/><br/>
      	
      	
      	<div class="panel panel-heading res" >
     
		</div>
		

		  <div class="time panel panel-heading">
   			
		  </div>
<!--      过渡 -->
      	<div class="panel panel-warning" style="height: 1px; width: 100%;"></div>
         
         
		<!-- 商品信息展示 -->
						<!-- 过度条 -->
	 <div class="panel panel-heading" style=" width: 100%; font-size: 20px;">
				 <div class="panel panel-heading back">
					   	<span class="sellerTitle">商家信息</span>
				</div>
				<div class="sellerName" >
	   		
			      </div><br/>
				<div class="sellerOnTime" >
	   			
			      </div><br/>
			      <div class="sellerPhoneNum" >
	   			
			      </div><br/>
			      <div class="sellerAddr">
	   		
			      </div><br/>
			      
	<!-- 		     地图位置 -->
	<div id="container" >
	<input type="hidden" name="address" id="address" class="sellerAddress">
	</div>



			</div>		<!-- 过度条 -->
		 <div class="panel panel-default" style="height: 1px; width: 100%;"></div>
		 
		<div class="message" style="color: blank; height: 40px; text-align: center;">
			
		 </div>  
		 
		 
		 
		 <div class="content">
 
			<div id="page">
			 </div>	
			 
		 </div>
		 

			    
			    
<div class="cue" style="text-align: center; color: gray;height: 50px;"></div>
		 
		 <div class="footer" style="height: 50px;">
		 
		 </div>
		 <!-- 底部菜单 -->
		<div class="service">
			<a href="javascript:alert('敬请期待！');">
				<img  src='${pageContext.request.contextPath}/icons/service.png' />
			</a>
		</div>
			  
		
<div>
	<div data-role="widget" data-widget="nav4" class="nav4">
		<nav>
		<div id="nav4_ul" class="nav4">
			<ul class="box" style="margin-bottom: 0px;text-align: center;">
				<li >
				<a href="/wx/wx/index" id="home">
					 <span class="commonMenu"> 
					 <span class="glyphicon glyphicon-home"></span>
					 首页</span>
				</a></li>
				
				<li><a href="/wx/order/index" id="order">
					 <span class="commonMenu">
					 <span class="glyphicon glyphicon-list-alt"></span>
					 订单</span>
				</a></li>
				<li><a id="buy" >
					 <span class="buy" >
					 	<span class="glyphicon glyphicon-hand-right"></span> 
					 活动结束</span>
				</a></li>
			</ul>
		</div>
		</nav>
		
	</div>
</div>

</body>
</html>