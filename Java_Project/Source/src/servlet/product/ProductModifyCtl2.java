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

import service.ProductService;
import vo.PaddVO;
import vo.ProductVO;

/**
 * Servlet implementation class ProductModifyCtl2
 */
@WebServlet("/ProductModifyCtl2.do")
public class ProductModifyCtl2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductModifyCtl2() {
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
		
		String userID = (String) request.getSession().getAttribute("userID");
		
		
		ProductService pservice = new ProductService();
		ProductVO vo = new ProductVO();
		
		
		
		String realFolder;
		PrintWriter out1 = response.getWriter();
		request.setCharacterEncoding("utf-8"); 
		response.setContentType("text/html; charset=UTF-8"); 
		PrintWriter out = response.getWriter(); 
		int uploadSizeLimit = 10 * 1024 * 1024; 
		String encType ="UTF-8"; 
		ServletContext context = getServletContext();
		String uploadPath = context.getRealPath("upload");
//		String uploadPath = "C:\\_z_im\\_z_im\\NewWorkSpace\\Potato\\WebContent\\upload";
		MultipartRequest multi = new MultipartRequest(request,uploadPath,uploadSizeLimit,encType,new DefaultFileRenamePolicy()); 
		Enumeration files = multi.getFileNames();
		
		
		
		int p_id = Integer.parseInt(multi.getParameter("p_id"));
		
		

//		PaddVO Delpvo = new PaddVO();
//		Delpvo.setP_id(p_id);
//
//		Delpvo.setPa_img1(multi.getParameter("img1"));
//		Delpvo.setPa_img2(multi.getParameter("img2"));
//		Delpvo.setPa_img3(multi.getParameter("img3"));
		
		
		
		
//		int result2 = 0;
		
//		if ((!(multi.getParameter("img1") == 1)) || (!(multi.getParameter("img2") == 1)) || (!(multi.getParameter("img3") == null))) {
//			result2 = pservice.deleteProductImg(Delpvo);
//			// ImgupChk : 0 삭제된 파일없음
//			// ImgupChk : 1 삭제한 파일명이 있음
//			System.out.println("이미지 삭제함" + Delpvo.toString());
//		}
		
		//기존파일 그대로 업뎃하기
		PaddVO expvo = new PaddVO();
		expvo.setP_id(p_id);
		expvo.setPa_img1(multi.getParameter("eximg1"));
		expvo.setPa_img2(multi.getParameter("eximg2"));
		expvo.setPa_img3(multi.getParameter("eximg3"));
		
		
		
		
		//새로 업로드된 파일
		int i = 1;
		PaddVO pvo = new PaddVO();
		while (files.hasMoreElements()) {       // 업로드 된 파일 이름 얻어오기
			String file = (String)files.nextElement();
			String fileName = multi.getFilesystemName(file);
			
			if(i==1) {
				if(fileName==null) {
					fileName = multi.getParameter("eximg1");
					if(fileName.equals("0")) {
						fileName = null;
					}
					pvo.setPa_img1(fileName);
				}else {
					pvo.setPa_img1(fileName);
				}
			}else if(i==2) {
				if(fileName==null) {
					fileName = multi.getParameter("eximg2");
					if(fileName.equals("0")) {
						fileName = null;
					}
					pvo.setPa_img2(fileName);
				}else {
					pvo.setPa_img2(fileName);
				}
			}
			else if(i==3){
				if(fileName==null) {
					fileName = multi.getParameter("eximg3");
					if(fileName.equals("0")) {
						fileName = null;
					}
					pvo.setPa_img3(fileName);
				}else {
					pvo.setPa_img3(fileName);
				}
			}
			i++;
		}
		
		
		
		
		p_id = Integer.parseInt(multi.getParameter("p_id"));
		int c_lid = Integer.parseInt(multi.getParameter("c_lid"));
		int l_id = Integer.parseInt(multi.getParameter("l_id"));
		String p_name = multi.getParameter("p_name");
		int p_value = Integer.parseInt(multi.getParameter("p_value"));
		char p_status = multi.getParameter("p_status").charAt(0);
		String p_description = multi.getParameter("p_description");
		String p_brand = multi.getParameter("p_brand");
		char p_premium = multi.getParameter("p_premium").charAt(0);
		int p_view = Integer.parseInt(multi.getParameter("p_view"));
		int p_like = Integer.parseInt(multi.getParameter("p_like"));
		
		// 카테고리 기타 소분류 처리 코드
		if(multi.getParameter("c_sid")==null) {	//기타인경우
			vo.setC_sid(1);
		}else {	// 소분류 값이 있는 경우
			int c_sid = Integer.parseInt(multi.getParameter("c_sid"));
			vo.setC_sid(c_sid);
		}
		
		vo.setP_id(p_id);
		vo.setM_id(userID);
		vo.setC_lid(c_lid);
		vo.setL_id(l_id);
		vo.setP_name(p_name);
		vo.setP_value(p_value);
		vo.setP_status(p_status);
		vo.setP_description(p_description);
		vo.setP_brand(p_brand);
		vo.setP_premium(p_premium);
		vo.setP_view(p_view);
		vo.setP_like(p_like);
		
		pvo.setP_id(p_id);
		
		
		String FName[] = new String[3];
		int result3 = pservice.updateProductImg(pvo);
		List<ProductVO> list = pservice.updateProduct(vo);
		
		
		FName = pservice.selectProductImg(p_id);
		
		
		if (list.size()>0 && result3 > 0) {	//글수정 성공시 데이터 가지고 해당글 상세페이지로 이동
			vo = list.get(0);
			
			System.out.println(vo.toString());
			System.out.println(result3 + "//////" + FName[0]+FName[1]+FName[2]);
			
			request.setAttribute("vo", vo);
			request.setAttribute("FName", FName);
			RequestDispatcher disp = request.getRequestDispatcher("ProductContentCtl.do?p_id=" + p_id + "&c_lid=" + c_lid + "&m_id=" + userID + "&Likeresult=0");
			disp.forward(request, response);
		} else {	//글등록 실패시 데이터 가지고 이전화면으로 이동
			request.setAttribute("vo", vo);
			RequestDispatcher disp = request.getRequestDispatcher("Productmodify.jsp");
			disp.forward(request, response);
		}
	}

}