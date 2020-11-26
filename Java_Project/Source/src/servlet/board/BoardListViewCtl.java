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

import dao.BoardDAO;
import service.BoardService;
import vo.BoardVO;

/**
 * Servlet implementation class BoardListViewCtl
 */
@WebServlet("/BoardListViewCtl.do")
public class BoardListViewCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BoardListViewCtl() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int pageSize = 9; //  한 페이지당글수
		int pageBlock = 3; // 한 화면에 나타날 페이지 링크 수
		String b_type = request.getParameter("b_type");
		String select = request.getParameter("select");
		List<BoardVO> list = new ArrayList<BoardVO>();
		BoardService sv = new BoardService();
		BoardDAO dao = new BoardDAO();
		int bCount = 0;
		if(b_type==null) {
			b_type ="G";
		}
		if(select==null) {
			bCount = dao.getboardCount(b_type);
		}
		else {
			bCount = dao.getSearchBoardCount(select); 
		}
		
		//현재 page 값으로 들고 들어온 것을 확인
		String pageNum = request.getParameter("currentPage");
		if (pageNum == null) {
		pageNum = "1"; // 현재 page 값을 들고 들오온게 없다면 1번째 page 보여주기
		}
		
		int currentPage = Integer.parseInt(pageNum); // 현재 page
		if(currentPage == 0) {
			currentPage = 1;
		}
		//총 페이지 개수 = (총 글개수 / 페이지당글수) + (총 글개수에서 페이지당글개수 나눈 나머지가 0 이라면 0, 나머지가 있다면 페이지 개수를 1 증가함)
		int pageCount = (bCount / pageSize) + (bCount % pageSize == 0 ? 0 : 1);

		int startPage = 1; // 화면에 나타날 시작 페이지
		int endPage = 1; // 화면에 나타날 마지막 페이지

		if (currentPage % pageBlock == 0) { // 즉 currentPage가 10, 20, 30.. 인 경우 11~20인 페이지, 21~30인 페이지가 보일 수 있음을 방지함
		startPage = ((currentPage / pageBlock) - 1) * pageBlock + 1;
		} else {
		startPage = ((currentPage / pageBlock)) * pageBlock + 1;
		}
		endPage = startPage + pageBlock - 1; // - 1 빼줘야 함. 1~10 --> 즉 1 + 9 = 10, 총 글 35개, 총페이지는 4개, 10
		if (endPage > pageCount)
		endPage = pageCount;

		//화면에 보여줄 게시글 rownum 구하기
		int startRnum = (currentPage - 1) * pageSize + 1;
		int endRnum = startRnum + pageSize - 1; // currentPage*pageSize
		if(select==null) {
			
			list =sv.getBoardAll(startRnum, endRnum, b_type);
		}
		
		else {
			list= sv.searchGetBoardAll(startRnum,endRnum , select);
			System.out.println(select);
		}
		request.setAttribute("list", list);
		request.setAttribute("b_type", b_type);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("bCount", bCount);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		List<BoardVO> hotview = new ArrayList<BoardVO>();
		hotview = sv.hotPost();
		request.setAttribute("hotview", hotview);
		request.setAttribute("select",select );
		if(select!=null) {
			
			RequestDispatcher dis1 = request.getRequestDispatcher("MainBoard.jsp?currentPage="+currentPage+"&b_type="+b_type +"&select="+select);
			dis1.forward(request, response);
			
		}
		else {
			RequestDispatcher dis1 = request.getRequestDispatcher("MainBoard.jsp?currentPage="+currentPage+"&b_type="+b_type);
			dis1.forward(request, response);
		}
		/*
		 * RequestDispatcher dis =
		 * request.getRequestDispatcher("MainBoard.jsp?currentPage="+
		 * currentPage+"&ttype="+b_type); dis.forward(request, response);
		 */

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
