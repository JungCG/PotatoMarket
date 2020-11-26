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
 * Servlet implementation class ProductModifyCtl
 */
@WebServlet("/ProductModifyCtl.do")
public class ProductModifyCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductModifyCtl() {
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
		int p_id = Integer.parseInt(request.getParameter("p_id"));
		int likeresult = Integer.parseInt(request.getParameter("Likeresult"));
		
		
		ProductService pservice = new ProductService();
		List<ProductVO> list = pservice.selectProduct(p_id, likeresult);
		String[] FName = new String[3];
		FName = pservice.selectProductImg(p_id);
		
		System.out.println(FName[0] + FName[1] + FName[2]);
		
		ProductVO vo = new ProductVO();
		vo = list.get(0);
		request.setAttribute("vo", vo);
		request.setAttribute("FName", FName);
		request.setAttribute("FName0", FName[0]);
		request.setAttribute("FName1", FName[1]);
		request.setAttribute("FName2", FName[2]);
		RequestDispatcher disp = request.getRequestDispatcher("Productmodify.jsp");
		disp.forward(request, response);
	}

}
