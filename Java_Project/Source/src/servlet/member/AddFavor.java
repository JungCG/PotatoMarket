package servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.FavorService;


/**
 * Servlet implementation class ManageFavor
 */
@WebServlet("/AddFavor.do")
public class AddFavor extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddFavor() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		execute(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		execute(request, response);
	}

	protected void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		FavorService fdao = new FavorService();
		String m_id = (String) request.getSession().getAttribute("userID");
		int c_lid = Integer.parseInt(request.getParameter("mainmenu"));
		int c_sid = Integer.parseInt(request.getParameter("submenu"));
		
		fdao.insertFavor(m_id, c_lid, c_sid);
		
		response.sendRedirect("./LikeList.do");
	}
}
