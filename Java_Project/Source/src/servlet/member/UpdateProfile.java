package servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.MemberService;


@WebServlet("/UpdateProfile.do")
public class UpdateProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public UpdateProfile() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String name = request.getParameter("username");
		String id = request.getParameter("id");
		String pw = request.getParameter("userpwd");
		String phone = request.getParameter("userphone");
		String email = request.getParameter("email");
		String birth = request.getParameter("userbirth");
		String address = request.getParameter("roadAddress")+"_"+request.getParameter("detailAddress");
		String gender = request.getParameter("wUserGender");
		String proimg = request.getParameter("userimg");
		String nick = request.getParameter("usernickname");
		String intro = request.getParameter("profileintro");
		MemberService dao = new MemberService();
		dao.UpdateProfile(name, id, pw, phone, email, birth, address, gender, proimg, nick, intro);
		
		response.sendRedirect("./MyPage.jsp");
	}

}
