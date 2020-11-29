package servlet.board;

import java.io.IOException;
import java.util.ArrayList;
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
 * Servlet implementation class BoardContetntLoad
 */
@WebServlet("/BoardContetntLoadCtl.do")
public class BoardContentLoadCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardContentLoadCtl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	int b_id =  Integer.parseInt(request.getParameter("b_id"));
	BoardService sv = new BoardService();
	List<BoardVO>list = new ArrayList<BoardVO>();
	list =sv.getBoard(b_id);
	request.setAttribute("list",list);
	List<BaddVO>imglist = new ArrayList<BaddVO>();
	imglist = sv.selectImg(b_id);
	request.setAttribute("imglist",imglist);
	request.setAttribute("currentPage",request.getParameter("currentPage"));
	RequestDispatcher dis =  request.getRequestDispatcher("BoardUpdate.jsp");
	dis.forward(request, response);
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
