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
 * Servlet implementation class BoardCommentWriteCtl
 */
@WebServlet("/BoardCommentWriteCtl.do")
public class BoardCommentWriteCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardCommentWriteCtl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		BoardVO vo = new BoardVO();
		vo.setB_id(Integer.parseInt(request.getParameter("bno1")));
		vo.setB_ref(Integer.parseInt(request.getParameter("b_ref")));
		vo.setB_re_step(Integer.parseInt(request.getParameter("b_re_step")));
		vo.setB_re_level(Integer.parseInt(request.getParameter("b_re_level")));
		vo.setB_content(request.getParameter("b_content"));
		vo.setB_type(request.getParameter("b_type").charAt(0));
		vo.setM_id(request.getParameter("m_id"));
		BoardService sv = new BoardService();
		sv.writeComment(vo);
		response.sendRedirect("BoardContentCtl.do?b_id="+vo.getB_id()+"&currentPage="+request.getParameter("currentPage")+"&b_type="+request.getParameter("b_type"));
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
