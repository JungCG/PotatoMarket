package servlet.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.MemberService;
import vo.MemberVO;

/**
 * Servlet implementation class IdSearchCtl
 */
@WebServlet("/IdSearchCtl.do")
public class IdSearchCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IdSearchCtl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("search_name");
		String email = request.getParameter("search_email");
		
		MemberService service = new MemberService();
		MemberVO vo = service.searchUsingEmail(email);

			
		PrintWriter out = response.getWriter();
		
		if(vo != null) {
			String id = vo.getM_id();
			int len = id.length();
			String secret_id = "";
			
			for(int i = 0 ; i<len-3;i++) {
				secret_id+=String.valueOf(id.charAt(i));
			}
			secret_id+="***";

			out.append("<script>");
			out.append("alert('"+name+"님의 아이디는 "+secret_id+" 입니다!');");
			out.append("location.href = \"Login.jsp\";");
			out.append("</script>");
		}else {
			out.append("<script>");
			out.append("alert('해당 이메일을 가진 "+name+"님의 아이디는 존재하지 않습니다!');");
			out.append("location.href = \"IdPwSearch.jsp\";");
			out.append("</script>");
		}
		
		out.flush();
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
