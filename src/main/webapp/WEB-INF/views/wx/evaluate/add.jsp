<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<c:import url="../../common/import.jsp"></c:import>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/show.css">

<!-- /*datetime控件*/ -->


<script type="text/javascript">
/* if(window.history && window.history.pushState) {
	$(window).on('popstate', function() {
		var hashLocation = location.hash;
		var hashSplit = hashLocation.split("#!/");
		var hashName = hashSplit[1];
		if(hashName !== '') {
			var hash = window.location.hash;
			if(hash === '') {
				history.go(-2); 
				window.location.replace("/wx/user/index"); 
			}
		}
	});
	window.history.pushState('forward', null, './#forward');
} */
function checkEva(){

	if($('#message').val().trim()==""||$('#message').val().length<=0){
		alert("请填写您的评论！"); 
		return false;
	}
	

	var goodsId = $('#goodsId').val();

	$.ajax({
		type : 'get',
		async : true,
		url : "/wx/evaluate/check?goodsId="+goodsId,
		// 如果参数为json，加上这句
		contentType : "text/json",
		// 规定反参类型为text
		dataType : "json",
		success : function(msg) {
			if(msg.code==0){
				if(msg.result.state==false){
					alert("不能重复提交！");
					return false;
				}
				$('#myForm').submit();	
			}
		},
		error : function(msg) {
			
			alert("请刷新页面");
			return false;
		}
	});
	
	

}
</script>
</head>
<body>

<form id="myForm" action="/wx/evaluate/save" method="post" enctype="multipart/form-data" >
	
	<input type="hidden" id="goodsId" name="goodsId" value="${goodsId}">
	<input type="hidden" id="orderId" name="orderId" value="${orderId}">
	<div class="preName2">
			<span>评论</span>
	</div>
	<div class="inputCom">
		<div class="col-sm-10">
		<div class="inputCom">
			<textarea rows="8" cols="40"  name="message" id="message" placeholder="请输入您的真实评价"></textarea>
		</div>

	   	</div>
	</div>

	<div>
		<input onclick="checkEva();"  class='preName btn btn-danger' type="button" value="评论"/>
	</div>
	
</form>


</body>
</html>