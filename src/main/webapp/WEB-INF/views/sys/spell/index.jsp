
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>拼团信息</title>
	
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
				<p style="text-align: center; background-color: gray; height: 25px;">温馨提示：添加拼团请到"优惠商品"界面添加！</p>
				
				<!-- <button class="btn button_btn bg-deep-gray" data-toggle='modal' type="button" onclick="javascript:initGoods()">
					<i class="iconfont"></i>&nbsp;添加拼团
				</button> -->
			</div>
           <!--列表内容-->
           <div class="page_content clearfix mb15 table-module ">
        	 <table id="table"></table>
           </div>
    </div>
  </div>
  
  <!-- 拼团信息态框 -->
<div class="modal fade" id="spellListModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
		
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
				</button>
				<h4 class="modal-title" id="spellListTitle">
					拼团详情
				</h4>
			</div>
			<script>
						$(function () {
							$('#datetimepicker3').datetimepicker({
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
							$('#datetimepicker4').datetimepicker({
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
			
			<div class="modal-body" id ='spellContent' style="padding: 50px 30% 50px 30%;align-items: center;">
				<div class="row">
					<div class="col-lg-10">
						<div class="input-group">
							开始时间:
							<div class='input-group date' id='datetimepicker3' >
					               <input type='text' name="preTimeStr" id="startTime" class="form-control" />
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
							结束时间:
							<div class='input-group date' id='datetimepicker4' >
					               <input type='text' name="preTimeStr" id="endTime" class="form-control" />
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
							<input type="text" class="form-control" id="Sprice">
						</div>
					</div>
				</div>
				<br/>
				
				
				<div class="row">
					<div class="col-lg-10">
						<div class="input-group">
							拼团人数:
							<input type="text" class="form-control" id="num">
						</div>
					</div>
				</div>
				<br/>
			</div> 
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">
					关闭
				</button>
				<button type="button" class="btn btn-primary" id="spellBtn" onclick="javascript:checkSpell(this)">
					确认
				</button>
				
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script type="text/javascript">

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
	            field : 'startTime',
	            title : '开始时间',
	            align : 'center',
	        },{
	            field : 'endTime',
	            title : '结束时间',
	            align : 'center'
	        },{
	            field : 'price',
	            title : '团购价',
	            align : 'center'
	        },{
	            field : 'num',
	            title : '人数/团',
	            align : 'center'
	        },{
	            field : 'state',
	            title : '状态',
	            align : 'center',
		            formatter: function(value, row, index) {
		            	/*	状态==1:进行中的活动
		                 * 状态==2：将要进行的活动
		                 * 状态==3：结束的活动
		                 * */
		                 if(value==1){
		                	 return "<span style='background-color:#89ff55;font-style:bold'>进行中</span>";;
		                 }else if(value==2){
		                	 return "<span style='background-color:#e1ff48;font-style:bold'>将要进行</span>";;
		                 }else{
		                	 return "<span style='background-color:#bac0ae;font-style:bold'>已结束</span>";;
		                 }
		            	
		            }
		     },{
	            field : 'seller',
	            title : '商家名',
	            align : 'center',
	            formatter: function(value, row, index) {
	            	if(value==null)
	            		return "<span style='background-color:#bac0ae;font-style:bold'>无商家信息</span>";
	            	return value.name;
	            }
			 },{
	            field : 'goods',
	            title : '商品标题',
	            align : 'center',
	            formatter: function(value, row, index) {
	            	if(value==null)
	            		return "无商品信息（该条拼团信息有误）";
	            	return value.titleName;
	            }
			 },{
	        	title: '操作',
	            align: 'center',
	            formatter: function(value, row, index) {
	               //处理格式化数据
	               var sellerId;
 	            	if(row.seller==null)
 	            		sellerId=null;
 	            	else
 	            		sellerId =row.seller.id;
	            	return '<a class="iconfont" onclick="javascript:removeSpell(\''+row.id+'\')"> </a>'+
	      			'<a class="iconfont" onclick="javascript:initSpellList('+row.goodsId+',\''+sellerId+'\','+row.id+')"> </a>';
	            }
		    }],
        url: "/wx/spell/sys/getAll",      //请求数据的地址URL
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
       },onExpandRow : function (index, row, $detail) {
       	
               onclick = row.id;
               var parentId = row.id;
               var countNum = row.num;
               var prjLogBookProblemTable = $detail.html('<table></table>').find('table');
               //var test = $detail.html('<table></table>').find('.fixed-table-toolbar');
               $(prjLogBookProblemTable).bootstrapTable({    

            	   columns: [/* {                         
                       checkbox : true,
           	        },*/{
           	            title : '拼团',
           	            align : 'center',
           	         	formatter: function(value, row, index) {
           	         		return (index+1);
           	         	}
           	        },{
           	            field : 'id',
           	            title : '参与人',
           	            align : 'center',
           	         	formatter: function(value, row, index) {
           	         		var back_str="";
	           	         	$.ajax({
	           	 			type : 'get',
	           	 			async : false,
	           	 			url : "/wx/spell/sys/group?id="+value,
	           	 			// 如果参数为json，加上这句
	           	 			contentType : "text/json",
	           	 			// 规定反参类型为text
	           	 			dataType : "json",
		           	 			success : function(msg) {
		           	 				if(msg.code==0){
		           	 					
		           	 					$.each(msg.result.list,function(idx,obj){
		           	 						if(obj == null)
		           	 							back_str += "匿名";
		           	 						else{
			           	 						if(idx<=0)
			           	 							back_str += obj.name;
			           	 						else
			           	 							back_str +="、"+obj.name;
		           	 						}
		           	 						
		           	 					})
		           	 					return back_str;
		           	 				}else{
		           	 					return "未查询到用户";
		           	 				}
		           	 			},
		           	 			error : function(msg) {
		           	 				return "错误";
		           	 			}
           	 				});
	           	         	return back_str;
           	 		
         	            }
           	        },{
           	        	field :'count',
           	            title : '状态',
           	            align : 'center',
           	            formatter:function(value,row, index){
           	            	
           	            	if(countNum == value){
           	            		return "<span style='background-color:yellow;font-style:bold'>已完成</span>";
           	            	}else if(value>countNum){
           	            		return "<span style='background-color:red;font-style:bold'>错误：拼团人数超出</span>";
           	            	}else{
           	            		return "<span style='background-color:green;font-style:bold'>未完成</span>";
           	            	}
           	            }
           	        }/*,{
           	        	title: '操作',
           	            align: 'center',
           	            formatter: function(value, row, index) {
           	               //处理格式化数据
           	            	return '<a class="iconfont" onclick="javascript:removeSpell(\''+row.id+'\')"> </a>'+
           	      			'<a class="iconfont" onclick="javascript:initSpell(\''+row.id+'\')"> </a>';
           	            }
           		    } */],
                url: "/wx/spell/sys/getItem?id="+parentId, 
                method : 'POST', //请求方式(*)
                sortable : true, //是否启用排序
                sortName : 'id',
                pagination: true,
       	        sidePagination: "server",  //分页方式：client客户端分页，server服务端分页(*)
       	        pageNumber: 1, //初始化加载第一页，默认第一页
       	        pageSize: 8,  //每页的记录行数(*)
       	        pageList: [20, 50, 100],  //可供选择的每页的行数(*)
       	        clickToSelect: true,   //是否启用点击选中行
                   sortOrder : 'asc', //排序方式                               
                   clickToSelect : true, //是否启用点击选中行
                   uniqueId : "id", //每一行的唯一标识，一般为主键列
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
       	                "total": sourceData.result.list.count,  // 总条数
       	                "rows": sourceData.result.list.rows // 返回的数据列表（后台返回一个list集合）
       	            };
       	        },queryParams : function (params) {
       	        	//console.log(params.offset);
       	            var temp = {
       	            		//id: $("input[name='id']").val(),
           	                //name: $("input[name='name']").val(),
       	                    limit : params.limit, // 每页显示数量
       	                    offset : params.offset, // SQL语句起始索引
       	                    page: (params.offset/params.limit) + 1, //当前页码
       	                };
       	                return temp;
       	        },
                   onLoadError: function(){  //加载失败时执行  
                        layer.msg("加载数据出错!", {time : 1500, icon : 5});
                   }
               });
           }, 
	 })
        
}); 
</script>

<!--拼团的CRUD  -->
<script type="text/javascript">
//删除
function removeSpell(id){
	var message= confirm("确定要删除吗？");
	if(message){
		$.ajax({
			type : 'get',
			async : false,
			url : "/wx/spell/sys/remove?id="+id,
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
//初始化拼团页面
var current_ListId;
var current_GoodsId;
var current_Spell_SellerId;
//默认未开始状态
var spell_state=2;
function setState(state){
	var state_text;
	if(state==1)
		state_text="进行中";
	else if(state==2)
		state_text="未开始";
	else
		state_text="已结束";
	$('.stateDrop').html(state_text+"<b class='caret'></b>");
	$('#state').val(state);
}
function initSpellList(goodsId,sellerId,id){
	current_GoodsId=goodsId;
	current_Spell_SellerId =sellerId;
	current_ListId = id;
	$('#spellListModel').modal('show');
	if(id!=null&&id!="null"&&typeof(id)!="undefinded"){
		$("#spellListTitle").text("修改拼团");
		$("#spellBtn").text("修改");
		//修改初始化
		$.ajax({
			type : 'post',
			async : false,
			url : "/wx/spell/sys/get?id="+id,
	        dataType:"json",
	        contentType:"application/json",
	        async: false,
	        cache:false,
			success : function(msg) {
				console.log(msg);
				if(msg){
					$("#startTime").val(msg.startTime);
					$("#endTime").val(msg.endTime);
					$("#Sprice").val(msg.price);
					$("#num").val(msg.num);
					//$("#state").val(msg.state);
					setState(msg.state);
					//添加到商品下
					current_GoodsId=msg.goods.id;
					//拿到state
					spell_state = msg.state;
					current_ListId = msg.id;
					
					if(msg.seller==null)
						current_Spell_SellerId = null;
					else
						current_Spell_SellerId=msg.seller.id;
				}
			},
			error : function(msg) {
				console.log(msg);
			}
		});
	}
}


//输入框验证
function checkSpell(obj){
	var startTime = $("#startTime").val();
	var endTime = $("#endTime").val();
	var Sprice = $("#Sprice").val();
	var num = $("#num").val();
	var state = $("#state").val();
	

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
	
	var is_pass=true;
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
				
				if(eDate<preDate){
					alert("错误：拼团结束时间小于商品开始时间");
					is_pass = false;
					return false;
				}
				if(eDate>sufDate){
					alert("错误：拼团结束时间大于商品结束时间");
					is_pass = false;
					return false;
				}
				
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
	 var data ={
		'id':current_ListId,
		'startTime':startTime,
		'endTime':endTime,
		'price':Sprice,
		'num':num,
		'state':spell_state,
		'seller':{
			'id':current_Spell_SellerId
		},
		'goods':{
			'id':current_GoodsId
		}
	};
	 if(is_pass)
		saveSpell(data);
}
function saveSpell(data){
	$.ajax({
		type : 'post',
		async : false,
		url : "/wx/spell/sys/save",
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
	$('#spellListModel').modal('hide');
	$('#table').bootstrapTable('refresh');
	
}
</script>


 </body>
</html>
