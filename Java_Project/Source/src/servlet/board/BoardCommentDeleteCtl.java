package servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BoardService;


/**
 * Servlet implementation class BoardCommentDeleteCtl
 */
@WebServlet("/BoardCommentDeleteCtl.do")
public class BoardCommentDeleteCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardCommentDeleteCtl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bno = Integer.parseInt(request.getParameter("B_id"));
		int bre_step = Integer.parseInt(request.getParameter("b_re_step2"));
		BoardService sv= new BoardService();
		sv.commentDelete(bno,bre_step);
		response.sendRedirect("BoardContentCtl.do?b_id="+bno+"&currentPage="+request.getParameter("currentPage")+"&b_type="+request.getParameter("b_type"));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
