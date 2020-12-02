<%@page import="service.ProductService"%>
<%@page import="vo.MemberVO"%>
<%@page import="java.util.List"%>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="css/jck_nav.css">
<link rel="stylesheet" href="css/JWJ_MyPage.css">

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
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
<script src="http://code.jquery.com/jquery-latest.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src = "js/bootstrap.js"></script>
<title>감자 마켓</title>
<style type="text/css">
#setupbtn{
	background-color : #B97A57;
	height : 100%;
	color : white;
	margin : 0;
}
.middle_input {
	width: 6vw;
	height: 35px;
	color: white;
	background-color: #CC8431;
	border-radius: 25px;
	box-sizing: border-box;
	text-align: center;
}
</style>

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
		
		
		$(function() {
			$("#m_like").click(function() {
				$("#likemembercheck").css("display", "block");
			});
			$("#clear").click(function() {
				$("#likemembercheck").css("display", "none");
			});
		});
	</script>
	<style type="text/css">
.jck_content_container{
margin-top : 5vh;
}
</style>
<style>

#JWJsaleslist {
	position: relative;
	left: 50%;
	transform: translateX(-50%);
	width: 80%;
}

#JWJsaleslisttbl {
	position: relative;
	left: 50%;
	transform: translateX(-50%);
	width: 100%;
	border: 1px solid #444444;
	border-collapse: collapse;
}

#JWJsaleslisttbl tr {
	border: 1px solid #444444;
}

#JWJsaleslisttbl td {
	border: 1px solid #444444;
}

#JWJbuylist {
	position: relative;
	left: 50%;
	transform: translateX(-50%);
	width: 80%;
}

#JWJbuylisttbl {
	position: relative;
	left: 50%;
	transform: translateX(-50%);
	width: 100%;
	border: 1px solid #444444;
	border-collapse: collapse;
}

#JWJbuylisttbl tr {
	border: 1px solid #444444;
}

#JWJbuylisttbl td {
	border: 1px solid #444444;
}

#JWJsearchassistant {
	border: 1px solid #444444;
	height: 70px;
	vertical-align: middle;
	line-height: 60px;
}

#searchinfo {
	height: 100px;
	text-align: left;
}

#changeDealStatus1 {
	display: none;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translateY(-50%);
	transform: translateX(-50%);
	width: 300px;
	border: 1px solid black;
	background: white;
	top: 50%;
	padding: 30px 30px 30px 30px;
}

#changeDealStatus2 {
	display: none;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translateY(-50%);
	transform: translateX(-50%);
	width: 300px;
	border: 1px solid black;
	background: white;
	top: 50%;
	padding: 30px 30px 30px 30px;
}

.jck_content_container_div1 {
	flex-basis: 0%;
}

.jck_content_container_div2 {
	flex-basis: 100%;
}

.jck_content_container_div3 {
	flex-basis: 0%;
}
.middle_input {
	width: 8vw;
	height: 35px;
	color: white;
	background-color: #CC8431;
	border-radius: 25px;
	box-sizing: border-box;
	text-align: center;
}
</style>
<script>
	$(function(){
		$("#showsaleslist").click(function(){
			$("#JWJsaleslist").css("display","block");
			$("#JWJbuylist").css("display","none");
			$("#showsaleslist").css("color","white");
			$("#showsaleslist").css("background","#B97A57");
			$("#showbuylist").css("color","#B97A57");
			$("#showbuylist").css("background","white");
		});
		$("#showbuylist").click(function(){
			$("#JWJsaleslist").css("display","none");
			$("#JWJbuylist").css("display","block");
			$("#showbuylist").css("color","white");
			$("#showbuylist").css("background","#B97A57");
			$("#showsaleslist").css("color","#B97A57");
			$("#showsaleslist").css("background","white");
		});
	});
	
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

				<div id="JWJmainsection">
					<%
		String id = (String) session.getAttribute("userID");
		%>
					<div id="JWJpagetitle" style="padding-bottom: 20px;">
						<h1>거래 목록</h1>
					</div>
					<hr id="divline" style="width: 80%;">
					<h2>
						<a id="showsaleslist"
							<%if (request.getAttribute("Search") == "buy") {%>
							style="color: #B97A57; background: white;" <%} else {%>
							style="color:white; background:#B97A57;" <%}%>>판매 내역 조회 </a>
						&nbsp;&nbsp;|&nbsp;&nbsp; <a id="showbuylist"
							<%if (request.getAttribute("Search") == "buy") {%>
							style="color: white; background: #B97A57;" <%} else {%>
							style="color:#B97A57; background:white;" <%}%>>구매 내역 조회</a>
					</h2>

					<div id="JWJsaleslist"
						<%if (request.getAttribute("Search") == "buy") {%>
						style="display:none;<%}%>">
						<form action="./SalesList" method="post">
							<div id="JWJsearchassistant">
								<b style="font-size: 7pt">* 조회할 기간 설정&nbsp;&nbsp;</b> <input
									type="date" id="startDate" name="startDate">&nbsp;&nbsp;~&nbsp;&nbsp;
								<input type="date" id="endDate" name="endDate">&nbsp;&nbsp;
								<input type="submit" id="setupbtn" name="setupbtn" value="조회하기">
							</div>
						</form>
						<div id="searchinfo">
							<b style="font-size: 7pt;"> * 기본적으로 최근 3개월간의 자료가 조회되며, 기간 검색시 지난 판매내역을 조회하실 수 있습니다.<br> * 리스트의 상품을 클릭하시면 상세내용을 확인하실 수 있습니다.
							</b>
						</div>
						<form name="frm" action="./changeDealStatus.do"
							method="post">
							<table id="JWJsaleslisttbl" style="width: 100%;">
								<tr>
									<td width="10%">글 번호</td>
									<td width="10%">등록 일자</td>
									<td width="25%">상품 제목</td>
									<td width="10%">좋아요</td>
									<td width="10%">프리미엄</td>
									<td width="10%">거래 여부</td>
								</tr>

								<c:if test="${not empty transactionList}">
									<c:forEach items="${ transactionList }" var="mvo" varStatus="s">
										<tr>
											<td id="p_id" style="display: none">${mvo.p_id }</td>
											<td>${s.count}</td>
											<td>${mvo.p_adddate}</td>
											<td>${mvo.p_name}</td>
											<td>${mvo.p_like}</td>
											<td>${mvo.p_premium}</td>
											<c:choose>
												<c:when test="${mvo.p_dealstatus eq 'N'.charAt(0)}">
													<td><input type="text" id="dealstatus"
														name="dealstatus" value="N" style="display: none">
														<b class="opencheck1"
														style="width: 100%; background: green; color: white; cursor: pointer;">판매중</b></td>
													<td id="p_dealstatus" style="display: none">${mvo.p_dealstatus }</td>
												</c:when>
												<c:otherwise>
													<td><input type="text" id="dealstatus"
														name="dealstatus" value="Y" style="display: none">
														<b class="opencheck2"
														style="width: 100%; background: orange; color: white; cursor: pointer;">판매완료</b></td>
													<td id="p_dealstatus" style="display: none">${mvo.p_dealstatus }</td>
												</c:otherwise>
											</c:choose>
										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${empty transactionList }">
									<tr>
										<td colspan="6" height=100 style="word-break: break-all;">판매한
											상품이 없습니다.</td>
									</tr>
								</c:if>
							</table>
							<script>
				$(function() {
					$(".opencheck1").click(function() {
						$("#changeDealStatus1").css("display", "block");
					});

					$(".opencheck2").click(function() {
						$("#changeDealStatus2").css("display", "block");
					});

					$(".reset").click(function() {
						$("#changeDealStatus1").css("display", "none");
						$("#changeDealStatus2").css("display", "none");
					});
					
				});

					$(".opencheck1").click(function() {
						var checkBtn = $(this);
						var tr = checkBtn.parent().parent();
						var td = tr.children();

						$("#p_id_value").val(td.eq(0).text());
						$("#dealstatus_value").val(td.eq(7).text());
					});

					$(".opencheck2").click(function() {
						var checkBtn = $(this);
						var tr = checkBtn.parent().parent();
						var td = tr.children();

						$("#p_id_value").val(td.eq(0).text());
						$("#dealstatus_value").val(td.eq(7).text());
					});
					
				</script>
							<div id="changeDealStatus1">
								다음 상품을 판매완료 하시겠습니까?<br> <input type="text" id="p_id_value"
									name="p_id_value" style="display: none;"><input
									type="text" id="dealstatus_value" name="dealstatus_value"
									style="display: none;"><input type="text" id="buyerid"
									name="buyerid" placeholder="구매자 아이디를 입력해주세요." required
									style="width: 200px; margin-top: 10px;"><br> <br>
								<input type="submit" value="확인"  class = "middle_input"> <input type="reset"
									id="reset" value="취소"  class = "reset middle_input">
							</div>
							<div id="changeDealStatus2">
								다음 상품을 판매완료를 취소하시겠습니까?<br> <input type="text"
									id="p_id_value" name="p_id_value" style="display: none;"><input
									type="text" id="dealstatus_value" name="dealstatus_value"
									style="display: none;"><br> <input type="button"
									value="확인" class="submit middle_input" onclick="newSubmit()"> <input
									type="button" id="reset" class="reset middle_input" value="취소">
							</div>

							<script>
				function newSubmit(){
					document.frm.submit();
				}					
				</script>

						</form>
					</div>


					<div id="JWJbuylist"
						<%if (request.getAttribute("Search") == "buy") {%>
						style="display: block;" <%} else {%> style="display:none;" <%}%>>
						<form action="./BuyList" method="post">
							<div id="JWJsearchassistant">
								<b style="font-size: 7pt">* 조회할 기간 설정&nbsp;&nbsp;</b> <input
									type="date" id="startDate1" name="startDate1">&nbsp;&nbsp;~&nbsp;&nbsp;
								<input type="date" id="endDate1" name="endDate1">&nbsp;&nbsp;
								<input type="submit" id="setupbtn" name="setupbtn" value="조회하기">
							</div>
							<script>
				if(<%=request.getAttribute("endDate")%> == null){
					var endDate = new Date();
					$("#endDate").val(getFormatDate(endDate));
				}else{
					$("#endDate").val("<%=request.getAttribute("endDate")%>");
				}
				
				if(<%=request.getAttribute("startDate")%> == null){
					var startDate = new Date();
					startDate.setMonth(startDate.getMonth() - 3);
					
					$("#startDate").val(getFormatDate(startDate));
				}else{
					$("#startDate").val("<%=request.getAttribute("startDate")%>");
				}
				
				if(<%=request.getAttribute("endDate1")%> == null){
					var endDate1 = new Date();
					$("#endDate1").val(getFormatDate(endDate1));
				}else{
					$("#endDate1").val("<%=request.getAttribute("endDate1")%>");
				}
				
				if(<%=request.getAttribute("startDate1")%> == null){
					var startDate1 = new Date();
					startDate1.setMonth(startDate1.getMonth() - 3);
					
					$("#startDate1").val(getFormatDate(startDate1));
				}else{
					$("#startDate1").val("<%=request.getAttribute("startDate1")%>");
					}

					function getFormatDate(date) {
						var year = date.getFullYear();
						var month = (1 + date.getMonth());
						month = month >= 10 ? month : '0' + month;
						var day = date.getDate();
						day = day >= 10 ? day : '0' + day;
						return year + '-' + month + '-' + day;
					}
				</script>
						</form>
						<div id="searchinfo">
							<b style="font-size: 7pt;"> * 기본적으로 최근 3개월간의 자료가 조회되며, 기간 검색
								시 지난 구매내역을 조회하실 수 있습니다.<br> * 리스트의 상품을 클릭하시면 상세내용을 확인하실 수
								있습니다.
							</b>
						</div>
						<table id="JWJsaleslisttbl" style="width: 100%;">
							<tr>
								<td width="10%">글 번호</td>
								<td width="10%">등록 일자</td>
								<td width="25%">상품 제목</td>
								<td width="10%">좋아요</td>
								<td width="10%">프리미엄</td>
								<td width="10%">거래 여부</td>
							</tr>
							<c:if test="${not empty buyList}">
								<c:forEach items="${ buyList }" var="pvo" varStatus="b">
									<tr>
										<td id="p_id" style="display: none">${pvo.p_id }</td>
										<td>${b.count}</td>
										<td>${pvo.p_adddate}</td>
										<td>${pvo.p_name}</td>
										<td>${pvo.p_like}</td>
										<td>${pvo.p_premium}</td>
										<td><input type="text" id="dealstatus" name="dealstatus"
											value="Y" style="display: none"> <b id="opencheck1"
											style="width: 100%; background: #880015; color: white; cursor: pointer;">구매완료</b></td>
										<td id="p_dealstatus" style="display: none">${pvo.p_dealstatus }</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty buyList }">
								<tr>
									<td colspan="6" height=100 style="word-break: break-all;">구매한
										상품이 없습니다.</td>
								</tr>
							</c:if>
						</table>
					</div>
				</div>
			</div>
			<div class="jck_content_container_div3 jck_nav_container">
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
				      %>

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
							<li><a href="ProductCategoryCtl.do?c_lid=1">의류</a></li>
							<li><a href="ProductCategoryCtl.do?c_lid=2">가전제품</a></li>
							<li><a href="ProductCategoryCtl.do?c_lid=3">뷰티</a></li>
							<li><a href="ProductCategoryCtl.do?c_lid=4">아동용품</a></li>
							<li><a href="ProductCategoryCtl.do?c_lid=5">기타</a></li>
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
		$(document)
				.ready(
						function() {
							$("#jck_mainpage_btn1").click(function() {
								location.href = "./ProductMainPageGetCountCtl.do";
							});
							$("#jck_mainpage_btn2").click(function() {
								location.href = "./ProductMainPageGetCountCtl.do";
							});
							$("#jck_mypagebefore").click(function() {
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
							$("#jck_loginbefore").click(function() {
								location.href = "./Login.jsp";
							});
							$("#jck_loginafter").click(function() {
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
</body>
</html>