<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
</style>
<title>根据中心点关键字周边搜索</title>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=1507703fda1fb9594c7e7199da8c41d8"></script>
<script type="text/javascript" src="/lib/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="/lib/purl.js"></script>
</head>
<body>
<div id="allmap"></div>
</body>
</html>

<script type="text/javascript">
$(function(){
    var all = $.url().param("all");
    var id = $.url().param("restaurantId");

    var url = "";
    if(all) {
         url = "/restaurants/all";
    } else if(id) {
         url = "/restaurants?restaurantId=" + id;
    } else {
         url = "/restaurants";
    }
    if(url) {
	$.ajax({
	     type: "GET",
	     url: url,
         contentType: "application/json; charset=utf-8",
         dataType: "json",
	     async: false,
	     success: function(data){
	     		// 百度地图API功能
			    // 创建Map实例
	     		var map = new BMap.Map("allmap");
	            $.each(data, function(index,element){
	                var loc_arr = [];

	                if(data[index].location) {
                        loc_arr = data[index].location.split(",");
                        var lon = loc_arr[0];
                        var lat = loc_arr[1];
                        var name = data[index].name;
                        var address = data[index].address;

                        var point = new BMap.Point(lon,lat);
                        map.centerAndZoom(point, 13);
                        map.addControl(new BMap.NavigationControl());
                        var marker = new BMap.Marker(point); // 创建标注
                        map.addOverlay(marker);
                        
                        //直接显示位置信息
                        /* var opts = {
                              position : point,    // 指定文本标注所在的地理位置
                              offset   : new BMap.Size(30, -30)    //设置文本偏移量
                            }
                        var label = new BMap.Label(name + " " + address, opts);  // 创建文本标注对象
                            label.setStyle({
                                 color : "red",
                                 fontSize : "12px",
                                 height : "20px",
                                 lineHeight : "20px",
                                 fontFamily:"微软雅黑"
                             });
                        map.addOverlay(label);
                            
                        var local = new BMap.LocalSearch(map, {
                          renderOptions:{map: map, autoViewport:true}
                        }); */
                        
                        //单击坐标点弹窗显示weiz
                        var opts = {
						  width : 200,// 信息窗口宽度
						  height: 80,// 信息窗口高度
						  title : name,// 信息窗口标题
						  enableMessage:false,//设置允许信息窗发送短息
						  message:"亲耐滴，晚上一起吃个饭吧？戳下面的链接看下地址喔~"
						}

						var infoWindow = new BMap.InfoWindow("地址：" + address, opts);  // 创建信息窗口对象 

						marker.addEventListener("click", function(){          
							map.openInfoWindow(infoWindow,point); //开启信息窗口
						});

                        var removeMarker = function(e,ee,marker){
                            map.removeOverlay(marker);
                        }

                        //创建右键菜单
                        var markerMenu = new BMap.ContextMenu();
                        markerMenu.addItem(new BMap.MenuItem('删除标记',removeMarker.bind(marker)));

                        marker.addContextMenu(markerMenu);

                        // 定义一个控件类,即function
                        function ZoomControl(){
                          // 默认停靠位置和偏移量
                          this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
                          this.defaultOffset = new BMap.Size(50, 10);
                        }

                        // 通过JavaScript的prototype属性继承于BMap.Control
                        ZoomControl.prototype = new BMap.Control();

                        // 自定义控件必须实现自己的initialize方法,并且将控件的DOM元素返回
                        // 在本方法中创建个div元素作为控件的容器,并将其添加到地图容器中
                        ZoomControl.prototype.initialize = function(map){
                          // 创建一个DOM元素
                          var div = document.createElement("div");
                          // 添加文字说明
                          div.appendChild(document.createTextNode("添加标记"));
                          // 设置样式
                          div.style.cursor = "pointer";
                          div.style.border = "1px solid gray";
                          div.style.backgroundColor = "white";
                          // 绑定事件,点击一次放大两级
                          div.onclick = function(e){
                            var marker = new BMap.Marker(point); // 创建标注
                            map.addOverlay(marker);
                          }
                          // 添加DOM元素到地图中
                          map.getContainer().appendChild(div);
                          // 将DOM元素返回
                          return div;
                        }
                        // 创建控件
                        var myZoomCtrl = new ZoomControl();
                        // 添加到地图当中
                        map.addControl(myZoomCtrl);
                    }
	            });
        }
    });
}
});
</script>
