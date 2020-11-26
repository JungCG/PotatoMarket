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
 * Servlet implementation class CheckDateList
 */
@WebServlet("/CheckDateList.do")
public class CheckDateList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CheckDateList() {
        super();
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
		String startDate1 = request.getParameter("startDate1");
		String endDate1 = request.getParameter("endDate1");
		
		List<ProductVO> sVoList = dao.selectAllProduct(id, startDate, endDate);

		List<ProductVO> bVoList = dao.selectAllProduct2(id, startDate1, endDate1);
		
		
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);
		request.setAttribute("startDate1", startDate1);
		request.setAttribute("endDate1", endDate1);
		request.setAttribute("buyList", bVoList);
		request.setAttribute("transactionList", sVoList);
		RequestDispatcher disp = request.getRequestDispatcher("./TransactionList.jsp");
		disp.forward(request, response);
	}

}
