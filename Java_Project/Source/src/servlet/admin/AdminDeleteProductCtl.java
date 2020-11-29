package servlet.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.ChatService;
import service.ProductService;
import vo.ProductVO;

/**
 * Servlet implementation class AdminDeleteProductCtl
 */
@WebServlet("/AdminDeleteProductCtl.do")
public class AdminDeleteProductCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminDeleteProductCtl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	int p_id = Integer.parseInt(request.getParameter("p_id"));
	
	 ProductService sv = new ProductService();
	List<ProductVO> list = sv.selectProduct(p_id);
	ProductVO vo = list.get(0);
	
	int result = sv.AdminDeleteProduct(p_id);
	if(result == 1) {
		ChatService cs = new ChatService();
		cs.submit("MasterPotato1", vo.getM_id(), vo.getP_name()+" 이라는 제목으로 올린 상품이 관리자에 의해 삭제되었습니다.");
	}
RequestDispatcher dis = request.getRequestDispatcher("AdminListViewCtl.do?type=P");
dis.forward(request, response);
	
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
