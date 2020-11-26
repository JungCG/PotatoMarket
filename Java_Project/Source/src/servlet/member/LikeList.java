package servlet.member;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CategoryDAO;
import vo.Category_FavorVO;

/**
 * Servlet implementation class LikeList
 */
@WebServlet("/LikeList.do")
public class LikeList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LikeList() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		execute(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		execute(request, response);
	}

	private void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String m_id = (String) request.getSession().getAttribute("userID");
		CategoryDAO cdao = new CategoryDAO();
		
		List<Category_FavorVO> cVoList = cdao.showCname(m_id); // list에 뿌려줄 data를 다 받아왔음
		
		request.setAttribute("categoryVoList", cVoList);  // 위 받아온 list를  memberVoList이름에다가 실어줌.
		RequestDispatcher disp = request.getRequestDispatcher("./LikeList.jsp");
		disp.forward(request, response);
			
	}
}