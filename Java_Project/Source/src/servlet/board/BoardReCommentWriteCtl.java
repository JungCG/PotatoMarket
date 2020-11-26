package servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BoardService;
import vo.BoardVO;


/**
 * Servlet implementation class BoardReCommentWriteCtl
 */
@WebServlet("/BoardReCommentWriteCtl.do")
public class BoardReCommentWriteCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardReCommentWriteCtl() {
        super();
    }
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		BoardVO vo = new BoardVO(); 
		vo.setB_id(Integer.parseInt(request.getParameter("rbno")));
		vo.setB_ref(Integer.parseInt(request.getParameter("rref")));
		vo.setB_re_step(Integer.parseInt(request.getParameter("rbre_step")));
		vo.setB_re_level(Integer.parseInt(request.getParameter("rbre_level")));
		vo.setB_content(request.getParameter("rcontent"));
		vo.setM_id(request.getParameter("m_id"));
		BoardService sv = new BoardService();
		sv.writeReComment(vo);
		response.sendRedirect("BoardContentCtl.do?b_id="+vo.getB_ref()+"&currentPage="+request.getParameter("currentPage")+"&b_type="+request.getParameter("b_type"));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
