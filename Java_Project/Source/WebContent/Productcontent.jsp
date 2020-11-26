   <%-- <%@page import="service.product.ProductService"%> --%>
<link rel = "stylesheet" href = "css/bootstrap.css">
<link rel = "stylesheet" href = "css/custom.css">
<link rel = "stylesheet" href = "css/jck_nav3.css">
<link rel = "stylesheet" href = "css/ICR_ProductContent.css">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.util.List"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
      String userID = null;
      if(session.getAttribute("userID") != null){
         userID = (String) session.getAttribute("userID");
      }
   %>
   <%
       String ctx = request.getContextPath();
       String ctxPath = request.getContextPath();
    %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

   <link rel="shortcut icon" href="./favicon/favicon.ico" type="image/x-icon">
   <link rel="apple-touch-icon" sizes="180x180" href="./favicon/apple-touch-icon.png">
   <link rel="icon" type="image/png" sizes="32x32" href="./favicon/favicon-32x32.png">
   <link rel="icon" type="image/png" sizes="16x16" href="./favicon/favicon-16x16.png">
   <link rel="manifest" href="./favicon/site.webmanifest">
   <link rel="mask-icon" href="./favicon/safari-pinned-tab.svg" color="#5bbad5">
   <meta name="msapplication-TileColor" content="#da532c">
   <meta name="theme-color" content="#ffffff">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   <script src = "js/bootstrap.js"></script>
    <title>감자 마켓</title>



<script type="text/javascript">
      function getUnread(){
         $.ajax({
            type:"POST",
            url : "./ChatUnreadServlet",
            data : {
               userID : '<%=userID%>'
            },
            success : function(result){
               if(result >= 1){
                  showUnread(result);
               }else{
                  showUnread('');
               }
            }
         });
      }
      
      function getInfiniteUnread(){
         setInterval(function(){
            getUnread();
         }, 4000);
      }
      
      function showUnread(result){
         $('#unread').html(result);
      }
      
      
   </script>
   <style type="text/css">
      #YJH_main{
         text-align : center;
      }
      #YJH__detail{
         text-align : center;
      }
      
      @media only screen and (max-width:1505px){
            #YJH_item_main_info,#YJH_item_detail,#YJH_other_item{
                display:block;
            }
   </style>
</head>
<body>
      <div class = "jck_everything">
        <div class = "jck_menu_container">
            <div class = "jck_menu_item jck_menu_item1">
                <button class = "jck_menu1_item jck_menu1_item1" id="jck_myBtn"><img src = "./images/menu.png"></button>
                <button class = "jck_menu1_item jck_menu1_item2" id = "jck_mainpage_btn1">
                    <a href="MainPage.jsp"><img src = "./images/logo_img.png"></a>
                </button>
            </div>
            <div class = "jck_menu_item jck_menu_item2">
                   <select name ="SearchFilter" id = "SearchFilter" class = "menu jck_display_none jck_menu_input jck_menu2_item1">
                       <option value = "0">필터</option>
                       <option value = "1">상품명</option>
                       <option value = "2">지역명</option>
                   </select>
                   <input id = "SearchStr" name = "SearchStr" value = "${SearchStr}" class = "jck_display_none jck_menu_input jck_menu2_item2" type = "text" placeholder = "검색어를 입력해주세요.">
                   <button id = "SearchButton" type = "Button" class = "jck_menu2_item3"><img src = "./images/search.png"></button>
                <a href = "mapsearch.jsp"><button class = "jck_menu2_item4"><img src = "./images/gps.png"></button></a>
            </div>
            <div class = "jck_menu_item jck_menu_item3">
            	<button id = "jck_chatbox" class = "jck_menu3_item1 jck_after_login"><img src = "./images/chat.png"><span id = "unread" class = "label label-info"></span></button>
                <button id = "jck_mypagebefore" class = "jck_menu3_item1 jck_before_login"><img src = "./images/mypagebefore.png"></button>
                <button id = "jck_mypageafter" class = "jck_menu3_item1 jck_after_login"><img src = "./images/mypageafter.png"></button>
                <button id = "jck_loginbefore" class = "jck_menu3_item1 jck_before_login"><img src = "./images/login.png"><div id = "jck_login_text" class="jck_before_login"></div></button>
                <button id = "jck_loginafter" class = "jck_menu3_item1 jck_after_login"><img src = "./images/logout.png"><div id = "jck_logout_text" class="jck_after_login"></div></button>
            </div>
        </div>
        <div class = "jck_content_container">
            <div class = "jck_content_container_div1">
            <div class =YJH_emtpydiv1>
            </div>
            </div>
            <div class = "jck_content_container_div2">
            
            
            
            
            
            
            
            <div id="ICR_Btndiv">
               <button id="ICR_delete" type="button">삭제</button>
               <button id="ICR_modify" type="button" onclick="window.location='ProductModifyCtl.do?p_id=${vo.p_id}&Likeresult=0'">수정</button>
               <button id="ICR_list" type="button" onclick="window.location='ProductgetCountCtl.do'">상품목록</button>
            </div>
               <!-- 윤지혜시작 -->
               <div id="YJH_SearchPage">
                  <div class="YJH_item_main">
                     <div id="YJH_item_main_title">
                        ${vo.p_name }
                     </div>

                     <div id="YJH_main">
                        <div id="YJH_item_main_image">
                        <div class="container" style="width: 450px; height: 400px; padding: 0;">
                          <div id="myCarousel" class="carousel slide" data-ride="carousel">
                            <!-- Indicators -->
                            <ol class="carousel-indicators">
                            <c:if test="${not empty FName[1]}">
                              <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                              <li data-target="#myCarousel" data-slide-to="1"></li>
                            </c:if>
                            <c:if test="${not empty FName[0]}">
                              <li data-target="#myCarousel" data-slide-to="2"></li>
                            </c:if>
                            </ol>
                        
                            <!-- Wrapper for slides -->
                            <div class="carousel-inner">
                              <c:if test="${not empty FName[2]}">
                              <div class="item active">
                                <img src="./upload/${FName[2]}" style="width: 450px; height: 400px; border-radius: 15px;">
                              </div>
                              </c:if>
                           <c:if test="${not empty FName[1]}">
                              <div class="item">
                                <img src="./upload/${FName[1]}" style="width: 450px; height: 400px; border-radius: 15px;">
                              </div>
                            </c:if>
                            <c:if test="${not empty FName[0]}">
                              <div class="item">
                                <img src="./upload/${FName[0]}" style="width: 450px; height: 400px; border-radius: 15px;">
                              </div>
                              </c:if>
                            </div>
                        
                            <!-- Left and right controls -->
                            <c:if test="${not empty FName[1]}">
                            <a class="left carousel-control" href="#myCarousel" data-slide="prev">
                              <span class="glyphicon glyphicon-chevron-left"></span>
                              <span class="sr-only">Previous</span>
                            </a>
                            <a class="right carousel-control" href="#myCarousel" data-slide="next">
                              <span class="glyphicon glyphicon-chevron-right"></span>
                              <span class="sr-only">Next</span>
                            </a>
                            </c:if>
                          </div>
                        </div>
                     </div>
                        <div id="YJH_item_main_info">
                           <div id="YJH_info">
                              가격 : ${vo.p_value }원<br>
                              지역 : ${vo.l_name }<br>
                              판매자 : <a href="./CheckProfile.jsp" style="text-decoration: none;">${vo.m_nick }</a><br>
                              조회수 : ${vo.p_view }<br>
                              게시일 : 
                              <fmt:parseDate var="dateString" value="${vo.p_adddate }" pattern="yyyy-MM-dd HH:mm:ss" />
                              <fmt:formatDate value="${dateString}" pattern="yy년 MM월 dd일 " /><br>
                           </div><br>
                           <div>
                              <input type="button" id="YJH_askbutton" value="판매자와 1:1채팅" onclick="location.href='chat.jsp?toID=${vo.m_id}'">
                              
                              <button style="border: 0;outline: 0;background: none;" id="YJH_like" name="YJH_like" class="likeandshare"
                                    onclick="window.location='ProductInsertLikeCtl.do?p_id=${vo.p_id}&c_lid=${vo.c_lid}&m_id=${vo.m_id }'">
                                 <img id="ICR_p_like_N" style="width: 30px; height: 30px;" src="./images/p_like2.png">
                                 <img id="ICR_p_like_Y" style="width: 30px; height: 30px;display: none;" src="./images/p_like.png">
                              </button>
                              
                              <button style="border: 0; outline: 0; background: none;" id="YJH_share" name="YJH_share" class="likeandshare">
                                 <a href="ProductContentCtl.do?p_id=${vo.p_id}&c_lid=${vo.c_lid}&m_id=${vo.m_id}&Likeresult=0" onclick="copy_trackback(this.href); return false;">
                                 <img style="width: 30px; height: 30px;" src= "./images/share.png"></a>
                              </button>
                           </div>
                        </div>
                     </div>
                     <div id="YJH__detail">
                        <div id="YJH_item_detail">
                           <p style="font-weight: bold;">상세설명</p>
                           ${vo.p_description }
                        </div>
                        <div id="YJH_other_item">
                        <c:if test="${not empty list4 }">
                           <p style="font-weight: bold;">판매자의 다른상품</p>
                           <c:forEach items="${list4 }" var="rvo" begin="0" end="1">
                              <div class="YJH_other_item-1">
                                 <a href="ProductContentCtl.do?p_id=${rvo.p_id}&c_lid=${rvo.c_lid}&m_id=${rvo.m_id}&Likeresult=0">
                                 <img src="./upload/${rvo.pa_img3}" style="float: left; width:50px; height:50px;">
                                 <p class="ICR_rp">${rvo.p_name}<br>${rvo.p_description }</p></a>
                              </div>
                           </c:forEach>
                        </c:if>
                        </div>
                     </div>
                     
                     <hr style="border-top: 1px solid#B97A57; width: 100%;">
                     <div id="YJH_item">
                        <div>
                           <h2>Related Item Page</h2>
                           <div style="width:100%; text-align: center;">
                              
                              <c:if test="${not empty list3 }">
                                 <c:forEach items="${list3 }" var="pvo" begin="0" end="2">
                                    <div id="ICR_Product" class="YJH_floating_box">
                                    <table class="YJH_item_image" style="width: 250px; table-layout: fixed;">
                                       <tr>
                                          <td colspan="2">
                                          <a href="ProductContentCtl.do?p_id=${pvo.p_id}&c_lid=${pvo.c_lid}&m_id=${pvo.m_id}&Likeresult=0">
                                          <img style="width: 240px; height: 180px;border-radius: 15px;" src="./upload/${pvo.pa_img3}"></a></td>
                                       </tr>
                                       <tr>
                                          <td colspan="2" style="text-align:left; text-overflow:ellipsis; overflow: hidden; padding-top: 10px;"><nobr>
                                          <a href="ProductContentCtl.do?p_id=${pvo.p_id}&c_lid=${pvo.c_lid}&m_id=${pvo.m_id}&Likeresult=0" style="text-decoration: none;">${pvo.p_name}</a>
                                          </nobr></td>
                                       </tr>
                                       <tr>
                                          <td colspan="2" style="text-align: left; font-size: small; width: 40px;">${pvo.l_name}&nbsp;&nbsp;|&nbsp;
                                          <fmt:parseDate var="dateString" value="${pvo.p_adddate }" pattern="yyyy-MM-dd HH:mm:ss" />
                                          <fmt:formatDate value="${dateString}" pattern="yy년 MM월 dd일 " /></td>
                                       </tr>
                                       <tr>
                                          <td style="font-weight: bold;text-align: left;">${pvo.p_value}원</td>
                                          <td style="text-align: right;">
                                          <img src="./images/p_view.png" style="width: 20px;height: 20px;">${pvo.p_view }&nbsp;
                                          <img src="./images/p_like.png" style="width: 18px;height: 18px;">${pvo.p_like }</td>
                                       </tr>
                                    </table>
                                    </div>
                                 </c:forEach>
                                 
                                 <br>
                                 
                                 <c:forEach items="${list3 }" var="pvo" begin="3" end="5">
                                    <div id="ICR_Product" class="YJH_floating_box">
                                    <table class="YJH_item_image" style="width: 250px; table-layout: fixed;">
                                       <tr>
                                          <td colspan="2">
                                          <a href="ProductContentCtl.do?p_id=${pvo.p_id}&c_lid=${pvo.c_lid}&m_id=${pvo.m_id}&Likeresult=0">
                                          <img style="width: 240px; height: 180px;border-radius: 15px;" src="./upload/${pvo.pa_img3}"></a></td>
                                       </tr>
                                       <tr>
                                          <td colspan="2" style="text-align:left; text-overflow:ellipsis; overflow: hidden; padding-top: 10px;"><nobr>
                                          <a href="ProductContentCtl.do?p_id=${pvo.p_id}&c_lid=${pvo.c_lid}&m_id=${pvo.m_id}&Likeresult=0" style="text-decoration: none;">${pvo.p_name}</a>
                                          </nobr></td>
                                       </tr>
                                       <tr>
                                          <td colspan="2" style="text-align: left; font-size: small; width: 40px;">${pvo.l_name}&nbsp;&nbsp;|&nbsp;
                                          <fmt:parseDate var="dateString" value="${pvo.p_adddate }" pattern="yyyy-MM-dd HH:mm:ss" />
                                          <fmt:formatDate value="${dateString}" pattern="yy년 MM월 dd일 " /></td>
                                       </tr>
                                       <tr>
                                          <td style="font-weight: bold;text-align: left;">${pvo.p_value}원</td>
                                          <td style="text-align: right;">
                                          <img src="./images/p_view.png" style="width: 20px;height: 20px;">${pvo.p_view }&nbsp;
                                          <img src="./images/p_like.png" style="width: 18px;height: 18px;">${pvo.p_like }</td>
                                       </tr>
                                    </table>
                                    </div>
                                 </c:forEach>
                                 </c:if>
                                 
                              
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            
            
            
            
            
            
            
            
            
            
             </div>
            <div class = "jck_content_container_div3 jck_nav_container">
                      <%
                  /* ProductService pdao = new ProductService();
                       */
                      String p_1 = "0";
                      String p_2 = "0";
                      String p_3 = "0";
                      
                      if(session.getAttribute("img1") != null)
                     p_1 = (String) session.getAttribute("img1");
                      if(session.getAttribute("img1") != null)
                         p_2 = (String) session.getAttribute("img2");
                      if(session.getAttribute("img1") != null)
                         p_3 = (String) session.getAttribute("img3");
                  
                      String p_img1 = "logoimg.png";
                      String p_img2 = "logoimg.png";
                      String p_img3 = "logoimg.png";
                      /* 
                      if(!p_1.equals("0"))
                     p_img1 = pdao.selectHistory(p_1);
                      if(!p_2.equals("0"))
                         p_img2 = pdao.selectHistory(p_2);
                      if(!p_3.equals("0"))
                         p_img3 = pdao.selectHistory(p_3); */
                  %>
            <div id="JWJhistorylist">
               <aside>
                  <h3 style="color: white; background: #B97A57; text-align : center;">최근 본 상품</h3>
                  <a href=""><img src="./upload/<%=p_img1 %>"></a> <a href=""><img src="./upload/<%=p_img2 %>"></a>
                  <a href=""><img src="./upload/<%=p_img3 %>"></a>
               </aside>
            </div>
            </div>
        </div>
        <div class = "jck_footer_container">
            <div><a href = "#">감자 마켓<br>회사 소개</a></div>
            <div><a href = "#">개인 정보<br>취급 방침</a></div>
            <div><a href = "#">위치기반 서비스<br>이용 약관</a></div>
        </div>
    </div>
    
    <!-- The Modal -->
    <div id="jck_myModal" class="jck_modal">
      <!-- Modal content -->
      <div class="jck_modal-content">
        <div class="jck_modal-header">
          <span class="jck_close">&times;</span>
          <h2>감자 마켓</h2>
        </div>
        <div class="jck_modal-body">
            <ul>
               <li>
                  <p><a href = "#">&lt;홈페이지 소개&gt;</a></p>
               </li>
               <li>
               <hr>
               </li>
               <li>
                  <p><a href = "MyPage.jsp">&lt;마이 페이지&gt;</a></p>
               </li>
               <li>
                  <hr>
               </li>
               <li>
                  <p><a href = "ProductgetCountCtl.do">&lt;상품 검색&gt;</a></p>
                  <ul>
                     <li><a href = "ProductCategoryCtl.do?c_lid=1">의류</a></li>
                     <li><a href = "ProductCategoryCtl.do?c_lid=2">가전제품</a></li>
                     <li><a href = "ProductCategoryCtl.do?c_lid=3">뷰티</a></li>
                     <li><a href = "ProductCategoryCtl.do?c_lid=4">아동용품</a></li>
                     <li><a href = "ProductCategoryCtl.do?c_lid=5">기타</a></li>
                  </ul>
               </li>
               <li>
                  <hr>
               </li>
               <li>
                  <p><a href = "BoardListViewCtl.do?b_type=G">&lt;게시판&gt;</a></p>
                  <ul>
                     <li><a href = "BoardListViewCtl.do?b_type=N">공지사항</a></li>
                     <li><a href = "BoardListViewCtl.do?b_type=P">구매 게시판</a></li>
                     <li><a href = "BoardListViewCtl.do?b_type=G">일반 게시판</a></li>
                     <li><a href = "BoardListViewCtl.do?b_type=Q">QnA</a></li>
                  </ul>
               </li>
               <li>
               <hr>
               </li>
               <li>
                  <p><a href = "avgchart.jsp">&lt;시세 조회&gt;</a></p>
               </li>
            </ul>
        </div>
        <div class="jck_modal-footer">
          <h2>Potato Market</h2>
        </div>
      </div>
    </div>
    
    
      <script>
        $(window).resize(function(){
            if(window.innerWidth < 600){
                window.resizeTo(600, window.innerHeight);
            }
        });
    </script>
    
    <script>
    // Get the modal
    var modal = document.getElementById("jck_myModal");
    // Get the button that opens the modal
    var btn = document.getElementById("jck_myBtn");

    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("jck_close")[0];

    // When the user clicks the button, open the modal 
    btn.onclick = function() {
      modal.style.display = "block";
    }
    // When the user clicks on <span> (x), close the modal
    span.onclick = function() {
      modal.style.display = "none";
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
      if (event.target == modal) {
        modal.style.display = "none";
      }
    }
    </script>
    <script>
    var prevScrollpos = window.pageYOffset;
    window.onscroll = function() {
    var currentScrollPos = window.pageYOffset;
      
        if(window.innerWidth >= 900){
            document.getElementById("JWJhistorylist").style.display = "block";
        } else{
           document.getElementById("JWJhistorylist").style.display = "none";
        }
      prevScrollpos = currentScrollPos;
    }
    $(window).resize(function(){
            var currentScrollPos = window.pageYOffset;
      
            if(window.innerWidth >= 900){
                document.getElementById("JWJhistorylist").style.display = "block";
            } else{
               document.getElementById("JWJhistorylist").style.display = "none";
            }
      prevScrollpos = currentScrollPos;
        });
    </script>
    <script>
   $(document).ready(function(){
    <%
       if(session.getAttribute("userID") == null){
    %>
          var before = document.getElementsByClassName("jck_before_login");
          for(var i = 0 ; i<before.length;i++){
             before[i].style.display = "block";
          }
          var after = document.getElementsByClassName("jck_after_login");
          for(var i = 0 ; i<after.length;i++){
             after[i].style.display = "none";
          }
          var Ltext = document.getElementById("jck_login_text");
          Ltext.innerHTML = "로그인";
          Ltext.style.color = "#CC8431";
          Ltext.style.width = "100%";
          Ltext.style.textAlign = "center";
          Ltext.style.fontWeight = "bolder";
       
    <%      
       }else{
    %>
       
    var before = document.getElementsByClassName("jck_before_login");
	for(var i = 0 ; i<before.length;i++){
		before[i].style.display = "none";
	}
	var after = document.getElementsByClassName("jck_after_login");
	for(var i = 0 ; i<after.length;i++){
		after[i].style.display = "block";
	}
	var LOtext = document.getElementById("jck_logout_text");
	LOtext.innerHTML = "로그아웃";
	LOtext.style.color = "#CC8431";
	LOtext.style.width = "100%";
	LOtext.style.textAlign = "center";
	LOtext.style.fontWeight = "bolder";
    <%   
       }
    %>
   })
    </script>
       <script>
       $(document).ready(function(){
          $("#jck_mainpage_btn1").click(function(){
             location.href = "./MainPage.jsp";
          });
          $("#jck_mainpage_btn2").click(function(){
             location.href = "./MainPage.jsp";
          });
          $("#jck_mypagebefore").click(function(){
             location.href = "./Login.jsp";
          });
          
          $("#jck_mypageafter").click(function(){
             location.href = "./MyPage.jsp";
          });
          $("#jck_loginbefore").click(function(){
             location.href = "./Login.jsp";
          });
          $("#jck_loginafter").click(function(){
             location.href = "./LogoutCtl.do";
          });
          $("#SearchButton").click(function(){
  			location.href = "./ProductgetSearchCountCtl.do?SearchFilter="+$("#SearchFilter").val()+"&SearchStr="+$("#SearchStr").val();
  		});
  		$("#jck_chatbox").click(function(){
  			location.href="./box.jsp";
  		});
       });
          
       </script>
       <%
      String messageContent = null;
      if(session.getAttribute("messageContent") != null){
         messageContent = (String) session.getAttribute("messageContext");
      }
      String messageType = null;
      if(session.getAttribute("messageType") != null){
         messageContent = (String) session.getAttribute("messageType");
      }
      if(messageContent != null){
   %>
       <div class = "modal fade" id = "messageModal" tabindex="-1" role = "dialog" aria-hidden = "true">
          <div class = "vertical-alignment-helper">
             <div class = "modal-dialog vertical-align-center">
                <div class = "modal-content <% if(messageType.equals("오류 메시지")) out.println("panel-warning"); else out.println("panel-success"); %>">
                   <div class = "modal-header panel-heading">
                      <button type = "button" class = "close" data-dismiss="modal">
                         <span aria-hidden="true">&times;</span>
                         <span class="sr-only">Close</span>
                      </button>
                      <h4 class = "modal-title">
                         <%=messageType %>
                      </h4>
                   </div>
                   <div class = "modal-body">
                      <%=messageContent %>
                   </div>
                   <div class = "modal-footer">
                      <button type = "button" class = "btn btn-primary" data-dismiss="modal">확인</button>
                   </div>
                </div>
             </div>
          </div>
      </div>
      <script>
         $('#messageModal').modal("show");
      </script>   
      <%   
         session.removeAttribute("messageContent");
         session.removeAttribute("messageType");
         }
      %>
      <%
         if(userID != null){
      %>
         <script type="text/javascript">
            $(document).ready(function(){
               getUnread();
               getInfiniteUnread();
            });
         </script>
      <%
         }
      %>
   
   
   <script>
   //로그인 유무 - 버튼보이기
   <%
   if(userID != null && !userID.isEmpty()){   //로그인시
      if(userID == request.getParameter("write_m_id")){   //글 작성자와 로그인 사용자가 같은 경우 (수정,삭제 보이기)
         out.println("$('#ICR_modify').css('display','inline-block');");
         out.println("$('#ICR_delete').css('display','inline-block');");
      }
   }else{   //로그인 안함
      out.println("$('#ICR_modify').css('display','none');");
      out.println("$('#ICR_delete').css('display','none');");
      out.println("$('#YJH_askbutton').css('display','none');");
      out.println("$('#YJH_like').css('display','none');");
   }
   %>
   </script>
   
   <script>
   //해당상품 찜 유무 판단하기
   <%
   int result = ((Integer)request.getAttribute("result")).intValue();
   int Likeresult2 = ((Integer)request.getAttribute("Likeresult2")).intValue();
   
   if(result == 1) {   //찜 한 상태 ♥
      out.println("$('#ICR_p_like_N').css('display','none');");
      out.println("$('#ICR_p_like_Y').css('display','inline-block');");
   }else if(result == -1) {   //찜 안 한 상태 ♡
      out.println("$('#ICR_p_like_N').css('display','inline-block');");
      out.println("$('#ICR_p_like_Y').css('display','none');");
   }
   
   if(Likeresult2 == 2){   //insert 성공
      out.println("if(confirm('찜 등록에 성공했습니다. 찜목록으로 이동할까요?')==true){");
      out.println("window.location='ProductSelectLikeCtl.do';");
      out.println("}else{");
      out.println("}");
      
      out.println("$('#ICR_p_like_N').css('display','none');");
      out.println("$('#ICR_p_like_Y').css('display','inline-block');");
   }else if(Likeresult2 == 3){   //delete 성공
      out.println("$('#ICR_p_like_N').css('display','inline-block');");
      out.println("$('#ICR_p_like_Y').css('display','none');");
   }else{   //0인경우 - 최초 onload
      
   }
   %>
   </script>
   
   <script>
   //글 삭제하기
   $("#ICR_delete").click(function(){
      if(confirm("정말 삭제하시겠습니까 ?") == true){
         window.location="ProductDeleteCtl.do?p_id=${vo.p_id}";
            alert("삭제되었습니다");
         window.location="ProductgetCountCtl.do";
            } else {
               return;
            }
      });
   </script>

   <script>
   //상품 페이지 공유 버튼 
    function copy_trackback(address) {
        var IE=(document.all)?true:false;
        if (IE) {
            if(confirm("이 글의 주소를 클립보드에 복사하시겠습니까?"))
                window.clipboardData.setData("Text", address);
        } else {
            temp = prompt("해당 상품 공유를 원하시면 Ctrl+C를 눌러 클립보드로 복사하세요", address);
        }
    }
    </script>
    
</body>

</html>