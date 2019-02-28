<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:import url="../../common/import.jsp"></c:import>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/show.css">
<script type="text/javascript">
function update(){
	alert("页面开发中");
	//$('.phone').val();
}
</script>


<title>手机绑定</title>
</head>

<body>
<div>
手机:<input class="phone" type="text" value="${phone}">
	<c:if test="${phone==''||phone==null}">
		<input type="button" value="确认绑定"  onclick="update()">
	</c:if>
	<c:if test="${phone!=''||phone!=null}">
		<input type="button" value="修改"  onclick="update()">
	</c:if>
</div>


</body>
</html>