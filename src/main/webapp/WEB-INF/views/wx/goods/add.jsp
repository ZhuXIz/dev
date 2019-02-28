<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html class="pixel-ratio-1" style="font-size: 18px !important;">
<head>
<style type="text/css">


</style>
<c:import url="../../common/import.jsp"></c:import>


<!-- /*datetime控件*/ -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/show.css">
    <link href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/css/bootstrap-select.min.css" rel="stylesheet">
	
 	<script src="${pageContext.request.contextPath}/js/moment-with-locales.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-select.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/defaults-zh_CN.min.js"></script>
<style type="text/css">
.pre_text{
	float: left;
	padding-right: 10px;
	width: 90px;
	font-weight: bolder;
}
.next_obj{
	width: 70%;
	float:right;
	padding-left: 10%;
}
.auto_item{
padding-top: 20px;
}
</style>
<script type="text/javascript">
var imageStr='';
function setGoodsImg(obj){
	var f=$(obj).val();
	alert(f);
	console.log(obj);
    if(f == null || f ==undefined || f == ''){
        return false;
	}
    if(!/\.(?:png|jpg|bmp|gif|PNG|JPG|BMP|GIF)$/.test(f))
    {
        alert("类型必须是图片(.png|jpg|bmp|gif|PNG|JPG|BMP|GIF)");
        $(obj).val('');
        return false;
    }
    var data = new FormData();
    console.log(data);
    $.each($(obj)[0].files,function(i,file){
        data.append('file', file);
    });
    console.log(data);
    $.ajax({
        type: "POST",
        url: "/wx/goods/uploadImg",
        data: data,
        cache: false,
        contentType: false,    //不可缺
        processData: false,    //不可缺
        dataType:"json",
        success: function(ret) {
        	console.log(ret);
        	//var imageStr= $("#goodsImage").val();
            if(ret.code==0){
            	imageStr = "&"+ret.result.url;
            	// imageStr+="&"+ret.result.url;
                 //$("#goodsImage").val(imageStr);//将地址存储好
                 var showHtml ="<img src='/wx"+ret.result.url+"' style='width:50px;height:50px;'/><input value='"+ret.result.url+"' type='hidden' name='image' id='goodsImage'/>";
               	//显示图片  
                 $(".imageShowCon").append(showHtml); 
                 alert(ret.message);
            }else{
                alertError(ret.message);
                $("#goodsImage").val("");
                $(obj).val('');
            }
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            alert("上传失败，请检查网络后重试");
        }
    });
}

function setImg(obj){
	var f=$(obj).val();
	alert(f);
	console.log(obj);
    if(f == null || f ==undefined || f == ''){
        return false;
	}
    if(!/\.(?:png|jpg|bmp|gif|PNG|JPG|BMP|GIF)$/.test(f))
    {
        alert("类型必须是图片(.png|jpg|bmp|gif|PNG|JPG|BMP|GIF)");
        $(obj).val('');
        return false;
    }
    var data = new FormData();
    console.log(data);
    $.each($(obj)[0].files,function(i,file){
        data.append('file', file);
    });
    console.log(data);
    $.ajax({
        type: "POST",
        url: "/wx/goods/uploadImg",
        data: data,
        cache: false,
        contentType: false,    //不可缺
        processData: false,    //不可缺
        dataType:"json",
        success: function(ret) {
        	console.log(ret);
            if(ret.code==0){
            		$('.titleImage').html("<span><img id='photourlShow' style='width:50px;height:50px;'/></span>");
                    $("#titleImage").val(ret.result.url);//将地址存储好
                    $("#photourlShow").attr("src","/wx"+ret.result.url);//显示图片
                    alert(ret.message);
            }else{
                alertError(ret.message);
                $("#titleImage").val("");
                $(obj).val('');
            }
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            alert("上传失败，请检查网络后重试");
        }
    });
}

</script>

<script>



var init = function(){
	$(".imageShowCon").html("");
	
	$(function () {
		$('#datetimepicker1').datetimepicker({
			  format:'yyyy-mm-dd hh:00',
			  language : 'zh-CN',
			  weekStart : 1,
			  todayBtn : true,
			  autoclose : 1,
			  startView : 'year',
			  maxView:'decade',
			  minView :'day',
			  forceParse : false,
			  pickerPosition: "bottom-left"
		}); 
		$('#datetimepicker2').datetimepicker({
			  format:'yyyy-mm-dd hh:00',
			  language : 'zh-CN',
			  weekStart : 1,
			  todayBtn : true,
			  autoclose : 1,
			  startView : 'year',
			  maxView:'decade',
			  minView :'day',
			  forceParse : false,
			  pickerPosition: "bottom-left"
		}); 
	 
	});

	$(document).ready(function(){
	    $('#auto').click(function(){
	        $('#upload').click();
	    });

	});
	
	//修改页面的初始化
	//初始化支付类型
/* 	var payType = $('#payType').val();
	
	if(typeof(payType)!="undefined"){
		var text = $("pay"+payType).text();
		$('.payTypeDrop').html(text+"<b class='caret'></b>");
		$('#payType').val(payType);
	}
	
	
	//初始化商品类型
	var goodsType = $('.goodsType').val();
	if(typeof(goodsType)!="undefined"){
		var text = $("goods"+goodsType).text();
		$('.goodsTypeDrop').html(text+"<b class='caret'></b>");
		$('#goodsType').val(goodsType);
	} */
	
}

function RQcheck(RQ) {
    var date = RQ;
    var result = date.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/);

    if (result == null)
        return false;
    var d = new Date(result[1], result[3] - 1, result[4]);
    return (d.getFullYear() == result[1] && (d.getMonth() + 1) == result[3] && d.getDate() == result[4]);

}

function checkGoods(){
	var sufTime = $('#sufTime').val();
	var preTime = $('#preTime').val();
	var titleImage = $('#titleImage').val();
	var goodsImage = $('#goodsImage').val();
	var titleName = $('#titleName').val();
	var oldPrice = $('#oldPrice').val();
	var price = $("#price").val();
	var goodsTy = $("#goodsType").val();
	var payTy = $("#payType").val();
	var resNum = $("#resNum").val();
	
	if(preTime.trim().length<=0){
		alert("请输入开始时间");
		return false;
	}
	if(sufTime.trim().length<=0){
		alert("请输入结束时间");
		return false;
	}

	var sDate = new Date(preTime.replace(/\-/g, "\/"));
	var eDate = new Date(sufTime.replace(/\-/g, "\/"));
	if(sDate > eDate){
		alert("结束日期不能小于开始日期");
		return false;
	}
	
	
	if(typeof(titleImage)=="undefined"||titleImage.length<=0){
		alert("请添加宣传图");
		return false;
	}
	if(typeof(goodsImage)=="undefined"||goodsImage.length<=0){	
		alert("请添加至少一张轮播图");
		return false;
	}
	

	if(/\D/.test(resNum)){
		 alert("优惠券数量若无限制请填0或不填写"); 
		 return false; 
	} 
	if (!/^\d+(\.\d+)?$/.test(parseFloat(price))) {
		alert("价格应为数字,且不为负数！");
		return false;
	}
	if (!/^\d+(\.\d+)?$/.test(parseFloat(oldPrice))) {
		alert("原价应为数字,且不为负数！");
		return false;
	}
	if(price.trim().length<=0){
		alert("请填写现价");
		return false;
	}
	
	if(typeof(payTy)!="undefined" && payTy.length<=0){
		alert("请填写支付类型");
		return false;
	}
	if(typeof(goodsTy)!="undefined" && goodsTy.length<=0){
		alert("请填写商品类型");
		return false;
	}

	var goodsId = $('#goodsId').val();

	$.ajax({
		type : 'get',
		async : true,
		url : "/wx/goods/check",
		// 如果参数为json，加上这句
		contentType : "text/json",
		// 规定反参类型为text
		dataType : "json",
		success : function(msg) {
			if(msg.code==0){
				if(msg.result.state==false){
					alert("请不要频繁添加促销活动！");
					return false;
				}
				$('#myForm').submit();
				alert("添加成功");
			}
		},
		error : function(msg) {
			alert("添加遇到错误！");
			return false;
		}
	});
	

}

</script>
</head>
<body onload="init()">

<form id="myForm" action="/wx/goods/save" method="post" enctype="multipart/form-data" >
	<div>
		<input id="id" name="id"  type="hidden">
		<input id="id" name="seller.id" value="${user.id}" type="hidden">
	</div>
	
	
	<div class="auto_item">
		<div class="col-sm-10">
      		<div class="pre_text">宣传图</div>
      			<div class="next_obj">
	
					<span class="titleImage">
					</span>
		
				<img src="${pageContext.request.contextPath}/upload/imgs/upload.png"  onclick="$('#upload').click();">
				 <input type="hidden" name="titleImage" id="titleImage"/>
				<input type="file" style="display: none;" name="logoFile" id="upload" onchange="setImg(this)">
				
			</div>
		</div>
	</div>
	
	
	
	<div class="auto_item">
		<div class="col-sm-10">
      		<div class="pre_text">商品轮播图</div>
      			<div class="next_obj">
					<span class="imageShowCon">

					</span>
					<img src="${pageContext.request.contextPath}/upload/imgs/upload.png"  onclick="$('#imagesUpload').click();">
					<input type="file" style="display: none;" id="imagesUpload" name="logoFile" onchange="setGoodsImg(this)">
				
			</div>
		</div>
	</div>
	
	
	
	
	<div class="auto_item">
		<div class="col-sm-10">
	      		<div class="pre_text">商品名</div>
	      		<div class="next_obj">
	      			<input type="text" class="form-control"  id="titleName" name="titleName"  placeholder="输入商铺名">
	    		</div>
    	</div>
	</div>
	
<div class="auto_item">
		<div class="col-sm-10">
	      		<div class="pre_text">开始时间</div>
	      		<div class="next_obj">
       <!--      指定 date标记 -->
            <div class='input-group date' id='datetimepicker1' >
                <input type='text' name="preTimeStr" id="preTime" class="form-control" />
                <span class="input-group-addon">
                    <span class="glyphicon glyphicon-calendar"></span>
                </span>
            </div>
        </div>
    </div>
 </div>  
<div class="auto_item">
	<div class="col-sm-10">
      		<div class="pre_text">结束时间</div>
      		<div class="next_obj">
	            <!-- 指定 date标记 -->
	            <div class='input-group date' id='datetimepicker2'>
	                <input type='text' name="sufTimeStr" id="sufTime" class="form-control" />
	                <span class="input-group-addon">
	                    <span class="glyphicon glyphicon-calendar"></span>
	                </span>
	            </div>
      			</div>
   	</div>
</div> 

	
	<div class="auto_item">
		<div class="col-sm-10">
	      		<div class="pre_text">原价</div>
	      		<div class="next_obj">
	      			<input type="text" class="form-control" name="oldPrice" id="oldPrice" placeholder="原价">
	    		</div>
		</div>
	</div>
	
	<div class="auto_item">
		<div class="col-sm-10">
	      		<div class="pre_text">现价</div>
	      		<div class="next_obj">
	      		<input type="text" class="form-control" name="price" id="price" placeholder="现价">
	      		</div>
	     </div>
	</div>
	
	
	<div class="auto_item">
		<div class="col-sm-10">
	      		<div class="pre_text">优惠数量</div>
	      		<div class="next_obj">
			     	<input type="text" class="form-control" value="${goods.resNum}" name="resNum" id="resNum" placeholder="请填写该活动的参与人数">
			   	</div>
		</div>
	</div>
	
	
	<script type="text/javascript">
	function setDoc(obj){
		var f=$(obj).val();
		alert(f);
		console.log(obj);
	    if(f == null || f ==undefined || f == ''){
	        return false;
		}
	    if(!/\.(?:doc|Doc|DOC)$/.test(f))
	    {
	        alert("类型必须是(.doc|Doc|DOC)");
	        $(obj).val('');
	        return false;
	    }
	    var data = new FormData();
	    console.log(data);
	    $.each($(obj)[0].files,function(i,file){
	        data.append('file', file);
	    });
	    console.log(data);
	    $.ajax({
	        type: "POST",
	        url: "/wx/goods/upload",
	        data: data,
	        cache: false,
	        contentType: false,    //不可缺
	        processData: false,    //不可缺
	        dataType:"json",
	        success: function(ret) {
	        	console.log(ret);
	            if(ret.code==0){
	            	alert("上传成功");
	            	console.log(ret.result.url);
	            	$("#htmlSrc").val(ret.result.url);//将地址存储好 
	            }else{
	                alertError(ret.message);
	                $("#titleImage").val("");
	                $(obj).val('');
	            }
	        },
	        error: function(XMLHttpRequest, textStatus, errorThrown) {
	        	console.log(ret);
	            alert("上传失败，请检查网络后重试");
	        }
	    });
	}
	</script>

	<div class="auto_item">
		<div class="col-sm-10">
      		<div class="pre_text">商品详细(</div>
      			<div class="next_obj">
					<img src="${pageContext.request.contextPath}/upload/imgs/upload.png"  onclick="$('#docUpload').click();">
				     <input type="hidden" id="htmlSrc" name="itemSrc"/>
					<input type="file" name="logoFile" style="display: none;" id="docUpload" onchange="setDoc(this)">
				</div>
		</div>
	</div>
	
	
	
	<div class="auto_item"> 
		<div class="col-sm-10">
	      		<div class="pre_text">商品类型</div>
	      		<div class="next_obj">
				<input type="hidden" class="form-control" value="" style="width: 50px;" name="goodsType.id" id="goodsType" placeholder="商品类型">
				<ul class="nav nav-pills">
				<li class="dropdown all-camera-dropdown">
					<a class="goodsTypeDrop dropdown-toggle" data-toggle="dropdown">
						商品类型
						<b class="caret"></b>
					</a>
					<ul class="dropdown-menu" id="goods_type">
						<!-- <li><a id="goods1" onclick="setGoodsType(this,1)">旅游</a></li>
						<li><a id="goods2" onclick="setGoodsType(this,2)">美食</a></li>
						<li><a id="goods3" onclick="setGoodsType(this,3)">KTV</a></li>
						<li><a id="goods4" onclick="setGoodsType(this,4)">服装</a></li>
						<li><a id="goods5" onclick="setGoodsType(this,5)">其他</a></li> -->
					</ul>
				</li>
			</ul>
			</div>
		</div>
	</div>
	<script type="text/javascript">
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
            		type_html=type_html+'<li><a onclick="setGoodsType(this,'+obj.id+')">'+obj.genreName+'</a></li>';
            	})
            	$("#goods_type").html(type_html);
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
	<script type="text/javascript">
	var chackedNum = 0;
		function setRec(){
			if(chackedNum%2==0){
				//选中
				console.log("选中");
				//支付服务费
				$('#myBtn').val("支付0.00并发布");
			}
			else{
				//不选中
				console.log("没选中");
				//免费发布
				$('#myBtn').val("免费发布");
			}
				
			chackedNum++;
		}
	</script>
	
	<script type="text/javascript">
		function setPayType(obj,type){
			var text = $(obj).text();
			$('.payTypeDrop').html(text+"<b class='caret'></b>");
			$('#payType').val(type);
		}
	</script>
	
	<div class="auto_item">
		<div class="col-sm-10">
      		<div class="pre_text">支付类型</div>
      			<div class="next_obj">
			      	<ul class="nav nav-pills">
						<li class="dropdown all-camera-dropdown">
							<a class="payTypeDrop dropdown-toggle" data-toggle="dropdown">
								支付类型
								<b class="caret"></b>
							</a>
							<input type="hidden" class="form-control" value="" style="width: 50px;" name="payType" id="payType" placeholder="商品类型">
							<ul class="dropdown-menu">
								<li><a onclick="setPayType(this,1)" id="pay1">到店付</a></li>
								<li><a onclick="setPayType(this,2)" id="pay2">在线付</a></li>
							</ul>
						</li>
					</ul>
				</div>
		</div>
	</div>
	
	
	<div class="auto_item">
		<div class="col-sm-10">
      		<div class="pre_text">是否推荐</div>
      		<div class="next_obj" >
				<input onclick="setRec()" style="margin-left: 15px"  type="checkbox" class="isRecommend" name="isRecommend">
		 	</div>
		</div>
	</div>
		<br/>
	<div style="padding-left: 30%;padding-right: 30% ;margin-bottom: 10px">
		<input id="myBtn" class='preName btn btn-danger' type="button" onclick="checkGoods();" value="免费发布"/>
	</div>

</form>


</body>
</html>