<%-- <%@page import="service.product.ProductService"%> --%>
<link rel = "stylesheet" href = "css/bootstrap.css">
<link rel = "stylesheet" href = "css/custom.css">
<link rel = "stylesheet" href = "css/jck_nav2.css">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src = "js/bootstrap.js"></script>
    <title>감자 마켓</title>
    
    
    
<style>
	 table, td {
            border: 1px solid #bcbcbc;
        }

        table {
            width: 600px;
            height: 800px;
            text-align: center;
            border-collapse: collapse;
            margin: 0 auto;
        }

        .yjh_jb-th-1 {
            width: 150px;
            text-align: center;
        }

        .yjh_jb-th-2 {
        width: 90%;
        height: 70%;
        
        }
        .ICR_writeBtn{
			border: 0;
			outline: 0;
			background-color: #B97A57;
			width: 80px;
			height: 30px;
			color: white;
			padding: 6px;
			cursor: pointer;
			border-radius: 5px;
		}
		input[type="file"]{
			display: inline-block;
		}
		#reimg1btn, #reimg2btn, #reimg3btn {
			display: none;
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
	<%
		
	String p_id = (request.getParameter("p_id") != null) ? request.getParameter("p_id") : "0";
	String p_status = request.getParameter("p_status");
	String p_premium = request.getParameter("p_premium");
	String l_id = request.getParameter("l_id");
	%>
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
				
				
				
				
				
				
	<form name="PwriteFrm" action="ProductModifyCtl2.do" method="post" enctype="multipart/form-data">
		<!-- 직접 입력한 값 말고 hidden 으로 숨겨진 애들도 다 가지고 간다. (보이진 않지만 소중한 값) -->
		<input type="hidden" name="p_id" value="${vo.p_id }">
		<input type="hidden" name=p_view value="${vo.p_view }">
		<input type="hidden" name=p_like value="${vo.p_like }">
		
		<!-- 삭제할 파일명 -->
		<input type="text" name="img1" id="imgdel1" value="0">
        <input type="text" name="img2" id="imgdel2" value="0">
        <input type="text" name="img3" id="imgdel3" value="0">
        
		<input type="text" name="eximg1" id="eximg1" value="${FName[2]}">
        <input type="text" name="eximg2" id="eximg2" value="${FName[1]}">
        <input type="text" name="eximg3" id="eximg3" value="${FName[0]}">
        

        
        
		<table>
			<tr>
				<td>제목</td>
				<td><input class="yjh_jb-th-2" type="text" name="p_name" value="${vo.p_name }" required="required" placeholder="제목을 입력하세요."></td>
			</tr>
			<tr>
				<td>가격</td>
				<td><input class="yjh_jb-th-2" type="text" name="p_value"  value="${vo.p_value }" required="required" placeholder="가격을 입력하세요."></td>
			</tr>
			<tr>
				<td>브랜드</td>
				<td><input class="yjh_jb-th-2" type="text" name="p_brand" value="${vo.p_brand }" required="required" placeholder="브랜드를 입력하세요."></td>
			</tr>
			<tr>
				<td>상세설명</td>
				<td>
				<textarea rows="10" cols="" name="p_description" class="yjh_jb-th-2" required="required" placeholder="상세설명을 입력하세요.">${vo.p_description }</textarea>
				</td>
			</tr>
			<tr>
				<td>상품상태</td>
				<td><label><input type="radio" name="p_status" value="A" checked='<c:if test="${vo.p_status eq A }"></c:if>'>A</label>
				<label><input type="radio" name="p_status" value="B" checked='<c:if test="${vo.p_status eq B }"></c:if>'>B</label>
				<label><input type="radio" name="p_status" value="C" checked='<c:if test="${vo.p_status eq C }"></c:if>'>C</label></td>
			</tr>
			<tr>
				<td>프리미엄 적용 여부</td>
				<td><label><input type="radio" name="p_premium" value="P" checked='<c:if test="${vo.p_premium eq P }"></c:if>'>프리미엄</label>
				<label><input type="radio" name="p_premium" value="G" checked='<c:if test="${vo.p_premium eq G }"></c:if>'>일반</label></td>
			</tr>
			<tr>
				<td>거래지역</td>
				<td><select id="ICR_Lid_selectbox" name="l_id" style="width: 130px; height: 25px;">
						<option value="1">강남구</option>
									<option value="2">강동구</option>
									<option value="3">강북구</option>
									<option value="4">강서구</option>
									<option value="5">관악구</option>
									<option value="6">광진구</option>
									<option value="7">구로구</option>
									<option value="8">금천구</option>
									<option value="9">노원구</option>
									<option value="10">도봉구</option>
									<option value="11">동대문구</option>
									<option value="12">동작구</option>
									<option value="13">마포구</option>
									<option value="14">서대문구</option>
									<option value="15">서초구</option>
									<option value="16">성동구</option>
									<option value="17">성북구</option>
									<option value="18">송파구</option>
									<option value="19">양천구</option>
									<option value="20">영등포구</option>
									<option value="21">용산구</option>
									<option value="22">은평구</option>
									<option value="23">종로구</option>
									<option value="24">중구</option>
									<option value="25">중랑구</option>
									<option value="26">강원</option>
									<option value="27">경기</option>
									<option value="28">경남</option>
									<option value="29">경북</option>
									<option value="30">전남</option>
									<option value="31">전북</option>
									<option value="32">충남</option>
									<option value="33">충북</option>
									<option value="34">제주특별자치도</option>
									<option value="35">부산</option>
									<option value="36">대구</option>
									<option value="37">인천</option>
									<option value="38">광주</option>
									<option value="39">대전</option>
									<option value="40">울산</option>
									<option value="41">세종특별자치시</option>
				</select></td>
			</tr>
			<tr>
				<td>카테고리 분류</td>
				<td><select id="ICR_clid_selectbox" name="c_lid" onchange="categoryChange(this)" style="width: 130px; height: 25px;">
						<option style="display: none;">카테고리 선택</option>
						<option value="1">의류</option>
						<option value="2">가전제품</option>
						<option value="3">뷰티</option>
						<option value="4">아동용품</option>
						<option value="5">기타</option>
				</select>
				<select  id="ICR_smallCategory" name="c_sid" style="width: 130px; height: 25px;">
					<option style="display: none;">소분류 선택</option>
				</select>
				</td>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td style="text-align: center;">
					대표이미지 : <input type="file" name="filename1" id="filename1"><br/>
					추가이미지 : <input type="file" name="filename2" id="filename2"><br/>
					추가이미지 : <input type="file" name="filename3" id="filename3">
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
				<c:if test="${not empty FName[2]}">
					<img src="./upload/${FName[2]}" id="showimg1" style="width: 60px; height: 60px;"><span class="filetext"></span>
					<input type="button" id="img1btn" value="이미지삭제">
					<input type="button" id="reimg1btn" value=되돌리기 class="rebtn">
				</c:if>
				<c:if test="${not empty FName[1]}">
					<img src="./upload/${FName[1]}" id="showimg2" style="width: 60px; height: 60px;"><span class="filetext"></span>
					<input type="button" id="img2btn" value="이미지삭제">
					<input type="button" id="reimg2btn" value=되돌리기 class="rebtn">
				</c:if>
				
				<c:if test="${not empty FName[0]}">
					<img src="./upload/${FName[0]}" id="showimg3" style="width: 60px; height: 60px;"><span class="filetext"></span>
					<input type="button" id="img3btn" value="이미지삭제">
					<input type="button" id="reimg3btn" value=되돌리기 class="rebtn">
				</c:if>
				
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
				<button class="ICR_writeBtn" type="button" id="ICR_WriteBtn" onclick="goWrite();">등록</button>
				<button class="ICR_writeBtn" type="button" onclick="window.location='ProductgetCountCtl.do'">상품목록</button>
				</td>
			</tr>
		</table>
	</form>
	
	
	
	
	
	
	
	
	
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
		
		//카테고리 선택 스크립트
		function categoryChange(e){
			var cloth = ["상의","하의","신발","모자","가방","의류 기타"];
			var elec = ["모바일","게임","노트북","카메라","모니터","가전제품 기타"];
			var beauty = ["색조","스킨케어","헤어","네일","남성화장품","뷰티 기타"];
			var child = ["여아의류","남아의류","장난감","기저귀","이유식","아동용품 기타"];
			var target = document.getElementById("ICR_smallCategory");
			
			if(e.value=="1") var d = cloth;
			else if(e.value=="2") var d = elec;
			else if(e.value=="3") var d = beauty;
			else if(e.value=="4") var d = child;
				target.options.length = 0;
				
			//소분류 value값
			for(i=0; i<d.length; i++){
				var opt = document.createElement("option");
				opt.value = i+1;
				opt.innerHTML = d[i];
				target.appendChild(opt);
			}
		}
		//Selectbox_setting
		window.onload = function ICR_selectbox(){
			document.getElementById("ICR_Lid_selectbox").value = ${vo.l_id};
			var e = document.getElementById("ICR_clid_selectbox");
			e.value = ${vo.c_lid};
			
			var cloth = ["상의","하의","신발","모자","가방","의류 기타"];
			var elec = ["모바일","게임","노트북","카메라","모니터","가전제품 기타"];
			var beauty = ["색조","스킨케어","헤어","네일","남성화장품","뷰티 기타"];
			var child = ["여아의류","남아의류","장난감","기저귀","이유식","아동용품 기타"];
			var target = document.getElementById("ICR_smallCategory");
			
			if(e.value=="1") var d = cloth;
			else if(e.value=="2") var d = elec;
			else if(e.value=="3") var d = beauty;
			else if(e.value=="4") var d = child;
				target.options.length = 0;
			
				//소분류 value값
				for(i=0; i<d.length; i++){
					var opt = document.createElement("option");
					opt.value = i+1;
					opt.innerHTML = d[i];
					target.appendChild(opt);
					target.value = "${vo.c_sid}";
				}
			}
	</script>
	
	<script>
    function goWrite(){
    	var Frm = document.PwriteFrm;
    	Frm.method = "POST";
	    Frm.action = "ProductModifyCtl2.do";
	    Frm.enctype = "multipart/form-data";
	    
	    var Num_test = /^[0-9]*$/;
    	var Text_test = /^[가-힣a-zA-Z]+$/;
    	
    	//유효성 검사하기
    	if(PwriteFrm.p_name.value==""){
    		alert("제목을 입력해주세요.");
    		PwriteFrm.p_name.value=="";
            PwriteFrm.p_name.focus();
            return false;
    	}else if(PwriteFrm.p_value.value==""){
    		alert("가격을 입력해주세요.");
    		PwriteFrm.p_value.value=="";
            PwriteFrm.p_value.focus();
            return false;
    	}else if(isNaN(PwriteFrm.p_value.value)){
    		alert("숫자만 입력해주세요.");
    		document.getElementById("p_value_id").value="";
            PwriteFrm.p_value.focus();
            return false;
		}else if(PwriteFrm.p_value.value.length>12){
	    		alert("올바른 가격을 입력해주세요.");
	    		document.getElementById("p_value_id").value="";
	            PwriteFrm.p_value.focus();
	            return false;
    	}else if(PwriteFrm.p_brand.value==""){
    		alert("상품 브랜드를 입력해주세요.");
    		PwriteFrm.p_brand.value=="";
            PwriteFrm.p_brand.focus();
            return false;
    	}else if(!Text_test.test(PwriteFrm.p_brand.value)){
    		alert("문자만 입력해주세요.");
    		document.getElementById("p_brand_id").value="";
            PwriteFrm.p_brand.focus();
            return false;
    	}else if(PwriteFrm.p_description.value==""){
    		alert("상세설명을 입력해주세요.");
    		PwriteFrm.p_description.value=="";
            PwriteFrm.p_description.focus();
            return false;
    	}else if(PwriteFrm.p_status.value==""){
    		alert("상품상태를 선택해주세요.");
            return false;
    	}else if(PwriteFrm.p_premium.value==""){
    		alert("프리미엄 여부를 선택해주세요.");
            return false;
    	}else if(PwriteFrm.c_lid.selectedIndex < 1){
    		alert("카테고리를 선택해주세요.");
    		PwriteFrm.c_lid.options[0].focus();
            return false;
    	}else{
    		Frm.submit();
    	}
    }
    </script>
   
    <script>
    $(function() {

       $("#filename1").on("change", function() {
          if (window.FileReader) {
             var filename = $(this)[0].files[0].name;
          }
          $(this).next().html(filename);
          var temp = URL.createObjectURL(event.target.files[0]);
          $("#showimg1").attr("src", temp);
          $("#showimg1").css("display", "inline");
       });

       $("#filename2").on("change", function() {
          if (window.FileReader) {
             var filename = $(this)[0].files[0].name;
          }
          $(this).next().html(filename);
          var temp = URL.createObjectURL(event.target.files[0]);
          $("#showimg2").attr("src", temp);
          $("#showimg2").css("display", "inline");
       });

       $("#filename3").on("change", function() {
          if (window.FileReader) {
             var filename = $(this)[0].files[0].name;
          }
          $(this).next().html(filename);
          var temp = URL.createObjectURL(event.target.files[0]);
          $("#showimg3").attr("src", temp);
          $("#showimg3").css("display", "inline");
       });

    });
    </script>
    
    
    <script>
    $(function(){

        $("#img1btn").click(function(){
        
        var img1val=$("#img1btn").val();
           $("#eximg1").val(0);
           $("#showimg1").css("display","none");
           $(this).css("display","none");
           $("#reimg1btn").css("display","inline");
           
        });
        
        $("#img2btn").click(function(){
        	$("#eximg2").val(0);
           $("#showimg2").css("display","none");
           $("#reimg2btn").css("display","inline");
           $(this).css("display","none");
        })
        
        $("#img3btn").click(function(){
        
        	$("#eximg3").val(0);
           $("#showimg3").css("display","none");
           $("#reimg3btn").css("display","inline");
           $(this).css("display","none");
        });
        
        $("#reimg1btn").click(function(){
           $("#img1").css("display","block");
           $(this).css("display","none");
           $("#showimg1").css("display","inline");
           $("#img1btn").css("display","inline");
           $("#eximg1").val("${FName[2]}");
        });
        $("#reimg2btn").click(function(){
                    
           $("#img2").css("display","block");
           $(this).css("display","none");
           $("#showimg2").css("display","inline");
           $("#img2btn").css("display","inline");
           $("#eximg2").val("${FName[1]}");
        });
        $("#reimg3btn").click(function(){
                    
           $("#img3").css("display","block");
           $(this).css("display","none");
           $("#showimg3").css("display","inline");
           $("#img3btn").css("display","inline");
           $("#eximg3").val("${FName[0]}");
        });
     });
    </script>
    
</body>
</html>