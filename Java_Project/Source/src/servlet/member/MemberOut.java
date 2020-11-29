package servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.MemberService;


/**
 * Servlet implementation class MemberOut
 */
@WebServlet("/MemberOut.do")
public class MemberOut extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberOut() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		execute(request, response);	
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		execute(request, response);
	}
	protected void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String m_id = (String) request.getSession().getAttribute("userID");
		MemberService mdao = new MemberService();
		mdao.WithdrawMember(m_id);
		request.getSession().invalidate();
		response.sendRedirect("./ProductMainPageGetCountCtl.do");
	}
}
