package servlet.admin;

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
import service.MemberService;
import service.ProductService;
import service.ReportService;
import vo.BoardVO;
import vo.MemberVO;
import vo.ProductVO;
import vo.ReportVO;

/**
 * Servlet implementation class AdminListViewCtl
 */
@WebServlet("/AdminListViewCtl.do")
public class AdminListViewCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminListViewCtl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pageSize = 9; //  한 페이지당글수
		int pageBlock = 3; // 한 화면에 나타날 페이지 링크 수
		String ac = request.getParameter("currentPage");
		List<BoardVO> list = new ArrayList<BoardVO>();
		List<ProductVO> plist = new ArrayList<ProductVO>();
		List<MemberVO> mlist = new ArrayList<MemberVO>();
		List<ReportVO> slist = new ArrayList<ReportVO>();
		BoardService sv = new BoardService();
		ProductService psv = new ProductService();
		MemberService msv = new MemberService();
		ReportService ssv = new ReportService();
		String type = request.getParameter("type");
		int bCount = 0;
		//합쳤을때 밑에걸로 실행
		if(type == null) {
			
			type ="M";
		}
		 
		  if(type.equals("P")){
			  bCount = psv.getProductAllCount(); }
		  else if(type.equals("M")) {
			  bCount = msv.getMemberAllCount(); }
		  else if(type.equals("S")) {
			  bCount =ssv.getReportAllCount(); }
		  else if(type.equals("G")){
			  bCount = sv.getboardAllCount();
			  
		  }
		String pageNum = request.getParameter("currentPage");
		if (pageNum == null) {
		pageNum = "1"; // 현재 page 값을 들고 들오온게 없다면 1번째 page 보여주기
		}
		int currentPage = Integer.parseInt(pageNum); // 현재 page
		if(currentPage == 0) {
			currentPage = 1;
		}
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
		System.out.println(type);
		int startRnum = (currentPage - 1) * pageSize + 1;
		int endRnum = startRnum + pageSize - 1; // currentPage*pageSize
		
		
		list = sv.selectGetBoardAll(startRnum,endRnum);
		plist = psv.searchGetProductAll(startRnum, endRnum);
		mlist = msv.searchGetMemberAll(startRnum, endRnum);
		slist = ssv.selectGetReportAll(startRnum, endRnum);
		request.setAttribute("list", list);
		request.setAttribute("plist",plist );
		request.setAttribute("mlist",mlist );
		request.setAttribute("slist",slist );
		request.setAttribute("bCount",bCount);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("type",type);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		RequestDispatcher dis1 = request.getRequestDispatcher("AdminPage.jsp?currentPage="+currentPage+"&type="+type);
		dis1.forward(request, response);
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
