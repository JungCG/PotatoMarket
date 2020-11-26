
<link rel ="stylesheet" href = "css/GJW-avgchart.css">
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.5.1.slim.js"
   integrity="s-ha256-DrT5NfxfbHvMHux31Lkhxg42LY6of8TaYyK50jnxRnM="
   crossorigin="anonymous"></script>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
   src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"></script>
<title>Document</title>
<style type="text/css">
#myChart {
   padding: 2vw;
   padding-right: 20vw;
    padding-left: 20vw;
}
a{
text-decoration: none;
}
a:hover{
text-decoration: none;

}
</style>
</head>
<body id="cvs">
   <section>
      <div id="GJW-titlewrap">
         <h1 class="hhh"><a href ="MainPage.jsp">감자마켓 </a>시세조회</h1>
      </div>
      <div class="GJW-searchwrap">
         <input type="text" placeholder="Search..." id="searchbox_box" name="searchbox_box" class="GJW-searchbox" required="required">
         <button id="send_btn" name="send_btn" class="search"></button>
         <span class="xxx"></span>
      </div>
      <!-- <div class="GJW-searchwrap">
         <input type="text" placeholder="Search..." id="searchbox_box" name="searchbox_box" class="GJW-searchbox" required="required">
         <button id="send_btn" name="send_btn" class="search">Search</button>
         <div class="search"></div>
      </div> -->
      <!-- div class="GJW-searchwrap">
         <input type="text" id="searchbox_box" name="searchbox_box"
            class="GJW-searchbox" placeholder="검색어를 입력해주세요" required="required" />
         <button id="send_btn" name="send_btn" class="search">Search</button>
      </div> -->
      <div id="GJW-resulttext">

         <span id="result"></span>
      </div>

      <div class="searchbox">
         <div class="searchbox_wrap"></div>
      </div>
      <div>
         <div id="chartwrap">
            <canvas id="myChart" width="400" height="400"></canvas>
         </div>
      </div>

   </section>
   <script>
      $("#send_btn")
            .on(
                  "click",
                  function() {
                     var search = $("#searchbox_box").val();
                     $
                           .ajax({
                              url : "ProductSearchCtl.do",
                              data : {
                                 searchbox_box : search
                              },
                              success : function(res) {
                                 if (res != 0) {
                                    $
                                          .ajax({
                                             url : "ProductSelectAVGCtl.do",
                                             data : {
                                                searchbox_box : search
                                             },
                                             dataType : "json",
                                             //console.log(search),
                                             success : function(
                                                   obj) {
                                                $('#myChart')
                                                      .remove();
                                                $(
                                                      '.searchbox_wrap')
                                                      .append(
                                                            '<canvas id="myChart"><canvas>');
                                                $("#result")
                                                      .html(
                                                            "");
                                                var ctx = document
                                                      .getElementById(
                                                            'myChart')
                                                      .getContext(
                                                            '2d');
                                                console
                                                      .log(ctx);
                                                var myChart = new Chart(
                                                      ctx,
                                                      {
                                                         type : 'line',
                                                         data : {
                                                            labels : [
                                                                  '2020.08',
                                                                  '2020.09',
                                                                  '2020.10',
                                                                  '2020.11' ],
                                                            datasets : [ {

                                                               label : '검색 결과',
                                                               data : [
                                                                     obj.avg8,
                                                                     obj.avg9,
                                                                     obj.avg10,
                                                                     obj.avg11 ],
                                                               backgroundColor : [
                                                                     'rgba(255, 159, 64, 0.4)',
                                                                     'rgba(255, 99, 132, 0.4)',
                                                                     'rgba(225, 206, 86, 0.4)',
                                                                     'rgba(75, 192, 192, 0.4)',

                                                               ],
                                                               borderColor : [
                                                                     'rgba(255, 159, 64, 0.4)',
                                                                     'rgba(255, 99, 132, 0.4)',
                                                                     'rgba(255, 206, 86, 0.4)',
                                                                     'rgba(75, 192, 192, 0.4)', ],
                                                               borderWidth : 1,
                                                               fontSize : 30,
                                                            } ]
                                                         },
                                                         options : {
                                                            title : {

                                                               display : true,
                                                               text : search
                                                                     + '로 검색한 최근 4개월간의 시세입니다',
                                                               fontSize : 40,

                                                            },
                                                            legend : {
                                                               labels : {
                                                                  fontColor : "#BB1F00",
                                                                  fontSize : 24
                                                               }
                                                            },

                                                            scales : {
                                                               yAxes : [ {
                                                                  ticks : {
                                                                     /* beginAtZero : true */
                                                                     fontColor : 'rgba(124, 124, 24, 1)',
                                                                     fontSize : 30
                                                                  },
                                                                  gridLines : {
                                                                     color : "rgba(199, 182, 232, 1)",
                                                                     lineWidth : 2
                                                                  },
                                                            
                                                               } ],
                                                            xAxes : [ {
                                                               ticks : {
                                                                  /* beginAtZero : true */
                                                                  fontColor : 'rgba(175, 165, 35, 1)',
                                                                  fontSize : 40
                                                               },
                                                               gridLines : {
                                                                  color : "rgba(199, 182, 232, 1)",
                                                                  lineWidth : 2
                                                               },
                                                         
                                                            } ]
                                                            }
                                                         }
                                                      });
                                             },
                                          });
                                 } else {
                                    alert("검색결과가 없습니다");
                                    $('#myChart').remove();
                                    $('#result')
                                          .html(
                                                "검색결과가 없습니다. 검색어를 다시 입력해주세요");
                                 }
                              }
                           })
                  });
   </script>
</body>
</html>
