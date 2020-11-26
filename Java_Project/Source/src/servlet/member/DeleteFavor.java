package servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.FavorDAO;

@WebServlet("/DeleteFavor.do")
public class DeleteFavor extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DeleteFavor() {
        super();
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
		FavorDAO fdao = new FavorDAO();
		String m_id = (String) request.getSession().getAttribute("userID");
		String c_lsid = request.getParameter("c_lsid");
		String[] arr = c_lsid.split("-");
		int c_lid = Integer.parseInt(arr[0]);
		int c_sid = Integer.parseInt(arr[1]);
		
		fdao.deleteFavor(m_id, c_lid, c_sid);
		
		response.sendRedirect("./LikeList.do");
	}
}
