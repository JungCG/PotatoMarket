package servlet.board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BoardService;

/**
 * Servlet implementation class BoardContentPassCheckCtl
 */
@WebServlet("/BoardContentPassCheckCtl.do")
public class BoardContentPassCheckCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardContentPassCheckCtl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		int b_secretnumber = Integer.parseInt(request.getParameter("b_secretnumber"));
		int b_id = Integer.parseInt(request.getParameter("b_id"));
		int result =0;
		int pass = 0;
		BoardService sv = new BoardService();
		pass = sv.selectContentPass(b_id);
		
		if(pass == b_secretnumber) {
			result = 1;
			out.print(result=1);
		}else {
			out.print(result=0);
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
