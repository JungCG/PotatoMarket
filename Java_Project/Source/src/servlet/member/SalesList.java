package servlet.member;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProductDAO;
import vo.ProductVO;

/**
 * Servlet implementation class SalesList
 */
@WebServlet("/SalesList")
public class SalesList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SalesList() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		execute(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		execute(request, response);
	}

	private void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = (String) request.getSession().getAttribute("ID");
		ProductDAO dao = new ProductDAO();

		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		
		List<ProductVO> sVoList = dao.selectAllProduct(id, startDate, endDate);

		List<ProductVO> bVoList = dao.selectAllProduct2(id);
		
		
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);
		request.setAttribute("buyList", bVoList);
		request.setAttribute("transactionList", sVoList);
		RequestDispatcher disp = request.getRequestDispatcher("./TransactionList.jsp");
		disp.forward(request, response);
	}

}
