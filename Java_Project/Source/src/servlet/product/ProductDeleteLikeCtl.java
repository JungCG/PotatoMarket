package servlet.product;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.ProductService;

/**
 * Servlet implementation class ProductLikeDeleteCtl
 */
@WebServlet("/ProductDeleteLikeCtl.do")
public class ProductDeleteLikeCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductDeleteLikeCtl() {
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
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String userID = (String) request.getSession().getAttribute("userID");
		String p_id = request.getParameter("p_id");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("m_id", userID);
		map.put("p_id", p_id);
		
		ProductService pservice = new ProductService();
		int result = pservice.deletelikeProduct(map);
		
		
		if(result > 0) {	//찜 삭제 성공 ㅡ> 찜목록 페이지
			request.setAttribute("userID", userID);
			RequestDispatcher disp = request.getRequestDispatcher("ProductSelectLikeCtl.do");
			disp.forward(request, response);
		}else {	//찜 삭제 실패
			request.setAttribute("userID", userID);
			RequestDispatcher disp = request.getRequestDispatcher("ProductSelectLikeCtl.do");
			disp.forward(request, response);
		}
	}

}
