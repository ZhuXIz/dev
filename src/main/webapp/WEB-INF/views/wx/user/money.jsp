<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="pixel-ratio-1" style="font-size: 18px !important;">
<head>
<meta charset="UTF-8">

<title>资中优生活</title>
<c:import url="../../common/import3.jsp"></c:import>


</head>
<body class="bg_f5">
<div id="main">
<div class="wrap ht100p has_menu">
		<div class="recharge-top">
			<div class="l-flex wp pt12 mb2">
				<div class="l-iflex">
					<span></span>
				</div>
			</div>
			<div class="pt4 font12 tc">
				<p>我的余额</p>
				￥<span class="font26 l-ht36">${userInfo.money}</span>
			</div>
		</div>
	</div>
</div>	
</body>
</html>