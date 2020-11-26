package servlet.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.MemberService;
import vo.MemberVO;

/**
 * Servlet implementation class PwdSearchCtl
 */
@WebServlet("/PwdSearchCtl.do")
public class PwdSearchCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PwdSearchCtl() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("search_id");
		String email = request.getParameter("search_email");

		MemberService service = new MemberService();
		MemberVO vo = service.searchUsingEmail(email);

		PrintWriter out = response.getWriter();
		if (vo != null) {
			if (!id.equals(vo.getM_id())) {
				out.append("<script>");
				out.append("alert('아이디와 이메일이 일치하지 않습니다.');");
				out.append("location.href = \"IdPwSearch.jsp\";");
				out.append("</script>");
			} else {
				int result = service.updatePwd(id);
				if(result == 1) {
					request.setAttribute("userID", id);
					request.getRequestDispatcher("SearchEmailSendCtl.do").forward(request, response);
				}else {
					out.append("<script>");
					out.append("alert('예기치 못한 에러가 발생했습니다. 다시 시도해주세요..');");
					out.append("location.href = \"IdPwSearch.jsp\";");
					out.append("</script>");
				}
			}
		} else {
			out.append("<script>");
			out.append("alert('해당 이메일을 가진  아이디는 존재하지 않습니다!');");
			out.append("location.href = \"IdPwSearch.jsp\";");
			out.append("</script>");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
