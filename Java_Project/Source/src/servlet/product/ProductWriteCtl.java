package servlet.product;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import service.ChatService;
import service.FavorService;
import service.ProductService;
import vo.PaddVO;
import vo.ProductVO;

/**
 * Servlet implementation class ProductWriteCtl
 */
@WebServlet("/ProductWriteCtl.do")
public class ProductWriteCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductWriteCtl() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 글정보

		String userID = (String) request.getSession().getAttribute("userID");

		ProductService pservice = new ProductService();
		ProductVO vo = new ProductVO();

		String realFolder;
		PrintWriter out1 = response.getWriter();
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		int uploadSizeLimit = 10 * 1024 * 1024;
		String encType = "UTF-8";
		ServletContext context = getServletContext();
		String uploadPath = request.getSession().getServletContext().getRealPath("upload");
//		String uploadPath = "C:\\_z_im\\_z_im\\NewWorkSpace\\Potato\\WebContent\\upload";
		MultipartRequest multi = new MultipartRequest(request, uploadPath, uploadSizeLimit, encType,
				new DefaultFileRenamePolicy());
		Enumeration files = multi.getFileNames();

		
		
		
		

			int i = 1;
			PaddVO pvo = new PaddVO();
			while (files.hasMoreElements()) { // 업로드 된 파일 이름 얻어오기
				String file = (String) files.nextElement();
				String fileName = multi.getFilesystemName(file);
				if (fileName == null) {
					fileName = "";
				}
				if (i == 1) {
					pvo.setPa_img1(fileName);
				} else if (i == 2) {
					pvo.setPa_img2(fileName);
				} else if (i == 3) {
					pvo.setPa_img3(fileName);
				}
				i++;
			}

			
			

		
		
		
		// =============== 글 정보 ========================================

					int p_id = Integer.parseInt(multi.getParameter("p_id"));
					String m_id = (String) request.getSession().getAttribute("userID");
					int c_lid = Integer.parseInt(multi.getParameter("c_lid"));
					int l_id = Integer.parseInt(multi.getParameter("l_id"));
					String p_name = multi.getParameter("p_name");
					String p_adddate = multi.getParameter("p_adddate");
					int p_value = Integer.parseInt(multi.getParameter("p_value"));
					char p_status = multi.getParameter("p_status").charAt(0);
					String p_description = multi.getParameter("p_description");
					String p_brand = multi.getParameter("p_brand");
					char p_premium = multi.getParameter("p_premium").charAt(0);

					// 카테고리 기타 소분류 처리 코드
					if (multi.getParameter("c_sid") == null) { // 기타인경우
						vo.setC_sid(1);
					} else { // 소분류 값이 있는 경우
						int c_sid = Integer.parseInt(multi.getParameter("c_sid"));
						vo.setC_sid(c_sid);
					}

					vo.setP_id(p_id);
					vo.setM_id(userID);
					vo.setC_lid(c_lid);
					vo.setL_id(l_id);
					vo.setP_name(p_name);
					vo.setP_adddate(p_adddate);
					vo.setP_value(p_value);
					vo.setP_status(p_status);
					vo.setP_description(p_description);
					vo.setP_brand(p_brand);
					vo.setP_premium(p_premium);

					int result = pservice.insertProduct(vo);
					int result2 = pservice.insertProductImg(pvo);
					
					
					if (result > 0 && result2 > 0) { // 글등록 성공시 list 페이지로 이동
						FavorService fs = new FavorService();
						List<String> lls = fs.searchFavorMember(c_lid, vo.getC_sid());
						if(lls.size() > 0) {
							ChatService cs = new ChatService();
							for(int j = 0 ; j<lls.size();j++) {		
								String toID = lls.get(j);
								cs.submit("MasterPotato1", toID, " 회원님이 관심분야로 추가한 상품이 등록되었습니다.");
								cs.submit("MasterPotato1", toID, " 상품명 : " + p_name+" / 상품 설명 : "+p_description+" / 상품 가격 : "+p_value);
								cs.submit("MasterPotato1", toID, " 상품명으로 검색해주세요:-) 우리동네 직거래는 감자마켓!!");
							}
						}
						RequestDispatcher disp = request.getRequestDispatcher("ProductgetCountCtl.do");
						disp.forward(request, response);
					} else { // 글등록 실패시 데이터 가지고 이전화면으로 이동
						request.setAttribute("vo", vo);
						RequestDispatcher disp = request.getRequestDispatcher("Productwrite.jsp");
						disp.forward(request, response);
					}

	}

}
