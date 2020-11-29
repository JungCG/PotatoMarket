package servlet.member;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.MemberService;
import service.ReportService;
import vo.ReportVO;

/**
 * Servlet implementation class MemberReport
 */
@WebServlet("/MemberReport.do")
public class MemberReport extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MemberReport() {
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

	protected void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		ReportService rdao = new ReportService();
		MemberService mdao = new MemberService();

		List<ReportVO> rVoList = rdao.showReport();
		int r_id = 0;
		if (rVoList.size() == 0) {
			r_id = 1;
		} else {
			r_id = rVoList.size() + 1;
		}
		String m_id = request.getParameter("m_id");
		String m_id2 = request.getParameter("m_id2");
		String r_reason = request.getParameter("r_reason");

		List<ReportVO> VoList = rdao.showReport(m_id);

		mdao.UpdateReport(VoList.size() + 1, m_id);
		rdao.reportMember(r_id, m_id2, m_id, r_reason);

		response.sendRedirect("./CheckProfile.jsp");
	}
}
