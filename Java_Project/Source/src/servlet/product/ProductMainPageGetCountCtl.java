package servlet.product;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.ProductService;
import vo.ProductVO;

/**
 * Servlet implementation class ProductMainPageGetCountCtl
 */
@WebServlet("/ProductMainPageGetCountCtl.do")
public class ProductMainPageGetCountCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductMainPageGetCountCtl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProductService ps = new ProductService();
		List<ProductVO> list1 = ps.getMainProduct1();
		if(list1.size() == 0) {
			String noneMsg1 = "등록된 상품이 없습니다.";
			request.setAttribute("noneMsg1", noneMsg1);
		}else {
			request.setAttribute("list1", list1);
		}
		
		List<ProductVO> list2 = ps.getMainProduct2();
		if(list2.size() == 0) {
			String noneMsg2 = "등록된 상품이 없습니다.";
			request.setAttribute("noneMsg2", noneMsg2);
		}else {
			request.setAttribute("list2", list2);
		}
		
		RequestDispatcher disp = request.getRequestDispatcher("./MainPage.jsp");
		disp.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
