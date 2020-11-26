package servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BoardService;


/**
 * Servlet implementation class BoardReCommentDeleteCtl
 */
@WebServlet("/BoardReCommentDeleteCtl.do")
public class BoardReCommentDeleteCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardReCommentDeleteCtl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		int bno = Integer.parseInt(request.getParameter("Bno"));
		int bno1 = Integer.parseInt(request.getParameter("bno1"));
		BoardService sv = new BoardService();
		sv.deleteReComment(bno);
		response.sendRedirect("BoardContentCtl.do?b_id="+bno1+"&currentPage="+request.getParameter("currentPage")+"&b_type="+request.getParameter("b_type"));
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
