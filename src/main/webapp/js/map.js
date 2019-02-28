var geocoder, map, marker = null;
var init = function() {
    var center = new qq.maps.LatLng(39.916527, 116.397128);
    map = new qq.maps.Map(document.getElementById('container'), {
        center: center,
        zoom: 15,
    });
 
    //地址和经纬度之间进行转换服务
    geocoder = new qq.maps.Geocoder({
        //设置服务请求成功的回调函数
        complete: function(result) {
            map.setCenter(result.detail.location);
            var marker = new qq.maps.Marker({
                map: map,
                position: result.detail.location
            });
            //点击Marker会弹出反查结果
            qq.maps.event.addListener(marker, 'click', function() {
                alert("坐标地址为： " + result.detail.location);
            });
        },
        //若服务请求失败，则运行以下函数
        error: function() {
            alert("出错了，请输入正确的经纬度！！！");
        }
    });
 
 
}
 
function codeAddress() {
    var address = document.getElementById("address").value;
    //对指定地址进行解析
    geocoder.getLocation(address);
}

//可拖动的地图
var init = function() {
    var center = new qq.maps.LatLng(29.916527,104.397128);
    var map = new qq.maps.Map(document.getElementById('container'),{
        center: center,
        zoom: 13
    });
    var marker = new qq.maps.Marker({
        position: center,
        draggable: true,
        map: map
    });
}
