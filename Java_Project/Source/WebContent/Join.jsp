	<%-- <%@page import="service.product.ProductService"%> --%>
<link rel = "stylesheet" href = "css/bootstrap.css">
<link rel = "stylesheet" href = "css/custom.css">
<link rel = "stylesheet" href = "css/jck_nav.css">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%
    	String ctx = request.getContextPath();
    	String ctxPath = request.getContextPath();
    %>
<!DOCTYPE html>
<html>
<head>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
	%>
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
    <script src = "./js/jquery-3.5.1.js" type = "text/javascript"></script>
	<script src = "js/bootstrap.js"></script>
    <script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <title>감자 마켓</title>
	<style>
#jck_join_table {
	border-collapse: collapse;
}

#jck_join_table td {
	border: 3px solid orange;
}

#JWJmainsection {
	text-align: center;
}

#JWJmainsection table {
	text-align: left;
	margin: 0 auto;
	border-collapse: collapse;
}

#JWJmainsection table input {
	border: 2px solid black;
	padding : 2px 5px;
}

#JWJmainsection table textarea {
	border: 2px solid black;
}

#JWJmainsection table input[type='button'] {
	background-color: #CC8431;
	color : white;
	padding : 1px 13px;
}

#JWJmainsection table input[type='button']:hover{
	background-color: rgba(204,132,49,0.7);
}

#JWJmainsection table input[type='button']:active{
	background-color: rgba(204,132,49,0.7);
}

tr td:first-child, td:nth-of-type(2) {
	text-align: center;
	font-weight: bolder;
}

#JWJmainsection input {
	margin-bottom: 5px;
}

table * {
	font-size: 18px;
}

.filebox label {
	display: inline-block;
	padding: .5em .75em;
	color: #fff;
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #CC8431;
	cursor: pointer;
	border: 1px solid #000000;
	border-radius: .25em;
	-webkit-transition: background-color 0.2s;
	transition: background-color 0.2s;
	z-index: 1;
	position: relative;
}

.filebox label:hover {
	background-color: rgba(204,132,49,0.7);
}

.filebox label:active {
	background-color: rgba(204,132,49,0.7);
}

.filebox input[type="file"] {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

#showimg{
	height : 200px;
}

.jck_join_input{
	width : 250px;
}

.jck_join_button{
	background-color:#CC8431;
	color : white;
	padding : 9px 13px;
}

.jck_join_button:hover{
	background-color: rgba(204,132,49,0.7);
}
.jck_join_button:active{
	background-color: rgba(204,132,49,0.7);
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
			}, 4000);
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
            </div>
            <div class = "jck_content_container_div2">
                <div id="JWJmainsection">
					<form action="<%=ctx %>/JoinCtl.do" method="post" name="form1" id = "form1"
						enctype="multipart/form-data">
						<h1 id="top_title">
							<b>회원가입</b>
						</h1>
						<br>
						<table style="border-collapse: collapse; font-size: 9pt;">
							<tbody>
								<tr>
									<td colspan="3">&nbsp;</td>
								</tr>
								<tr class="register" height="30">
									<td width="5%" align="center">*</td>
									<td width="27%">이 름</td>
									<td><input type="text" id="username" name="username"
										required value="${param.username }" class = "jck_join_input"></td>
								</tr>
								<tr>
									<td colspan="3">&nbsp;</td>
								</tr>
								<tr class="register" height="30">
									<td width="5%" align="center">*</td>
									<td>회원 ID</td>
									<td><input type="text" id="id" name="id"
										onKeyup="idDupCheck();" required value="${param.id }" class = "jck_join_input">&nbsp;<span
										id="idOkSpan" name="idOkSpan"></span><input type="hidden"
										id="idOk" name="idOk" value="n" value="${param.idOk }"></td>
								</tr>
								<tr class="register" height="30">
									<td width="5%" align="center">&nbsp;</td>
									<td width="20%">&nbsp;</td>
									<td><b style="color: gray; font-size: 8pt;">대문자, 소문자,
											숫자 조합 / 최소 7자리</b></td>
								</tr>
								<tr>
									<td colspan="3">&nbsp;</td>
								</tr>
								<tr class="register" height="30">
									<td width="5%" align="center">*</td>
									<td width="20%">비밀번호</td>
									<td><input type="password" name="userpwd" id="userpwd"
										required value="${param.userpwd }" onKeyup="passwordSameCheck();" class = "jck_join_input">&nbsp;</td>
								</tr>
								<tr class="register" height="30">
									<td width="5%" align="center">&nbsp;</td>
									<td width="20%">&nbsp;</td>
									<td><b style="color: gray; font-size: 8pt;">첫글자 대문자 /
											대소문자, 숫자 사용 / 6~12글자</b></td>
								</tr>
								<tr>
									<td colspan="3">&nbsp;</td>
								</tr>
								<tr class="register" height="30">
									<td width="5%" align="center">*</td>
									<td width="20%">비밀번호 확인</td>
									<td><input type="password" name="userpwd2" id="userpwd2"
										onKeyup="passwordSameCheck();" value="${param.userpwd2 }"
										required class = "jck_join_input">&nbsp;<span id="passwordSpan"
										name="passwordSpan" style="display: none;"></span></td>
								</tr>
								<tr>
									<td colspan="3">&nbsp;</td>
								</tr>
								<tr class="register" height="30">
									<td width="5%" align="center">*</td>
									<td width="20%">휴대전화</td>
									<td><input type="text" id="userphone" name="userphone"
										placeholder="000-0000-0000" required
										value="${param.userphone }" class = "jck_join_input"></td>
								</tr>
								<tr>
									<td colspan="3">&nbsp;</td>
								</tr>
								<tr class="register" height="30">
									<td width="5%" align="center">*</td>
									<td width="20%">이메일</td>
									<td><input type="email" id="email" name="email"
										onKeyup="emailDupCheck();" required value="${param.email }" class = "jck_join_input">&nbsp;<span
										id="emailOkSpan" name="emailOkSpan"></span><input
										type="hidden" id="emailOk" name="emailOk" value="n"
										value="${param.emailOk }"></td>
								</tr>
								<tr>
									<td colspan="3">&nbsp;</td>
								</tr>
								<tr class="register" height="30">
									<td width="5%" align="center">*</td>
									<td width="20%">생년월일</td>
									<td><input type="date" id="userbirth" name="userbirth"
										style="width: 56%;" required value="${param.userbirth }" class = "jck_join_input"></td>
								</tr>
								<tr>
									<td colspan="3">&nbsp;</td>
								</tr>
								<tr>
									<td colspan="3">&nbsp;</td>
								</tr>
								<tr class="register" height="30">
									<td width="5%" align="center">*</td>
									<td width="20%">주소</td>
									<td><input type="text" id="sample4_postcode"
										onclick="sample4_execDaumPostcode()" placeholder="우편번호"
										readonly required value="${param.sample4_postcode }" class = "jck_join_input">
										<input type="button" onclick="sample4_execDaumPostcode()"
										value="우편번호 찾기"><br> <input type="text"
										id="sample4_roadAddress" name="sample4_roadAddress"
										placeholder="도로명주소" readonly required
										value="${param.sample4_roadAddress }" class = "jck_join_input"> <input
										type="text" id="sample4_jibunAddress" placeholder="지번주소"
										readonly value="${param.sample4_jibunAddress }" class = "jck_join_input"> <span
										id="guide" style="color: #999; display: none"></span> <br>
										<input type="hidden" id="sample4_extraAddress"
										placeholder="참고항목"> <input type="text"
										id="sample4_detailAddress" name="sample4_detailAddress"
										placeholder="상세주소를 입력해주세요."
										value="${param.sample4_detailAddress }" class = "jck_join_input"></td>
								</tr>
								<tr>
									<td colspan="3">&nbsp;</td>
								</tr>
								<tr class="register" height="30">
									<td width="5%" align="center">*</td>
									<td width="20%">성별</td>
									<td><input type="radio" name="wUserGender" value="M">남성&nbsp;&nbsp;&nbsp;&nbsp;<input
										type="radio" name="wUserGender" value="F">여성</td>
								</tr>
								<tr>
									<td colspan="3">&nbsp;</td>
								</tr>
								<tr class="register" height="30">
									<td width="5%" align="center">*</td>
									<td width="20%">프로필 이미지</td>
									<td>
										<div class="filebox">
											<span id="imgspan"></span> <label for="userimg">첨부하기</label>
											<input type="file" name="userimg" id="userimg">
											<label id = "imgDeleteBtn">&times;</label>
										</div>
									</td>
								</tr>
								<tr style ="border : 1px solid beige;">
									<td>&nbsp;</td>
									<td colspan="2">
										<img id = "showimg" name = "showimg">
									</td>
								</tr>
								
								<tr>
									<td colspan="3">&nbsp;</td>
								</tr>

								<tr class="register" height="30">
									<td width="5%" align="center">*</td>
									<td width="27%">닉네임</td>
									<td><input type="text" id="usernickname"
										name="usernickname" onKeyup="nickDupCheck();" required
										value="${param.usernickname }" class = "jck_join_input">&nbsp;<span
										id="nicknameOkSpan" name="nicknameOkSpan"></span><input
										type="hidden" name="nicknameOk" id="nicknameOk" value="n"
										value="${param.nicknameOk }"></td>
								</tr>
								<tr>
									<td colspan="3">&nbsp;</td>
								</tr>
								<tr class="register" height="30">
									<td width="5%" align="center">*</td>
									<td width="27%">프로필 소개글</td>
									<td><input type="text" id="userintro" name="userintro"
										placeholder="자신을 소개해주세요." value="${param.userintro }" class = "jck_join_input"></td>
								</tr>
								<tr>
									<td colspan="3">&nbsp;</td>
								</tr>
							</tbody>
						</table>
						<table style="text-align: center;">
							<tbody>
								<tr height="40">
									<td><input type="submit" id="btnSubmit" value="회원가입" class = "jck_join_button">
										<input type="reset" id="btnReset" value="취소" class = "jck_join_button"></td>
								</tr>
							</tbody>
						</table>
					</form>
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
            			<li><a href = "<%=ctxPath%>/servlet/product/ProductCategoryCtl.do?c_lid=1">의류</a></li>
            			<li><a href = "<%=ctxPath%>/servlet/product/ProductCategoryCtl.do?c_lid=2">가전제품</a></li>
            			<li><a href = "<%=ctxPath%>/servlet/product/ProductCategoryCtl.do?c_lid=3">뷰티</a></li>
            			<li><a href = "<%=ctxPath%>/servlet/product/ProductCategoryCtl.do?c_lid=4">아동용품</a></li>
            			<li><a href = "<%=ctxPath%>/servlet/product/ProductCategoryCtl.do?c_lid=5">기타</a></li>
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
    			location.href = "<%=ctxPath%>/servlet/product/ProductgetSearchCountCtl.do?SearchFilter="+$("#SearchFilter").val()+"&SearchStr="+$("#SearchStr").val();
    		});
    	});
    		
    	</script>
    	<script>
		//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
		function sample4_execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var roadAddr = data.roadAddress; // 도로명 주소 변수
							var extraRoadAddr = ''; // 참고 항목 변수

							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraRoadAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraRoadAddr += (extraRoadAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraRoadAddr !== '') {
								extraRoadAddr = ' (' + extraRoadAddr + ')';
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('sample4_postcode').value = data.zonecode;
							document.getElementById("sample4_roadAddress").value = roadAddr;
							document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

							// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
							if (roadAddr !== '') {
								document.getElementById("sample4_extraAddress").value = extraRoadAddr;
							} else {
								document.getElementById("sample4_extraAddress").value = '';
							}

							var guideTextBox = document.getElementById("guide");
							// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
							if (data.autoRoadAddress) {
								var expRoadAddr = data.autoRoadAddress
										+ extraRoadAddr;
								guideTextBox.innerHTML = '(예상 도로명 주소 : '
										+ expRoadAddr + ')';
								guideTextBox.style.display = 'block';

							} else if (data.autoJibunAddress) {
								var expJibunAddr = data.autoJibunAddress;
								guideTextBox.innerHTML = '(예상 지번 주소 : '
										+ expJibunAddr + ')';
								guideTextBox.style.display = 'block';
							} else {
								guideTextBox.innerHTML = '';
								guideTextBox.style.display = 'none';
							}
						}
					}).open();
		}
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
		$(function() {
			$("#userimg").on("change", function() {
				if (window.FileReader) {
					var filename = $(this)[0].files[0].name;
				}
				$("#imgspan").html(filename);
				
				var temp = URL.createObjectURL(event.target.files[0]);
				
				$("#showimg").attr("src", temp);
			});
			
			$("#imgDeleteBtn").on("click", function(){
				$("#userimg").val("");
				$("#imgspan").html("");
				$("#showimg").attr("src", "");
			});
		});

		function idDupCheck() {
			var uid = $("#id").val().trim();
			var ureg1 = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{7,}$/;
			if (uid != "") {
				if (!ureg1.test(uid)) {
					$("#idOkSpan").text("조건에 맞지 않습니다.");
					$("#idOk").val('n');
					$("#idOkSpan").css('color', 'red');
					return false;
				} else {
					$.ajax({
						type : "POST",
						url : "IdCheckCtl.do",
						data : {
							id : $("#id").val()
						},
						dataType : "json", // 전달받을 객체는 JSON 이다.
						success : function(data) {
							if (data.cnt == "0") {
								$("#idOkSpan").text("사용가능한 ID 입니다.");
								$("#idOk").val('y');
								$("#idOkSpan").css('color', 'green');
							} else {
								$("#idOkSpan").text("사용 불가능한 ID 입니다.");
								$("#idOk").val('n');
								$("#idOkSpan").css('color', 'red');
							}
						},
						error : function(request, status, error) {
							console.log("code:" + request.status + "\n"
									+ "message:" + request.responseText + "\n"
									+ "error:" + error);
						}
					});
				}	
			}
		}

		function nickDupCheck() {
			if ($("#usernickname").val() != null && $("#usernickname").val() != "") {
				$.ajax({
					type : "POST",
					url : "NickCheckCtl.do",
					data : {
						usernickname : $("#usernickname").val()
					},
					dataType : "json", // 전달받을 객체는 JSON 이다.
					success : function(data) {
						if (data.cnt == "0") {
							$("#nicknameOkSpan").text("사용 가능한 닉네임입니다.");
							$("#nicknameOk").val('y');
							$("#nicknameOkSpan").css('color', 'green');
						} else {
							$("#nicknameOkSpan").text("사용 불가능한 닉네임입니다.");
							$("#nicknameOk").val('n');
							$("#nicknameOkSpan").css('color', 'red');
						}
					},
					error : function(request, status, error) {
						console.log("code:" + request.status + "\n"
								+ "message:" + request.responseText + "\n"
								+ "error:" + error);
					}
				});
			}
		}

		function emailDupCheck() {
			if ($("#email").val() != null && $("#email").val() != "") {
				$.ajax({
					type : "POST",
					url : "EmailCheckCtl.do",
					data : {
						email : $("#email").val()
					},
					dataType : "json", // 전달받을 객체는 JSON 이다.
					success : function(data) {
						if (data.cnt == "0") {
							$("#emailOkSpan").text("사용 가능한 EMAIL입니다.");
							$("#emailOk").val('y');
							$("#emailOkSpan").css('color', 'green');
						} else {
							$("#emailOkSpan").text("사용 불가능한 EMAIL입니다.");
							$("#emailOk").val('n');
							$("#emailOkSpan").css('color', 'red');
						}
					},
					error : function(request, status, error) {
						console.log("code:" + request.status + "\n"
								+ "message:" + request.responseText + "\n"
								+ "error:" + error);
					}
				});
			}
		}

		function passwordSameCheck() {
			var pwd1 = $("#userpwd").val().trim();

			var pwd2 = $("#userpwd2").val().trim();
			if (pwd1 != pwd2) {
				$("#passwordSpan").text("비밀번호가 다릅니다.");
				$("#passwordSpan").css('display', 'inline-block');
				$("#passwordSpan").css('color', 'red');
			} else {
				$("#passwordSpan").text("비밀번호가 동일합니다.");
				$("#passwordSpan").css('display', 'inline-block');
				$("#passwordSpan").css('color', 'green');
			}
		}

		$("form1").submit(function() {
							var IOK = $("#idOk").val();
							if (IOK == 'n') {
								alert("ID 변경이 필요합니다.");
								$("#id").val("");
								$("#id").focus();
								return false;
							}

							var EOK = $("#emailOk").val();
							if (EOK == 'n') {
								alert("EMAIL 변경이 필요합니다.");
								$("#email").val("");
								$("#email").focus();
								return false;
							}

							var pwd1 = $("#userpwd").val().trim();
							var reg1 = /^[A-Z][A-Za-z0-9_]{5,11}$/;
							var reg2 = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,12}$/;
							/* ?= 있는지 .*길이에 상관없이 임의의 문자열 숫자 */

							if (pwd1 != "") {
								if (!reg1.test(pwd1)) {
									alert("조건에 맞게 입력해주세요. [비밀번호 첫글자는 대문자, 6글자이상, 12글자 이하, 숫자, 영문자까지 입력이 가능.]");
									$("#userpwd").val("");
									return false;
								} else if (!reg2.test(pwd1)) {
									alert("조건에 맞게 입력해주세요. [비밀번호는 대문자, 소문자, 숫자가 반드시 1개이상 입력되어야 한다.]");
									$("#userpwd").val("");
									return false;
								}
							}

							var pwd2 = $("#userpwd2").val().trim();
							if (pwd1 != pwd2) {
								alert('비밀번호가 일치하지 않습니다.');
								$("#userpwd2").val("");
								$("#userpwd2").focus();
								return false;
							}

							var a = $("#userphone").val().trim();
							var regVal = /[0][0-9]{1,2}-[0-9]{3,4}-[0-9]{4,4}/;
							if (!regVal.test(a)) {
								alert("전화번호 형식에 맞춰 작성해 주세요.(010-0000-0000)");
								$("#userphone").val('').focus();

								return false;
							}

							var rcheck = $("input[name='wUserGender']").length;

							if (rcheck == 0) {

								alert("성별을 선택하세요");

								return false;

							}
						});
	</script>
</body>
</html>