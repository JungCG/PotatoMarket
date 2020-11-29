package servlet.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BoardService;
import vo.BaddVO;
import vo.BoardVO;

/**
 * Servlet implementation class BoardContentCtl
 */
@WebServlet("/BoardContentCtl.do")
public class BoardContentCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardContentCtl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	
		int b_id=Integer.parseInt(request.getParameter("b_id"));
		char b_type; 
		int currentPage = 0;
		try {
			
			
		 currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}catch(Exception e) {
			
			
		}
		
		
		
		BoardService sv = new BoardService();
		List<BaddVO>imgList = sv.selectImg(b_id);
		request.setAttribute("ImgList",imgList);
		List<BoardVO> list = sv.getBoard(b_id); 	
		request.setAttribute("BoardList",list);
		b_type = list.get(0).getB_type();
		sv.updateBoardCount(b_id);
	
		if(currentPage == 0) {
			RequestDispatcher dis = request.getRequestDispatcher("Board.jsp?b_id="+b_id+"&b_type="+b_type);
			dis.forward(request, response);
			
		}else {
			
			RequestDispatcher dis = request.getRequestDispatcher("Board.jsp?b_id="+b_id+"&b_type="+b_type+"&currentPage="+currentPage);
			dis.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
