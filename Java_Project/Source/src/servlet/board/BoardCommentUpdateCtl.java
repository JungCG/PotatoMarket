package servlet.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BoardService;
import vo.BoardVO;

/**
 * Servlet implementation class BoardCommentUpdateCtl
 */
@WebServlet("/BoardCommentUpdateCtl.do")
public class BoardCommentUpdateCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardCommentUpdateCtl() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		BoardVO vo = new BoardVO();
		BoardService sv = new BoardService();
		
		int b_ref = Integer.parseInt(request.getParameter("b_ref"));
		int b_re_level =Integer.parseInt(request.getParameter("b_re_level"));
		int b_re_step = Integer.parseInt(request.getParameter("b_re_step"));
		String b_content = request.getParameter("b_content");
		vo.setB_content(b_content);
		vo.setB_re_level(b_re_level);
		vo.setB_ref(b_ref);
		vo.setB_re_step(b_re_step);
		sv.updateComment(vo);
		RequestDispatcher dis = request.getRequestDispatcher("BoardContentCtl.do?b_id="+b_ref+"&currentPage="+request.getParameter("currentPage"));
		dis.forward(request, response);
	}	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
