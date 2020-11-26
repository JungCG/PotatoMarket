<%-- <%@page import="dao.ProductDAO"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset='utf-8'>
<title>감자마켓</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="./JWJ_MainPage.css?ver=2">
</head>
<script>
	$("document").ready(function() {
		$(window).on("scroll", function() {
			if ($(window).scrollTop() > 150) {
				$("#JWJhistorylist").css("top", "140px");
				$("#JWJhistorylist").css("transition-duration", "0.7s");
			} else {
				$("#JWJhistorylist").css("top", "400px");
			}
		});

		$(window).on("scroll", function() {
			if ($(window).scrollTop() > 330) {
				$("#JWJmainmenu1").css("position", "fixed");
				$("#JWJmainmenu1").css("top", "0%");
				$("#JWJmainmenu2").css("position", "fixed");
				$("#JWJmainmenu2").css("top", "0%");
			} else {
				$("#JWJmainmenu1").css("position", "relative");
				$("#JWJmainmenu1").css("top", "20%");
				$("#JWJmainmenu2").css("position", "relative");
				$("#JWJmainmenu2").css("top", "20%");
			}
		});
	})
</script>
<style>
/* The Modal (background) */
.jck_modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	padding-top: 80px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(255, 255, 255); /* Fallback color */
	background-color: rgba(255, 255, 255, 0.4);
}

.jck_modal ul, li {
	list-style: none;
}

.jck_modal li {
	text-align: center;
}

/* Modal Content */
.jck_modal-content {
	position: relative;
	background-color: white;
	padding: 0;
	width: 20%;
	animation-name: jck_animatetop;
	animation-duration: 0.4s
}

@keyframes jck_animatetop {
	from {top: -300px;
	opacity: 0
}

to {
	top: 0;
	opacity: 1
}

}

/* The Close Button */
.jck_close {
	color: white;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.jck_close:hover, .jck_close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

.jck_modal-header {
	padding: 2px 16px;
	background-color: #EFCEAD;
	color: white;
	text-align: center;
}

.jck_modal-body {
	text-align:center;
}

.jck_modal-body ul {
	padding-left:0;
	margin-top: 10px;
	margin-bottom: 10px;
}

.jck_modal-body li {
	padding-left:0;
	margin-top: 10px;
	margin-bottom: 10px;
}

.jck_modal-body>ul>li {
	margin-top: 10px;
	margin-bottom: 10px;
}

.jck_modal-body>ul>li>p>a {
	font-size: 1.1vw;
	color: saddleBrown;
}

.jck_modal-body>ul>li>ul>li>a {
	font-size: 1vw;
	color: chocolate;
}

.jck_modal-footer {
	padding: 2px 16px;
	background-color: #EFCEAD;
	color: white;
	text-align: center;
}

.jck_modal-body a {
	text-decoration: none;
}

.jck_modal-body a:link, a:link:active, a:visited, a:visited:active {
	color: black;
}
</style>
<body>
	<header>
		<div id="JWJmaintitle">
			<a href=""><img src="./images/logotitle.png"></a>
		</div>
		<div id="JWJmainmenu1">
			<a id="jck_myBtn"><img src="./images/목록.png"></a> <a href="./MainPage.jsp"><img
				src="./images/logoimg.png"></a> <select class="menu"
				style="width: 200px; height: 41px; border: 1px solid black; border-radius: 10px;">
				<option value="none">지역 선택</option>
				<option value="서울">서울</option>
				<option value="경기도">경기도</option>
				<option value="충청도">충청도</option>
				<option value="전라도">전라도</option>
				<option value="전라도">전라도</option>
				<option value="경상도">경상도</option>
				<option value="강원도">강원도</option>
			</select> <input type="text" placeholder="검색어를 입력해주세요." class="menu"
				style="width: 450px; height: 40px; border: 1px solid black; z-index:0; position:relative; border-radius: 10px;">
			<a href=""><img src="./images/돋보기.png" style="margin-left:-90px; z-index:1;position:relative;"></a> <a href=""
				id="gps"><img src="./images/지도.png" style="margin-left:-45px; z-index:1;position:relative;"></a> <a href="" id="cart"><img
				src="./images/장바구니.png"></a> <a href="./MyPage.jsp"><img
				src="./images/사람.png"></a> <a href="./js/login.jsp"><img
				src="./images/로그인.png"></a>
		</div>


		<div id="JWJmainmenu2">
			<a id="jck_myBtn"><img src="./images/목록.png"></a> <a href="./MainPage.jsp"><img
				src="./images/logoimg.png"></a> <a href=""><img 
				src="./images/돋보기.png"></a> <a href="" id="gps"><img
				src="./images/지도.png"></a> <a href="" id="cart"><img
				src="./images/장바구니.png"></a> <a href="./MyPage.jsp"><img
				src="./images/사람.png"></a> <a href=""><img
				src="./images/로그인.png"></a>
		</div>
	</header>
	<div id="JWJmainsection">
		<div id="JWJitemlist">
			<div id="JWJnewitemlist">
				<h3>
					<a href="">새로 올라온 상품</a>
				</h3>
				<a href=""><img src="./"></a><a href=""><img src="./"></a><a
					href=""><img src="./"></a><a href=""><img src="./"></a>
			</div>
			<div id="JWJhotitemlist">
				<h3>
					<a href="">인기있는 상품</a>
				</h3>
				<a href=""><img src="./"></a><a href=""><img src="./"></a><a
					href=""><img src="./"></a><a href=""><img src="./"></a>
			</div>
		</div>
		<%
		/* ProductDAO pdao = new ProductDAO();
		 */String p_1 = (String) session.getAttribute("img1");
		String p_2 = (String) session.getAttribute("img2");
		String p_3 = (String) session.getAttribute("img3");
		
		/* String p_img1 = pdao.selectHistory(p_1);
		String p_img2 = pdao.selectHistory(p_2);
		String p_img3 = pdao.selectHistory(p_3);
		 */%>
		<div id="JWJhistorylist">
			<aside>
				<h3 style="color: white; background: #B97A57;">최근 본 상품</h3>
				<%-- <a href=""><img src="./upload/<%=p_img1 %>"></a> <a href=""><img src="./upload/<%=p_img2 %>"></a>
				<a href=""><img src="./upload/<%=p_img3 %>"></a> --%>
			</aside>
		</div>
	</div>
	<footer>
		<h1></h1>
	</footer>
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
						<p>
							<a href="#">홈페이지 소개</a>
						</p>
					</li>
					<li>
					<hr>
					</li>
					<li>
						<p>
							<a href="#">마이 페이지</a>
						</p>
					</li>
					<li>
					<hr>
					</li>
					<li>
						<p>
							<a href="#">상품 검색</a>
						</p>
						<ul>
							<li><a href="#">의류</a></li>
							<li><a href="#">가전제품</a></li>
							<li><a href="#">뷰티</a></li>
							<li><a href="#">아동용품</a></li>
							<li><a href="#">기타</a></li>
						</ul>
					</li>
					<li>
					<hr>
					</li>
					<li>
						<p>
							<a href="#">게시판</a>
						</p>
						<ul>
							<li><a href="#">공지사항</a></li>
							<li><a href="#">물건 삽니다!</a></li>
							<li><a href="#">일반 게시판</a></li>
							<li><a href="#">QnA</a></li>
						</ul>
					</li>
				</ul>
			</div>
			<div class="jck_modal-footer">
				<h2>Potato Market</h2>
			</div>
		</div>
	</div>
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