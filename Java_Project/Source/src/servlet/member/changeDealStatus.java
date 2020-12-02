package servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.MemberService;
import service.ProductService;
import service.TradeInfoService;


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

		ProductService pdao = new ProductService();
		int p_id = Integer.parseInt(request.getParameter("p_id_value"));
		String dealstatus = request.getParameter("dealstatus_value");
		
		TradeInfoService tdao = new TradeInfoService();
		String s_id = (String) request.getSession().getAttribute("userID");
		String b_id = request.getParameter("buyerid");
		
		MemberService mdao = new MemberService();
		
		
		if (dealstatus.equals("N")) {
			dealstatus = "Y";
			tdao.insertTradeInfo(p_id, s_id, b_id);
			mdao.updateDealAmount(s_id);
		} else {
			dealstatus = "N";
			mdao.deleteDealAmount(s_id);
			tdao.deleteTradeInfo(p_id);
		}
		
		pdao.changeDealStatus(dealstatus, p_id);
		
		response.sendRedirect("./TransactionList.do");
	}
}
