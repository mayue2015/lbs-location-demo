<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 <head>
   <meta http-equiv="Content-Type" content="text/html; charset=utf8" />
   <title>系统</title>
   <style type="text/css">
   #submit {
		cursor: pointer;
		width: 271px;
		height: 47px;
		margin: 33px auto 0px auto;
		font-size: 14px;
		background-color: rgb(235,40,40);
		color: #fff;
		line-height: 47px;
		border: 0px;
	}
	#showmap {
		cursor: pointer;
		width: 271px;
		height: 47px;
		margin: 33px auto 0px auto;
		font-size: 14px;
		background-color: rgb(235,40,40);
		color: #fff;
		line-height: 47px;
		border: 0px;
	}
   </style>
 </head>

<script type="text/javascript" src="/lib/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="/lib/purl.js"></script>
<script type="text/javascript">

$(function() {
    var id = $.url().param("restaurantId");
    $("#restaurantId").val(id);
    $.getJSON("/restaurants?id=" + id, function(data) {
           $("#location").val(data[0].location);
    });



});

function dl(){
	if( form1.location.value==""){
		alert("请您填写位置坐标!");
		return false;
	}
}
function showAll(){
	window.location.href="location?all=true";
}

function show(id){
	window.location.href="location?restaurantId=" + id;
}

</script>

<body bgcolor="">
<table >
  <tr>
    <td height="100%" background="">
     <table width="1342"  align="center">
      <tr>
        <form action="/location" name="form1" method="post" onSubmit="return dl()" >
         <table width="100%" >
          <tr>
          	  <p align="center">
                <span class="STYLE3" align="center">&nbsp;餐馆ID：</span>
                <input type="text" id="restaurantId" name="restaurantId" style="width:200px;height:40px;"
                readonly="true">
              </p>
              <p align="center">
                <span class="STYLE3" align="center">位置坐标：</span>
                <input type="text" name="location" id="location" style="width:200px;height:40px;" >
              </p>

              <p align="center">
                  <a target="_blank" href="http://api.map.baidu.com/lbsapi/getpoint/">百度坐标拾取</a>
                </p>

           
           <td height="247" valign="top">
           <table width="100%" border="0" cellspacing="0" cellpadding="0">
           <tr>
              <td width="22%" height="30">&nbsp;</td>
              <td width="56%">　　　　　　　　　　　　　　　　
	              <input id="submit" type="submit" name="Submit"  align="center" value="提交" />　
              </td>
              <td width="22%">&nbsp;</td>
          </tr> 
          
          <tr>
              <td width="22%" height="30">&nbsp;</td>
              <td width="56%">　　　　　　　　　　　　　　　　
	              <input id="submit" name="Reset" type="Reset" align="center" value="重 置" />
              </td>
              <td width="22%">&nbsp;</td>
          </tr> 
          
          <tr>
          	  <td width="22%" height="30">&nbsp;</td>
          	  <td width="56%">　　　　　　　　　　　　　　　　
	              <input id="showmap" type="button" name="Submit"  align="center" value="查看所有地图位置" onclick="showAll()"
	               />　
              </td>
              <td width="22%">&nbsp;</td>
          </tr>    
          </table>
          </td>
          
         </tr>
        </table>
       </td>
      </tr>
    </table>
    </td>
  </tr>
</table>
</body>
</html>
