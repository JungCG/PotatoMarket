package servlet.board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BoardService;

/**
 * Servlet implementation class BoardLikeCtl
 */
@WebServlet("/BoardLikeCtl.do")
public class BoardLikeCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardLikeCtl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		int LikeCount = 0;
		String m_id = request.getParameter("m_id");
	int b_id = Integer.parseInt(request.getParameter("b_id"));
	int chc = Integer.parseInt(request.getParameter("chc"));

	BoardService sv = new BoardService();
	sv.insertLike(m_id,b_id,chc);
	sv.updateLike(b_id,chc);
	LikeCount =sv.getBoardLikeCount(b_id);
	out.print(LikeCount);
	out.flush();
	out.close();
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
