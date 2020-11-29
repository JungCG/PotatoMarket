package servlet.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BoardService;
import service.ChatService;
import vo.BoardVO;

/**
 * Servlet implementation class AdminDeleteBoardContent
 */
@WebServlet("/AdminDeleteBoardContent.do")
public class AdminDeleteBoardContent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminDeleteBoardContent() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bno = Integer.parseInt(request.getParameter("b_id"));
		String type =request.getParameter("type");
		BoardService sv = new BoardService();
		
		List<BoardVO> list = sv.getBoard(bno);
		BoardVO vo = list.get(0);
		
		sv.deleteLike(bno);
		sv.deleteImgPost(bno);
		sv.deletePost(bno);
		
		ChatService cs = new ChatService();
		cs.submit("MasterPotato1", vo.getM_id(), vo.getB_title()+" 이라는 제목으로 올린 게시글이 관리자에 의해 삭제되었습니다.");
		response.sendRedirect("AdminListViewCtl.do?type="+type);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
