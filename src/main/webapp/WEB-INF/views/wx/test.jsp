<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html class="pixel-ratio-1" style="font-size: 18px !important;">

<head>

<c:import url="../common/import3.jsp"></c:import>
</head>
<div class="g-wrap-c" id="main">
	<div class="hd-head bottom-line">
		<div id="ih-scroll">
			<ul class="" style="width: 689px;">
				<li class="type-item active " data-id="all">全部</li>
				<li class="type-item" data-id="7">美食</li>
				<li class="type-item" data-id="9">亲子</li>
				<li class="type-item" data-id="8">娱乐</li>
				<li class="type-item" data-id="10">结婚</li>
				<li class="type-item" data-id="12">装修</li>
				<li class="type-item" data-id="11">丽人</li>
			</ul>
		</div>
	</div>
	<div class="view-box ios-scroll" id="view-box">
		<div class="h-view-item bg-white nofma mard" data-page="1">
			<div class="weui-loadmore error" style="">
				<span class="weui-loadmore__tips">暂无内容</span>
			</div>
		</div>
	</div>
</div>

</body>

</html>