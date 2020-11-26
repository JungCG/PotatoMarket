package servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProductDAO;
import dao.TradeInfoDAO;

@WebServlet("/changeDealStatus.do")
public class changeDealStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public changeDealStatus() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ProductDAO pdao = new ProductDAO();
		int p_id = Integer.parseInt(request.getParameter("p_id_value"));
		String dealstatus = request.getParameter("dealstatus_value");
		
		TradeInfoDAO tdao = new TradeInfoDAO();
		String s_id = (String) request.getSession().getAttribute("ID");
		String b_id = request.getParameter("buyerid");
		
		if (dealstatus.equals("N")) {
			dealstatus = "Y";
			tdao.insertTradeInfo(p_id, s_id, b_id);
		} else {
			dealstatus = "N";
			tdao.deleteTradeInfo(p_id);
		}
		
		pdao.changeDealStatus(dealstatus, p_id);
		
		response.sendRedirect("./TransactionList.do");
	}
}
