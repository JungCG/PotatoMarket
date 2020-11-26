package servlet.product;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.ProductService;

/**
 * Servlet implementation class ProductLikeCtl
 */
@WebServlet("/ProductInsertLikeCtl.do")
public class ProductInsertLikeCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductInsertLikeCtl() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String userID = (String) request.getSession().getAttribute("userID");

		ProductService service = new ProductService();
		int p_id = Integer.parseInt(request.getParameter("p_id"));
		int c_lid = Integer.parseInt(request.getParameter("c_lid"));
		String writer_m_id = request.getParameter("m_id");
		int Likeresult = 0;

		
		Likeresult = service.likeProduct(p_id, userID);	//result = 2 : insert 성공!	//result = 3 : delete 성공!
		System.out.println(Likeresult);
		
		request.setAttribute("Likeresult", Likeresult);
		RequestDispatcher disp = request.getRequestDispatcher("ProductContentCtl.do?p_id=" + p_id + "&c_lid=" + c_lid + "&m_id=" + writer_m_id + "&Likeresult=" + Likeresult);
		disp.forward(request, response);

		
		
		
	}

}
