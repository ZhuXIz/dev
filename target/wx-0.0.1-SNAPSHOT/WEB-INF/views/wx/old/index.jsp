<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>资中优生活</title>


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/show.css">
<c:import  url="../common/import.jsp"></c:import>

<script language="javascript">
	//定义该页面的名字
	var pageName = 'home';
	window.onload = function() {
		$.ajax({
			type : 'get',
			async : false,
			url : "/wx/goods/show",
			// 如果参数为json，加上这句
			contentType : "text/json",
			// 规定反参类型为text
			dataType : "json",
			success : function(msg) {
				var oldPrice;
				var titleName;
				if (msg) {
					$.each(msg,function(idx, obj) {
						if(obj.id==null)
							return true;
					titleName = obj.titleName;
					if(titleName!=null&&titleName.length>=18){
						titleName = titleName.substring(0,17)+".....";
					}
					
					var html;
					var titleHtml="";
					if(obj.isValid==true){
						titleHtml="<div onclick='getGoods(this)' class='goodsShowLeft' id='"+ obj.id+ "'>"+
						"<div class='panel-heading'>"+
						"<div class='cueImage'>"+
						"<img id ='cueImage' src='${pageContext.request.contextPath}/icons/ing.png' /></div>";
					}else{
						titleHtml="<div onclick='getGoods(this)' class='goodsShowLeft' id='"+ obj.id+ "'>"+
						"<div class='panel-heading'>"+
						"<div class='cueImage'>"+
						"<img id ='cueImage' src='${pageContext.request.contextPath}/icons/over.png' /></div>";
					}
	
					if(idx%2==0){
						html = titleHtml+
						"<img class='titleImage' src='${pageContext.request.contextPath}"+obj.titleImage+"'/>"+
						"<span class='title'>"+titleName+"</span>"+
						"<span class='priceCue' style='color:red;font-style:italic;float: right;font-size:20px;font-weight:bold;'>￥"+obj.price+
						"</span></div></div>";
					}else{
						html = titleHtml+
							"<img class='titleImage' src='${pageContext.request.contextPath}"+obj.titleImage+"'/>"+
							"<span class='title'>"+titleName+"</span>"+
							"<span class='priceCue' style='color:red;font-style:italic;float: right;font-size:20px;font-weight:bold;'>￥"+obj.price+
							"</span></div></div>";
						
					}
			
						$('.goodsShow').append(html);
					});
				}
			},
			error : function(msg) {
				alert("网站维护，请稍后再试！");
				console.log(msg);
			}
		});
	}
	
	

	function getGoods(goods) {
		window.location.href = "/wx/goods/goods?goodsId=" + goods.id;
	}
</script>
</head>

<body>

	
	
	<!-- 轮播图  320*240 -->
	<div id="carousel-example-generic" class="carousel slide"
		data-ride="carousel" data-interval="3000">

		<!-- Wrapper for slides -->
		<div class="carousel-inner" style="text-align: center">
		<c:if test="${ advertList==null||advertList.size()==0}">
			<div class="item active">
				<img style="width: 100%" src="${pageContext.request.contextPath}/upload/imgs/advert/eat.jpg" />
			</div>
			<div class="item">
				<img style="width: 100%" src="${pageContext.request.contextPath}/upload/imgs/advert/drink.jpg" />
			</div>
			<div class="item">
				<img style="width: 100%" src="${pageContext.request.contextPath}/upload/imgs/advert/play.jpg" />
			</div>
			<div class="item">
				<img style="width: 100%" src="${pageContext.request.contextPath}/upload/imgs/advert/happy.jpg" />
			</div>
		</c:if>
		
		<c:if test="${ advertList!=null&&advertList.size()!=0}">
			<c:forEach items="${ advertList}" var="advert"
				varStatus="advertStatu">
				<c:if test="${advertStatu.index==0 }">
					<div class="item active">
						<img style="width: 100%"
						src="${pageContext.request.contextPath}${advert.img}" />
					</div>
				</c:if>
				<c:if test="${advertStatu.index!=0 }">
					<div class="item">
						<img style="width: 100%"
						src="${pageContext.request.contextPath}${advert.img}" />
					</div>
				</c:if>
				
			</c:forEach>
		</c:if>
			


	</div>

	<!-- Controls -->
	<!--     <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left"><</span>
      </a>
      <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right">></span>
      </a>
  -->
	</div>

	<!-- 过度条 -->
	<div class="panel panel-warning" style="height: 1px; width: 100%;"></div>


	<!-- 商品展示 -->

	<div class="panel-heading"
		style="color: rgba(66, 255, 73, 0.9); padding-top: 0px">
		今日推荐<img style="max-width: 30px;"
					src="${pageContext.request.contextPath}/icons/zhekou.png" />
		
	</div>

	<div class="goodsShow" style="height: 750px;">
		
	</div>


	<c:import url="../common/footer.jsp"></c:import>





</body>


</html>