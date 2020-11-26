	<%-- <%@page import="service.product.ProductService"%> --%>
<%@page import="vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@page import="dao.MemberDAO"%>
<link rel = "stylesheet" href = "css/bootstrap.css">
<link rel = "stylesheet" href = "css/custom.css">
<link rel = "stylesheet" href = "css/jck_nav.css">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <script src="http://code.jquery.com/jquery-latest.js"></script>
	<script src = "js/bootstrap.js"></script>
    <title>감자 마켓</title>
	<style type="text/css">
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
	border : 0px;
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
		
		$(document).ready(function() {
			$('#profileintro').on('keyup', function() {
				if ($(this).val().length > 100) {
					$(this).val($(this).val().substring(0, 100));
				}
			});
			$("#userpwd2").on("input", function() {

				if ($("#userpwd").val() != $("#userpwd2").val()) {
					$("#pwchkmsg").css("display", "none");
					$("#pwchkmsg1").css("display", "inline-block");
					$("#pwchkmsg2").css("display", "none");
				} else {
					$("#pwchkmsg").css("display", "none");
					$("#pwchkmsg1").css("display", "none");
					$("#pwchkmsg2").css("display", "inline-block");
				}

			});
		});
	</script>
	<style>
#JWJprofileform {
	position: relative;
	left: 50%;
	transform: translateX(-50%);
	width: 70%;
	padding-top: 20px;
	text-align: left;
}

#JWJprofiletable {
	margin: 0 auto;
}

#formbtn {
	text-align: center;
}

#pwchkmsg {
	color: orange;
	font-size: 8pt;
}

#pwchkmsg1 {
	color: red;
	font-size: 8pt;
}

#pwchkmsg2 {
	color: green;
	font-size: 8pt;
	
}
body {
	margin: 0 auto;
	padding-top: 100px;
	width: 100%;
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
            </div>
            <div class = "jck_content_container_div2">
               <div id="JWJmainsection" style="both:clear;">

				<div id="JWJpagetitle" style="text-align:center;">
					<h1>프로필 수정</h1>
				</div>
		<div id="JWJprofileform">
			<form action="./UpdateProfile.do" method="post" name="form1">
				<%
						String id = (String) session.getAttribute("userID");

						MemberDAO dao = new MemberDAO();
						List<MemberVO> mVoList = dao.ShowProfile(id);
						MemberVO mvo = mVoList.get(0);
				%>
				<fieldset
					style="border: 0; border-top: 1px solid gray; border-bottom: 1px solid gray;">
					<legend style="text-align: center;">&nbsp;&nbsp;회&nbsp;원&nbsp;정&nbsp;보&nbsp;&nbsp;</legend>
					<table id="JWJprofiletable">
						<tbody>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr class="register" height="30">
								<td width="5%" align="center">*</td>
								<td width="30%">이 름</td>
								<td><input type="text" id="username" name="username"
									readonly required value="<%=mvo.getM_name()%>" style="border:none;"></td>
								<td></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr class="register" height="30">
								<td width="5%" align="center">*</td>
								<td width="30%">회원 ID</td>
								<td><input type="text" id="id" name="id" readonly
									value="<%=mvo.getM_id()%>" style="border:none;"></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr class="register" height="30">
								<td width="5%" align="center">*</td>
								<td width="30%">비밀번호</td>
								<td><input type="password" name="userpwd" id="userpwd"
									value="<%=mvo.getM_pw()%>" required>&nbsp; <b
									style="color: gray; font-size: 8pt;">첫글자 대문자 / 대소문자,_ 사용 /
										6~12글자</b></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr class="register" height="30">
								<td width="5%" align="center">*</td>
								<td width="30%">비밀번호 확인</td>
								<td><input type="password" name="userpwd2" id="userpwd2"
									required>&nbsp;<b id="pwchkmsg"
									style="display: inline-block;">* 비밀번호를 입력해주세요.</b> <b
									id="pwchkmsg1" style="display: none;">* 비밀번호를 확인해주세요.</b> <b
									id="pwchkmsg2" style="display: none;">* 확인 되었습니다.</b></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr class="register" height="30">
								<td width="5%" align="center">*</td>
								<td width="30%">휴대전화</td>
								<td><input type="text" id="userphone" name="userphone"
									value="<%=mvo.getM_phone()%>" required></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr class="register" height="30">
								<td width="5%" align="center">*</td>
								<td width="30%">이메일</td>
								<td><input type="email" id="email" name="email" readonly
									value="<%=mvo.getM_email()%>" required>&nbsp;<input
									type="button" value="중복체크" onclick="emailDupCheck()"></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr class="register" height="30">
								<td width="5%" align="center">*</td>
								<td width="30%">생년월일</td>
								<td><input type="date" id="userbirth" name="userbirth"
									style="width: 56%;" value="<%=mvo.getM_birth()%>" required></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<%
								String addr = mvo.getM_address();
							String[] arr = addr.split("_");
							%>
							<tr class="register" height="30">
								<td width="5%" align="center">*</td>
								<td width="30%">주소</td>
								<td><input type="text" id="sample4_postcode" onclick="sample4_execDaumPostcode()"
									placeholder="우편번호" class = "jck_join_input"> <input type="button"
									onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
									<input type="text" id="sample4_roadAddress"
									name="roadAddress" placeholder="도로명주소"
									value="<%=arr[0]%>"  class = "jck_join_input"><br> <input type="text"
									id="sample4_jibunAddress" placeholder="지번주소"  class = "jck_join_input"> <span
									id="guide" style="color: #999; display: none"></span> <br>
									<input type="text"
									id="sample4_detailAddress" name="detailAddress"
									placeholder="상세주소를 입력해주세요." value="<%=arr[1]%>"  class = "jck_join_input"></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr class="register" height="30">
								<td width="5%" align="center">*</td>
								<td width="30%">성별</td>
								<td><input type="radio" name="wUserGender" id="man"
									value="M" <%if (mvo.getM_gender() == 'M') {%> checked="checked"
									<%}%>>남성&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio"
									name="wUserGender" id="woman" value="F"
									<%if (mvo.getM_gender() == 'F') {%> checked="checked" <%}%>>여성</td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr class="register" height="30">
								<td width="5%" align="center">*</td>
								<td width="30%">프로필 이미지</td>
								<td><input type="text" id="userimg" name="userimg"
									value="<%=mvo.getM_image()%>">&nbsp;&nbsp;<input
									type="button" id="imgbtn" name="imgbtn" value="파일첨부"> <br>
								<img src="./profileIMG/<%=mvo.getM_image()%>"></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>

							<tr class="register" height="30">
								<td width="5%" align="center">*</td>
								<td width="30%">닉네임</td>
								<td><input type="text" id="usernickname"
									name="usernickname" readonly value="<%=mvo.getM_nick()%>" required style="border:none;"></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr class="register" height="30">
								<td width="5%" align="center">*</td>
								<td width="30%">프로필 소개글</td>
								<td><textarea rows="2" cols="40" style="resize: none;"
										id="profileintro" name="profileintro"><%=mvo.getM_intro()%></textarea></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
						</tbody>
					</table>
				</fieldset>
				<div id="formbtn">
					<br> <input class = "jck_join_button" type="submit" id="btnSubmit" value="수정완료">&nbsp;&nbsp;&nbsp;&nbsp;<input
						class = "jck_join_button" type="button" id="btnback" value="취소"
						onclick="location.href='./MyPage.jsp'">
				</div>
			</form>
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
</body>
</html>