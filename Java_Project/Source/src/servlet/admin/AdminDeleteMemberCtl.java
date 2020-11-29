package servlet.admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.MemberService;

/**
 * Servlet implementation class AdminDeleteMemberCtl
 */
@WebServlet("/AdminDeleteMemberCtl.do")
public class AdminDeleteMemberCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminDeleteMemberCtl() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String m_id = request.getParameter("m_id");
		String o_reason = request.getParameter("o_reason");
		MemberService sv = new MemberService();
		int result = sv.deleteMember2(m_id, o_reason);
		if (result == 1) {
			request.getRequestDispatcher("./OutEmailSendCtl.do").forward(request, response);
		} else {
			RequestDispatcher dis = request.getRequestDispatcher("./AdminListViewCtl.do?type=M");
			dis.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
