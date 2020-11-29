	package servlet.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.MemberService;

/**
 * Servlet implementation class LoginCtl
 */
@WebServlet("/LoginCtl.do")
public class LoginCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginCtl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberService service = new MemberService();
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("jck_user_id");
		String pw = request.getParameter("jck_user_pwd");
		
		int check = service.loginCheck(id, pw);
		
		if(check == 2){
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert(\"이메일 인증이 필요한 아이디입니다.\");");
			out.println("location.href = \"Login.jsp\";");
			out.println("</script>");
			out.flush();
			out.close();
		}else if(check == 1){
			int check2 = service.outCheck(id);

			if(check2 == 1) {
				HttpSession session = request.getSession();
				session.setAttribute("userID", id);
				service.updateLogin(id);
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert(\"로그인 성공\");");
				out.println("location.href = \"ProductMainPageGetCountCtl.do\";");
				out.println("</script>");
				out.flush();
				out.close();
			}else if(check2 == 0) {
				String reason = service.OutReason(id);

				if(reason.equals("") || reason == null) {
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert(\"탈퇴한 회원입니다.\");");
					out.println("location.href = \"Login.jsp\";");
					out.println("</script>");
					out.flush();
					out.close();
				}else {
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('탈퇴한 회원입니다. 사유 : " + reason + "');");
					out.println("location.href = \"Login.jsp\";");
					out.println("</script>");
					out.flush();
					out.close();
				}
				
			}else {
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert(\"데이터베이스 조회에 실패했습니다.\");");
				out.println("location.href = \"Login.jsp\";");
				out.println("</script>");
				out.flush();
				out.close();
			}
		}else if(check == 0){
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert(\"비밀번호 불일치\");");
			out.println("location.href = \"Login.jsp\";");
			out.println("</script>");
			out.flush();
			out.close();
		}else if(check == -1){
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert(\"아이디가 존재하지 않습니다.\");");
			out.println("location.href = \"Login.jsp\";");
			out.println("</script>");
			out.flush();
			out.close();
		}else {
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert(\"DataBase 연결 실패\");");
			out.println("location.href = \"Login.jsp\";");
			out.println("</script>");
			out.flush();
			out.close();
		}
	}

}
