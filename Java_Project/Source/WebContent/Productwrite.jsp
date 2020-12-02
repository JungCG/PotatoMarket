<%@page import="service.ProductService"%>
<link rel = "stylesheet" href = "css/bootstrap.css">
<link rel = "stylesheet" href = "css/custom.css">
<link rel = "stylesheet" href = "css/jck_nav2.css">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
		#showimg1, #showimg2, #showimg3{
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
			}, 10000);
		}
		
		function showUnread(result){
			$('#unread').html(result);
		}
		
		
	</script>
    
</head>
<body>
	<%
	String p_id = (request.getParameter("p_id") != null) ? request.getParameter("p_id") : "0";
	%>
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
            <div class = "jck_content_container_div1">
            </div>
            <div class = "jck_content_container_div2">
            
                <form name="PwriteFrm" action="ProductWriteCtl.do" method="post" enctype="multipart/form-data">
					<!-- 직접 입력한 값 말고 hidden 으로 숨겨진 애들도 다 가지고 간다. (보이진 않지만 소중한 값) -->
					<input type="hidden" name="p_id" value="<%=p_id%>">
					<table>
						<tr>
							<td>제목</td>
							<td><input type="text" name="p_name" class="yjh_jb-th-2" required="required" placeholder="제목을 입력하세요."></td>
						</tr>
						<tr>
							<td>가격</td>
							<td><input type="text" name="p_value" id="p_value_id" class="yjh_jb-th-2" required="required" placeholder="가격을 입력하세요."></td>
						</tr>
						<tr>
							<td>브랜드</td>
							<td><input type="text" name="p_brand" id="p_brand_id" class="yjh_jb-th-2" required="required" placeholder="상품 브랜드를 입력하세요."></td>
						</tr>
						<tr>
							<td>상세설명</td>
							<td>
							<textarea rows="10" cols="" name="p_description" id="yjh_comment_box" class="yjh_jb-th-2" required="required" placeholder="상세설명을 입력하세요."></textarea>
							</td>
						</tr>
						<tr>
							<td>상품상태</td>
							<td><label><input type="radio" name="p_status" value="A">A</label>
							<label><input type="radio" name="p_status" value="B">B</label>
							<label><input type="radio" name="p_status" value="C">C</label></td>
						</tr>
						<tr>
							<td>프리미엄 적용 여부</td>
							<td><label><input type="radio" name="p_premium" value="P">프리미엄</label>
							<label><input type="radio" name="p_premium" value="G">일반</label></td>
						</tr>
						<tr>
							<td>거래지역</td>
							<td><select name="l_id" style="width: 130px; height: 25px;">
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
							<td><select name="c_lid" onchange="categoryChange(this)" style="width: 130px; height: 25px;">
									<option style="display: none;">카테고리 선택</option>
									<option value="1">의류</option>
									<option value="2">가전제품</option>
									<option value="3">뷰티</option>
									<option value="4">아동용품</option>
									<option value="5">기타</option>
							</select>
							<select name="c_sid" id="ICR_smallCategory" style="width: 130px; height: 25px;">
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
							<td colspan="2">
							<img id="showimg1" style="width: 60px; height: 60px;"><span class="filetext"></span>
							<img id="showimg2" style="width: 60px; height: 60px;"><span class="filetext"></span>
							<img id="showimg3" style="width: 60px; height: 60px;"><span class="filetext"></span>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: center;">
							<button class="ICR_writeBtn" type="button" id="ICR_WriteBtn" onclick="goWrite();">등록</button>
							<button class="ICR_writeBtn" type="reset">다시작성</button>
							<button class="ICR_writeBtn" type="button" onclick="window.location='ProductgetCountCtl.do'">상품목록</button>
							</td>
						</tr>
					</table>
				</form>
				
				
				
				
				
				
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
    </script>
    
    <script>
    function goWrite(){
    	var Frm = document.PwriteFrm;
    	Frm.method = "POST";
	    Frm.action = "ProductWriteCtl.do";
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
    	}else if(PwriteFrm.filename1.value=="" || PwriteFrm.filename2.value=="" || PwriteFrm.filename3.value==""){
          alert("3개의 이미지를 첨부해주세요.");
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
       })

    });
    </script>
</body>
</html>