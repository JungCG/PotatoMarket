<%@page import="service.ProductService"%>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/jck_nav.css">
<link rel="stylesheet" href="css/GJW_MainBoard.css">
<link rel="stylesheet" href="css/custom.css">
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<style>
.jck_everything {
   height: auto;
}

.jck_content_container {
   justify-content: stretch;
}

</style>
<%
      String userID = null;
      if(session.getAttribute("userID") != null){
         userID = (String) session.getAttribute("userID");
      }
   %>
<meta name="msapplication-TileColor" content="#da532c">
<meta name="theme-color" content="#ffffff">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="./js/jquery-3.5.1.js" type="text/javascript"></script>
<script src="js/bootstrap.js"></script>
<title>감자 마켓 게시판</title>
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
         }, 10000);
      }
      
      function showUnread(result){
         $('#unread').html(result);
      }
      
      
   </script>
</head>
<body>
   <div class="jck_everything">
      <div class="jck_menu_container">
         <div class="jck_menu_item jck_menu_item1">
            <button class="jck_menu1_item jck_menu1_item1" id="jck_myBtn">
               <img src="./images/menu.png">
            </button>
            <button class="jck_menu1_item jck_menu1_item2"
               id="jck_mainpage_btn1">
               <a href="ProductMainPageGetCountCtl.do"><img src="./images/logo_img.png"></a>
            </button>
         </div>
         <div class="jck_menu_item jck_menu_item2">
            <select name="SearchFilter" id="SearchFilter"
               class="menu jck_display_none jck_menu_input jck_menu2_item1">
               <option value="0">필터</option>
               <option value="1">상품명</option>
               <option value="2">지역명</option>
            </select> <input id="SearchStr" name="SearchStr" value="${SearchStr}"
               class="jck_display_none jck_menu_input jck_menu2_item2" type="text"
               placeholder="검색어를 입력해주세요.">
            <button id="SearchButton" type="Button" class="jck_menu2_item3">
               <img src="./images/search.png">
            </button>
            <a href="mapsearch.jsp"><button class="jck_menu2_item4">
                  <img src="./images/gps.png">
               </button></a>
         </div>
         <div class="jck_menu_item jck_menu_item3">
            <button id = "jck_chatbox" class = "jck_menu3_item1 jck_after_login"><img src = "./images/chat.png"><span id = "unread" class = "label label-info"></span></button>
                <button id = "jck_mypagebefore" class = "jck_menu3_item1 jck_before_login"><img src = "./images/mypagebefore.png"></button>
                <button id = "jck_mypageafter" class = "jck_menu3_item1 jck_after_login"><img src = "./images/mypageafter.png"></button>
                <button id = "jck_loginbefore" class = "jck_menu3_item1 jck_before_login"><img src = "./images/login.png"><div id = "jck_login_text" class="jck_before_login"></div></button>
                <button id = "jck_loginafter" class = "jck_menu3_item1 jck_after_login"><img src = "./images/logout.png"><div id = "jck_logout_text" class="jck_after_login"></div></button>
         </div>
      </div>
      <div class="jck_content_container">
         <div class="jck_content_container_div1"></div>
         <div class="jck_content_container_div2">
            <section>
               <div id="GJW-menuwrap">
                  <div class="GJW-Board">


                     <div class="boardtype" style="font-family: 'Hanna', serif;">
                        <div class="boardtype-1">
                           <label for="ge" value="G" id="gela">일반게시판</label> <input
                              type="radio" name="type" class="rd" id="ge" value="G"
                              ${param.b_type == 'G'? "checked='checked'" : "" } />

                        </div>
                        <div class="boardtype-1">
                           <label for="pro" value="P" id="prola">구매게시판</label> <input
                              type="radio" name="type" class="rd" id="pro" value="P"
                              ${param.b_type == 'P' ? "checked='checked'" : "" } />
                        </div>
                        <div class="boardtype-1">
                           <label for="qna" value="Q" id="qnala">QnA게시판</label> <input
                              type="radio" name="type" class="rd" id="qna" value="Q"
                              ${param.b_type == 'Q' ? "checked='checked'" : "" } />
                        </div>
                        <div class="boardtype-1">
                           <label for="news" value="N" id="newsla">공지사항&nbsp;&nbsp;&nbsp;</label>
                           <input type="radio" name="type" class="rd" id="news" value="N"
                              ${param.b_type == 'N' ? "checked='checked'" : "" } />
                        </div>
                     </div>
                     <div class="imgtextbox">
                        <span id="boardtext"></span> <img src="" class="typeimg"
                           id="nImg">
                     </div>
                  </div>
               </div>
               <div class="kdy_board_wrap">
                  <div class="gjw-board-wrap">
                     <div id="GJW-hotviewdiv">
                        <table id="GJW-hotviewtable">
                           <tr id="GJW-boardip">
                              <td>글번호</td>
                              <td>제목</td>
                              <td>글쓴이</td>
                              <td>작성일</td>
                              <td>조회수</td>
                           </tr>
                           <c:forEach items="${ hotview }" var="hv" varStatus="s">
                              <tr class="GJW-hotviewtr">
                                 <td>${hv.b_id}</td>
                                 <td class="GJW"><span class="GJW-gocontent">${hv.b_title}
                                       <input type="hidden" class="bb_secret" name="b_secret"
                                       value="${hv.b_secret }"> <input type="hidden"
                                       class="bb_id" name="bb_id" value="${hv.b_id}">
                                 </span> <span class="GJW-commentCount">(${hv.b_count })</span> <span
                                    class="check"> <input type="hidden" class="bb_secret"
                                       name="b_secret" value="${hv.b_secret }"> 
                                       <input
                                       type="text" name="b_secretnumber" placeholder="비밀번호를 입력해주세요"
                                       class="GJW-scretnumbertext"> <input type="button"
                                       value="비밀번호 확인" name="checkb_secretnumber"
                                       class="secretcheckbtn"> <input type="hidden"
                                       class="bb_id" name="bb_id" value="${hv.b_id}">
                                 </span></td>
                                 <td>${hv.m_id }</td>
                                 <td><fmt:formatDate value="${hv.b_timestamp}"
                                       pattern="yyyy-MM-dd HH:mm" /></td>
                                 <td>${hv.b_view }</td>

                              </tr>
                           </c:forEach>

                           </div>




                           <%
                              String b_type = request.getParameter("b_type");
                           %>
                           <tr>
                              <c:if test="${not empty list}">
                                 <c:forEach items="${ list }" var="mvo" varStatus="s">

                                    <c:set var="b_secret" value="${mvo.b_secret}" />

                                    <tr class="GJW-boardlisttr">
                                       <td>${mvo.b_id}</td>
                                       <td class="GJW"><span class="GJW-gocontent">${mvo.b_title}
                                             <input type="hidden" class="bb_secret" name="b_secret"
                                             value="${mvo.b_secret }"> <c:if
                                                test="${b_secret eq 'Y'.charAt(0)}">
                                                <img src="images/lock.png" class="GJW-lockimg">
                                             </c:if> <input type="hidden" class="bb_id" name="bb_id"
                                             value="${mvo.b_id}">
                                       </span> <span class="GJW-commentCount">(${mvo.b_count })</span> <span
                                          class="check"> <input type="hidden"
                                             class="bb_secret" name="b_secret"
                                             value="${mvo.b_secret }"> <input type="password"
                                             name="b_secretnumber" class="GJW-scretnumbertext" placeholder ="비밀번호를 입력해주세요">
                                             <input type="button" value="비밀번호 확인"
                                             name="checkb_secretnumber" class="secretcheckbtn">
                                             <input type="hidden" class="bb_id" name="bb_id"
                                             value="${mvo.b_id}">
                                       </span></td>
                                       <td>${mvo.m_id }</td>
                                       <td><fmt:formatDate value="${mvo.b_timestamp}"
                                             pattern="yyyy-MM-dd HH:mm" /></td>
                                       <td>${mvo.b_view }</td>
                                 </c:forEach>
                              </c:if>
                           </tr>
                           <c:if test="${ empty list}">
                              <tr>
                                 <td colspan="5"><h1>검색결과가 없습니다</h1>
                              </tr>
                           </c:if>
                        </table>
                        <div id="GJW-serchbar">
                           <div id="GJW-BoardPagig">
                              <c:if test="${empty param.select }">
                                 <a
                                    href="BoardListViewCtl.do?currentPage=<%=Integer.parseInt(request.getParameter("currentPage")) - 1%>&b_type=<%=b_type%>"
                                    class="GJW-pagenumber">&nbsp;&nbsp;[이전]&nbsp;&nbsp;</a>
                                 <br>
                              </c:if>
                              <c:if test="${not empty param.select }">
                                 <a
                                    href="BoardListViewCtl.do?currentPage=<%=Integer.parseInt(request.getParameter("currentPage")) - 1%>&b_type=<%=b_type %>&select=${param.select}"
                                    class="GJW-pagenumber">&nbsp;&nbsp;[이전]&nbsp;&nbsp;</a>
                                 <br>
                              </c:if>
                              <c:forEach begin="${startPage }" end="${endPage }" var="i">
                                 <c:if test="${empty param.select }">
                                    <a
                                       href="BoardListViewCtl.do?currentPage=<c:out value="${i }"/>&b_type=<%=b_type %>">&nbsp;<c:out
                                          value="${i }" />&nbsp;
                                    </a>
                                 </c:if>
                                 <c:if test="${not empty param.select }">
                                    <a
                                       href="BoardListViewCtl.do?currentPage=<c:out value="${i }"/>&b_type=<%=b_type %>&select=${param.select}">&nbsp;<c:out
                                          value="${i }" />&nbsp;
                                    </a>
                                 </c:if>
                              </c:forEach>
                              <c:if test="${empty param.select }">
                                 <a
                                    href="BoardListViewCtl.do?currentPage=<%=Integer.parseInt(request.getParameter("currentPage")) + 1%>&b_type=<%=b_type%>"
                                    class="GJW-pagenumber">&nbsp;&nbsp;[다음]&nbsp;&nbsp;</a>
                                 <br>
                              </c:if>
                              <c:if test="${not empty param.select }">
                                 <a
                                    href="BoardListViewCtl.do?currentPage=<%=Integer.parseInt(request.getParameter("currentPage")) + 1%>&b_type=<%=b_type %>&select=${param.select}"
                                    class="GJW-pagenumber">&nbsp;&nbsp;[다음]&nbsp;&nbsp;</a>
                                 <br>
                              </c:if>
                              <%
                                 String id = (String) session.getAttribute("ID");
                              %>
                              <div id="GJW-writeBoard"></div>
                           </div>
                           <%
                              if (!(userID == null)) {
                           %>
                           <div style ="display: flex; justify-content: flex-end;">
                           <a style="display: flex; justify-content: flex-end;"
                              href="BoardWrite.jsp?currentPage=<%=Integer.parseInt(request.getParameter("currentPage"))%>" class="lasc">글쓰기</a>
                                 </div>
                           <%
                              }
                           %>
                           <div id="GJW-srearhinput">
                              <form action="BoardListViewCtl.do" method="post">
                                 <input type="text" name="select" id="GJW-searchbar">
                                 <input type="hidden" name="currentPage"
                                    value="<%=Integer.parseInt(request.getParameter("currentPage"))%>">
                                 <input type="submit" class="lase" value="검색">
                              </form>
                           </div>
                        </div>
                     </div>

                  </div>
            </section>
         </div>
		<div class = "jck_content_container_div3 jck_nav_container">
                      <%
				      ProductService pdao = new ProductService();
                      
                      String p_1 = "0";
                      String p_2 = "0";
                      String p_3 = "0";
                      
                      if(session.getAttribute("img1") != null)
  				      	p_1 = String.valueOf(session.getAttribute("img1"));
                        if(session.getAttribute("img2") != null)
                        	p_2 = String.valueOf(session.getAttribute("img2"));
                        if(session.getAttribute("img3") != null)
                        	p_3 = String.valueOf(session.getAttribute("img3"));
				      
                      String p_img1 = "logoimg.png";
                      String p_img2 = "logoimg.png";
                      String p_img3 = "logoimg.png";
                      
                      if(!p_1.equals("0"))
				      	p_img1 = pdao.selectHistory(p_1);
                      if(!p_2.equals("0"))
                      	p_img2 = pdao.selectHistory(p_2);
                      if(!p_3.equals("0"))
                      	p_img3 = pdao.selectHistory(p_3);
                      
                      String href1="#";
                      String href2="#";
                      String href3="#";
                      
                      if(!p_img1.equals("logoimg.png")){
                    	  href1="./ProductContentCtl.do?p_id="+session.getAttribute("img1")+"&c_lid="+session.getAttribute("img1_c_lid")+"&m_id="+session.getAttribute("img1_m_id")+"&Likeresult="+session.getAttribute("img1_likeresult");
                      }
                      if(!p_img2.equals("logoimg.png")){
                    	  href2="./ProductContentCtl.do?p_id="+session.getAttribute("img2")+"&c_lid="+session.getAttribute("img2_c_lid")+"&m_id="+session.getAttribute("img2_m_id")+"&Likeresult="+session.getAttribute("img2_likeresult");
                      }
                      if(!p_img3.equals("logoimg.png")){
                    	  href3="./ProductContentCtl.do?p_id="+session.getAttribute("img3")+"&c_lid="+session.getAttribute("img3_c_lid")+"&m_id="+session.getAttribute("img3_m_id")+"&Likeresult="+session.getAttribute("img3_likeresult");
                      }
				      %>
		      <div id="JWJhistorylist">
		         <aside>
		            <h3 style="color: white; background: #B97A57; text-align : center;">최근 본 상품</h3>
		            
		            <a href="<%=href1%>"><img src="./upload/<%=p_img1 %>"></a>
		            
		            <a href="<%=href2%>"><img src="./upload/<%=p_img2 %>"></a>
		            
		            <a href="<%=href3%>"><img src="./upload/<%=p_img3 %>"></a>
		         </aside>
		      </div>
            </div>
      </div>
      
      <div class = "jck_footer_container" style = "text-align : center;">
            <div style = "color : #CC8431;">상호 : 감자마켓 | 팀원 : 정창균, 정운진, 강대영, 금지운, 윤지혜, 임채린<br>
주소 : 서울특별시 중구 남대문로 120 대일빌딩 2F, 3F<br>
서비스 이용문의 : nothing1360@gmail.com | 서비스제휴문의 : nothing1360@gmail.com<br>
Copyright © Potato-Market. All Rights Reserved.</div>
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
               <%
            		if(session.getAttribute("userID") != null){
            	%>
            	<li>
            		<p><a href = "MyPage.jsp">&lt;마이 페이지&gt;</a></p>
            	</li>
            	<li>
            		<hr>
            	</li>
            	<%
            		}
            	%>
               <li>
                  <p>
                     <a href="ProductgetCountCtl.do">&lt;상품 검색&gt;</a>
                  </p>
                  <ul>
                     <li><a
                        href="ProductCategoryCtl.do?c_lid=1">의류</a></li>
                     <li><a
                        href="ProductCategoryCtl.do?c_lid=2">가전제품</a></li>
                     <li><a
                        href="ProductCategoryCtl.do?c_lid=3">뷰티</a></li>
                     <li><a
                        href="ProductCategoryCtl.do?c_lid=4">아동용품</a></li>
                     <li><a
                        href="ProductCategoryCtl.do?c_lid=5">기타</a></li>
                  </ul>
               </li>
               <li>
                  <hr>
               </li>
               <li>
                  <p>
                     <a href="BoardListViewCtl.do?b_type=G">&lt;게시판&gt;</a>
                  </p>
                  <ul>
                     <li><a href="BoardListViewCtl.do?b_type=N">공지사항</a></li>
                     <li><a href="BoardListViewCtl.do?b_type=P">구매 게시판</a></li>
                     <li><a href="BoardListViewCtl.do?b_type=G">일반 게시판</a></li>
                     <li><a href="BoardListViewCtl.do?b_type=Q">QnA</a></li>
                  </ul>
               </li>
               <li>
                  <hr>
               </li>
               <li>
                  <p>
                     <a href="avgchart.jsp">&lt;시세 조회&gt;</a>
                  </p>
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
             location.href = "./ProductMainPageGetCountCtl.do";
          });
          $("#jck_mainpage_btn2").click(function(){
             location.href = "./ProductMainPageGetCountCtl.do";
          });
          $("#jck_mypagebefore").click(function(){
             location.href = "./Login.jsp";
          });
          
          $("#jck_mypageafter").click(function(){
  			<%if(userID != null){
  				if(userID.equals("MasterPotato1")){
  			%>
  				location.href = "./AdminListViewCtl.do";
  			<%
  				}else{
  			%>
  				location.href = "./MyPage.jsp";
  			<%
  				}}
  			%>
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
   if (session.getAttribute("messageContent") != null) {
      messageContent = (String) session.getAttribute("messageContext");
   }
   String messageType = null;
   if (session.getAttribute("messageType") != null) {
      messageContent = (String) session.getAttribute("messageType");
   }
   if (messageContent != null) {
   %>
   <div class="modal fade" id="messageModal" tabindex="-1" role="dialog"
      aria-hidden="true">
      <div class="vertical-alignment-helper">
         <div class="modal-dialog vertical-align-center">
            <div
               class="modal-content <%if (messageType.equals("오류 메시지"))
   out.println("panel-warning");
else
   out.println("panel-success");%>">
               <div class="modal-header panel-heading">
                  <button type="button" class="close" data-dismiss="modal">
                     <span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
                  </button>
                  <h4 class="modal-title">
                     <%=messageType%>
                  </h4>
               </div>
               <div class="modal-body">
                  <%=messageContent%>
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
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
      if (userID != null) {
   %>
   <script type="text/javascript">
      $(document).ready(function() {
         getUnread();
         getInfiniteUnread();
      });
   </script>
   <%
      }
   %>



   <script>
      $(".rd").click(function() {
         location.href = "BoardListViewCtl.do?b_type=" + $(this).val();
      });
      $(function() {
         if ($("#ge").is(":checked")) {
            $("#nImg").attr("src", "./images/TypeG.png");
            $("#gela").css("color", "orange");
            $("#boardtext").css("color", "orange");
            $("#boardtext").text("일반 게시판");

         }
         if ($("#pro").is(":checked")) {
            $("#nImg").attr("src", "./images/TypeP.png");
            $("#prola").css("color", "violet");
            $("#boardtext").css("color", "violet");

            $("#boardtext").text("구매 게시판");
         }
         if ($("#qna").is(":checked")) {
            $("#nImg").attr("src", "./images/TypeQ.png");
            $("#qnala").css("color", "skyblue");

            $("#boardtext").css("color", "skyblue");
            $("#boardtext").text("QnA 게시판");
         }
         if ($("#news").is(":checked")) {
            $("#nImg").attr("src", "./images/TypeN.png");
            $("#newsla").css("color", "forestgreen");
            $("#boardtext").css("color", "forestgreen");
            $("#boardtext").text("공지사항 게시판");
         }
      });
      $(function() {
         $(".GJW-gocontent")
               .click(
                     function() {
                        var b_secret = $(this).children(".bb_secret")
                              .val();
                        var b_id = $(this).children(".bb_id").val();
                        if (b_secret == "Y") {
                           alert("비밀글입니다 비밀번호를 입력해주세요");
                           $(this).next().next(".check").css(
                                 "display", "block");
                           
                        
                        } else {
                           location.href = "BoardContentCtl.do?b_id="
                                 + b_id
                                 + "&b_type=${param.b_type}&currentPage=${param.currentPage}";
                        }
                     })
      })
      $(function() {
         var sc = $(".bb_secret").val();
         if (sc == "N") {

            sc.next("img").css("display", "none");
         }
      })
      $(function() {
         $(".secretcheckbtn")
               .click(
                     function() {
                        var b_secretnumber = $(this).prev(
                              ".GJW-scretnumbertext").val();
                        var b_id = $(this).next(".bb_id").val();
                        var passReg = /^[0-9]{4}$/;
                        if (b_secretnumber == "") {

                           alert("비밀번호를 입력해주세요");
                           return;
                        } else if (!passReg.test(b_secretnumber)) {
                           alert("숫자 4자리를 입력해주세요");
                           return;
                        } else {
                           $
                                 .ajax({
                                    //var b_id = $(".bb_id").val();
                                    //var b_scretnumbertext =$(".GJW-scretnumbertext").val();
                                    url : "BoardContentPassCheckCtl.do",
                                    type : "POST",
                                    data : {
                                       b_id : b_id,
                                       b_secretnumber : b_secretnumber
                                    },
                                    success : function(result) {
                                       if (result == 1) {
                                          alert("비밀번호 확인완료");
                                          location.href = "BoardContentCtl.do?b_id="
                                                + b_id
                                                + "&b_type=${param.b_type}&currentPage=${param.currentPage}";
                                       } else {
                                          alert("비밀번호가 틀려용");
                                       }
                                    }
                                 });
                        }
                     })

      })
   </script>

   <script>
      $(window).resize(function() {
         if (window.innerWidth < 600) {
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
         s

         if (window.innerWidth >= 900) {
            document.getElementsByClassName("jck_nav_item1")[0].style.display = "block";
            document.getElementsByClassName("jck_nav_item2")[0].style.display = "block";
            document.getElementsByClassName("jck_nav_item3")[0].style.display = "block";
         } else {
            document.getElementsByClassName("jck_nav_item1")[0].style.display = "none";
            document.getElementsByClassName("jck_nav_item2")[0].style.display = "none";
            document.getElementsByClassName("jck_nav_item3")[0].style.display = "none";
         }

         if (window.innerHeight < 600) {
            document.getElementsByClassName("jck_nav_item1")[0].style.display = "none";
            document.getElementsByClassName("jck_nav_item2")[0].style.display = "none";
            document.getElementsByClassName("jck_nav_item3")[0].style.display = "none";
         }
         prevScrollpos = currentScrollPos;
      }
      $(window)
            .resize(
                  function() {
                     var currentScrollPos = window.pageYOffset;

                     if (window.innerWidth >= 900) {
                        document
                              .getElementsByClassName("jck_nav_item1")[0].style.display = "block";
                        document
                              .getElementsByClassName("jck_nav_item2")[0].style.display = "block";
                        document
                              .getElementsByClassName("jck_nav_item3")[0].style.display = "block";
                     } else {
                        document
                              .getElementsByClassName("jck_nav_item1")[0].style.display = "none";
                        document
                              .getElementsByClassName("jck_nav_item2")[0].style.display = "none";
                        document
                              .getElementsByClassName("jck_nav_item3")[0].style.display = "none";
                     }

                     if (window.innerHeight < 600) {
                        document
                              .getElementsByClassName("jck_nav_item1")[0].style.display = "none";
                        document
                              .getElementsByClassName("jck_nav_item2")[0].style.display = "none";
                        document
                              .getElementsByClassName("jck_nav_item3")[0].style.display = "none";
                     }
                     prevScrollpos = currentScrollPos;
                  });
   </script>
</body>
</html>