<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<c:import url="../../common/import.jsp"></c:import>

<script charset="utf-8" src="https://map.qq.com/api/js?v=2.exp&key=2ZXBZ-CTX3J-EPVFZ-KRXCX-2PVVZ-N4BPQ"></script>
<style type="text/css">

input#address{
	width:300px;
}
#container {
   margin-left:10%;
   width:80%;
   height: 200px;
   margin-top: 10px;
   margin-bottom: 10px;
}
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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/show.css">

<script type="text/javascript">
$(document).ready(function(){
    $('#auto').click(function(){
        $('#upload').click();
    });

});
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
        url: "/wx/seller/uploadImg",
        data: data,
        cache: false,
        contentType: false,    //不可缺
        processData: false,    //不可缺
        dataType:"json",
        success: function(ret) {
        	console.log(ret);
            if(ret.code==0){
                    $("#introduceImage").val(ret.result.url);//将地址存储好
                    $("#photourlShow").attr("src","/wx"+ret.result.url);//显示图片   
                    alert(ret.message);
            }else{
                alertError(ret.message);
                $("#introduceImage").val("");
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
var commonMarker;
var geocoder,map,marker = null,markersArray = [];
var init = function() {
	var add = $("#addressV").val();
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
        draggable: true,
        map: map
 	});
    
    //调用地址解析类
    geocoder = new qq.maps.Geocoder({
        complete : function(result){
        	
            map.setCenter(result.detail.location);
            marker = new qq.maps.Marker({
                position: result.detail.location,
                draggable: true,
                map: map
         	});
            if(marker!=null){
        		commonMarker.setMap(null);
        	}
            commonMarker = marker;
        }
    });
    

}


function codeAddress() {
	
	
	var address = document.getElementById("address").value;
    //通过getLocation();方法获取位置信息值
    geocoder.getLocation(address);
   
}

function checkSeller(id){
	
	var pattern = /^((0\d{2,3}-?\d{7,8})|(1[35784]\d{9}))$/;
	var result =pattern.test(phoneNum);
	if(phoneNum && !result){
		 alert("不支持的手机格式"); 
		 return false;
	} 
	var name = $("#name").val();
	var onTime = $("#onTime").val();
	var phoneNum = $("#phoneNum").val();
	var address = commonMarker.position+"";
	$("#addressV").val(commonMarker.position);
	var introduceText = $("#introduceText").val();
	var introduceImage = $("#introduceImage").val();
	var phoneName = $("#phoneName").val();
	var addressStr = $("#addressStr").val();
  	//验证
	if(typeof(name)=="undefined"||name.trim().length<=0){	
		alert("请填写商家名！");
		return false;
	} 
	if(typeof(onTime)=="undefined"||onTime.trim().length<=0){	
		alert("请填写营业时间");
		return false;
	} 
	var pattern = /^((0\d{2,3}-?\d{7,8})|(1[35784]\d{9}))$/;
	var result =pattern.test(phoneNum);
	if(phoneNum && !result){
		 alert("不支持的手机格式"); 
		 return false;
	} 
	if(typeof(phoneNum)=="undefined"||phoneNum.trim().length<=0){	
		alert("请填写联系电话！");
		return false;
	} 

	if($("#onTime").val().length<=0||$("#onTime").val().trim()==""){
		alert("请填营业时间");
		return false;
	}
	if($("#phoneName").val().length<=0||$("#phoneName").val().trim()==""){
		alert("请填写联系人");
		return false;
	}
	if($("#phoneNum").val().length<=0||$("#phoneNum").val().trim()==""){
		alert("请填写联系电话");
		return false;
	}
	if($("#name").val().length<=0||$("#name").val().trim()==""){
		alert("请填写店铺名");
		return false;
	}
	if($("#addressStr").val().length<=0||$("#addressStr").val().trim()==""){
		alert("请填写详细地址");
		return false;
	}
	if($("#introduceText").val().length<20){
		alert("详细介绍应不少于20个字");
		return false;
	}
	if($("#introduceText").val().length>500){
		alert("详细介绍应不多于500个字");
		return false;
	}

	var data={
		'id':id,
		'name':name,
		'onTime':onTime,
		'phoneNum':phoneNum,
		'address':address,
		'introduceText':introduceText,
		'introduceImage':introduceImage,
		'phoneName':phoneName,
		'addressStr':addressStr,
			
	}
	
	
	if(id==null||typeof(id)=="undefined"){
		$.ajax({
			type : 'post',
			async : true,
			url : "/wx/seller/check",
			// 如果参数为json，加上这句
			contentType : "text/json",
			// 规定反参类型为text
			dataType : "json",
			success : function(msg) {
				if(msg.code==0){
					if(msg.result.state==false){
						alert("一个用户只能添加一个商家！");
						return false;
					}
					saveSeller(data);
				}
			},
			error : function(msg) {
				alert("请返回主页！");
				return false;
			}
		});
	}else{
		saveSeller(data);
	}
	
} 

function saveSeller(data){
	console.log(data);
	$.ajax({
		type : 'post',
		async : false,
		url : "/wx/seller/save",
		data: JSON.stringify(data),//必要
        dataType:"json",
        contentType:"application/json",
        async: false,
        cache:false,
		success : function(msg) {
			alert(msg.message);
		},
		error : function(msg) {
			console.log(msg);
			alert("未知错误,请联系客服!");
		}
	}); 
	window.location.href="/wx/seller/index";
}
</script>
</head>
<body onload="init()">


<form id="myForm" action="/wx/seller/save" method="post" enctype="multipart/form-data" >
	
	<div>
		<input id="id" name="id" value="${seller.id}" type="hidden">
	</div>
	

	<div class="auto_item">
		<div class="col-sm-10">
      		<div class="pre_text">店铺图</div>
      			<div class="next_obj">
					<input type="hidden" name="introduceImage" value="${seller.introduceImage}" id="introduceImage"/>
					
					<img src="${pageContext.request.contextPath}/upload/imgs/upload.png" id="autoImg" onclick="$('#upload').click();">
					<span><img id="photourlShow" src="${pageContext.request.contextPath}${seller.introduceImage}" style="max-width: 50px;"/></span>
					<input type="file" name="logoFile" id="upload" onchange="setImg(this)">
				</div>
		</div>
	</div>
	
	
	
	
	<div class="auto_item">
		<div class="col-sm-10">
      		<div class="pre_text">店铺名</div>
      		<div class="next_obj">
      				<input type="text"  class="form-control" value="${seller.name}" id="name" name="name"  placeholder="输入店铺名">
      		</div>
      		
    	</div>
	</div>
	
	
	<div class="auto_item">
		<div class="col-sm-10">
			<div class="pre_text">联系人</div>
			<div style="width: 70%;float:right;  padding-left: 10%">
      		<input type="text" class="form-control" value="${seller.phoneName}" name="phoneName"  id="phoneName" placeholder="联系人姓名">
      		</div>
    	</div>
	</div>
	
	<div class="auto_item">
		<div class="col-sm-10">
			<div class="pre_text">联系电话</div>
				<div style="width: 70%;float:right;  padding-left: 10%">
	      			<input type="text" class="form-control" value="${seller.phoneNum}" name="phoneNum" id="phoneNum" placeholder="联系电话">
      			</div>
    	</div>
	</div>
	
	<div class="auto_item">
		<div class="col-sm-10">
			<div class="pre_text">营业时间</div>
				<div style="width: 70%;float:right;  padding-left: 10%">
	     			<input type="text" class="form-control" value="${seller.onTime}" name="onTime" id="onTime" placeholder="营业时间，如9：00-21：00">
	     		</div>
	   	</div>
	</div>

	
	<div class="auto_item">
		<div class="col-sm-10">
			<div class="pre_text">地址</div>
			<div style="width: 70%;float:right;  padding-left: 10%">
				<input id="address" type="textbox" style="width: 70%" value="中国,四川，资中">
				<input type="hidden" name="address" id="addressV" value="${seller.address}">
				<button type="button" class="btn btn-info" onclick="codeAddress()">查询</button>
			</div>
		</div>
	</div>
		<div id="container">
		</div>
	
	
	
	<div class="auto_item">
		<div class="col-sm-10">
			<div class="pre_text">详细地址</div>
				<div class="next_obj">
	      			<input type="text" class="form-control" value="${seller.addressStr}" name="addressStr" id="addressStr" placeholder="店铺地址">
	      		</div>
		</div>
	</div>
	<div class="auto_item">
		<div class="col-sm-10">
			<div class="pre_text">店铺介绍</div>
				<div class="next_obj">
					<textarea rows="8" cols="40" style="width: 90%"  name="introduceText" id="introduceText" placeholder="店铺简要文字介绍(20~500字)">${seller.introduceText}</textarea>
				</div>
		</div>
	</div>
	
	<br/>
	
	<div style="padding-left: 30%;padding-right: 30% ;margin-bottom: 10px">
		<input onclick="checkSeller('${seller.id}');"  class='preName btn btn-danger' type="button" value="提交">
	</div>


</form>


</body>
</html>