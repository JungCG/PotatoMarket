package servlet.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.LikeDAO;
import dao.MemberDAO;
import vo.LikeVO;

/**
 * Servlet implementation class MemberLike
 */
@WebServlet("/MemberLike.do")
public class MemberLike extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MemberLike() {
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

	protected void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		LikeDAO ldao = new LikeDAO();
		MemberDAO mdao = new MemberDAO();
		String m_id = (String) request.getSession().getAttribute("ShowUserID");
		String m_id2 = (String) request.getSession().getAttribute("UserID");

		List<LikeVO> lVoList = ldao.showLike(m_id);
		int likecount;
		if (lVoList == null) {
			likecount = 0;
		} else {
			likecount = lVoList.size();
		}

		if (ldao.showLikeCheck(m_id, m_id2) == false) {
			mdao.UpdateLike(likecount + 1, m_id);
			ldao.likeMember(m_id, m_id2);
			response.sendRedirect("./CheckProfile.jsp");
		} else {
			response.setContentType("text/html; charset=UTF-8");
			ldao.deletelikeMember(m_id);
			mdao.UpdateLike(likecount - 1, m_id);
			PrintWriter out = response.getWriter();
			out.println("<script>alert(\"이미 추천한 회원입니다. 추천이 취소되었습니다.\"); location.href=\"./CheckProfile.jsp\";</script>");
			out.flush();
		}
	}

}
