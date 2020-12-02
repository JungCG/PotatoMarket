<%@page import="service.ProductService"%>
<link rel = "stylesheet" href = "css/bootstrap.css">
<link rel ="stylesheet" href ="css/GJW-BoardWrite.css">
<link rel = "stylesheet" href = "css/custom.css">
<link rel = "stylesheet" href = "css/jck_nav.css">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
#showimg1{
width: 300px;
}
#showimg2{
width: 300px;
}
#showimg3{
width: 300px;
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
    <title>게시판 글작성</title>
	
	
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
      String b_ref = (request.getParameter("b_ref") != null) ? request.getParameter("b_ref") : "0";
   String b_re_step = (request.getParameter("b_re_step") != null) ? request.getParameter("b_re_step") : "0";
   String b_re_level = (request.getParameter("b_re_level") != null) ? request.getParameter("b_re_level") : "0";
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
            <div class="GJW-writeBoardSection">
               <form method="post" enctype="multipart/form-data" name="go"
                  action="BoardContentWriteCtl.do">
                  <input type="hidden" name="b_ref" value="<%=b_ref%>"> <input
                     type="hidden" name="b_re_step" value="<%=b_re_step%>"> <input
                     type="hidden" name="b_re_level" value="<%=b_re_level%>">
                  <input type="hidden" name="currentPage"
                     value="<%=request.getParameter("currentPage")%>">
                  <table class="bowrtbl">
                     <tr>
                     </tr>
                     <tr>
                        <td>작성자ID</td>
                        <td><input type="text" name="m_id"
                           value="<%=session.getAttribute("userID")%>" readonly="readonly" style="border:none;"></td>
                     </tr>
                     <tr class="trline">
                        <td>게시판선택</td>
                        <td><select name="b_type">
                              <option value="G">일반게시판</option>
                              <option value="P">구매합니다</option>
                              <option value="Q">QnA게시판</option>
                              <%
                                 if (session.getAttribute("userID").equals("MasterPotato1")) {
                              %>
                              <option value="N">공지사항게시판</option>
                              <%
                                 } ;
                              %>
                        </select></td>
                     </tr>
                     <tr class="trline">
                        <td>제목</td>
                        <td><input type="text" name="b_title" required="required"></td>
                     </tr>
                     <tr class="trline">
                        <td>내용</td>
                        <td><textarea cols="100" rows="18" name="b_content"
                              required="required" style="resize: none;"></textarea>
                         </td>
                     </tr>
                     <tr class="trline">
                        <td>비밀글 선택</td>
                        <td>&nbsp;&nbsp;<label for="yes">Yes</label><input type="radio"
                           name="checksecret" id="yes" value="Y" />&nbsp;&nbsp;<label for="No">No</label>
                           <input type="radio" name="checksecret" id="No"
                           checked="checked" value="N" /></td>
                     </tr>
                     <tr id="secretnumber" class="trline2">
                        <td>비밀번호</td>
                        <td style ="font-family:'Hanna';"><input type="password" name="b_secretnumber"></td>
                     </tr>
                     <tr class="trline">
                        <td>첨부파일1<input type="file" name="uploadFile1"
                           id="uploadfile1" /></td>
                        <td class="imgupld"><span class="filetext"></span> <img id="showimg1">
                           <label for="uploadfile1" ><p class="upld_btn">업로드하기</p></label>
                           <div style ="    display: flex;
    justify-content: flex-end;
}"><p class ="upld_btn2" style = "    width: 100px;
    text-align: center;" id ="GJW-delimgbtn1">첨부파일삭제</p></div></td>
                           
                     </tr>
                     <tr class="trline2">
                        <td>첨부파일2<input type="file" name="uploadFile2" id="uploadfile2"/></td>
                        <td class="imgupld"><span class="filetext"></span> <img id="showimg2">
                           <label for="uploadfile2"><p class="upld_btn">업로드하기</p></label>
                           <div style ="    display: flex;
    justify-content: flex-end;
}"><p class ="upld_btn2" style = "    width: 100px;
    text-align: center;" id ="GJW-delimgbtn2">첨부파일삭제</p></div></td>
                     </tr>
                     <tr class="trline2">
                        <td>첨부파일3<input type="file" name="uploadFile3" id="uploadfile3"/></td>
                        <td class="imgupld"><span class="filetext"></span> <img id="showimg3">
                           <label for="uploadfile3"><p class="upld_btn">업로드하기</p>
                        </label>  <div style ="    display: flex;
    justify-content: flex-end;
}"> <p class ="upld_btn2" style = "    width: 100px;
    text-align: center;" id ="GJW-delimgbtn3">첨부파일삭제</p></div></td>
                     </tr>
                  </table>
                  <div id="btn_div">
                     <input type="submit" value="글등록" id="writebtn">
                     <input type="reset" value="다시작성" id="rebtn">
                     <input type="button" value="글목록" id="cnlbtn" onclick="window.location='BoardListViewCtl.do'">
                  </div>
               </form>
            </div>
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
      $(function() {

         $("#uploadfile1").on("change", function() {
            if (window.FileReader) {
               var filename = $(this)[0].files[0].name;
            }
            $(this).next().html(filename);
            var temp = URL.createObjectURL(event.target.files[0]);
            $("#showimg1").attr("src", temp);
         })

         $("#uploadfile2").on("change", function() {
            if (window.FileReader) {
               var filename = $(this)[0].files[0].name;
            }
            $(this).next().html(filename);
            var temp = URL.createObjectURL(event.target.files[0]);
            $("#showimg2").attr("src", temp);
         })

         $("#uploadfile3").on("change", function() {
            if (window.FileReader) {
               var filename = $(this)[0].files[0].name;
            }
            $(this).next().html(filename);
            var temp = URL.createObjectURL(event.target.files[0]);
            $("#showimg3").attr("src", temp);
         })

      })

      $(function() {

         if ($("#No").is(":checked")) {

            $("#secretnumber").css("display", "none");

         }

         $("#yes").click(function() {

            $("#secretnumber").css("display", "table-row");

         })

         $("#No").click(function() {

            $("#secretnumber").css("display", "none");

         })
      });

      /*  $(function(){
      
      
       $("#writebtn").click(function(){
      
       var f = document.go
       f.action ="BoardContentWriteCtl";
       $.ajax({
      
      
       url:"BoardContentWriteCtl"
      
       })
       })
      
       })

      
      
       */
       $(function(){
    	   $("#GJW-delimgbtn1").click(function(){
    		 
    		  $("#showimg1").removeAttr("src");
    		   $("#uploadfile1").val("");
    		   
    		   
    	   })
    	    $("#GJW-delimgbtn2").click(function(){
    		 
    		  $("#showimg2").removeAttr("src");
    		   $("#uploadfile2").val("");
    		   
    		   
    	   })
        $("#GJW-delimgbtn3").click(function(){
    		 
    		  $("#showimg3").removeAttr("src");
    		   $("#uploadfile3").val("");
    		   
    		   
    	   })
    	   
       })
       
       
   </script>



</body>
</html>