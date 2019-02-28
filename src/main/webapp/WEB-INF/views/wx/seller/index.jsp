<%@page
	import="javax.security.auth.message.callback.PrivateKeyCallback.Request"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="pixel-ratio-1" style="font-size: 18px !important;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>资中优生活</title>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/show.css">
<c:import url="../../common/import3.jsp"></c:import>
<script type="text/javascript">


var isSeller =true,isGoods=true;
var seller =null;
function getSeller(){
	if(isSeller){
		isSeller =false;
		isGoods=true;
		$(".messageRight").css("color","black");
		$(".messageLeft").css("color","gray");
		$('.content').html('');
		commonLength=0;

		$(function(){
			$.ajax({
				type : 'get',
				async : false,
				url : "/wx/seller/get",
				// 如果参数为json，加上这句
				contentType : "text/json",
				// 规定反参类型为text
				dataType : "json",
				success : function(msg) {
					console.log(msg);
					var sellerHtml="";
					if(msg!=null){
						seller=msg;
						var cue;
						if(!msg.isValid)
							cue="审核中";
						else
							cue="营业中";
						
						$('.content').html("<div class='myatten-list sellerContent' id='attenList'></div>"+
								"<a href='#' class='item' align='center'>"+
								
								"<div style='padding-left: 30%;padding-right: 30% ;margin-bottom: 10px'>"+
								"<input id='myBtn' class='preName btn btn-danger' type='button' onclick='update()' value='修改商家信息' />"+
								"</div>"+
								
								
									/* "<div class='rt_btm' >"+
										"<div class='btn' style='color: red;' onclick='update()'>修改商家信息</div>"+
									"</div>"+ */
								"</a>");
						sellerHtml="<div class='top_img swiper-container swiper-container-horizontal'>"+
						"<div class='swiper-wrapper'>"+
						"<div class='swiper-slide swiper-slide-active' style='width: 90%;padding-left:5%'>"+
							"<img src='${pageContext.request.contextPath}"+msg.introduceImage+"' class='img'>"+
						"</div>"+
					"</div>"+
					"<div class='top_tit'>"+
						"<h3>"+msg.name+"</h3>"+
					"</div>"+
				"</div>"+
				"<div class='shop-info wp'>"+
					"<div class='item l-flex'>"+
						"<div class='txt'>"+
						"	<i class='iconfont'></i> <span>营业时间："+msg.onTime+"</span>"+
						"</div>"+
					"</div>"+
					"<div class='item l-flex'>"+
						"<div class='txt'>"+
						"	<i class='iconfont'></i> <span>"+msg.phoneNum+"</span>"+
						"</div>"+
						"<a"+
						"	href='tel:"+msg.phoneNum+"'"+
						"	class='btn' style='margin-right:10%'>拨打</a>"+
					"</div>"+
					"<div class='item l-flex'>"+
					"	<div class='txt'>"+
					"		<i class='iconfont'></i> <span>"+msg.addressStr+"</span>"+
					"	</div>"+
					"</div>"+
					"<div class='item l-flex'>"+
					"	<div class='txt'>"+
					"		<i class='iconfont'></i> <span>"+cue+"</span>"+
					"	</div>"+
					"</div>"+
				"</div>";

						
						
						
	                        
						/* sellerHtml="<div class='commonContent'><img class='commonImg' src='${pageContext.request.contextPath}"+msg.introduceImage+"'></div>"+
						"<div class='commonContent'>"+msg.name+"</div>"+
						"<div class='commonContent'>联系人："+msg.phoneName+"</div>"+
						"<div class='commonContent'>联系电话："+msg.phoneNum+"</div>"+
						"<div class='commonContent'>地址："+msg.addressStr+"</div>"+
						"<div class='commonContent'>"+
						"<button class='btn btn-info' onclick='update()'>修改商家信息</button>"; */
						/* "&nbsp;&nbsp;<button class='btn btn-danger'onclick='remove()' >删除</button></div>" ;*/
						$('.sellerContent').append(sellerHtml);
					}else{
						$('.content').html("<div class='myatten-list sellerContent' id='attenList'></div>");
						sellerHtml="<div class='sellerText'>您还不是商家，若要成为商家，请<a href='/wx/seller/add'>添加</a></div>";
						$('.sellerContent').append(sellerHtml);
					}
				},
				error : function(msg) {
					console.log(msg);
					$('.content').html("<div class='myatten-list sellerContent' id='attenList'></div>");
					sellerHtml="<div class='sellerText'>您还不是商家，若要成为商家，请<a href='/wx/seller/add'>添加</a></div>";
					$('.sellerContent').append(sellerHtml);
				}
			});
		})
	}
}
function intoGoods(id){
	window.location.href='/wx/goods/goods?goodsId='+id;
}
function addGoods(){
	console.log(seller);
	
	if(seller==null){
		alert("您还不是商家，不能添加促销活动!");
		return false;
	}else{
		if(!seller.isValid){
			alert("请审核通过再操作!");
			return false;
		}
		window.location.href='/wx/goods/add';
	} 
}
function updateGoods(id){
	window.location.href='/wx/goods/add?goodsId='+id;
}
function removeGoods(id){
	$.ajax({
		type : 'get',
		async : false,
		url : "/wx/goods/remove?goodsId="+id,
		// 如果参数为json，加上这句
		contentType : "text/json",
		// 规定反参类型为text
		dataType : "json",
		success : function(msg) {
			console.log(msg);
			if(msg){
				alert("删除成功");
				window.location.reload();
			}else{
				alert("删除失败");
			}
			
			window.location.reload();
		},
		error : function(msg) {
			alert("删除失败");
			window.location.reload();
		}
	});
}
var commonPage=1,countPage=1;
var titleHtml="<div><button class='btn btn-danger' onclick='addGoods()'>添加促销活动</button></div><br/>";
var commonLength=0;
function getGoods(page){
	if(isGoods){
		
		if(page==1){
			isSeller =true;
			isGoods=false;
			$(".messageRight").css("color","gray");
			$(".messageLeft").css("color","black");
			$('.content').html('');
			commonPage=1;
		}
			$(function(){
				$.ajax({
					type : 'get',
					async : false,
					url : "/wx/goods/get?page="+page,
					// 如果参数为json，加上这句
					contentType : "text/json",
					// 规定反参类型为text
					dataType : "json",
					success : function(msg) {
						countPage = msg.total;
						var goodsHtml="";
						console.log(msg);
						$('.content').html("<div class='myatten-list goodsContent' id='attenList'></div>");
						if(msg!=null){
							commonLength+=msg.rows.length;
							$('.content').html("<div class='myatten-list goodsContent' id='attenList'></div>");
							$.each(msg.rows,function(index,obj){
								if(obj==null){
									return true;
								}
								
								
								var oldPrice=obj.price;
								if(oldPrice==null||typeof(oldPrice)=='undefined')
									oldPrice="";
								else
									oldPrice="￥"+oldPrice;
								
								goodsHtml+="<a href='/wx/goods/goods?goodsId="+obj.id+"' class='item'>"+
			                    "<div class='lt'><div class='lt_pic'>"+
			                    "<img src='${pageContext.request.contextPath}"+obj.titleImage+"'></div> </div>"+
			                 "<div class='rt'><div class='rt_tit'>"+obj.titleName+"</div>"+
			                     "<div class='rt_btm'> <div class='price'>"+
			                     "<span class='price_now'>¥<em>"+obj.price+"</em></span><span class='price_old'>"+oldPrice+"</span>"+
			                    // "<span class='price_now'>"+obj.preTime+"</span><span class='price_old'>"+obj.sufTime+"</span>"+
			                        "</div><div class='btn' onclick='goGoods("+ obj.id+ ")'>进入活动</div></div></div></a>";
			                        
							/* 	goodsHtml="<div><span class='titleImage'><img src='${pageContext.request.contextPath}"+obj.titleImage+"'>"+
								"</span><br/><span>"+obj.titleName+"</span>"+
								"<br/><span>"+obj.preTime+"--"+obj.sufTime+"</span>"+
								"<br/><span>￥"+obj.price+"</span><br/>"+
								//"<div>"+
								"<button class='btn btn-info' onclick='intoGoods("+obj.id+")''>进入活动</button>"+
								//"&nbsp;&nbsp;<button class='btn btn-danger' onclick='updateGoods("+obj.id+")''>修改</button>"+
							// 	"&nbsp;&nbsp;<button class='btn btn-danger' onclick='removeGoods("+obj.id+")'' >删除</button>"+
								"</div><div class='panel panel-warning' style='height: 5px; width: 100%;'></div>"; */
								if(index<=0){
									goodsHtml = titleHtml+goodsHtml;
								}
								$('.goodsContent').html(goodsHtml);
								
								
								/* if(index ==msg.rows.length-1){
									
									var itemHeight=parseInt($('.ss').css("height"));
									console.log(itemHeight);
									height = itemHeight*(commonLength+1);
									
									$('.sellerContent').css("height",height+"px");
								} */
							})
						}else{
							$('.content').html("<div class='myatten-list goodsContent' id='attenList'></div>");
							goodsHtml="<div class='sellerText'>您还没有促销活动，请<a href='/wx/goods/add'>添加</a>";
							$('.goodsContent').html(goodsHtml);
							
						}
					},
					error : function(msg) {
						//console.debug(msg==null);
						$('.content').html("<div class='myatten-list goodsContent' id='attenList'></div>");
						goodsHtml="<div class='sellerText'>您还没有促销活动，请<a onclick='addGoods()'>添加</a>";
						$('.goodsContent').html(goodsHtml);
					}
				});
			})
	}
}

getSeller();
$(window).scroll(function(){
	　//判断是否滑动到页面底部
	     if($(window).scrollTop() === $(document).height() - $(window).height()){
	    	
	           // TODO 滑动到底部时可请求下一页的数据并加载，加载可使用append方法
	           if(commonPage<countPage){
	        	   
		           //加载下一一个数据
		           commonPage++;
		           isGoods = true;
		           getGoods(commonPage);
		           
		           if(commonPage==countPage){
		        	   $('.cue').html("");
		        	   var html="<div>已经到底了>_<</div>";
						$('.cue').append(html);
		           }
		           
	           }
	     }
	});
	
	function update(){
		window.location.href='/wx/seller/add';
	}


	function remove(){
		$.ajax({
			type : 'get',
			async : false,
			url : "/wx/seller/remove",
			success : function(msg) {
				window.location.reload();
			},
			error : function(msg) {
				window.location.reload();	
			}
		});
	}
	
		
/* 	window.onload = function (){
		changeType(typeId,commonPage);
	} */
</script>
</head>
<body>
	<div style="color: blank; height: 40px; text-align: center;margin-top:10px;">
		<div class="messageLeft">
			<span onclick="getSeller()" style="font-size: 20px;font-style: italic;">我的商铺</span>
		</div>
		<div class="messageRight">
			<span style="font-size: 20px;font-style: italic;" onclick="getGoods(1)">促销活动</span>
		</div>
	</div>

	<br />
	<br />

	<div class="myatten-content">
		<!-- <div class="content" ></div> -->
		<div class="content">
			<!-- <div class="myatten-list sellerContent" id="attenList"></div>
				<a href="#" class="item" align="center">
					<div class="rt_btm" >
						<div class="btn" style="color: red;" onclick="update()">修改商家信息</div>
					</div>
				</a> -->
		</div>
	</div>



	


	<!-- 	
	<div class="modal fade" id="myModal"   tabindex="-1" role="dialog"  aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" >
			<div class="modal-content" >
				<div class="modal-body" style=" text-align: center;">
						
				</div>
	
			</div>/.modal-content
		</div>/.modal-dialog
	</div> -->


	<%-- <!-- 	商家图片 -->
	<div class="commonContent">
		<img src="${pageContext.request.contextPath}/upload/imgs/seller/seller1.jpg">
	</div>
<!-- 商家名 -->
	<div class="commonContent">
		小旋风火锅店
	</div>

<!-- 	商家所有人 -->
	<div class="commonContent">
		联系人：主席
	</div>
	<!-- 	商家联系电话 -->
	<div class="commonContent">
		联系电话：15351396123
	</div>
	<!-- 	商家联系地址 -->
	<div class="commonContent">
		地址：凤凰城19栋2单元1404
	</div>
	<div class="commonContent">
		<button class="btn btn-info">修改</button>
		<button class="btn btn-danger" >促销活动</button>
	</div>
 --%>

	<!-- <script type="text/javascript">
function centerModals() {   
    $('#myModal').each(function(i) {   
        var $clone = $(this).clone().css('display', 'block').appendTo('body'); var top = Math.round(($clone.height() - $clone.find('.modal-content').height()) / 2);   
        top = top > 0 ? top : 0;   
        $clone.remove();   
        $(this).find('.modal-content').css("margin-top", top);   
    });   
}   
$('#myModal').on('show.bs.modal', centerModals);   
$(window).on('resize', centerModals);  
</script> -->
	<div class="footer" style="height: 40px;" />
	<c:import url="../../common/footer.jsp"></c:import>

</body>
</html>