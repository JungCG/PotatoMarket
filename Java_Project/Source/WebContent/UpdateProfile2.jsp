<%@page import="service.ProductService"%>
<%@page import="service.MemberService"%>
<%@page import="vo.MemberVO"%>
<%@page import="java.util.List"%>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="css/jck_nav.css">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String ctx = request.getContextPath();
	String ctxPath = request.getContextPath();
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		session.setAttribute("messageType", "오류 메시지");
		session.setAttribute("messageContent", "현재 로그인이 되어 있지 않습니다.");
		response.sendRedirect("Login.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta name="msapplication-TileColor" content="#da532c">
<meta name="theme-color" content="#ffffff">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="./js/jquery-3.5.1.js"></script>
<script src="./js/bootstrap.js"></script>
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
	padding: 2px 5px;
}

#JWJmainsection table textarea {
	border: 2px solid black;
}

#JWJmainsection table input[type='button'] {
	background-color: #CC8431;
	color: white;
	padding: 1px 13px;
	border: 0px;
}

#JWJmainsection table input[type='button']:hover {
	background-color: rgba(204, 132, 49, 0.7);
}

#JWJmainsection table input[type='button']:active {
	background-color: rgba(204, 132, 49, 0.7);
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
	background-color: rgba(204, 132, 49, 0.7);
}

.filebox label:active {
	background-color: rgba(204, 132, 49, 0.7);
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

#showimg {
	height: 200px;
}

.jck_join_input {
	width: 250px;
}

.jck_join_button {
	background-color: #CC8431;
	color: white;
	padding: 9px 13px;
}

.jck_join_button:hover {
	background-color: rgba(204, 132, 49, 0.7);
}

.jck_join_button:active {
	background-color: rgba(204, 132, 49, 0.7);
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
			success : function(result) {
				if (result >= 1) {
					showUnread(result);
				} else {
					showUnread('');
				}
			}
		});
	}

	function getInfiniteUnread() {
		setInterval(function() {
			getUnread();
		}, 10000);
	}

	function showUnread(result) {
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

	<div id="JWJmainsection" style="clear : both;">
		<div id="JWJpagetitle" style="text-align : center;">
			<h1>프로필 수정</h1>
		</div>
		<div id="JWJprofileform">
			<form action="./UpdateProfile.do" method="post" name="form1">
				<%
					String id = (String) session.getAttribute("userID");
					MemberService dao = new MemberService();
					List<MemberVO> mVoList = dao.ShowProfile(id);
					MemberVO mvo = mVoList.get(0);
				%>
				<fieldset style="border: 0; border-top: 1px solid gray; border-bottom: 1px solid gray;">
					<legend style="text-align: center;">&nbsp;&nbsp;회&nbsp;원&nbsp;정&nbsp;보&nbsp;&nbsp;</legend>
					<table id="JWJprofiletable">
						<tbody>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr class="register" height="30">
								<td width="5%">*</td>
								<td width="30%">이 름</td>
								<td><input type="text" id="username" name="username" readonly required value="<%=mvo.getM_name()%>" style="border: 0;"></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr class="register" height="30">
								<td width="5%">*</td>
								<td width="30%">회원 ID</td>
								<td><input type="text" id="id" name="id" readonly value="<%=mvo.getM_id()%>" style="border: none;"></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr class="register" height="30">
								<td width="5%">*</td>
								<td width="30%">비밀번호</td>
								<td><input type="password" name="userpwd" id="userpwd" value="<%=mvo.getM_pw()%>" required>&nbsp; <b style="color: gray; font-size: 8pt;">첫글자 대문자 / 대소문자,_ 사용 / 6~12글자</b></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr class="register" height="30">
								<td width="5%">*</td>
								<td width="30%">비밀번호 확인</td>
								<td><input type="password" name="userpwd2" id="userpwd2" required>&nbsp;
								<b id="pwchkmsg" style="display: inline-block;">* 비밀번호를 입력해주세요.</b> 
								<b id="pwchkmsg1" style="display: none;">* 비밀번호를 확인해주세요.</b> 
								<b id="pwchkmsg2" style="display: none;">* 확인 되었습니다.</b></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr class="register" height="30">
								<td width="5%">*</td>
								<td width="30%">휴대전화</td>
								<td><input type="text" id="userphone" name="userphone" value="<%=mvo.getM_phone()%>" required></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr class="register" height="30">
								<td width="5%">*</td>
								<td width="30%">이메일</td>
								<td><input type="email" id="email" name="email" readonly value="<%=mvo.getM_email()%>" required>&nbsp;<input type="button" value="중복체크" onclick="emailDupCheck()"></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr class="register" height="30">
								<td width="5%">*</td>
								<td width="30%">생년월일</td>
								<td><input type="date" id="userbirth" name="userbirth" style="width: 56%;" value="<%=mvo.getM_birth()%>" required></td>
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
								<td width="5%">*</td>
								<td width="30%">주소</td>
								<td>
								<input type="text" id="sample4_postcode" onclick="sample4_execDaumPostcode()" placeholder="우편번호" class="jck_join_input">
								<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
								<input type="text" id="sample4_roadAddress" name="roadAddress" placeholder="도로명주소" value="<%=arr[0]%>" class="jck_join_input"><br>
								<input type="text" id="sample4_jibunAddress" placeholder="지번주소" class="jck_join_input">
								<span id="guide" style="color: #999; display: none"></span> <br>
								 <input type="text" id="sample4_detailAddress" name="detailAddress" placeholder="상세주소를 입력해주세요." value="<%=arr[1]%>" class="jck_join_input"></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr class="register" height="30">
								<td width="5%">*</td>
								<td width="30%">성별</td>
								<td><input type="radio" name="wUserGender" id="man" value="M" <%if (mvo.getM_gender() == 'M') {%> checked="checked" <%}%>>남성&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="wUserGender" id="woman" value="F" <%if (mvo.getM_gender() == 'F') {%> checked="checked" <%}%>>여성</td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr class="register" height="30">
								<td width="5%">*</td>
								<td width="30%">프로필 이미지</td>
								<td><input type="text" id="userimg" name="userimg" value="<%=mvo.getM_image()%>">&nbsp;&nbsp;<input type="button" id="imgbtn" name="imgbtn" value="파일첨부"> <br>
									<img src="./profileIMG/<%=mvo.getM_image()%>"></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>

							<tr class="register" height="30">
								<td width="5%">*</td>
								<td width="30%">닉네임</td>
								<td><input type="text" id="usernickname" name="usernickname" readonly value="<%=mvo.getM_nick()%>" required style="border: none;"></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr class="register" height="30">
								<td width="5%">*</td>
								<td width="30%">프로필 소개글</td>
								<td><textarea rows="2" cols="40" style="resize: none;" id="profileintro" name="profileintro"><%=mvo.getM_intro()%></textarea></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
						</tbody>
					</table>
				</fieldset>
				<div id="formbtn">
					<br> <input class="jck_join_button" type="submit" id="btnSubmit" value="수정완료">&nbsp;&nbsp;&nbsp;&nbsp;<input class="jck_join_button" type="button" id="btnback" value="취소" onclick="location.href=\'./MyPage.jsp\'">
				</div>
			</form>
		</div>
	</div>
</body>
</html>