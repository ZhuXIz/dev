<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>资中优生活</title>
<c:import url="../../common/import3.jsp"></c:import>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/show.css">
<script language="javascript">
function goGoods(url){
	window.location.href=url;
}
function cancleOrder(id){
	$.ajax({
		type: 'POST',
		async:false,
		url:"/wx/coll/remove?id="+id,
		// 如果参数为json，加上这句
		contentType:"text/json",
		// 规定反参类型为text
		dataType:"json",
		success : function(msg) {
			if (msg.code==0) {
				alert(msg.message);
				window.location.reload();
			}
		},
		error : function(msg) {
			alert(msg.message);
		}
	});
}
var commonPage=1,countPage=1;

function getColl(page){
		$.ajax({
			type: 'POST',
			async:false,
			url:"/wx/coll/get?page="+page,
			// 如果参数为json，加上这句
			contentType:"text/json",
			// 规定反参类型为text
			dataType:"json",
			success: function(msg){
				if(msg.rows.length==0){
					$('.cue').html('');
					var cueHtml="<div class='sellerText'>您还没有收藏哦！</div>";
					$('.cue').append(cueHtml);
					return false;
				}
				$('.collShow').html("");
				if(msg){
					countPage = msg.total;
					
					$.each(msg.rows,function(index,obj){
						if(obj.goods==null){
							return true;
						}
						console.log(index);
						var titleImage=obj.goods.titleImage;
						/* if(obj.goods.titleImage==null)
							titleImage=""; */
							var oldPrice=obj.goods.price;
							if(oldPrice==null||typeof(oldPrice)=='undefined')
								oldPrice="";
							else
								oldPrice="￥"+oldPrice;
						html="<a href='/wx/goods/goods?goodsId="+obj.goods.id+"' class='item'>"+
                        "<div class='lt'><div class='lt_pic'>"+
                        "<img src='${pageContext.request.contextPath}"+titleImage+"'></div> </div>"+
                     "<div class='rt'><div class='rt_tit'>"+obj.goods.titleName+"</div>"+
                         "<div class='rt_btm'> <div class='price'>"+
                         "<span class='price_now'>¥<em>"+obj.goods.price+"</em></span><span class='price_old'>"+oldPrice+"</span>"+
                            "</div><div class='btn' onclick='cancleOrder("+ obj.id+ ")'>取消收藏</div></div></div></a>";
						/* html ="<div class='MyColl' id='"+obj.id+"' onclick=goGoods('"+ obj.collAddress+ ")'>"+
						"<div class='panel-heading'>"+
						"<img class='titleImage' src='${pageContext.request.contextPath}"+titleImage+"'/>"+
						"<p class='title'>"+obj.goods.titleName+"</p>"+
						"<p class='price'>￥"+obj.goods.price+"</p>"+
						"<div class='btnCon'><input type='button' value='取消收藏'  id='orderBtn' class='btn btn-danger' onclick='cancleOrder("+ obj.id+ ")'/>"+
						"</div></div></div><div class='panel panel-warning' style='height: 1px; width: 100%;'></div>"; */
						$('.collShow').append(html);
					})
				}

			},error:function(msg){
				commonPage=1;
				var html="<div style='text-align: center; color: gray;'>查询类容为空>_<</div>";
				$('.collShow').append(html);
				
			}
		});
	//}
}


$(window).scroll(function(){
	
　　//判断是否滑动到页面底部
     if($(window).scrollTop() === $(document).height() - $(window).height()){
    	
           // TODO 滑动到底部时可请求下一页的数据并加载，加载可使用append方法
           if(commonPage<countPage){
        	   
	           //加载下一一个数据
	           commonPage++;
	           getColl(commonPage);
	           
	           if(commonPage==countPage){
	        	   $('.cue').html("");
	        	   var html="<div style='text-align: center; color: gray;'>已经到底了>_<</div>";
					$('.cue').append(html);
	           }
	           
           }
     }
});

window.onload = function (){
	getColl(commonPage);
}
</script>

</head>
<body>
<div class="myatten-tab-wrap">
    <div class="tab-shade" id="tabShade"></div>
    <div class="tab-area">
        <div class="myatten-tab">
            <!-- <div class="item"><span>上线提醒</span></div> -->
            <div class="item tab-atten" data-type="bar"><span>我的收藏</span></div>
        </div>
    </div>
</div>
    
    
<div class="myatten-content">
        <!-- <div class="content" ></div> -->
        <div class="content">
            <div class="myatten-list collShow" id="attenList">
            		
	           </div>
            <div class="weui-loadmore error" style="display: none;">
                <span class="weui-loadmore__tips">暂无内容</span>
            </div>
        </div>
    </div>

<div class="cue"></div>

</body>
</html>