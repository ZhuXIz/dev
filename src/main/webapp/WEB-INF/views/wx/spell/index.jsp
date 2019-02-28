<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="pixel-ratio-1" style="font-size: 18px !important;">
<head>

<title>资中优生活</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/wx/home.css" /></div>
<c:import url="../../common/import3.jsp"></c:import>

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
var currentClick;

var isAll=true;
var isMy=false;
function getAllSpell(curr,page){
	$(".typeParent").children(".active").removeClass("active");
	$('.cue').text('');
	$(curr).addClass("active");
	currentClick =curr;
	if(isAll&&!isMy){
		if(commonPage==1)
			$('.spellShow').html("");
		isAll=!isAll;
		isMy=!isMy;
		$.ajax({
			type: 'POST',
			async:false,
			url:"/wx/spell/getAll?page="+page,
			// 如果参数为json，加上这句
			contentType:"text/json",
			// 规定反参类型为text
			dataType:"json",
			success: function(msg){
				if(msg.rows.length==0){
					
					$('.cue').text("没有拼团活动！");
					return false;
				}
				$('.spellShow').html("");
				if(msg){
					countPage = msg.total;
					console.log(msg);
					$.each(msg.rows,function(index,obj){
						if(obj.goods==null){
							return true;
						}
						
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
                         "<span class='price_now'>¥<em>"+obj.price+"</em></span><span class='price_old'>"+oldPrice+"</span>"+
                            "</div><div class='btn' onclick='goGoods("+ obj.goods.id+ ")'>查看活动</div></div></div></a>";
						$('.spellShow').append(html);
					})
				}

			},error:function(msg){
				commonPage=1;
				var html="<div style='text-align: center; color: gray;'>查询类容为空>_<</div>";
				$('.spellShow').append(html);
				
			}
		});
	}
}


function getMySpell(curr,page){
	$(".typeParent").children(".active").removeClass("active");
	$(curr).addClass("active");
	$('.cue').text('');
	currentClick =curr;
	if(!isAll&&isMy){
		if(commonPage==1)
			$('.spellShow').html("");
		isAll=!isAll;
		isMy=!isMy;
		$.ajax({
			type: 'POST',
			async:false,
			url:"/wx/spell/getMySpell?page="+page,
			// 如果参数为json，加上这句
			contentType:"text/json",
			// 规定反参类型为text
			dataType:"json",
			success: function(msg){
				if(msg.rows.length==0){
					
					$('.cue').text("您还没有参加拼团哦！");
					return false;
				}
				$('.spellShow').html("");
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
	                     "<span class='price_now'>¥<em>"+obj.price+"</em></span><span class='price_old'>"+oldPrice+"</span>"+
	                        "</div><div class='btn' onclick='goGoods("+ obj.goods.id+ ")'>进入活动</div></div></div></a>";
						$('.spellShow').append(html);
					})
				}

			},error:function(msg){
				commonPage=1;
				var html="<div style='text-align: center; color: gray;'>查询类容为空>_<</div>";
				$('.spellShow').append(html);
				
			}
		});
	}
}



$(window).scroll(function(){
	
　　//判断是否滑动到页面底部
     if($(window).scrollTop() === $(document).height() - $(window).height()){
    	
           // TODO 滑动到底部时可请求下一页的数据并加载，加载可使用append方法
           if(commonPage<countPage){
        	   
	           //加载下一一个数据
	           commonPage++;
	           isAll=!isAll;
	   		   isMy=!isMy;
	   		   if(isMy&&!isAll)
	          	 getMySpell(currentClick,commonPage);
	   		   else
	   			 getAllSpell(currentClick,commonPage);
	           if(commonPage==countPage){
	        	   $('.cue').text("");
					$('.cue').text("已经到底了>_<");
	           }
	           
           }
     }
});

window.onload = function (){
	getAllSpell($('#all'),commonPage);
}
</script>

</head>
<body>
<div id="main">
	<div class="g-wrap-c" id="main">
		<div class="hd-head bottom-line" >
			<div id="ih-scroll" >
				<ul class="typeParent" style="width: 100%;">
					<li class="type-item active" id="all" onclick="getAllSpell(this,1);">所有拼团</li>
					<li class="type-item" onclick="getMySpell(this,1);">我的拼团</li>
				</ul>
			</div>
		</div>
	</div>
    
    
	<div class="myatten-content">
        <!-- <div class="content" ></div> -->
        <div class="content">
            <div class="myatten-list spellShow" id="attenList">
            		
	           </div>
            <div class="weui-loadmore error" style="display: none;">
                <div class="weui-loadmore__tips">暂无内容</div>
            </div>
        </div>
    </div>
<div class="cue" style="text-align: center; color: gray; height: 50px;"></div>
</div>
</body>
</html>