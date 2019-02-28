<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>资中优生活</title>
<c:import url="../../common/import3.jsp"></c:import>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/show.css">
<script language="javascript">
/* $(function(){
	pushHistory();
	window.addEventListener("popstate", function(e) {
	
	}, false);
	function pushHistory() {
	var state = {
	title: "title",
	url: "/wx/user/index"
	};
	window.history.pushState(state, "title", "#");
	}
});
 */

function goGoods(id){
	window.location.href="/wx/goods/goods?goodsId="+id;
}
function cancelOrder(id,goodsId){
	$.ajax({
		type: 'POST',
		async:false,
		url:"/wx/order/cancel?orderId="+id+"&goodsId="+goodsId,
		// 如果参数为json，加上这句
		contentType:"text/json",
		// 规定反参类型为text
		dataType:"json",
		success: function(msg){
			if(msg){
				alert("取消成功");
				window.location.reload();
			}else{
				alert("取消失败,请稍后再试");
			}
				
		},error:function(msg){
			alert("数据异常");
		}
	});
}

function ok(id){
	$.ajax({
		type: 'POST',
		async:false,
		url:"/wx/order/update?orderId="+id,
		// 如果参数为json，加上这句
		contentType:"text/json",
		// 规定反参类型为text
		dataType:"json",
		success: function(msg){
			if(msg){
				alert("已确认");
				window.location.reload();
			}else{
				alert("确认失败,请稍后再试");
			}
				
		},error:function(msg){
			alert("数据异常,请稍后再试");
		}
	});

}
function pageToEva(orderId,goodsId){
	window.location.href="/wx/evaluate/add?orderId="+orderId+"&goodsId="+goodsId;
}
var commonPage=1,countPage=1,commonKeyWords="";
var isSeller =true;
var isUser =true;
function getUserOrder(page,keyWords){
	
	if(isUser){
		if(page==1){
			commonPage=1;
			$(".messageRight").css("color","black");
			$(".messageLeft").css("color","gray");
			$('.orderShow').html('');
		}
		isSeller =true;
		isUser =false;
		$.ajax({
			type: 'POST',
			async:false,
			url:"/wx/order/get?page="+page,
			// 如果参数为json，加上这句
			contentType:"text/json",
			// 规定反参类型为text
			dataType:"json",
			success: function(msg){
				if(msg){
					if(msg.rows.length==0){
						$('.cue').html('');
						var cueHtml="<div class='sellerText'>您还没有订单，快去下单吧！</div>";
						$('.cue').append(cueHtml);
						return false;
					}
					
					countPage = msg.total;
					$.each(msg.rows,function(index,obj){
						if(obj.goods==null){
							return true;
						}
							
						console.log(obj.id);
						
						  
						
						
						
						/* html ="<div id='"+obj.id+"' class='MyOrder'>"+
						"<div class='panel-heading'>"+
						"<img class='titleImage'  onclick='goGoods("+ obj.goods.id+ ")' src='${pageContext.request.contextPath}/"+obj.goods.titleImage+"'/>"+
						"<span class='commonContent'>"+obj.goods.titleName+"</span><br/>"+
						"<span class='commonContent'>价格:￥"+obj.price+"</span><br/>"+
						"<span class='commonContent'>商家:"+obj.seller.name+"</span><br/>"+
						"<span class='commonContent'>联系电话:"+obj.seller.phoneNum+"</span><br/>"+
						"<span class='commonContent'>下单时间:"+obj.oTime+"</span><br/>"; */
						html="<li><a href='/wx/goods/goods?goodsId="+obj.goods.id+"' class='order_info'>"+
	                    "<div class='row_t border-thin_b'>"+
                        "<span class='num'><i class='iconfont'></i>商家:"+obj.seller.name+"</span>"+
                        "<span class='date'>"+obj.oTime+"</span>"+
				           "</div>"+
				           "<div class='row_m'>"+
				              	"<div class='pic'><img src='"+obj.goods.titleImage+"'>"+
								"</div>"+
								"<div class='intro'><h3 class='tit'>"+obj.goods.titleName+"</h3></div>"+
								"</div>"+
								"<div class='row_b border-thin_b'>"+
								"<div></div>"+
								"<span class='total'>价格:￥"+obj.price+
								"</span>"+
							"</div>"+
						"</a>";
						/*订单类型:
						 * 1==一般订单（个人订单）
						 * 2==拼团订单
						 * 
						 */
							/*订单状态
							 * 0==全部完成
							 * 1==进行中
							 * 2==完成未评论
							 * 3==被取消的（涉及金额自动退款）<---->显示退款中
							 * 4==拼团任务（未完成/提示申请退款）
							 * 5==下单未支付
							 * 6==订单被取消，退款完成
							 * 7==订单支付超时
							 * --*/
						/*状态为1为进行中订单有（取消和确认操作）、状态为2为完成订单增加评论，被取消的订单状态为3,全部完成改状态为0*/
						/* console.log(obj.isValid); */
						if(obj.isValid==1){
							
							html+="<div class='order_func'>"+
							"<span class='indate'>*有效期至："+obj.goods.sufTime+"</span>"+
							"<div class='btn_box'><a onclick='cancelOrder("+obj.id+","+ obj.goods.id+ ") class='btn btn-used'>取消订单</a>"+
							"<a onclick='ok("+ obj.id+ ")' class='btn btn-used'>确认完成</a></div>"+
						"</div>"+
					"</li>";
							/* html+="<div class='btnCon'><input type='button' value='取消订单'  id='orderBtn' class='btn btn-danger' onclick='cancelOrder("+obj.id+","+ obj.goods.id+ ")'/>"+
							"&nbsp;&nbsp;<input type='button' value='确认完成' id='okBtn' class='btn btn-success' onclick='ok("+ obj.id+ ")'/>"+
							"</div></div></div><div class='panel panel-warning' style='height: 2px; width: 100%;'></div></div>"; */
						}else if(obj.isValid==2){
							html+="<div class='order_func'>"+
							"<span class='indate'>*有效期至："+obj.goods.sufTime+"</span>"+
							"<div class='btn_box'>订单已完成,快去添加您的<a onclick='pageToEva("+obj.id+","+ obj.goods.id+ ")' class='btn btn-used'>评论</a>吧！"+
							"</div>"+
						"</div>"+
					"</li>";
							
							/* html+="<span>订单已完成,快去添加您的"+
							"<input type='button' value='评论' id='okBtn' class='btn btn-success' onclick='pageToEva("+obj.id+","+ obj.goods.id+ ")'/>吧！</span></div></div>"+
							"<div class='panel panel-warning' style='height: 2px; width: 100%;'></div>"; */
						}else if(obj.isValid==3){
							if(obj.Price<=0){
								html+="<div class='order_func'>"+
								"<span class='indate'>*有效期至："+obj.goods.sufTime+"</span>"+
								"<span class='indate'>订单已取消</span>"+
							"</div>"+
						"</li>";
							}else{
								html+="<div class='order_func'>"+
								"<span class='indate'>*有效期至："+obj.goods.sufTime+"</span>"+
								"<span class='indate'>订单已取消，退款中...</span>"+
							"</div>"+
						"</li>";
							}
							
							
							/* html+="<div style='text-align:center;background-color:gray'>订单已取消</div></div></div>"+
							"<div class='panel panel-warning' style='height: 2px; width: 100%;'></div>"; */
						}else if(obj.isValid==5){
							// 5==下单未支付
							html+="<div class='order_func'>"+
							"<span class='indate'>*有效期至："+obj.goods.sufTime+"</span>"+
							"<div class='btn_box'><a onclick='javascript:alert('支付接口')' class='btn btn-used'>立即支付</a>"+
							"</div>"+
						"</div>"+
					"</li>";
							
							
						}else if(obj.isValid==4){
							//4==拼团任务（未完成/提示申请退款）
								html+="<div class='order_func'>"+
							"<span class='indate'>*有效期至："+obj.goods.sufTime+"</span>"+
							"<div class='btn_box'><a onclick='javascript:alert('退款接口')' class='btn btn-used'>申请退款</a>"+
							"</div>"+
						"</div>"+
					"</li>";
						}else if(obj.isValid==6){
							//6==被取消的带有金额的订单，退款完成
							html+="<div class='order_func'>"+
							"<span class='indate'>*有效期至："+obj.goods.sufTime+"</span>"+
							"<span class='indate'>已取消，并完成退款</span>"+
						"</div>"+
					"</li>";
					}else if(obj.isValid==7){
						//7==订单支付超时
						html+="<div class='order_func'>"+
						"<span class='indate'>*有效期至："+obj.goods.sufTime+"</span>"+
						"<span class='indate'>订单支付超时,被取消</span>"+
					"</div>"+
				"</li>";
				}else{
							html+="<div class='order_func'>"+
							"<span class='indate'>*有效期至："+obj.goods.sufTime+"</span>"+
							"<span class='indate'>订单已完成</span>"+
						"</div>"+
					"</li>";
							/* html+="<div style='text-align:center;background-color:rgba(100, 255, 100, 0.29);'>订单已完成</div></div></div>"+
							"<div class='panel panel-warning' style='height: 2px; width: 100%;'></div>"; */
						}
						$('.orderShow').append(html);
						
					})
				}
			},error:function(msg){
				commonPage=1;
				var html="<div style='text-align: center; color: gray;'>查询类容为空>_<</div>";
				$('.orderShow').append(html);
				
			}
		});
		
	}
}

function getByKeyWords(){
	commonKeyWords = $("#keyWords").val();
	isSeller=true;
	getSellerOrder(1,commonKeyWords);
}

var titleHtml="<br/><div class='col-lg-6'><div class='input-group'><input type='text' id='keyWords' placeholder='用户姓名、电话关键字查询' class='form-control'>"+
"<span class='input-group-btn'>"+
"<button class='btn btn-default' onclick='getByKeyWords()' type='button' style='height:34px'>查询!</button></span></div></div><br/>";
/* 获取商户订单 */
function getSellerOrder(page,keyWords){
	if(isSeller){
		if(page==1){
			commonPage=1;
			$(".messageRight").css("color","gray");
			$(".messageLeft").css("color","black");
			$('.orderShow').html(titleHtml);
			
		}
		isSeller =false;
		isUser =true;
		$.ajax({
			type: 'POST',
			async:false,
			url:"/wx/order/seller?page="+page+"&keyWords="+keyWords,
			// 如果参数为json，加上这句
			contentType:"text/json",
			// 规定反参类型为text
			dataType:"json",
			success: function(msg){
				console.log(msg);
				if(msg){
					if(msg.rows.length==0){
						$('.cue').html('');
						var cueHtml="<div class='sellerText'>还没有用户下单哦！</div>";
						$('.cue').append(cueHtml);
						return false;
					}
					
					countPage = msg.total;
					$.each(msg.rows,function(index,obj){
						if(obj.goods==null){
							return true;
						}
						
						html="<li><a href='/wx/goods/goods?goodsId="+obj.goods.id+"' class='order_info'>"+
	                    "<div class='row_t border-thin_b'>"+
                        "<span class='num'><i class='iconfont'></i>下单用户联系:"+obj.phoneNum+"</span>"+
                        "<span class='date'>"+obj.oTime+"</span>"+
				           "</div>"+
				           "<div class='row_m'>"+
				              	"<div class='pic'><img src='"+obj.goods.titleImage+"'>"+
								"</div>"+
								"<div class='intro'><h3 class='tit'>"+obj.goods.titleName+"</h3></div>"+
								"</div>"+
								"<div class='row_b border-thin_b'>"+
								"<div></div>"+
								"<span class='total'>价格:￥"+obj.price+
								"</span>"+
							"</div>"+
						"</a>";
						
						
						
						/* html ="<div id='"+obj.id+"' class='MyOrder'>"+
						"<div class='panel-heading'>"+
						"<img class='titleImage'  onclick='goGoods("+ obj.goods.id+ ")' src='${pageContext.request.contextPath}/"+obj.goods.titleImage+"'/>"+
						"<span class='commonContent'>"+obj.goods.titleName+"</span><br/>"+
						"<span class='commonContent'>价格:￥"+obj.price+"</span><br/>"+
						"<span class='commonContent'>下单用户:"+obj.name+"</span><br/>"+
						"<span class='commonContent'>联系电话:"+obj.phoneNum+"</span><br/>"+
						"<span class='commonContent'>下单时间:"+obj.oTime+"</span><br/>"; */
						/*状态为1为进行中订单有（取消和确认操作）、状态为2为完成订单增加评论，被取消的订单状态为3,全部完成改状态为0*/
						console.log(obj.isValid);
						if(obj.isValid==1){
							html+="<div class='order_func'>"+
							"<span class='indate'>*有效期至："+obj.goods.sufTime+"</span>"+
							"<span class='indate'>订单进行中</span>"+
						"</div>"+
					"</li>";
						/* 	
							html+="<div style='text-align:center;background-color:green'>订单进行中！</div></div></div>"+
							"<div class='panel panel-warning' style='height: 2px; width: 100%;'></div>"; */
						}else if(obj.isValid==2){
							html+="<div class='order_func'>"+
							"<span class='indate'>*有效期至："+obj.goods.sufTime+"</span>"+
							"<span class='indate'>订单已完成,快让用户去评论吧!</span>"+
						"</div>"+
					"</li>";
							
							/* html+="<div style='text-align:center;background-color:green'>订单已完成,快让用户去评论吧!</div></div></div>"+
							"<div class='panel panel-warning' style='height: 2px; width: 100%;'></div>"; */
						}else if(obj.isValid==3){
							html+="<div class='order_func'>"+
							"<span class='indate'>*有效期至："+obj.goods.sufTime+"</span>"+
							"<span class='indate'>订单已被用户取消</span>"+
						"</div>"+
					"</li>";
					
						/* 	html+="<div style='text-align:center;background-color:gray'>订单已被用户取消</div></div></div>"+
							"<div class='panel panel-warning' style='height: 2px; width: 100%;'></div>"; */
						}else if (obj.isValid==4){
							html+="<div class='order_func'>"+
							"<span class='indate'>*有效期至："+obj.goods.sufTime+"</span>"+
							"<span class='indate'>用户为完成拼团活动，退款中。。。</span>"+
						"</div>"+
					"</li>";
						}else if(obj.isValid==5){
							html+="<div class='order_func'>"+
							"<span class='indate'>*有效期至："+obj.goods.sufTime+"</span>"+
							"<span class='indate'>用户已下单，未支付</span>"+
						"</div>"+
					"</li>";
					
						}else{
							html+="<div class='order_func'>"+
							"<span class='indate'>*有效期至："+obj.goods.sufTime+"</span>"+
							"<span class='indate'>订单已完成</span>"+
						"</div>"+
					"</li>";
							/* html+="<div style='text-align:center;background-color:green'>订单已完成</div></div></div>"+
							"<div class='panel panel-warning' style='height: 2px; width: 100%;'></div>"; */
						}
						$('.orderShow').append(html);
					})
				}else{
					
					var html="<div style='text-align: center; color: gray;'>查询类容为空>_<</div>";
					$('.orderShow').append(html);
				}
			},error:function(msg){
				
				commonPage=1;
				var html="<div style='text-align: center; color: gray;'>查询类容为空>_<</div>";
				$('.orderShow').append(html);
				
			}
		});
		
	}
}

$(window).scroll(function(){
	
　　//判断是否滑动到页面底部
     if($(window).scrollTop() === $(document).height() - $(window).height()){
    	
           // TODO 滑动到底部时可请求下一页的数据并加载，加载可使用append方法
           if(commonPage<countPage){
        	   
	           //加载下一一个数据
	           commonPage++;
	           isSeller =!isSeller;
	           isUser =!isUser;
	           if(isSeller)
	        	   getSellerOrder(commonPage,'');
	           else
	           		getUserOrder(commonPage);
	           
	           if(commonPage==countPage){
	        	   $('.cue').html("");
	        	   var html="<div style='text-align: center; color: gray;'>已经到底了>_<</div>";
					$('.cue').append(html);
	           }
	           
           }
     }
});

window.onload = function (){
	getUserOrder(commonPage,'');
}
</script>

</head>
<body>


<div class="message" style="color: blank; height: 40px; text-align: center;">
	<div class="messageLeft">
		<span id="item" onclick="getUserOrder(1,'')">我的订单</span>
	</div>
	<div class="messageRight">
		<span id="evaluate" onclick="getSellerOrder(1,'')">商户订单</span>
	</div>
</div>  


    	<div class="view-box overflow-h ios-scroll  pos-r" id="main">
    	  <div class="view-item top-0 left-0 pos-a per100  ht100p nofma mard" data-page="2">
    	    <ul class="userorder-list listul orderShow">
	    	  
            </ul>
            <div class="cue"></div>
    	  </div>
    	</div>



</body>
</html>