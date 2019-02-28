<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:import url="../../common/import3.jsp"></c:import>
<!-- /*datetime控件*/ -->


<script type="text/javascript">
	var isSub = true;
	function checkOrder() {

		if ($('#name').val().trim() == "" || $('#name').val().length <= 0) {
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

		if (phoneNum.length <= 0 || phoneNum.trim() == "") {
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
</head>
<body>
	<%-- ?goodsId=${goodsId}&sellerId=${sellerId} --%>
	<form id="myForm" action="/wx/order/save" method="post"
		enctype="multipart/form-data">
		<input type="hidden" id="sellerId" name="sellerId" value="${sellerId}">
		<input type="hidden" id="goodsId" name="goodsId" value="${goodsId}">
		
		<div>
			<input onclick="checkOrder();" class='preName btn btn-danger'
				type="button" value="下单" />
		</div>

	</form>


</body>
</html>