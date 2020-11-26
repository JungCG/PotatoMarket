	<%-- <%@page import="service.product.ProductService"%> --%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dao.BoardDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.BoardVO"%>
<%@page import="java.util.List"%>
<link rel = "stylesheet" href = "css/GJW-Board.css">
<link rel = "stylesheet" href = "css/bootstrap.css">
<link rel = "stylesheet" href = "css/custom.css">
<link rel = "stylesheet" href = "css/jck_nav.css">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
			userID = (String)session.getAttribute("userID");
		}
	%>
   <%
String writer = null;%>
<style>
.jck_everything {
     height: auto; 
 
}
.jck_content_container {

    justify-content: stretch;

}
.he {
   background-image: url( "./images/heart.png" );
background-size: cover;
    height: 94px;
    width: 100px;
    text-align: center;
    cursor: pointer;
}

.GJW-closeupdate {
      margin-top:10px;
   
}
.datupdatebtn {
   margin-top:10px;
}

</style>
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
    <title>상세 페이지</title>
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
            <section>
               <div id="GJW-board">
                  <div id="GJW-content">
   <%!SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");%>
                     <%
                        try {

                        List<BoardVO> BoardList = (ArrayList<BoardVO>) request.getAttribute("BoardList");
                        writer = (String) BoardList.get(0).getM_id().trim();

                        if ((String) BoardList.get(0).getM_id().trim() != null) {
                           writer=(String) BoardList.get(0).getM_id().trim();
                        }

                     } catch (Exception e) {
                        e.printStackTrace();
                     }
                     %>
                     <input type="hidden" id="mm_id" name="m_id" value="<%=userID%>">
                     <c:forEach items="${BoardList}" var="boardcontent" varStatus="s">
                        <c:set var="content" value="${bcontent }"></c:set>
                        <c:out value="${content }" />
                        <div id="GJW-content-1">
                           <div id="GJW-title">${boardcontent.b_title}</div>
                           <div id="GJW-subtitle">
                              <div id="GJW-writer">작성자 : ${boardcontent.m_id}</div>
                              <div id="GJW-date">
                                 작성날짜 :
                                 <fmt:formatDate value="${boardcontent.b_timestamp}"
                                    pattern="yyyy-MM-dd HH:mm" />
                              </div>
                           </div>


                           <c:if test="${!empty ImgList}">
                              <c:forEach items="${ImgList}" var="ImgList">
                                 <c:if test="${!empty ImgList.ba_img1 }">
                                    <img src="boardupload/${ImgList.ba_img1 }" class="GJW-viewimg">
                                 </c:if>
                                 <c:if test="${!empty ImgList.ba_img2 }">
                                    <img src="boardupload/${ImgList.ba_img2 }" class="GJW-viewimg">
                                 </c:if>
                                 <c:if test="${!empty ImgList.ba_img3 }">
                                    <img src="boardupload/${ImgList.ba_img3 }" class="GJW-viewimg">
                                 </c:if>
                              </c:forEach>
                           </c:if>

                           <div>
                              <textarea name="board_content" cols="120" 
                                 id="GJW-main" readonly="readonly">${boardcontent.b_content}</textarea>






                           </div>
                           <div class="GJW-heartwrap">
                              <div class="he">
                                 <span id="GJW-heartnumber">${boardcontent.b_like }</span>
                              </div>
                           </div>
                        </div>
                     </c:forEach>

                  </div>
               </div>
               <div id="GJW-datcon">
                  <div id="GJW-commenttext">
                     		<p id ="GJW-commenttextsize">댓글</p>
                  </div>
                  <div id="GJW-dat">

                     <%
                        BoardDAO dao = new BoardDAO();
                     int b_id = Integer.parseInt(request.getParameter("b_id"));
                     List<BoardVO> listdat = dao.getComment(b_id);
                     for (int i = 0; i < listdat.size(); i++) {
                        BoardVO vodat = listdat.get(i);
                        String bre_level2 = String.valueOf(vodat.getB_re_level());
                        String bre_step2 = String.valueOf(vodat.getB_re_step());
                        String bref2 = String.valueOf(vodat.getB_ref());
                        String bno12 = String.valueOf(vodat.getB_id());
                        String b_mid = vodat.getM_id();
                        if (vodat.getB_re_level() > 1) {
                     %>

                     <div class="GJW-datdat">
                        <form action="BoardCommentUpdateCtl.do" method="post"
                           class="GJW-rcform">
                           <div>
                           <div class="GJW-redatWriter">
                              <p><%=vodat.getM_id()%></p>
                           </div>
                           <input type="hidden" name="b_re_level"
                              value="<%=vodat.getB_re_level()%>"> <input
                              type="hidden" name="currentPage"
                              value="<%=request.getParameter("currentPage")%>"> <input
                              type="hidden" name="b_re_step"
                              value="<%=vodat.getB_re_step()%>"> <input
                              type="hidden" id="bb_id" name="b_ref"
                              value="<%=vodat.getB_ref()%>">
                           <div class ="GJW-rctextdiv"style="display:flex">
                              <textarea readonly="readonly" class="GJW-rctext"
                                 name="b_content" cols="100"  style="resize: none;"><%=vodat.getB_content()%></textarea>
                           </div>
                           </div>
                           <div class="GJW-redatbt">
                              <p style="font-weight: bold;    margin-top: 15;"><%=sdf.format(vodat.getB_timestamp())%></p>
							<%
                                 if (userID != null && userID.equals(vodat.getM_id())) {
                                	 %>
                                	 <div
                                 style="display: flex; justify-content: flex-end;">
                                 <input type="hidden" id="reupdateval"
                                    value="<%=vodat.getB_content()%>"> <input
                                    type="button" value="대댓글 수정" class="reblockdatupdatebtn ddn">
                                 <input type="button" value="취소" class="GJW-closeupdate ddn">
                                 <input type="submit" value="등록" class="datupdatebtn ddn">
                     <input type="button" value="대댓글삭제"class ="GJW-redatdelbtn ddn" onclick="location.href='BoardReCommentDeleteCtl.do?Bno=<%=bno12%>&bre_step2=<%=bre_step2%>&bno1=<%=b_id%>&currentPage=<%=request.getParameter("currentPage")%>&b_type=<%=request.getParameter("b_type")%>'"/>
                              </div>
                                 <% }%>
                           </div>
                        </form>
                     </div>
                     <%
                        }

                     else {
                     %>
                     <div class="GJW-datdat">
                        <div>
                           <form action="BoardCommentUpdateCtl.do" method="post"
                              class="GJW-cform">
                              
                              <div>
                              
                              <div class="GJW-datWriter">
                                 <p><%=vodat.getM_id()%></p>
                              </div>
                              <input type="hidden" name="b_re_level"
                                 value="<%=vodat.getB_re_level()%>"> <input
                                 type="hidden" name="currentPage"
                                 value="<%=request.getParameter("currentPage")%>"> <input
                                 type="hidden" name="b_re_step"
                                 value="<%=vodat.getB_re_step()%>"> <input
                                 type="hidden" name="b_ref" value="<%=vodat.getB_ref()%>">
                              <div class="GJW-ccontent">
                                 <textarea readonly="readonly" class="GJW-ctext"
                                    name="b_content" cols="100" style="resize: none;"><%=vodat.getB_content()%></textarea>
                              </div>
                              </div>
                              <div class="GJW-datbt">
                                 <p style="font-weight: bold;    margin-top: 15;"><%=sdf.format(vodat.getB_timestamp())%></p>
                                 <%
                                    if (userID != null) {
                                 %>
                                 <input type="button" value="답글달기" class="redatbtn dtn">
                                 <%
                                    }
                                 %><br>
                                 <%
                                    if (userID != null && userID.equals(vodat.getM_id())) {
                                 %>
                                 <input type="hidden" id="updateval"
                                    value="<%=vodat.getB_content()%>"> <input
                                    type="button" value="댓글수정" class="cblockdatupdatebtn dtn">
                                 <input type="button" value="취소" class="GJW-closeupdate dtn">
                                 <input type="submit" value="등록" class="datupdatebtn dtn">
                  <input type="button" value="댓글삭제"class ="GJW-redatdelbtn" onclick="location.href='BoardCommentDeleteCtl.do?B_id=<%=bref2%>&b_re_step2=<%=bre_step2%>&bno1=<%=b_id%>&currentPage=<%=request.getParameter("currentPage")%>&b_type=<%=request.getParameter("b_type")%>'"/>
                              
                                 <%
                                    }
                                 %>
                              </div>
                           </form>

                        </div>

                        <div>
                           <form method="post" class="GJW-redatform"
                              action="BoardReCommentWriteCtl.do">
                                                         <input type="hidden" name="m_id" value="<%=userID%>">
                        <input type="hidden" name="b_type" value="<%=request.getParameter("b_type")%>">
                              <input type="hidden" name="currentPage"
                                 value="<%=request.getParameter("currentPage")%>"> <input
                                 type=hidden name="rbno" value="<%=bno12%>"> <input
                                 type=hidden name="rbre_step" value="<%=bre_step2%>">
                              <input type=hidden name="rref" value="<%=bref2%>"> <input
                                 type=hidden name="rbre_level" value="<%=bre_level2%>">
                              <textarea name="rcontent" class="GJW-re" cols="100" 
                                 style="resize: none;overflow: hidden;" required="required" placeholder ="대댓글을 입력해주세요"></textarea>
                              <input type="submit" value="답글" class="GJW-redatbtn ddn">
                              <input type="button" value="취소" class="GJW-redatbtnclose ddn">
                           </form>
                        </div>
                     </div>

                     <%
                        }
                     %>
                     <%
                        }
                     %>

                     <br>
                  </div>

                  <div>
                     <%
                        List<BoardVO> evo = (ArrayList<BoardVO>) request.getAttribute("BoardList");
                     BoardVO vo = new BoardVO();
                     vo = evo.get(0);
                     %>
                     <div id="GJW-datcon">
                        <form method="post" action="BoardCommentWriteCtl.do">
                           <input type="hidden" name="bno1" value="<%=vo.getB_id()%>">
                           <input type="hidden" name="m_id" value="<%=userID%>"> <input
                              type="hidden" name="b_ref" value="<%=vo.getB_ref()%>">
                           <input type="hidden" name="b_re_step"
                              value="<%=vo.getB_re_step()%>">
                        <input type="hidden" name="b_type" value="<%=request.getParameter("b_type")%>">
                               <input type="hidden"
                              name="b_re_level" value="<%=vo.getB_re_level()%>"> <input
                              type="hidden" name="currentPage"
                              value="<%=request.getParameter("currentPage")%>">

                           <%
                              if (userID!=null) {
                           %> 
                           <textarea cols="70" name="b_content" id="GJW-dattext"
                              style="resize: none;" required="required" placeholder="댓글을 입력해주세요"></textarea>
                           <input type="submit"
                              style="float: right;border: 1px solid darkorange;border-radius: 25px;font-size: 20px;background: pink;outline: none;cursor: pointer;font-family: 'Hanna';width: 90px;margin-right:40px;
                              "
                              value="댓글등록">
                        <%
                              }
                           %>
                        </form>
                        <div class="compofatag">
                           <a href="BoardListViewCtl.do?currentPage=<%=request.getParameter("currentPage")%>&b_type=<%=request.getParameter("b_type")%>"class="GJW-boardmo"> 글목록</a>
									
									<% if(userID != null && userID.equals(writer)){%>
                           <a href="BoardContentDeleteCtl.do?Bno=<%=b_id%>"
                              class="GJW-boardmo">글삭제</a> <a
                              href="BoardContetntLoadCtl.do?b_id=<%=b_id%>&currentPage=<%=request.getParameter("currentPage")%>&b_type=<%=request.getParameter("b_type")%>">글수정</a>
                             <%}%>
                        </div>
                     </div>
                  </div>
               </div>
            </section>
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
        <div class = "jck_footer_container">
            <div><a href = "#">감자 마켓<br>회사 소개</a></div>
            <div><a href = "#">개인 정보<br>취급 방침</a></div>
            <div><a href = "#">위치기반 서비스<br>이용 약관</a></div>
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
   $(function(){
      

      $(".redatbtn").click(function(){
         $(this).parent().parent().parent().next('div').children('.GJW-redatform').css("display","flex"); 
      });
   
   });
      
   $(function(){
      
      $(".GJW-redatbtnclose").click(function(){
         $(this).parent(".GJW-redatform").css("display","none");
         
      })
   })
   
      </script>
   <script>
 
      $(function(){

         $(".cblockdatupdatebtn").click(function(){
            //$(this).prev().prev().prev('.ee').removeAttr("readonly");
            $(this).parent().prev('div').children('.GJW-ccontent').children(".GJW-ctext").removeAttr("readonly");
            $(this).parent().prev('div').children('.GJW-ccontent').children(".GJW-ctext").focus();
            $(this).parent().prev('div').children('.GJW-ccontent').children(".GJW-ctext").css("out")
            $(this).next().next(".datupdatebtn").css("display", "block");
            $(this).next(".GJW-closeupdate").css("display","block");
            $(this).css("display", "none");
         });
      });

      $(function(){
         
         
         $(".GJW-closeupdate").click(function(){
            
            var i =$(this).prev().prev('#updateval').val();
            $(this).parent().prev('div').children('.GJW-ccontent').children(".GJW-ctext").val(i);
            $(this).parent().prev('div').children('.GJW-ccontent').children(".GJW-ctext").attr("readonly",true);
            $(this).css("display","none");
            $(this).next(".datupdatebtn").css("display","none");
            $(this).prev(".cblockdatupdatebtn").css("display","block");
         })
         
      }) 
      //댓글 여기까지 -------------------------------------------------------------------------------------------------------
 
      $(function(){

         $(".reblockdatupdatebtn").click(function(){
            //$(this).prev().prev().prev('.ee').removeAttr("readonly");
            $(this).parent().parent().prev().children(".GJW-rctextdiv").children(".GJW-rctext").removeAttr("readonly");
            $(this).parent().parent().prev().children(".GJW-rctextdiv").children(".GJW-rctext").focus();
            $(this).next().next(".datupdatebtn").css("display", "block");
            $(this).next(".GJW-closeupdate").css("display","block");
            $(this).css("display", "none");
         });
      });

      $(function(){
         
         
         $(".GJW-closeupdate").click(function(){
            
            var i =$(this).prev().prev('#reupdateval').val();
            console.log(i);
            $(this).parent().parent().prev().children(".GJW-rctextdiv").children(".GJW-rctext").val(i);
            $(this).parent().parent().prev().children(".GJW-rctextdiv").children(".GJW-rctext").attr("readonly",true);;
            $(this).prev(".reblockdatupdatebtn").css("display","block");
            $(this).css("display","none");

            
            
            
         })
         
      }) 
      
      
      
      $(function(){
         
         
         $(".he").click(function(){
            var user_id = "<%=userID%>";
            if(user_id=="null" || user_id == ""){
               alert("글추천을 하시려면 회원가입을 하셔야합니다")
            }
            else{
               
               $.ajax({
                  url:"BoardLikeCheckCtl.do",
                  data:{m_id:"<%=userID%>",b_id:<%=b_id%>},
                  success:function(res1){
                     if(res1 == 1){
                         var deletelike= confirm("이미 추천하신 글입니다 추천을 취소하시겠습니까?")
                        if(deletelike == true){
                           $.ajax({
                              url:"BoardLikeCtl.do",
                              data:{m_id:"<%=userID%>",b_id:<%=b_id%>,chc:res1},
                              success:function(res){
                                 alert("글 추천을 취소하셨습니다");
                                 $("#GJW-heartnumber").text(res);
                              }
                           })
                        }
                     }
                     else{
               var heart= confirm("글을 추천하시겠습니까?");
               
               if(heart == true){
               $.ajax({
                  url:"BoardLikeCtl.do",
                  data:{m_id:"<%=userID%>",b_id :<%=b_id%>,chc : res1},
                success : function(res) {
                  alert("글추천에 성공하셨습니다");
                  $("#GJW-heartnumber").text(res);
                                                      }
                                                   })
                                          }
                                       }
                                    }
                                 })

                        }
                     })

      })
jQuery.each(jQuery('textarea[data-autoresize]'), function() { var offset = this.offsetHeight - this.clientHeight; var resizeTextarea = function(el) { jQuery(el).css('height', 'auto').css('height', el.scrollHeight + offset); }; jQuery(this).on('keyup input', function() { resizeTextarea(this); }).removeAttr('data-autoresize'); });


      //$(this).prev('.ee').removeAttr("readonly");'
      //$(this).next('.ee').removeAttr("readonly");
      //$(this).nextAll('.ee').removeAttr("readonly");
      //$(this).prevAll('.ee').removeAttr("readonly");
      //$(".ee").removeAttr("readonly");
   </script>
</body>
</html>