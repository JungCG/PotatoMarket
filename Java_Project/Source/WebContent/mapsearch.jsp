<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<script type="text/javascript"
   src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d74127830388b733af72f318db6754cb"></script>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
   display: flex;
    flex-direction: column;
}
.label {text-align: center;
font-weight: bold;
z-index: 12;
}
.label2 {text-align: center;
font-weight: bold;
z-index: 12;
}
.label * {display: inline-block;vertical-align: top;}
.label .left {display: inline-block;height: 26px;overflow: hidden;vertical-align: top;width: 7px;}
.label .center1 {display: inline-block;height: 26px;font-size: 17px;line-height: 26px;}
.label2 .center2 {display: inline-block;height: 26px;font-size: 13px;line-height: 26px;}
.label .right {display: inline-block;height: 26px;overflow: hidden;width: 6px;}
.textcircle{
display: flex;
    justify-content: center;
    flex-wrap: wrap;
    font-weight: bold;
}
.info {
   font-size: 12px;
   padding: 5px;
   display: flex;
   flex-direction: column;
}
.info .title {
   font-weight: bold;
}
a{
text-decoration: none;
color:black;
}
</style>
</head>
<body>
<div>
  <div style ="display:flex; justify-content: center; font-size:30px;     margin-bottom: 20px;"><a href ="ProductMainPageGetCountCtl.do" style ="color:brown">
  감자마켓 메인페이지로 이동하기 </a></div>
   <div id="map" style="width: 100%; height: 900px;">
   </div>
</div>
</body>
<script>

// 지도에 폴리곤으로 표시할 영역데이터 배열입니다 
var areas = [
    {name:'경남',
       path: new kakao.maps.LatLng(35.432917, 128.176628),
       size:25000,
       idx:28,
       value:1,
       col2:'powderblue',
       res:0,
    },
    {name:'전남',
          path: new kakao.maps.LatLng(34.868813, 126.980192),
       size:25000,
       idx:168,
       value:1,
       col2:'powderblue',
       res:0,

    },
    {name:'경북',
       size:25000,
          path: new kakao.maps.LatLng(36.377534, 128.898851),
          idx:29,
          value:1,
            col2:'powderblue',
           res:0,

    },
    {name:'충남',
       size:25000,
          path: new kakao.maps.LatLng(36.738892, 126.797291),
          idx:32,
          value:1,
         col2:'powderblue',
         res:0,

    },
    {name:'충북',
       size:25000,
          path: new kakao.maps.LatLng(37.006470, 127.693667),
          idx:33,
          value:1,
         col2:'powderblue',
         res:0,

    },
    {name:'강원',
       size:25000,
          path: new kakao.maps.LatLng(37.758513, 128.071406),
          idx:26,
          value:1,
         col2:'powderblue',
         res:0,

    },
    {name:'전북',
       size:25000,
          path: new kakao.maps.LatLng(35.730343, 127.159324),
          idx:31,
          value:1,
         col2:'powderblue',
         res:0,

    },
    {name:'경기',
       size:25000,
        value:1,
          path: new kakao.maps.LatLng(37.428343, 127.507843),
          idx:27,
            col2:'powderblue',
           res:0,

    },
   {name:'제주',
       size:25000,
       path:new kakao.maps.LatLng(33.386426, 126.512128),
       value:1,
       res:0,
       idx:34,
       col2:'powderblue',

       
    },
   //광역시---------
    {name:'부산',
       path:new kakao.maps.LatLng(35.183220, 129.021505),
       size:15000,
       col2:'peachpuff',
       value:1,
       idx:35,
      res:0,

    },
    {name:'대구',
       path:new kakao.maps.LatLng(35.837753, 128.567850),
       idx:36,
       value:1,
       size:15000,
       col2:'peachpuff',
       res:0,
    },
    {name:'인천',
       path:new kakao.maps.LatLng(37.461585, 126.705072),
       size:15000,
       col2:'peachpuff',
       value:1,
       idx:37,
      res:0,
    },
    {name:'광주',
       path:new kakao.maps.LatLng(35.157908, 126.842819),
       size:15000,
       col2:'peachpuff',
       value:1,
       idx:38,
      res:0,
    },
    {name:'대전',
       path:new kakao.maps.LatLng(36.345431, 127.387428),
       size:15000,
       col2:'peachpuff',
       value:1,
       idx:39,
      res:0,
    },
    {name:'울산',
       path:new kakao.maps.LatLng(35.555689, 129.249131),
       size:15000,
       col2:'peachpuff',
       value:1,
       idx:40,
      res:0,
       
    },
    {name:'세종',
       path:new kakao.maps.LatLng(36.553489, 127.255165),
       size:15000,
       col2:'peachpuff',
       value:1,
       idx:41,
      res:0,
    }, 
    {name:'서울',
       path:new kakao.maps.LatLng(37.552488, 126.984921),
       size:20000,
       col2:'thistle',
       value:1,
       idx:42,
      res:0,
    }, 

    //서울시 --------
    {
      name:'도봉구',
      size:1700,
      path: new kakao.maps.LatLng(37.689244, 127.046228),
    idx:10,   
    value:2,
     col2:'#569A21',
     res:0,
    
    

    },
    {
       size:1700,
      name:'용산구',
      path: new kakao.maps.LatLng(37.5311008,126.9810742),
     idx:21,
        value:2,
          col2:'#569A21',
       res:0,
    },
    {
       size:1700,
      name:'영등포구',
      path: new kakao.maps.LatLng(37.522214, 126.909788),
     idx:20, 
     value:2,
     col2:'#569A21',
     res:0,
    },
    {
       size:1700,
      name:'양천구',
      path: new kakao.maps.LatLng(37.5270616,126.8561534),
     idx:19,
     value:2,
     col2:'#569A21',
     res:0,
    },
    {
       size:1700,
      name:'송파구',
      path: new kakao.maps.LatLng(37.5048534,127.1144822),
     idx:18,
     value:2,
     col2:'#569A21',
     res:0,
    },
    {size:1700,
      name:'성동구',
      path: new kakao.maps.LatLng(37.5506753,127.0409622),
     idx:16,
     value:2,
     col2:'#569A21',
     res:0,
    },
    {size:1700,
      name:'성북구',
      path: new kakao.maps.LatLng(37.606991,127.0232185),
     idx:17,
     value:2,
     col2:'#569A21',
     res:0,
    },
    {size:1700,
      name:'서대문구',
      path: new kakao.maps.LatLng(37.5820369,126.9356665),
     idx:14,
     value:2,
     col2:'#569A21',
     res:0,
    },
    {size:1700,
      name:'서초구',
      path: new kakao.maps.LatLng(37.473841, 127.031022),
     idx:15,
     value:2,
     col2:'#569A21',
     res:0,
    },
    
    {size:1700,
      name:'노원구',
      path: new kakao.maps.LatLng(37.655264,127.0771201),
     idx:9,
     value:2,
     col2:'#569A21',
     res:0,
    },
    {size:1700,
      name:'마포구',
      path: new kakao.maps.LatLng(37.5622906,126.9087803),
     idx:13,
     value:2,
     col2:'#569A21',
     res:0,
    },
    {size:1700,
      name:'중랑구',
      path: new kakao.maps.LatLng(37.5953795,127.0939669),
     idx:25,
     value:2,
     col2:'#569A21',
     res:0,
    },
    
    {size:1700,
      name:'중구',
      path: new kakao.maps.LatLng(37.5579452,126.9941904),
     idx:24, 
     value:2,
     col2:'#569A21',
     res:0,
    },
    {size:1700,
      name:'종로구',
      path: new kakao.maps.LatLng(37.5990998,126.9861493),
     idx:23, 
     value:2,
     col2:'#569A21',
     res:0,
    },
    {size:1700,
      name:'광진구',
      path: new kakao.maps.LatLng(37.5481445,127.0857528),
     idx:6,
     value:2,
     col2:'#569A21',
   res:0,

    },
    {size:1700,
      name:'관악구',
      path: new kakao.maps.LatLng(37.4653993,126.9438071),
     idx:5,
     value:2,
     col2:'#569A21',
   res:0,

    },
    {size:1700,
      name:'구로구',
      path: new kakao.maps.LatLng(37.4954856,126.858121),
     idx:7,
     value:2,
     col2:'#569A21',
   res:0,

    },
    {size:1700,
      name:'금천구',
      path: new kakao.maps.LatLng(37.4600969,126.9001546),
     idx:8,
     value:2,
     col2:'#569A21',
   res:0,

    },
    {size:1700,
      name:'강서구',
      path: new kakao.maps.LatLng(37.5657617,126.8226561),
     idx:4,
     value:2,
     col2:'#569A21',
   res:0,

    },
    {size:1700,
      name:'강남구',
      path: new kakao.maps.LatLng(37.4959854,127.0664091),
     idx:1,
     value:2,
     col2:'#569A21',
   res:0,

    },
    {size:1700,
      name:'강동구',
      path: new kakao.maps.LatLng(37.5492077,127.1464824),
     idx:2, 
     value:2,
     col2:'#569A21',
   res:0,

    },
    {size:1700,
      name:'강북구',
      path: new kakao.maps.LatLng(37.6469954,127.0147158),
     idx:3, 
     value:2,
     col2:'#569A21',
   res:0,

    },
    
    {size:1700,
      name:'은평구',
      path: new kakao.maps.LatLng(37.6176125,126.9227004),
     idx:175,
     value:2,
     col2:'#569A21',
   res:0,

    },
    {size:1700,
      name:'동작구',
      path: new kakao.maps.LatLng(37.4965037,126.9443073),
     idx:12,
     value:2,
     col2:'#569A21',
   res:0,

    },
    {size:1700,
      name:'동대문구',
      path: new kakao.maps.LatLng(37.5838012,127.0507003),
     idx:11,
     value:2,
     col2:'#569A21',
     res:0,
    },
];
for(var i = 0; i<areas.length;i++){
   $.ajax({
      url:"ProductCountMapCtl.do",
      async:false,
      data:{l_id:areas[i].idx}, // area.idx == 상품코드입니다
      success:function(res){
      areas[i].res = res;
      }
   })
}

$.ajax({
    
    url:"ProductCountSeoulCtl.do",
    async:false,
    success:function(res1){
       areas[16].res=res1;
    }
    
    
 });

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level:12 // 지도의 확대 레벨
    };
var map = new kakao.maps.Map(mapContainer, mapOption);
var zoomControl = new kakao.maps.ZoomControl();
customOverlay = new kakao.maps.CustomOverlay({}),
infowindow = new kakao.maps.InfoWindow({removable: true});
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
for (var i = 0, len = areas.length; i < len; i++){
    displayArea(areas[i]);
         }
function displayArea(area){
	var content ="<div class ='label'><span class='left'></span><span class='center1'>"+area.name+"</span><span class='right'></span></div><div class ='label2'><span class='left'></span><span class='center2'>"+area.res+"개</span><span class='right'></span><input type ='hidden'value ='"+area.idx+"'class ='GJW-idx'</div>";
	var content1 ="<div class ='label'><span class='left'></span><span class='center1'>"+"<a href ='ProductgetSearchCountCtl.do?SearchFilter=2&SearchStr="+area.name+"'</a>"+area.name+"</span><span class='right'></span></div><div class ='label2'><span class='left'></span><span class='center2'>"+area.res+"개</span><span class='right'></span><input type ='hidden'value ='"+area.idx+"'class ='GJW-idx'</div>"	
if(area.idx == "42"){
var customOverlay = new kakao.maps.CustomOverlay({
    map: map,
    position:area.path,
    clickable: true,
    zIndex:0,
    content:content,
});
}else{
	var customOverlay = new kakao.maps.CustomOverlay({
	    map: map,
	    position:area.path,
	    clickable: true,
	    zIndex:0,
	    content:content1,
	});
}
var circle = new kakao.maps.Circle({
    center:area.path,  // 원의 중심좌표 입니다 
    radius:area.size, // 미터 단위의 원의 반지름입니다 
    strokeWeight: 5, // 선의 두께입니다 
    strokeColor:area.col2, // 선의 색깔입니다
    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
    // 선의 스타일 입니다
    fillColor:area.col2, // 채우기 색깔입니다
    fillOpacity: 0.9,  // 채우기 불투명도 입니다   
    zIndex:2,
   }); 
circle.setZIndex(3)
kakao.maps.event.addListener(circle, 'mousemove', function(mouseEvent) {
});
circle.setMap(map); 
circle.setZIndex(1);
kakao.maps.event.addListener(map, 'zoom_changed', function(){        
    
    var level = map.getLevel();
    if(level >8){
      if(area.value==1){
       customOverlay.setVisible(true)
      circle.setMap(map);
      }
      else if(area.value==2){
       customOverlay.setVisible(false)
      circle.setMap(null);
    }
    }
    if(level <=8){
      if(area.value==1){
             customOverlay.setVisible(false)
            circle.setMap(null);
      }
      else if(area.value==2){
          customOverlay.setVisible(true)
         circle.setMap(map);
      }
    };
});
    kakao.maps.event.addListener(circle,'click', function(mouseEvent) {
        var level = map.getLevel();
        if(level>=10){
               for(var i = 1; i < areas.length;i++){
           if(area.value==1){
               customOverlay.setVisible(false)
               circle.setMap(null);
              }
           }
               if(area.idx==42){
       map.setCenter(new kakao.maps.LatLng(37.537183, 127.005454))
       map.setLevel(8, {anchor: new kakao.maps.LatLng(37.575673, 126.968710)});
               }
               else{
                   location.href="ProductgetSearchCountCtl.do?SearchFilter=2&SearchStr="+area.name;
               }
        }if(level <=8){
            location.href="ProductgetSearchCountCtl.do?SearchFilter=2&SearchStr="+area.name;
        }
        	
    });
    kakao.maps.event.addListener(circle,'click', function(mouseEvent) {
        var level = map.getLevel();
    });
    kakao.maps.load(function() {
    	if(area.value==2){
           customOverlay.setVisible(false)
            circle.setMap(null);
       }
    });   
};
   $(function(){
      $(".label").click(function(mouseEvent){
           var c = $(this).text();
           var tidx = $(this).next("div").children(".GJW-idx").val(); //지역코드
           if(c=="서울"){
         map.setLevel(8,{anchor: new kakao.maps.LatLng(37.575673, 126.968710)});
           }
           else{
         location.href ="ProductgetSearchCountCtl.do?SearchFilter=2&SearchStr="+tidx;
           }
      })
   })
   $(function(){
      $(".label2").click(function(mouseEvent){
           var tidx = $(this).children(".GJW-idx").val(); //지역코드
           if(tidx=="42"){
         map.setLevel(8,{anchor: new kakao.maps.LatLng(37.575673, 126.968710)});
           }
           else{
         location.href ="ProductgetSearchCountCtl.do?SearchFilter=2&SearchStr="+tidx;
           }
      })
   })
</script>


</html>