<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:import url="../../common/import.jsp"></c:import>

<script type="text/javascript">
//定义该页面的名字
var pageName = 'rush';
//默认全部展示
var airUrl="/wx/goods/more";

$(function(){
	<!-- 商品分类(旅游<==>1、美食<==>2、KTV<==>3、衣服<==>4、其他生活服务<==>5) -->
	 //默认全部展示
	$.ajax({
		type: 'POST',
		async:false,
		url:airUrl,
		// 如果参数为json，加上这句
		contentType:"text/json",
		// 规定反参类型为text
		dataType:"json",
		success: function(msg){
			if (msg) {//根据返回值进行跳转
				$.each(msg,function(idx,obj){
					var html="<div id='"+obj.id+"'>"+
					"<img src='${pageContext.request.contextPath}"+obj.titleImage+"'/>"+obj.titleName+"</div><br/>";
					$('.goodsShow').append(html);
				});
			}
		},error:function(msg){
			var html="<div style='text-align: center; color: gray;'>查询类容为空>_<</div>";
			$('.goodsShow').append(html);
		}
	}); 
})


function changeType(url){
	if(airUrl !=url){
		airUrl =url;
		$('.goodsShow').html("");
		// 衣服
		$.ajax({
			type: 'POST',
			async:false,
			url:url,
			// 如果参数为json，加上这句
			contentType:"text/json",
			// 规定反参类型为text
			dataType:"json",
			success: function(msg){
				if (msg) {//根据返回值进行跳转
					$.each(msg,function(idx,obj){
						var html="<div id='"+obj.id+"'>"+
						"<img src='${pageContext.request.contextPath}"+obj.titleImage+"'/>"+obj.titleName+"</div><br/>";
						$('.goodsShow').append(html);
					});
				}
			},error:function(msg){
				var html="<div style='text-align: center; color: gray;'>查询类容为空>_<</div>";
				$('.goodsShow').append(html);
			}
		});
	}
}

<!-- 上滑刷新-->
//页面拉到最下方,加载更多评论
$(window).scroll(function(){
    if (isLoading == true) {
        if (($("body").height() - $("body").scrollTop()) <= document.documentElement.clientHeight) {
            $("#loading").show();
            messagePage++;
            getOnePageMessage(id ,messagePage);
        }
    }
});


function getOnePageMessage(id, page){
    var onePageMessageTmp;
    var messagePageCount;
    isLoading = false;
    $.ajax({
        url : "/wx/goods/moreType",
        type : "get",
        dataType: "json",
        data: {
        	typeId:
            page: page,
        },
        success : function (data) {
            if (data.code == 0){
                messagePageCount = data.result.pageCount;
                onePageMessageTmp = data.result.leaveMessages;
                if ((onePageMessageTmp.length == 0) || (messagePageCount == 1)) {       // 无数据或只有一页数据，隐藏加载提示
                    $("#loading").hide();
                }
                if (onePageMessageTmp.length != 0) {
                    addMessage(onePageMessageTmp);
                    isLoading = true;
                }
            }
            else{
                onePageMessageTmp.length = 0;
                $("#loading").hide();
            }
        }
    });
}


</script>
<title>资中优生活</title>
</head>

<body>

<!-- 商品分类(旅游<==>1、美食<==>2、KTV<==>3、衣服<==>4、其他生活服务<==>5) -->
	<ul class="pager" >
		<li role="presentation" class="active"><a class="type" id="type2" onclick="changeType('/wx/goods/moreType?typeId=2');">美食</a></li>
		<li role="presentation" ><a class="active" id="type1" onclick="changeType('/wx/goods/moreType?typeId=1');">旅游</a></li>
		<li role="presentation" ><a class="type" id="type3" onclick="changeType('/wx/goods/moreType?typeId=3')">KTV</a></li>
		<li role="presentation" ><a class="type" id="type4" onclick="changeType('/wx/goods/moreType?typeId=4')">衣服</a></li>
		<li role="presentation" ><a class="type" id="type5" onclick="changeType('/wx/goods/moreType?typeId=5')">其他生活服务</a></li>
	</ul>
<!-- 过度条 -->
		<div class="panel panel-warning" style="height: 1px; width: 100%;"></div>

		<div id="goodsShow" class="goodsShow" style=" width: 100%;">
			<div class="panel-heading" style="color: rgba(66,255,73,0.9);padding-top: 0px">
   			
		      </div>
		</div>

		<div id="loading" style="position:relative;">
            <img class="loading-gif" src="/wishDriftBottle/imgs/sourceImgs/loading_bg_transparent.gif">
            <div class="loading-text">加载中...</div>
        </div>

<c:import url="../../common/footer.jsp"></c:import> 

</body>
</html>