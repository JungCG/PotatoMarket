package servlet.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.SHA256;
import service.MemberService;
import vo.MemberVO;

/**
 * Servlet implementation class JoinCtl
 */
@WebServlet("/JoinCtl.do")
public class JoinCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public JoinCtl() {
		super();
		// TODO Auto-generated constructor stub
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
		// TODO Auto-generated method stub
		MemberService service = new MemberService();
		MemberVO vo = new MemberVO();
		String fileSavePath = "profileIMG";
		int uploadSizeLimit = 10 * 1024 * 1024;
		String encType = "UTF-8";
		if (!ServletFileUpload.isMultipartContent(request)) {
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('encType error!');");
			out.println("location.herf='/Join.jsp'");
			out.println("</script>");
			out.flush();
			out.close();
		} else {
			ServletContext context = getServletContext();
			String uploadPath = request.getSession().getServletContext().getRealPath(fileSavePath);
			
			MultipartRequest multi = new MultipartRequest(request, uploadPath, uploadSizeLimit, encType, new DefaultFileRenamePolicy());

			String imgname = multi.getFilesystemName("userimg");

			vo.setM_image(imgname);

			vo.setM_id(multi.getParameter("id"));
			vo.setM_name(multi.getParameter("username"));
			vo.setM_pw(multi.getParameter("userpwd"));
			vo.setM_phone(multi.getParameter("userphone"));
			vo.setM_email(multi.getParameter("email"));
			vo.setM_emailhash(SHA256.getSHA256(multi.getParameter("email")));
			String[] date = multi.getParameter("userbirth").split("-");
			vo.setM_birth(new Date(Integer.parseInt(date[0]), Integer.parseInt(date[1]), Integer.parseInt(date[2])));
			vo.setM_gender(multi.getParameter("wUserGender").charAt(0));
			vo.setM_nick(multi.getParameter("usernickname"));
			vo.setM_intro(multi.getParameter("userintro"));

			vo.setM_address(
					multi.getParameter("sample4_roadAddress") + "_" + multi.getParameter("sample4_detailAddress"));
			
			if(multi.getParameter("sample4_roadAddress").equals("") || multi.getParameter("sample4_roadAddress") == null) {
				request.getRequestDispatcher("Join.jsp").forward(request, response);
			}
			
			String lchk1 = multi.getParameter("sample4_roadAddress").split(" ")[0];
			String lchk2 = multi.getParameter("sample4_roadAddress").split(" ")[1];

			if (lchk1.equals("서울")) {
				vo.setL_id(service.localNumber(lchk2));
			} else {
				vo.setL_id(service.localNumber(lchk1));
			}

			boolean check = service.insertMember(vo);

			if (check == true) {
				boolean check2 = service.insertOutMember(vo.getM_id());
				if(check2 == true) {
					request.setAttribute("userID", vo.getM_id());
					request.getRequestDispatcher("EmailSendCtl.do").forward(request, response);
				}else {
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('회원가입 실패, 관리자에게 문의해주세요.');");
					out.println("location.herf='./Join.jsp'");
					out.println("</script>");
					out.flush();
					out.close();
				}
			} else {
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('회원가입 실패');");
				out.println("location.herf='./Join.jsp'");
				out.println("</script>");
				out.flush();
				out.close();
			}
		}
	}

}
