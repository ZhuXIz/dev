<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>资中优生活</title>
<c:import url="../../common/import.jsp"></c:import>

</head>
<body>


      </div>
      <!--       标题 -->
        <div class="panel-heading" style="color: rgba(66,255,73,0.9);padding-top: 0px">
   			联系人:${contact.phoneName }
		  </div>
      <div class="panel-heading" style="color: rgba(66,255,73,0.9);padding-top: 0px">
   			联系电话：${contact.phoneNum }
		  </div>
		   <div class="panel-heading" style="color: rgba(66,255,73,0.9);padding-top: 0px">
   			联系时间:${contact.onTime }
		  </div>
<!--      过渡 -->
      	<div class="panel panel-warning" style="height: 1px; width: 100%;"></div>
         
         
		<!-- 商品信息展示 -->
		

<c:import url="../../common/footer.jsp"></c:import> 

</body>
</html>