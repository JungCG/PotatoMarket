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
 * Servlet implementation class ProductContectCtl
 */
@WebServlet("/ProductContentCtl.do")
public class ProductContentCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductContentCtl() {
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
		int c_lid = Integer.parseInt(request.getParameter("c_lid"));
		String m_id = request.getParameter("m_id");
		
		String userID = (String) request.getSession().getAttribute("userID");
		int result = 0;
		int likeresult2 = 0;
		if(Integer.parseInt(request.getParameter("Likeresult"))!=0) {
			likeresult2 = Integer.parseInt(request.getParameter("Likeresult"));
		}else {
			
		}
		
		//최근 본 상품
//		HttpSession session = request.getSession();
//		   if (session.getAttribute("img1") == null)
//		      session.setAttribute("img1", p_id);
//		   else if (session.getAttribute("img2") == null)
//		      session.setAttribute("img2", p_id);
//		   else if (session.getAttribute("img3") == null)
//		      session.setAttribute("img3", p_id);
//		   else{
//		      session.setAttribute("img3", session.getAttribute("img2"));
//		      session.setAttribute("img2", session.getAttribute("img1"));
//		      session.setAttribute("img1", p_id);
//		   }
		
		
		
		
		ProductService pservice = new ProductService();
		List<ProductVO> list = pservice.selectProduct(p_id, likeresult2);
		List<ProductVO> list3 = pservice.selectrelatedProduct(c_lid, p_id);
		List<ProductVO> list4 = pservice.selectotherProduct(m_id,p_id);
		result = pservice.checklikeProduct(p_id, userID);
		
		System.out.println(result);
		
		String[] FName = new String[3];
		FName = pservice.selectProductImg(p_id);
		
		ProductVO vo = new ProductVO();
		vo = list.get(0);
		String write_m_id = vo.getM_id();
		request.setAttribute("vo", vo);
		request.setAttribute("write_m_id", write_m_id);
		request.setAttribute("list3", list3);
		request.setAttribute("list4", list4);
		request.setAttribute("FName", FName);
		request.setAttribute("FName1", FName[0]);
		request.setAttribute("FName2", FName[1]);
		request.setAttribute("FName3", FName[2]);
		request.setAttribute("result", result);
		request.setAttribute("Likeresult2", likeresult2);
		RequestDispatcher disp = request.getRequestDispatcher("Productcontent.jsp");
		disp.forward(request, response);
	}

}
