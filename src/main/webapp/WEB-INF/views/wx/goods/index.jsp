<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html class="pixel-ratio-1" style="font-size: 18px !important;">
<head>
<title>资中优生活</title>
<c:import url="../../common/import3.jsp"></c:import>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/wx/goods.css" />
	<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/wx/home.css" />
<meta name="urmtoken"
	content="5aa240ead45112e522ab49b5c36f80ff_5ce6fe34231caef3402542710ff7469d">
</head>


<style type="text/css">
body, button, input, select, textarea {
	font: 12px/16px Verdana, Helvetica, Arial, sans-serif;
}

p {
	width: 100%;
	padding-top: 3px;
	margin-top: 10px;
	overflow: hidden;
}

input#address {
	width: 300px;
}

#container {
margin-left:15%;
	width: 70%;
	height: 100px;
	margin-top: 20px;
	margin-bottom: 20px;
}
</style>
<!-- **************地图接口*********** -->
<script charset="utf-8"
	src="https://map.qq.com/api/js?v=2.exp&key=2ZXBZ-CTX3J-EPVFZ-KRXCX-2PVVZ-N4BPQ"></script>
	
<script type="text/javascript">


var fx_title;
var fx_imgUrl;
var fx_link;


</script>


<script>




var isBuyClick=true;
var goodsPrice;
//获取别人分享过来的参数
var goodsId = <%=request.getParameter("goodsId")%>;
var listId =<%=request.getParameter("listId")%>;
var userListId =<%=request.getParameter("userListId")%>;
var userId="${sessionScope.user.id}";
var currentUserId = "<%=request.getParameter("userId")%>";
//分享给别人 的参数
/*userListId、listId会存在为空的情况*/
 
 //alert("userId="+userId+"/currentUserId="+currentUserId)
if(userId==currentUserId){
		window.location.href="/wx/goods/goods?goodsId="+goodsId;
}
var payType;
var isSpell =false;
var spellPrice;
var isJoinSpell=false;

function cue(){
	alert("分享提示:点击右上角的<p >...</p>分享给朋友！");
}





var isHasOrder =false;
window.onload = function init() {
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
					isHasOrder=true;
					$('.buy').html('');
					$('.buy').attr("href","#")
					$('.buy').append("已下单");
					isBuyClick= false;
					$(".buy").css("background-color","gray");
				}
			}
		},
		error : function(msg) {
			alert("未知错误");
		}
	});
	
	
	
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
			    	$('.res').html("<div>&nbsp;&nbsp;已售:"+msg.goods.soldNum+"</div><div>总量:"+resNum+"</div>");
			    	if(msg.goods.oldPrice!=null)
						$('.oldPrice').html("￥"+msg.goods.oldPrice);
			    	if(msg.goods.price!=null)
						$('.price').html("￥"+msg.goods.price);
			    	else
			    		$('.price').html("");
					
			    	$('.buyTitleImage').html("<img src='${pageContext.request.contextPath}"+msg.goods.titleImage+"' >");
					$('.buyTitle').html(msg.goods.titleName);
					goodsPrice=msg.goods.price;
					$('.buyPrice').html("<i class='iconfont font10 font-b '>￥</i>"+
							"<span id='goodsPrice'>"+goodsPrice+"</span>");
					
					//分享页面初始化
					fx_title = msg.goods.titleName;
					fx_imgUrl = msg.goods.titleImage;
					
					
					
					
					
					if(msg.goods.seller!=null||typeof(msg.goods.seller)=="undefined"){
	                    $('.sellerName').html("商家名字:"+msg.goods.seller.name);
						$('.sellerOnTime').html("营业时间:"+msg.goods.seller.onTime);
						$('.sellerPhoneNum').html("<div class='font12 font-6'><div class='overflow-h '>商家电话:"+msg.goods.seller.phoneNum+"</div>"+
								"</div><a href='tel:"+msg.goods.seller.phoneNum+
								"' class='btn w-36 ht20 ml10 font10 l-ht20 tc font-white radius4'>拨打</a>");
						$('.sellerAddr').html("地址:"+msg.goods.seller.addressStr);
						$('.sellerAddress').val(msg.goods.seller.address);
						
	                  }
					$('.time').html("活动时间:"+msg.goods.preTime+"--"+msg.goods.sufTime);
					
					$('#goodsId').val(goodsId);
					$('#sellerId').val(msg.goods.seller.id);
					
					
					//更新商品的状态
					/*
					0:过期
					1:进行中
					2:将要进行
					*/
					//当前时间
					var currDate = new Date();
					//活动结束时间
					var endDate = new Date(msg.goods.sufTime.replace(/\-/g, "\/"));
					//活动开始时间
					var startDate = new Date(msg.goods.preTime.replace(/\-/g, "\/"));
									
					var myState;
					if(currDate<endDate&&startDate<currDate)
						myState=1;
					else if(startDate>currDate)
						myState=2;
					else 
						myState=0;
					if(msg.goods.state!=myState){
						//实时更新商品状态
						updateGoodsState(myState,goodsId);
					}
					//alert(myState);
					//alert(currDate+"//"+endDate);
					if(myState==0){
						$('.buy').html('');
						$('.buy').attr("href","#")
						$('.buy').append("已结束");
						$(".buy").css("background-color","gray");
						isBuyClick= false;
					}else if(myState==1){
						if(!isHasOrder){
							payType = msg.goods.payType;
							if(msg.goods.payType==1){
								$('.buy').html('');
								//$('.buy').attr("href","/wx/order/add?goodsId="+msg.goods.id+"&sellerId="+msg.goods.seller.id);
								$('.buy').append("立即下单");
								$('#add_order').text("下单到店付");
								$(".buy").css("background-color","red");
								isBuyClick= true;
							}
							if(msg.goods.payType==2){
								$('.buy').html('');
								//$('.buy').attr("href","javascript:alert('敬请期待');")
								$('.buy').append("立即支付");
								$('#add_order').text("立即支付");
								$(".buy").css("background-color","red");
								isBuyClick= true;
							}
						}
					}else{
						$('.buy').html('');
						$('.buy').attr("href","#")
						$('.buy').append("即将开始");
						$(".buy").css("background-color","#dede16");
						isBuyClick= false;
					}
					
					//检查剩余优惠数量还有多少
			    	if(soldNum>=resNum && msg.goods.resNum!=0&&resNum!="无限制"){
			    		$('.buy').html('');
						$('.buy').attr("href","#")
						$('.buy').append("已售罄");
						isBuyClick= false;
						$(".buy").css("background-color","gray");
			    	}
					
					$('.message').html("<div class='messageLeft'><span id='item' onclick='getItem("+msg.goods.id+")'>商品详情</span></div>"+
							"<div class='messageRight'><span id='evaluate' onclick='getEvaluate("+msg.goods.id+",1)'>商品评价("+msg.evaluateCount+")</span></div>");
					console.log(msg.goods.itemSrc);
					if(msg.goods.itemSrc=="#"||msg.goods.itemSrc.trim()=="")
						$("#page").html("");
					else
						$("#page").load("${pageContext.request.contextPath}"+msg.goods.itemSrc);
					
				}
			},
			error : function(msg) {
				alert("查询异常");
			}
		});
	    /*****************地图***************************/
	   
		var add = $("#address").val();
		if(add!="" && add!=null && typeof(add)!="undefined"){
			strs=add.split(","); 
			var center = new qq.maps.LatLng(strs[0],strs[1]);
			to_x=strs[0];
			to_y=strs[1];
			
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
	    
	    
	   
	
	    /*****************导航结束***************************/
 	
 	
    
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
					$(".coll").addClass("on");
				}else{
					$(".coll").removeClass("on");
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
    
    
    //拼团逻辑


var spellIsOpen = true;


	//查询是否有拼团活动，并展示信息
	$.ajax({
		type : 'post',
		async : false,
		url : "/wx/spell/getByGoods?goodsId="+goodsId,
		// 如果参数为json，加上这句
		contentType : "text/json",
		// 规定反参类型为text
		dataType : "json",
		success : function(msg) {
			if(msg){
				listId=msg.id;
				//检查是否加入拼团
				//初始化拼团活动-------判断是否结束
				//当前时间
				var currDate = new Date();
				//活动结束时间
				var endDate = new Date(msg.endTime.replace(/\-/g, "\/"));
				//活动开始时间
				var startDate = new Date(msg.startTime.replace(/\-/g, "\/"));
				var myState;
				if(currDate<endDate&&startDate<currDate)
					myState=1;
				else if(startDate>currDate)
					myState=2;
				else 
					myState=3;
				if(msg.state!=myState){
					//更新拼团状态
					updateState(myState,msg.id);
				}
				
				
				if(myState==3){
					spellIsOpen= false;
					$('.spellList').html("<div class='share-redbag __share'><div class='lt'>"+
							"<div class='lt_price'><span>拼团活动已结束</span></div>"+
							"<div class='lt_tip '></div></div>"+
							"<div class='rt'><div class=' spell'>期待下次活动</div></div></div>");
				}
				if(myState==2){
					spellIsOpen= false;
					$('.spellList').html("<div class='share-redbag __share'><div class='lt'>"+
							"<div class='lt_price'><span>拼团活动还未开始</span></div>"+
							"<div class='lt_tip '></div></div>"+
							"<div class='rt'><div class=' spell'>敬请期待！</div></div></div>");
				}
				if(!spellIsOpen)
					return true;
				checkSepellisOpen();
				if(isJoinSpell){
					isBuyClick=false;
					return true;
				}
				
				
				if(userListId==null){
					$('.spellList').html("<div class='share-redbag __share'><div class='lt'>"+
							"<div class='lt_price'><span>拼团活动（"+msg.num+"人团~￥"+msg.price+"/人）</span></div>"+
							"<div class='lt_tip '>"+msg.startTime+"~"+msg.endTime+"</div></div>"+
							"<div class='rt'><div class='rt_btn spell' onclick='javascript:openGoumai()'>我要开团</div></div></div>");
						spellPrice = msg.price;
				}else{
					getFriend();
				}
			}
			
			
		},
		error : function(msg) {
			console.log("获取失败");
		}
	});
	
	
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

	//通过config接口注入权限验证配置
	wx.config({
	    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	    appId: appId, // 必填，公众号的唯一标识
	    timestamp:timestamp , // 必填，生成签名的时间戳
	    nonceStr:nonceStr, // 必填，生成签名的随机串
	    signature:signature,// 必填，签名，见附录1
	    jsApiList: [
	    	'onMenuShareAppMessage',
	    	'getLocation'
	    ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	}); 

	
    /*******************微信接口************************/
	//提示弹窗----提示用户如何操作
	//通过ready接口处理成功验证
	fx_link = to_url+"&userListId="+userListId+"&listId="+listId+"&userId="+userId;
	wx.ready(function(){
	    //config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
		//分享给朋友
		wx.onMenuShareAppMessage({
			title: fx_title, // 分享标题
	        desc: fx_title, // 分享描述
	        link: fx_link,//分享点击之后的链接
	        imgUrl:fx_imgUrl, // 分享图标
	        type: 'link', // 分享类型,music、video或link，不填默认为link
	        success: function () {
	            //成功之后的回调
	        	alert("分享成功");
	        }
		});
		wx.getLocation({
			//type:'GCJ-02',
	        success: function (res) {
	            to_Name =$('.sellerAddr').text().split(':')[1];
	            from_x = res.latitude;
	            from_y =res.longitude; 
	            var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
	            var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
	            var speed = res.speed; // 速度，以米/每秒计
	            var accuracy = res.accuracy; // 位置精度
	            console.log('微信端获取地理位置'+accuracy);
	            console.log('longitude:' + longitude);
	            console.log('latitude:' + latitude);
	        },
	        fail: function(res) {
	        	//alert('未开启定位功能');
	            console.log(res);
	        },
	        cancel : function(res) {
	            alert('用户拒绝授权获取地理位置');
	        }
	    });
		
		//通过error接口处理失败验证
		wx.error(function(res){
		    //config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
		    //alert("微信调用异常！");
		});
	});
	
	
    
    
}

function updateGoodsState(state,id){
	$.ajax({
		type : 'get',
		async : false,
		url : "/wx/goods/updateState?isValid="+state+"&id="+id,
		// 如果参数为json，加上这句
		contentType : "text/json",
		// 规定反参类型为text
		dataType : "json",
		success : function(msg) {
			console.log(msg.message);
		},
		error : function(msg) {
			console.log(msg);
		}
	});
	
}


function updateState(state,id){
	$.ajax({
		type : 'get',
		async : false,
		url : "/wx/spell/updateState?state="+state+"&id="+id,
		// 如果参数为json，加上这句
		contentType : "text/json",
		// 规定反参类型为text
		dataType : "json",
		success : function(msg) {
			console.log(msg.message);
		},
		error : function(msg) {
			console.log(msg);
		}
	});
	
}


/*****************导航***************************/
var to_Name;
var to_x;
var to_y;
var from_x;
var from_y;
function daohang(){
	window.location.href="https://apis.map.qq.com/uri/v1/routeplan?"+
    "type=drive&fromcoord="+from_x+","+from_y+"&"+
    "to="+to_Name+"&tocoord="+to_x+","+to_y+"&referer=2ZXBZ-CTX3J-EPVFZ-KRXCX-2PVVZ-N4BPQ";
}
//开团
function openSpell(id){
	$.ajax({
		type : 'post',
		async : false,
		url : "/wx/spell/open?listId="+id,
		// 如果参数为json，加上这句
		contentType : "text/json",
		// 规定反参类型为text
		dataType : "json",
		success : function(msg) {
			console.log(msg);
			if(msg.code==0){
				alert(msg.message);
			}
		},
		error : function(msg) {
			console.log("获取失败");
		}
	});
}

//支付之后再调用加入朋友的开团
function joinFriendSpell(){
	
	$.ajax({
		type : 'post',
		async : false,
		url : "/wx/spell/join?id="+userListId+"&listId="+listId,
		// 如果参数为json，加上这句
		contentType : "text/json",
		// 规定反参类型为text
		dataType : "json",
		success : function(msg) {
			console.log(msg);
			alert(msg.message);
		},
		error : function(msg) {
			console.log("获取失败");
		}
	});
}

//查询我是否加入了该拼团活动，给出相应的页面反馈
function checkSepellisOpen(){
	$.ajax({
		type : 'post',
		async : false,
		url : "/wx/spell/getSpellIsOpen?listId="+listId,
		// 如果参数为json，加上这句
		contentType : "text/json",
		// 规定反参类型为text
		dataType : "json",
		success : function(msg) {
				if(msg){
					userListId = msg.userListId;
					console.log("已经加入了拼团");
					if(msg.count>=msg.num){
						$('.spellList').html("<div class='share-redbag __share'><div class='lt'>"+
								"<div class='lt_price'><span>我的拼团（您已完成拼团任务"+msg.num+"/"+msg.count+"~￥"+msg.price+"/人）<br/>"+
								"赶快去商家体验吧！</span></div>"+
								"<div class='lt_tip '>有效时间："+msg.startTime+"~"+msg.endTime+"</div></div>"+
								"</div>");
					}else{
						$('.spellList').html("<div class='share-redbag __share'><div class='lt'>"+
								"<div class='lt_price'><span>我的拼团<br/>（完成度："+msg.count+"/"+msg.num+"~￥"+msg.price+"/人）</span></div>"+
								"<div class='lt_tip '>"+msg.startTime+"~"+msg.endTime+"</div></div>"+
								"<div class='rt'><div class='rt_btn spell' onclick='javascript:cue()'>邀好友入团</div></div></div>");
					}
					spellPrice = msg.price;
					isJoinSpell=true;
				}else{
					console.log("未加入拼团");
					isJoinSpell=false;
				}
		},
		error : function(msg) {
			console.log("获取拼团失败");
		}
	});
}
function openMySpell(){
	 window.location.href="/wx/goods/goods?goodsId="+goodsId;
}
function getFriend(){
	$.ajax({
		type : 'post',
		async : false,
		url : "/wx/spell/getSpellByUser?userId="+currentUserId+"&listId="+listId+"&id="+userListId,
		// 如果参数为json，加上这句
		contentType : "text/json",
		// 规定反参类型为text
		dataType : "json",
		success : function(msg) {
			if(msg){
				if(msg.isJoin){
					$('.spellList').html("<div class='share-redbag __share'><div class='lt'>"+
							"<div class='lt_price'><span>"+msg.name+"发起的拼团<br/>（完成度："+msg.count+"/"+msg.num+"(未完成)~￥"+msg.price+"/人）</span></div>"+
							"<div class='lt_tip '>"+msg.startTime+"~"+msg.endTime+"</div></div>"+
							"<div class='rt'><div class='rt_btn spell' onclick='javascript:openGoumai()'>加入好友团</div></div></div>");
				}else{
					$('.spellList').html("<div class='share-redbag __share'><div class='lt'>"+
							"<div class='lt_price'><span>"+msg.name+"发起的拼团<br/>完成度："+msg.count+"/"+msg.num+"(已完成)~￥"+msg.price+"/人</span></div>"+
							"<div class='lt_tip '>"+msg.startTime+"~"+msg.endTime+"</div></div>"+
							"<div class='rt'><div class='rt_btn spell' onclick='javascript:openMySpell()'>自己开团</div></div></div>");
				}
				
					spellPrice = msg.price;
			}
		},
		error : function(msg) {
			console.log("获取失败");
		}
	});
}




var commonState;


function coll(obj){
	if(!commonState){
		$(obj).addClass("on");
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
		$(obj).removeClass("on");
		
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

var isGetItem =true;
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
						"<div class='evaMsg'><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+obj.message+"</span></div>"+
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
	






</script>

</head>

<!-- 服务协议 -->
<body class="bg_f5">
	<div class="has_menu ios-scroll" id="main">
		<!-- top01 -->
		<section class="mb12 bg-white">
			<!-- 头部轮播 -->
			<!-- 轮播图  320*240-->
			<div id="carousel-example-generic" class="carousel slide"
				data-ride="carousel" data-interval="3000">
				<!-- Wrapper for slides -->
				<div class="carousel-inner" style="text-align: center"></div>
			</div>
			<!-- end 头部轮播 -->


			<!-- 购买成功轮播 -->
			<div
				class="act-buylist swiper-container swiper-container-vertical swiper-container-autoheight"
				style="opacity: 1;">
				<div class="swiper-wrapper buyList" style="transform: translate3d(0px, -72px, 0px); transition-duration: 0ms; height: 36px;">
					<!-- 购买轮播 -->
					
				</div>
			</div>
			
			<!-- 查询下过单的用户添加到购买轮播的js -->
			<script type="text/javascript">
				  //查询下过单的用户
			    $.ajax({
					type : 'get',
					async : false,
					url : "/wx/goods/getUser?goodsId="+goodsId,
					// 如果参数为json，加上这句
					contentType : "text/json",
					// 规定反参类型为text
					dataType : "json",
					success : function(msg) {
						var listHtml='';
						if(msg.code==0){
							if(msg.result.user!=null&&msg.result.user.length>0){
								$.each(msg.result.user,function(index,obj){
									listHtml +="<div class='swiper-slide item'"+
									"data-swiper-slide-index='"+index+"' style='height: 36px;'>"+
									"<img src='"+obj.imageUrl+"' alt='' class='avatar'> <span>"+obj.name+"刚刚购买了本商品</span>"+
									"</div>";
								});
							}
							console.log(listHtml);
							$('.buyList').html(listHtml);
						}else{
							console.log("没有用户下单");
						}
					},
					error : function(msg) {
						console.log("没有用户下单");
					}
				});
			</script>
			<!-- end 购买成功轮播 -->
</section>
			<div class="wp act_info-top01 pb4 pt6 pos-r">
				<div class="l-flex l-flex_top mb4">
					<div class="font14 l-ht20 font-3 weui-flex__item titleName">
					</div>
					<div class="top_func">
						<div class="item views browNum">
							<!-- <i class="iconfont font18 vertical-a-m">&#xe723;</i> -->
						</div>
						<div class="js-atten item atten coll" onclick="coll(this)">收藏</div>
					</div>
				</div>

				<!-- --头信息 -->

				<section class="mb12 bg-white">
					<div>
						<div class="l-flex">
							<div>
								<div
									class="display-ib font16 act_info-cor1 act_info-cor2 l-ht28">
									<span class="font22 price"></span>
								</div>
								<div class="font10 font-9">
									<span style="text-decoration: line-through;" class="oldPrice"></span>
								</div>
							</div>
						</div>
					</div>
					<div class="l-flex font10 font-9 pt8 res"></div>
					<!--优惠信息-->
					<div class="discounts mt6 ht28 l-ht28">

						<span class="l-iflex font10 font-9 mr2"> <i
							class="iconfont font12 mr2 font-primary"></i> 限购<span
							class="act_info-cor1 font12">1</span>份
						</span>
					</div>

					<!-- 阶梯价格 -->
					<!-- 红包 -->
			</section>	
		<!-- end top01 -->



		<!--拼团活动-->
		<div class="bg-white mb12 pb10 pt10 wp spellList">
			
		</div>



		<section class="mb12 bg-white">
			<div class="wp act_info-tit01 ht32 bottom-line l-flex font-3">
				<div></div>
				<div class="l-iflex font14">
					<img src="${pageContext.request.contextPath}/icons/sellerIcon.png"
						alt="" class="w-16 mr4">商家信息
				</div>
				<div></div>
			</div>
			<div class="wp">
				<div class="act_info-top05 pt6 pb10 bottom-line">
					<span class="ht20 display-b tit mb6 font12 l-ht20"><span
						class="font-b sellerName"></span> </span>

					<div class="l-flex mb4">
						<div class="font12 font-6">
							<div class="overflow-h sellerOnTime"></div>
						</div>
					</div>
					<div class="l-flex mb4">
						<div class="font12 font-6">
							<div class="overflow-h time"></div>
						</div>
					</div>

					<div class="l-flex mb4 sellerPhoneNum">
						
						
					</div>
					<div class="l-flex mb4">
						<div class="font12 font-6">
							<div class="overflow-h sellerAddr"></div>
						</div>
						<a onclick="javascript:daohang()" class="btn w-36 ht20 ml10 font10 l-ht20 tc font-white radius4 daohang">导航</a>
					</div>
					
					
					<div id="container" >
						<input type="hidden" name="address" id="address" class="sellerAddress">
					</div>
				</div>
			</div>
		</section>






		<!-- top07 -->
		<section class="mb12 bg-white">
			<div class="act_info-tab act-tab font14 l-ht26 bg-white">
				<div class="message"
					style="color: blank; height: 40px; text-align: center;"></div>
			</div>
			<div class="content">

				<div id="page"></div>

			</div>
		</section>

		<div class="mb10 bg-white wp">
			<img src="${pageContext.request.contextPath}/icons/cue.jpg"
				class="per100">
		</div>



		<!-- footer -->
		<div class="info-footer bg-white">
			<div class="list l-flex wp">
				<div class="item">
					<a href="/wx/wx/index" class="display-b"> <img
						src="${pageContext.request.contextPath}/icons/home.png" alt=""
						class="w-18"> <span class="display-b font10 font-9">首页</span>
					</a>
				</div>
				<div class="item">
					<a href="/wx/user/index" class="display-b" id="login_act"> <img
						src="${pageContext.request.contextPath}/icons/my.png" alt=""
						class="w-18"> <span class="display-b font10 font-9">我的</span>
					</a>
				</div>
				<div class="item l-iflex">
					<a onclick="javascript:buy()"
						class="buy coupon_btn-single coupon_btn01 font14 font-white">立即下单</a>
						<input type="hidden" class="js-goumai">
				</div>
			</div>
		</div>





	</div></div>
	<!-- end #main -->

<!-- 购买弹窗 -->
	<div id="payPop" class="weui-popup__container">
		<div class="weui-popup__overlay"></div>
		<div class="weui-popup__modal boxSizing pay-popup__modal">
			<div class="popup-wrap ios-scroll ht100p">
				<div class="wp ht24 l-ht24 font12 font-12 opacity5 buyCue">
					
				</div>
				<!-- pay-top01 -->
				<div class="l-flex pay-top01 wp pt12 pb12 bg-white">
					<div class="w-54 mr8 buyTitleImage">
						
					</div>
					<div class="text font12">
						<p class="l-ht16 font-3 buyTitle"></p>
						<span class="act_info-cor1 buyPrice"> 
						</span>
					</div>
				</div>
				<!-- end pay-top01 -->

				<!-- pay-top02 -->
				<div class="pay-top02 bg-white pb2">
				
				
				
						
						<!-- 24.90 -->
						<input type="hidden" name="goods_attr_id" value=""> <input
							type="hidden" name="fid" value="495"> <input
							type="hidden" name="cid" value=""> <input type="hidden"
							name="group_price" >


						<div class="wp l-flex ht36">
							<div class="font12">
								<p>数量</p>
							</div>
							<div class="l-iflex act_pay-border radius4 js-changeCount">
								<em class="tc font16 font-9 l-ht20 ht20 w-28 mius">-</em> <input
									type="text" value="1"
									class="in-border tc w-28 ht20 l-ht20 font12 countNum" name="num"
									id="single" data-maxcount="171"> <em
									class="tc font16 font-9 l-ht20 ht20 w-28 add">+</em>
							</div>
						</div>

						<div class="wp l-flex ht32 top-line countPrice">
							
						</div>
				
				</div>
				<!-- end pay-top02 -->


		
		


	
				<!-- pay-top03 -->
				<form id="myForm" action="/wx/order/save" method="post" enctype="multipart/form-data">
					<input type="hidden" id="sellerId" name="sellerId">
					<input type="hidden" id="goodsId" name="goodsId" >
					<div class="pay-top03 bg-white mt6">
						<div class="wp pt8 pb8 l-flex font12 bottom-line">
						
							<div class="weui-label">姓名</div>
							<div class="weui-cell__bd">
								<input class="weui-input pt6 pb6" id="name" type="text"
									name="phoneName" placeholder="请填写姓名" value="">
							</div>
						</div>
						<div class="wp pt8 pb8 l-flex font12 bottom-line">
							<div class="weui-label">手机号</div>
							<div class="weui-cell__bd">
								<input class="weui-input  pt6 pb6" id="phoneNum" name="phoneNum"
									type="tel" placeholder="请填写联系电话">
							</div>
						</div>
					</div>
				
				<!-- end pay-top03 -->
				<div class="pay-top03 bg-white mt6 mb10">
					<div id="athmes"></div>
				</div>
				<!-- end pay-top03 -->


			<div class="pay-foot bg-white l-flex">
				<div class="count pl12 font14 font-3">
					支付：<span class="font12 act_info-cor1">￥<em
						class="goodsTotal">0</em></span>
						<input type="hidden" id="price" name="price" >
						<input type="hidden" id="payPrice" name="payPrice" >
						<input type="hidden" id="orderType" name="type">
				</div>
				<div class="l-iflex btn-box">
					<a href="javascript:void(0);" class="btn btn_cancel close-popup">取
						消</a> <a onclick="checkOrder(this);" class="btn btn_pay payMoeny" id="add_order">下单到店付</a>
				</div>
			</div>
			
			</form>
		</div>
	</div>
	</div>
	<!-- end 购买弹窗 -->
<script type="text/javascript">
	function checkOrder(obj) {
		
		var name = $('#name').val();
		if (name.trim() == "") {
			alert("请输入联系人姓名");
			return false;
		}

		var pattern = /^((0\d{2,3}-?\d{7,8})|(1[35784]\d{9}))$/;
		var phoneNum = $("#phoneNum").val();
		var result = pattern.test(phoneNum);
		if (phoneNum && !result) {
			alert("不支持的手机格式");
			return false;
		}

		if (phoneNum.trim() == "") {
			alert("请填写联系人电话");
			return false;
		}
		var goodsId = $('#goodsId').val();
		//检查是否已经下过单
		$.ajax({
			type : 'get',
			async : false,
			url : "/wx/order/getState?goodsId=" + goodsId,
			// 如果参数为json，加上这句
			contentType : "text/json",
			// 规定反参类型为text
			dataType : "json",
			success : function(msg) {
				if (msg.code == 0) {
					console.log(msg);
					if (msg.result.orderState == false
							|| msg.result.goodsState == true) {
						alert("错误操作：您已下单或优惠券不足");
						return false;
					}
					/*
					支付逻辑
					*/
					
					/* if($(obj).is('.payMoeny')){
						alert("我是要付钱的");
						return false;
					}
					 */
					
					 if(<%=request.getParameter("userListId")==null%>&&<%=request.getParameter("listId")==null%>){
						 openSpell(listId);
					 }else{
						//加入朋友开团
						joinFriendSpell();
					 }
					 
					 var isPay = true;
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
								alert("未开通支付！");
								isPay =false;
								return false;
							}
						});
					 if(isPay)
							$('#myForm').submit();
					
				}
			},
			error : function(msg) {
				alert("未知错误");
			}
		});

		/*  //检查是否已经下过单
		 */

	}
</script>
	<!-- 引用弹窗 -->

	<div id="rule" class="weui-popup__container">
		<div class="weui-popup__overlay"></div>
		<div class="weui-popup__modal boxSizing bg-white pb38">
			<div class="popup-wrap ios-scroll ht100p">
				<img src="https://ui.fhcloudapi.cn/urmyx/img/rule_buy.png" alt="">
				<!--购买-->
			</div>
			<!--取消-->
			<div class="foot_gm close-popup">
				<a class="font-white">返&nbsp;回</a>
			</div>
		</div>
	</div>



	<!-- 引用弹窗 -->

	<input type="hidden" value="9315" name="user_id">
	<input type="hidden" value="" name="group_id">
	<input type="hidden" value="" name="back_url">






	
<!-- 头图轮播及评价图轮播 -->
	<script>
		new Swiper('.act-buylist', {
			autoplay : 3000,
			slidesPerView : 1,
			direction : 'vertical',
			autoHeight : true,
			loop : true,
			onlyExternal : true,
			onSlideNextStart : function(swiper) {
				$('.act-buylist').animate({
					opacity : 0
				}, 0);
			},
			onSlideNextEnd : function(swiper) {
				$('.act-buylist').animate({
					opacity : 1
				}, 500);
			}
		})
		
		function popClose() {

			$('body').css({

				position : '',

				top : ''

			});

			$(window).scrollTop(popScrollTop);

			$('#main').show();

		}
		
		
		
		
		var fid = $('input[name="fid"]').val();
		var popScrollTop;
		function popShow() {
			popScrollTop = $(window).scrollTop();
			$('body').css({
				position : 'fixed',
				top : -popScrollTop
			});
		}
		function popClose() {
			$('body').css({
				position : '',
				top : ''
			});
			$(window).scrollTop(popScrollTop);
			$('#main').show();
		}
		$('.close-popup').on('click', function() {
			popClose();
		})

		function showAtten() {
			$('#atten').fadeIn(200, function() {
				$(this).addClass('on');
			});
		}

		// 阶梯价功能
		var isStepPrice = '';
		var flagStepPrice = true;
		function getStepPrice() {
			$.showLoading();
			var _fid = $('input[name="fid"]').val();
			$.post("/Home/Act/get_step_price.html", {
				form_id : _fid,
				uid : "9315"
			}, function(data) {
				if (data) {
					$('input[name="price"]').val(data.price);
					$('input#single').attr('data-maxCount', data.kucun_remain);
					flagStepPrice = false;
					$('.js-goumai').click();
					var timer = setTimeout(function() {
						flagStepPrice = true;
						clearTimeout(timer);
					}, 500);
				}
				$.hideLoading();
			})
		}
		function buy(){
			if(!isBuyClick){
				if(isJoinSpell)
					alert("您已参加了拼团活动!");
				return true;
			}
			$('.js-goumai').click();
		}
		function openGoumai(){
			isSpell=true;
			$('.js-goumai').click();
		}
		//老JS
		$('.js-goumai').on('click',function() {
				//拼团
				if(isSpell){
					//总价价格初始化显示
					var countNum = $('.countNum').val();
					$('#goodsPrice').text(spellPrice);
					$('.countPrice').html("<div class='font12'>总价</div>"+
					"<div class='font10 act_info-cor1'>"+
					"￥<span class='font14 cPrice'>"+spellPrice*countNum+"</span>"+
					"</div>");
					$('#price').val(spellPrice*countNum);
					$('#payPrice').val(spellPrice*countNum);
					$('.goodsTotal').text(spellPrice*countNum);
					isSpell=false;
					$('.buyCue').html("请您于下单<span class='act_info-cor1'>5分钟</span>内完成支付，逾时订单将自动取消");
					$('#add_order').text("支付并开团");
					$("#orderType").val(2);
					
				}else{
					$("#orderType").val(1);
					//总价价格初始化显示
					var countNum = $('.countNum').val();
					$('#goodsPrice').text(goodsPrice);
					$('.countPrice').html("<div class='font12'>总价</div>"+
					"<div class='font10 act_info-cor1'>"+
					"￥<span class='font14 cPrice'>"+goodsPrice*countNum+"</span>"+
					"</div>");
					$('#price').val(goodsPrice*countNum);
					
					if(payType==1){
						$('.buyCue').html("下单后,请在活动时间内到商家消费！");
						$('#add_order').text("下单到店付");
						$('#payPrice').val(0);
						$('.goodsTotal').text(0);
						$('#add_order').removeClass('payMoeny');
					}
					else{
						$('.buyCue').html("请您于<span class='act_info-cor1'>活动结束</span>前完成支付，逾时订单将自动取消");
						$('#add_order').text("立即支付");
						$('#payPrice').val(goodsPrice*countNum);
						$('.goodsTotal').text(goodsPrice*countNum);
					}
					
				}
					
				popClose();

				var is_need = $('input[name="need_share"]').val();
				var user_id = $('input[name=user_id]').val();
				if (isStepPrice && flagStepPrice) {
					getStepPrice();
					return;
				}

				$('#main').hide();
				$('#payPop').popup();
				setTimeout(function() {
					$('#payPop').css({
						position : 'absolute'
					});
				}, 300);
					
			})
				
				
			$('#payPop .btn_cancel').click(function() {
				$('#payPop').css({
					position : ''
				});
			})
		
	</script>
	<!-- end 头图轮播及评价图轮播 -->



<!-- 客服 -->
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