package servlet.product;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.ProductService;
import vo.ProductVO;

/**
 * Servlet implementation class ProductgetCountCtl
 */
@WebServlet("/ProductgetSearchCountCtl.do")
public class ProductgetSearchCountCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductgetSearchCountCtl() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pageSize = 9; //  한 페이지당글수
		int pageBlock = 3; // 한 화면에 나타날 페이지 링크 수
		
		//검색어 & 검색필터
		String SearchStr;
		String SearchFilter;
		if(request.getParameter("SearchStr")==null) {
			SearchStr = "";
		}else {
			SearchStr = request.getParameter("SearchStr");
		}
		if(request.getParameter("SearchFilter")==null) {
			SearchFilter = "0";
		}else {
			SearchFilter = request.getParameter("SearchFilter");
		}
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("SearchStr", SearchStr);
		map.put("SearchFilter", SearchFilter);
		
		// 총 글 개수
		ProductService pservice = new ProductService();
		int bCount = pservice.getProductByPageCount(map);

		//현재 page 값으로 들고 들어온 것을 확인
		String pageNum = request.getParameter("pageNum");
		if (pageNum == null) {
		pageNum = "1"; // 현재 page 값을 들고 들오온게 없다면 1번째 page 보여주기
		}
		int currentPage = Integer.parseInt(pageNum); // 현재 page
		
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
		
		int prePage = currentPage -1;
		int nextPage = currentPage +1;
		
		if(prePage<1) {
			prePage = startPage;
		}else if(nextPage > endPage) {
			nextPage = endPage;
		}
		
		
		
		
		
		List<ProductVO> list = pservice.getProductByPage(startRnum, endRnum, map);
		
		int SearchFilter2 = Integer.parseInt(SearchFilter);
		
		if(list.size()==0) { //검색결과 없을 때
			String noneMsg = "검색한 결과가 없습니다. 다시 입력해주세요.";
			request.setAttribute("noneMsg", noneMsg);
			request.setAttribute("SearchFilter2", SearchFilter2);
			request.setAttribute("SearchStr", SearchStr);
			
			RequestDispatcher disp = request.getRequestDispatcher("Productsearchlist.jsp");
			disp.forward(request, response);
		}else {
			request.setAttribute("list", list);
			request.setAttribute("bCount", bCount);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("SearchStr", SearchStr);
			request.setAttribute("SearchFilter2", SearchFilter2);
			request.setAttribute("prePage", prePage);
			request.setAttribute("nextPage", nextPage);
			
			RequestDispatcher disp = request.getRequestDispatcher("Productsearchlist.jsp");
			disp.forward(request, response);
		}
	}

}
