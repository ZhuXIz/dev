
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>订单信息</title>
	
		<!-- 1、Jquery组件引用 -->
	    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
	 
	    <!-- 2、bootstrap组件引用 -->
	    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet">
	    
	   <!--  3、bootstrap table组件以及中文包的引用 -->
	    <script src="${pageContext.request.contextPath}/js/bootstrap-table.js"></script>
	    <link href="${pageContext.request.contextPath}/css/bootstrap-table.css" rel="stylesheet" />
	    <script src="${pageContext.request.contextPath}/js/bootstrap-table-zh-CN.js"></script>
	    
	    
	    <!-- 系统 -->
		<link href="${pageContext.request.contextPath}/font/iconfont.css" rel="stylesheet" type="text/css" />
		<!-- /*datetime控件*/ -->
	    <link href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
		<link href="${pageContext.request.contextPath}/css/bootstrap-select.min.css" rel="stylesheet">
		
	 	<script src="${pageContext.request.contextPath}/js/moment-with-locales.js"></script>
	    <script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js"></script>
	    <script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js"></script>
	    <script src="${pageContext.request.contextPath}/js/bootstrap-select.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/defaults-zh_CN.min.js"></script>
</head>


<body id="situation">
	<div class="pages-style" >

		<!--右侧内容-->
	<div class="bk-con-message message-section " id="iframe_box">
           <!--编辑内容-->
			<div class="operation  mb15">
				<br/> &nbsp;&nbsp;&nbsp;
				<p style="text-align: center; background-color: gray; height: 25px;">温馨提示：无法手动添加订单！</p>
				<!--编辑内容-->
					<div class="operation  mb15">
						<br/> &nbsp;&nbsp;&nbsp;<button class="btn button_btn" data-toggle='modal' onclick="javascript:initOrder()" type="button">
							<i class="iconfont"></i>&nbsp;添加
						</button>
					</div>
			</div>
           <!--列表内容-->
           <div class="page_content clearfix mb15 table-module ">
        	 <table id="table"></table>
           </div>
    </div>
  </div>
  
  <!-- 订单信息态框 -->
<div class="modal fade" id="orderModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
		
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
				</button>
				<h4 class="modal-title" id="orderTitle">
					订单详情
				</h4>
			</div>
			
				<script>
						$(function () {
							$('#datetimepicker1').datetimepicker({
								  format:'yyyy-mm-dd hh:00',
								  language : 'zh-CN',
								  weekStart : 1,
								  todayBtn : true,
								  autoclose : 1,
								  startView : 'year',
								  maxView:'decade',
								  minView :'day',
								  forceParse : false,
								  pickerPosition: "bottom-left"
							}); 
						 
						});
					</script>
			
			<div class="modal-body" id ='orderContent' style="padding: 50px 30% 50px 30%;align-items: center;">
				
				 <input type='hidden' id="id" class="form-control" />
				 <input type='hidden' id="isValid" class="form-control" />
				<div class="row">
					<div class="col-lg-10">
						<div class="input-group">
							下单时间:
							<div class='input-group date' id='datetimepicker1' >
					               <input type='text' id="oTime" class="form-control" />
					               <span class="input-group-addon">
					                   <span class="glyphicon glyphicon-calendar"></span>
					               </span>
					          </div>
						</div>
					</div>
				</div>
				<br/>
				<div class="row">
					<div class="col-lg-10">
						<div class="input-group">
							价格:
							<input type="text" class="form-control" id="price">
						</div>
					</div>
				</div>
				<br/>
				<div class="row">
					<div class="col-lg-10">
						<div class="input-group">
							入账金额:
							<input type="text" class="form-control" id="payPrice">
						</div>
					</div>
				</div>
				<br/>
				
				
				<div class="row">
					<div class="col-lg-10">
						<div class="input-group">
							联系电话:
							<input type="text" class="form-control" id="phoneNum">
						</div>
					</div>
				</div>
				<br/>
				<div class="row">
					<div class="col-lg-10">
						<div class="input-group">
							联系人:
							<input type="text" class="form-control" id="name">
						</div>
					</div>
				</div>
				<br/>
				<div class="row">
					<div class="col-lg-10">
						<div class="input-group">
							订单类型:
							<input type="text" class="form-control" id="type">
						</div>
					</div>
				</div>
				<br/>
				
			</div> 
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">
					关闭
				</button>
				<button type="button" class="btn btn-primary" id="orderBtn" onclick="javascript:checkOrder()">
					确认
				</button>
				
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script type="text/javascript">
function payBack(){
	alert("现不支持退款");
	return false;
	$.ajax({
		type: 'POST',
		async:false,
		url:"/wx/sys/payBack",
		// 如果参数为json，加上这句
		contentType:"text/json",
		// 规定反参类型为text
		dataType:"json",
		success: function(msg){
	      
	      //拼接&redirect_url  支付回调
		},error:function(msg){
			alert("未开通支付！");
			isPay =false;
			return false;
		}
	});
}
$(function() {
	
	 $('#table').bootstrapTable('destroy').bootstrapTable({

		columns: [/* {                         
            checkbox : true,
	        },*/{
	            field : 'id',
	            title : '自增id',
	            align : 'center',
	            visible : false, //隐藏列
	        },{
            field : 'user.id',
            title : '下单账号',
            align : 'center',
            visible : false, //隐藏列
        	},{
	            field : 'oTime',
	            title : '下单时间',
	            align : 'center',
	        },{
	            field : 'isValid',
	            title : '状态',
	            align : 'center',
	            formatter:function(value,row,index){
	            	/*订单状态
	            	 * 0==全部完成
	            	 * 1==进行中
	            	 * 2==完成未评论
	            	 * 3==被取消的（涉及金额自动退款）<---->显示退款中
	            	 * 4==拼团任务（未完成/提示申请退款）
	            	 * 5==下单未支付
	            	 * 6==订单被取消，退款完成
	            	 * 7==订单支付超时
	            	 * --*/
	            	 switch(value){
	            	 	case 0 : return "<span style='background-color:#a3e02b;font-style:bold'>完成</span>";
	            	 	case 1 : return "<span style='background-color:#bfffa3;font-style:bold'>进行中</span>";
	            	 	case 2 : return "<span style='background-color:#628453;font-style:bold'>完成未评论</span>";
	            	 	case 3 : return "<span style='background-color:#d0d2d0;font-style:bold'>取消中，待退款<br/><button class='btn' style='height:25px;' onclick='javascript:payBack(\""+row.id+"\")' type='button'>通过</button></span>";
	            	 	case 4 : return "<span style='background-color:#9cb1e3;font-style:bold'>拼团任务未完成，待退款<br/><button class='btn button_btn' style='height:25px;' onclick='javascript:payBack(\""+row.id+"\")' type='button'>通过</button></span>";
	            	 	case 5 : return "<span style='background-color:#f96489;font-style:bold'>下单未支付</span>";
	            	 	case 6 : return "<span style='background-color:#a7a7a7;font-style:bold'>已取消，退款完成</span>";
	            	 	case 7 : return "<span style='background-color:#a58181;font-style:bold'>订单支付超时</span>";
	            	 	default : return "<span style='background-color:#849ee9;font-style:bold'>无效订单</span>";
	            	 }
	            }
	        },{
	            field : 'name',
	            title : '下单人姓名',
	            align : 'center'
	        },{
	            field : 'phoneNum',
	            title : '下单人电话',
	            align : 'center'
	        },{
	            field : 'price',
	            title : '订单价格',
	            align : 'center'
	        },{
	            field : 'payPrice',
	            title : '入账金额',
	            align : 'center'
	        },{
	            field : 'goods.payType',
	            title : '订单',
	            align : 'center',
	            formatter: function(value, row, index) {
	            	if(value==1){
	            		return "<span style='background-color:#a3e02b;font-style:bold'>到店付</span>";
	            	}else{
	            		return "<span style='background-color:#e4f825;font-style:bold'>在线付</span>";
	            	}
	            }
		     },{
		            field : 'goods',
		            title : '商品名',
		            align : 'center',
		            formatter: function(value, row, index) {
		            	if(value==null){
		            		return "<p style='color:red'>未查询到商品：错误订单</p>";
		            	}else{
		            		return value.titleName;
		            	}
		            }
			},{
	            field : 'seller',
	            title : '商家名',
	            align : 'center',
	            formatter: function(value, row, index) {
	            	if(value==null)
	            		return "<p style='color:red'>无商家信息</p>";
	            	return value.name;
	            }
			 },{
		            field : 'goods.sufTime',
		            title : '有效期',
		            align : 'center'
		      },{
	        	title: '操作',
	            align: 'center',
	            formatter: function(value, row, index) {
	               //处理格式化数据
	               var sellerId,userId;
 	            	if(row.seller==null)
 	            		sellerId=null;
 	            	else
 	            		sellerId =row.seller.id;
 	            	if(row.user==null)
 	            		userId=null;
 	            	else
 	            		userId =row.user.id;
	            	return '<a class="iconfont" onclick="javascript:removeOrder(\''+row.id+'\')"> </a>'+
	      			'<a class="iconfont" onclick="javascript:initOrder('+row.goodsId+',\''+sellerId+'\',\''+userId+'\','+row.id+')"> </a>';
	            }
		    }],
        url: "/wx/order/sys/getAll",      //请求数据的地址URL
        method: 'post',  //请求方式(*)
        striped: true,  //是否显示行间隔色
        cache: false,  //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性(*)
        pagination: true,
        sortable: true,  //是否启用排序
        sortOrder: "desc", //排序方式
        sidePagination: "server",  //分页方式：client客户端分页，server服务端分页(*)
        pageNumber: 1, //初始化加载第一页，默认第一页
        pageSize: 8,  //每页的记录行数(*)
        pageList: [20, 50, 100],  //可供选择的每页的行数(*)
        showColumns: false,  //是否显示所有的列
        showRefresh: false,  //是否显示刷新按钮
        minimumCountColumns: 2,  //最少允许的列数
        clickToSelect: true,   //是否启用点击选中行
        height: 700,
        detailView: true,  //是否显示父子表    *关键位置*
        queryParamsType: "limit",
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        checkboxHeader: true,
        search: false,
        singleSelect: true,
        striped: true,
        showColumns: true,  // 开启自定义列显示功能
        responseHandler: function responseHandler(sourceData) {
            //这里要做分页，所以对返回的数据进行了处理
            return {
                "total": sourceData.count,  // 总条数
                "rows": sourceData.rows // 返回的数据列表（后台返回一个list集合）
            };
        },queryParams : function (params) {
        	//console.log(params.offset);
            var temp = {
                    limit : params.limit, // 每页显示数量
                    offset : params.offset, // SQL语句起始索引
                    page: (params.offset / params.limit) + 1,//当前页码
                };
                return temp;
       }
	 })
        
}); 
</script>

<!--拼团的CRUD  -->
<script type="text/javascript">
//删除
function removeOrder(id){
	var message= confirm("确定要删除吗？");
	if(message){
		$.ajax({
			type : 'get',
			async : false,
			url : "/wx/order/sys/remove?id="+id,
			// 如果参数为json，加上这句
			contentType : "text/json",
			// 规定反参类型为text
			dataType : "json",
			success : function(msg) {
				if(msg.code==0){
					alert(msg.message);
					$('#table').bootstrapTable('refresh');
				}else{
					console.log("删除失败");
				}
			},
			error : function(msg) {
				
				console.log("删除失败");
			}
		});
		
	}
}

var curr_goods_id,curr_seller_id,curr_user_id,curr_id;
function initOrder(goodsId,sellerId,userId,id){
	$('#orderModel').modal('show');
	
	if(id!=null&&id!="null"&&typeof(id)!="undefinded"){
		$("#orderTitle").text("修改订单");
		$("#orderBtn").text("修改");
		//修改初始化
		$.ajax({
			type : 'post',
			async : false,
			url : "/wx/order/sys/get?id="+id,
	        dataType:"json",
	        contentType:"application/json",
	        async: false,
	        cache:false,
			success : function(msg) {
				if(msg){
					console.log("order:"+msg.goods);
					curr_id =msg.id;
					if(msg.goods != null)
						curr_goods_id = msg.goods.id;
					if(msg.seller != null)
						curr_seller_id = msg.seller.id;
					if(msg.user != null)
						curr_user_id = msg.user.id;
					
					$("#name").val(msg.name);
					$("#oTime").val(msg.oTime);
					$("#isValid").val(msg.isValid);
					$("#phoneNum").val(msg.phoneNum);
					$("#price").val(msg.price);
					$("#payPrice").val(msg.payPrice);
					$("#type").val(msg.type);
					
				}
			},
			error : function(msg) {
				alert("错误：获取失败");
				return false;
			}
		});
	}else{
		//添加
		$("#orderTitle").text("添加订单");
		$("#orderBtn").text("添加");
		$("#name").val("");
		$("#oTime").val("");
		$("#isValid").val("");
		$("#phoneNum").val("");
		$("#price").val("");
		$("#payPrice").val("");
		$("#type").val("");
	}
}


//输入框验证
function checkOrder(){
	if(curr_id==null||typeof(curr_id)=="undefined"){
		alert("暂不支持订单的添加！");
		return false;
	}
		
	var name = $("#name").val();
	var oTime = $("#oTime").val();
	var isValid = $("#isValid").val();
	var phoneNum = $("#phoneNum").val();
	var price = $("#price").val();
	var payPrice = $("#payPrice").val();
	var type = $("#type").val();
	
	
	if (!/^\d+(\.\d+)?$/.test(parseFloat(price))) {
		alert("价格应为数字,且不为负数！");
		return false;
	}
	if (!/^\d+(\.\d+)?$/.test(parseFloat(payPrice))) {
		alert("入账金额应为数字,且不为负数！");
		return false;
	}
	if (typeof(price)=="undefined"||price.trim().length<=0) {
		alert("请填写价格");
		return false;
	}
	if (typeof(payPrice)=="undefined"||payPrice.trim().length<=0) {
		alert("请填写入账金额！");
		return false;
	}
	if (typeof(phoneNum)=="undefined"||phoneNum.trim().length<=0) {
		alert("请填写下单人联系电话！");
		return false;
	}
	 
	if (typeof(oTime)=="undefined"||oTime.trim().length<=0) {
		alert("请填写下单时间！");
		return false;
	}
	 
	if (typeof(name)=="undefined"||name.trim().length<=0) {
		alert("请填写下单人！");
		return false;
	}
	 
	if (typeof(payPrice)=="undefined"||payPrice.trim().length<=0) {
		alert("请填写入账金额！");
		return false;
	}
	 
	if(phoneNum && !/^((0\d{2,3}-?\d{7,8})|(1[35784]\d{9}))$/.test(phoneNum)){
		 alert("不支持的手机格式"); 
		 return false;
	} 
	/* 
	if(startTime.trim().length<=0){
		alert("请输入开始时间");
		return false;
	}
	if(endTime.trim().length<=0){
		alert("请输入结束时间");
		return false;
	}

	var sDate = new Date(startTime.replace(/\-/g, "\/"));
	var eDate = new Date(endTime.replace(/\-/g, "\/"));
	if(sDate >= eDate){
		alert("结束日期不能小于或等于开始日期");
		return false;
	}
	
	
	if(typeof(Sprice)=="undefined"||Sprice.trim().length<=0){	
		alert("请填写拼团价格！");
		return false;
	} 
	if(typeof(Sprice)=="undefined"||Sprice.trim().length<=0){	
		alert("请填写拼团人数！");
		return false;
	} 
	
	if (!/^\d+$/.test(num)) {
		alert("拼团人数应为非负整数");
		return false;
	}
	
	
	if (!/^\d+(\.\d+)?$/.test(parseFloat(Sprice))) {
		alert("价格应为数字,且不为负数！");
		return false;
	}
	 */
	 
	/* var is_pass=true;
	$.ajax({
		type : 'post',
		async : false,
		url : "/wx/goods/sys/getTime?goodsId="+current_GoodsId,
        dataType:"json",
        contentType:"application/json",
        async: false,
        cache:false,
		success : function(msg) {
			if(msg.code==0){
				
				var preDate = new Date(msg.result.goods.preTime.replace(/\-/g, "\/"));
				var sufDate = new Date(msg.result.goods.sufTime.replace(/\-/g, "\/"));
				
				if(sDate>sufDate){
					alert("错误：拼团开始时间大于商品结束时间");
					is_pass = false;
					return false;
				}
				if(sDate<preDate){
					alert("错误：拼团开始时间小于商品结束时间");
					is_pass = false;
					return false;
				}
			}
		},
		error : function(msg) {
			console.log(msg);
		}
	});
	
	//alert(address);
	
	 if(is_pass) */
	 var data ={
		'id':curr_id,
		'name':name,
		'oTime':oTime,
		'isValid':isValid,
		'phoneNum':phoneNum,
		'price':price,
		'payPrice':payPrice,
		'type':type,
		'seller':{
			'id':curr_seller_id
		},
		'goods':{
			'id':curr_goods_id
		},
		'user':{
			'id':curr_user_id
		}
	};
	 console.log(data);
	saveOrder(data);
}
function saveOrder(data){
	$.ajax({
		type : 'post',
		async : false,
		url : "/wx/order/sys/save",
		data: JSON.stringify(data),//必要
        dataType:"json",
        contentType:"application/json",
        async: false,
        cache:false,
		success : function(msg) {
			console.log(msg);
			if(msg.code==0){
				alert(msg.message);
				
			}else{
				alert(msg.message);
			}
		},
		error : function(msg) {
			console.log(msg);
			alert("添加失败");
		}
	}); 
	$('#orderModel').modal('hide');
	$('#table').bootstrapTable('refresh');
	
}
</script>


 </body>
</html>
