<%@page import="service.ProductService"%>
<link rel = "stylesheet" href = "css/bootstrap.css">
<link rel = "stylesheet" href = "css/GJW-AdminPage.css">
<link rel = "stylesheet" href = "css/jck_nav.css">
<link rel = "stylesheet" href = "css/custom.css">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
 <script src = "./js/jquery-3.5.1.js" type = "text/javascript"></script>
	<script src = "js/bootstrap.js"></script>
<style>
section{
width: 100%;
}
.jck_everything {
height:110vh;
}
.jck_content_container {
    justify-content: stretch;
}
.jck_content_container_div1 {
    flex-basis: 0%;
}
.jck_content_container_div2 {
     flex-basis: 0%; 
    width: 100%;
    display: flex;
    justify-content: center;
}
.outform{
display:none;
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
    <script src = "./js/jquery-3.5.1.js" type = "text/javascript"></script>
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
			}, 10000);
		}
		
		function showUnread(result){
			$('#unread').html(result);
		}
		
		
	</script>
</head>
<body>
    <div class = "jck_everything">
        <div class = "jck_menu_container">
            <div class = "jck_menu_item jck_menu_item1">
                <button class = "jck_menu1_item jck_menu1_item1" id="jck_myBtn"><img src = "./images/menu.png"></button>
                <button class = "jck_menu1_item jck_menu1_item2" id = "jck_mainpage_btn1">
                    <a href="ProductMainPageGetCountCtl.do"><img src = "./images/logo_img.png"></a>
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
              <section>
              <div style ="display: flex;
    justify-content: center;">
              	<h1 style ="font-size: 50px; margin-bottom: 50px;color:#CC8431">관리자 페이지</h1>
              </div>
               <div id="GJW-menuwrap">
                  <div class="GJW-Board">
                     <div class="boardtype" style = "   font-family: 'Hanna', serif;">
                        <div class="boardtype-1">
                           <label for="ge" value="P" id="gela">상품게시판</label> <input
                              type="radio" name="type" class="rd" id="ge" value="P"
                              ${param.type == 'P'? "checked='checked'" : "" } />
                        </div>
                        <div class="boardtype-1">
                           <label for="pro" value="G" id="prola">게시판</label> <input
                              type="radio" name="type" class="rd" id="pro" value="G"
                              ${param.type == 'G' ? "checked='checked'" : "" } />
                        </div>
                        <div class="boardtype-1">
                           <label for="qna" value="M" id="qnala">회원정보</label> <input
                              type="radio" name="type" class="rd" id="qna" value="M"
                              ${param.type == 'M' ? "checked='checked'" : "" } />
                        </div>
                        <div class="boardtype-1">
                           <label for="news" value="S" id="newsla">신고리스트&nbsp;&nbsp;&nbsp;</label>
                           <input type="radio" name="type" class="rd" id="news" value="S"
                              ${param.type == 'S' ? "checked='checked'" : "" } />
                        </div>
                     </div>
                  </div>
               </div>
               <div class="kdy_board_wrap">
                  <div class="gjw-board-wrap">
                              <c:if test="${type eq 'P'}">
                              
                       <table>
					<tr>
						<td>상품번호</td>
						<td>상품명</td>
						<td>작성자</td>
						<td>가격</td>
						<td>등록일</td>
						<td>조회수</td>
						<td>삭제</td>
					</tr>

					<c:if test="${not empty plist }">
						<c:forEach items="${plist }" var="pvo">
							<tr>
								<td>${pvo.p_id}</td>
								<td><a href="ProductContentCtl.do?p_id=${pvo.p_id}&c_lid=${pvo.c_lid}&m_id=${pvo.m_id}&Likeresult=0">${pvo.p_name}</a>
								</td>
								<td>${pvo.m_id }</td>
								<td>${pvo.p_value}원</td>
								<td>${pvo.p_adddate }</td>
								<td>${pvo.p_view }</td>
								<td><a href="AdminDeleteProductCtl.do?p_id=${pvo.p_id }">상품
										삭제</a></td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty plist}">
						<tr>
							<td colspan='7'>검색결과가없습니다</td>
						</tr>
					</c:if>
				</table>
                              </c:if>
                              
                              
                                                            <c:if test="${type eq 'G'}">
                              <table>
				<tr>
					<td>글번호</td>
					<td>글내용</td>
					<td>작성자</td>
					<td>작성일</td>
					<td>조회수</td>
					<td>삭제</td>
				</tr>
				<c:if test="${not empty list}">
					<c:forEach items="${ list }" var="mvo" varStatus="s">
						<c:set var="b_secret" value="${mvo.b_secret}" />
						<tr class="GJW-boardlisttr">
							<td><a href ="BoardContentCtl.do?b_id=${mvo.b_id}&currentPage=${param.currentPage}">${mvo.b_id }</a></td>
							<td class="GJW"><span class="GJW-gocontent">
								<a href ="BoardContentCtl.do?b_id=${mvo.b_id}&currentPage=${param.currentPage}">${mvo.b_title}</a>
									<input type="hidden" class="bb_secret" name="b_secret"
									value="${mvo.b_secret }"> <c:if
										test="${b_secret eq 'Y'.charAt(0)}">
										<img src="images/lock.png" class="GJW-lockimg">
									</c:if> <input type="hidden" class="bb_id" name="bb_id"
									value="${mvo.b_id}">
							</span> <span class="GJW-commentCount">(${mvo.b_count })</span> <span
								class="check"> <input type="hidden" class="bb_id"
									name="bb_id" value="${mvo.b_id}">
							</span></td>
							<td>${mvo.m_id }</td>
							<td><fmt:formatDate value="${mvo.b_timestamp}"
									pattern="yyyy-MM-dd" /></td>
							<td>${mvo.b_view }</td>
							<td><a href="AdminDeleteBoardContent.do?b_id=${mvo.b_id }&type=G">게시글
									삭제</a></td>
					</c:forEach>
				</c:if>
				<c:if test="${empty list}">
					<tr>
						<td colspan='6'>검색결과가없습니다</td>
					</tr>
				</c:if>
			</table>
                              
                                                            </c:if>
                              
                              
                              
                                                                                     <c:if test="${type eq 'M'}">
                              <table>
						<tr id = "GJW-trborder"style ="border-bottom:1px solid brown;">
							<td>회원번호</td>
							<td>회원아이디</td>
							<td>회원명</td>
							<td>닉네임</td>
							<td>가입일</td>
							<td>추천수</td>
							<td>판매횟수</td>
							<td>신고당한횟수</td>
							<td>계정상태</td>
							<td>이메일</td>
							<td>회원삭제</td>
						</tr>
						<c:if test="${not empty mlist }">
							<c:forEach items="${mlist }" var="mb">
								 <c:if test="${mb.m_out eq 'Y'}">
		                         <tr style ="background-color: #e46d6d;">
		                         </c:if>
		                          <c:if test="${mb.m_out eq 'N'}">
		                        <tr>
		                        	</c:if> 
									<td>${mb.l_id }</td>
									<td>${mb.m_id }</td>
									<td>${mb.m_name}</td>
									<td>${mb.m_nick}</td>
									<td>${mb.m_joindate}</td>
									<td>${mb.m_like}</td>
									<td>${mb.m_sellamount}</td>
									<td>${mb.m_reportcount}</td>
									<td>${mb.m_status}</td>
									<td>${mb.m_email}</td>
									<td><c:if test="${mb.m_out eq 'N'}">
					               <input type = "button" class ="outbtn" value ="회원삭제">
					               </c:if>
										<form action = "AdminDeleteMemberCtl.do" method ="post" class = "outform">
										<input type ="hidden" value ="${mb.m_id }" name  ="m_id">
										<input type = "text" name = "o_reason" placeholder = "삭제사유를 입력해주세요" class ="o_reason" required="required">
										<input type = "submit" value ="등록">
										<input type ="button" value ="취소" class  ="outclosebtn">
										</form>
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty mlist}">
							<tr>
								<td colspan='11'>검색결과가없습니다</td>
							</tr>
						</c:if>
					</table>
                              
                                                                                          </c:if>
<c:if test="${type eq 'S'}">
                              	<table>
					<tr>
						<td>신고번호</td>
						<td>신고자</td>
						<td>피신고자</td>
						<td>신고사유</td>

					</tr>
					<c:if test="${not empty slist }">
						<c:forEach items="${slist }" var="rb">
							<tr>
								<td>${rb.r_id }</td>
								<td>${rb.m_id }</td>
								<td>${rb.m_id2 }</td>
								<td>${rb.r_reason }</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty slist }">
							<tr>
								<td colspan ="4">검색결과가 없습니다</td>
							</tr>
					</c:if>
				</table>
                                                                                                                        </c:if>
                        <div id="GJW-serchbar">
                           <div id="GJW-BoardPagig">
                                 <a
                                    href="AdminListViewCtl.do?currentPage=<%=Integer.parseInt(request.getParameter("currentPage")) - 1%>&type=${param.type }" class="GJW-pagenumber">&nbsp;&nbsp;[이전]&nbsp;&nbsp;</a>
                                 <br>
                              <c:forEach begin="${startPage }" end="${endPage }" var="i">
                                    <a
                                       href="AdminListViewCtl.do?currentPage=<c:out value="${i }"/>&b_type=&type=${param.type }">&nbsp;<c:out
                                          value="${i }" />&nbsp;
                                    </a>
                              </c:forEach>
                                 <a
                                    href="AdminListViewCtl.do?currentPage=<%=Integer.parseInt(request.getParameter("currentPage")) + 1%>&type=${param.type }"
                                    class="GJW-pagenumber">&nbsp;&nbsp;[다음]&nbsp;&nbsp;</a>
                                 <br>
                        </div>

                  </div>
            </section>
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
            		<p><a href = "ProductgetCountCtl.do">&lt;상품 검색&gt;</a></p>
            		<ul>
            			<li><a href = "ProductCategoryCtl.do?c_lid=1">의류</a></li>
            			<li><a href = "product/ProductCategoryCtl.do?c_lid=2">가전제품</a></li>
            			<li><a href = "product/ProductCategoryCtl.do?c_lid=3">뷰티</a></li>
            			<li><a href = "product/ProductCategoryCtl.do?c_lid=4">아동용품</a></li>
            			<li><a href = "product/ProductCategoryCtl.do?c_lid=5">기타</a></li>
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
   $(function(){
		$(".outbtn").click(function(){
			$(this).next(".outform").css("display","block");
			$(this).css("display","none");
		})
		$(".outclosebtn").click(function(){
			$(this).parent(".outform").css("display","none");
			$(this).parent(".outform").prev(".outbtn").css("display","block");
			$(this).parent(".outform").children(".o_reason").val("");

		
		})
		
		
	})
   $(function(){
	   
	   
      $(".rd").click(function() {
         location.href = "AdminListViewCtl.do?type="+$(this).val();
      });
   })
   
      $(function() {
         if ($("#ge").is(":checked")) {
            $("#gela").css("color", " #CC8431");
            $("#boardtext").css("color", "#CC8431");
            $("#boardtext").text("상품 게시판");
            
         }
         if ($("#pro").is(":checked")) {
            $("#prola").css("color", "#CC8431");
            $("#boardtext").css("color", "#CC8431");
            $("#boardtext").text("일반 게시판");
         }
         if ($("#qna").is(":checked")) {
            $("#qnala").css("color", "#CC8431");

            $("#boardtext").css("color", "#CC8431");
            $("#boardtext").text("회원정보");
         }
         if ($("#news").is(":checked")) {
            $("#newsla").css("color", "#CC8431");
            $("#boardtext").css("color", "#CC8431");
            $("#boardtext").text("신고 리스트");
         }
      });

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
   
</body>
</html>