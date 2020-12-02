package servlet.board;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import service.BoardService;
import vo.BaddVO;
import vo.BoardVO;

/**
 * Servlet implementation class BoardContentWriteCtl
 */
@WebServlet("/BoardContentWriteCtl.do")
public class BoardContentWriteCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardContentWriteCtl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	
	
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realFolder;
		PrintWriter out1 = response.getWriter();
		request.setCharacterEncoding("utf-8"); 
		response.setContentType("text/html; charset=UTF-8"); 
		PrintWriter out = response.getWriter(); 
		String fileSavePath = "boardupload";
		int uploadSizeLimit = 10 * 1024 * 1024; 
		String encType ="UTF-8"; 
		ServletContext context = getServletContext();
		String uploadPath = request.getSession().getServletContext().getRealPath(fileSavePath);
		MultipartRequest multi = new MultipartRequest(request,uploadPath,uploadSizeLimit,encType,new DefaultFileRenamePolicy()); 
		Enumeration files = multi.getFileNames();
		realFolder = request.getSession().getServletContext().getRealPath(fileSavePath);
		int i = 1;
		BaddVO vod = new BaddVO();
		while (files.hasMoreElements()) {      
			String file = (String)files.nextElement();
			String fileName = multi.getFilesystemName(file); 
			if(fileName==null) {
				fileName="";
			}
			if(i==1) {
				vod.setBa_img1(fileName);
			}else if(i==2) {
				vod.setBa_img2(fileName);
			}
			else if(i==3){
				vod.setBa_img3(fileName);
			}
			
			i++;
		}
		BoardVO vo = new BoardVO();
		vo.setB_ref(Integer.parseInt(multi.getParameter("b_ref")));
		vo.setB_re_step(Integer.parseInt(multi.getParameter("b_re_step")));
		vo.setB_re_level(Integer.parseInt(multi.getParameter("b_re_level")));
		vo.setB_type(multi.getParameter("b_type").charAt(0));
		vo.setB_secret(multi.getParameter("checksecret").charAt(0));
		try {
			vo.setB_secretnumber(Integer.parseInt(multi.getParameter("b_secretnumber")));
			
		}catch(Exception e) {
		}
		vo.setM_id(multi.getParameter("m_id"));
		vo.setB_title(multi.getParameter("b_title"));
		vo.setB_content(multi.getParameter("b_content"));
		BoardService sv = new BoardService();		
		int result = sv.writeBoard(vo);
		vod.setB_id(result);
		sv.insertImg(vod);
		if(result > 0) {
		out1.println("<script>");	
		out1.println("location.href='BoardContentCtl.do?b_id="+result+"&b_type="+multi.getParameter("b_type")+"&currentPage="+multi.getParameter("currentPage")+"'");
		out1.println("</script>");	
		out1.flush();
		out1.close();
		
		}else {
			out1.println("<script>");	
			out1.println("location.href='BoardWrite.jsp?b_id="+result+"&b_type="+multi.getParameter("b_type")+"&currentPage="+multi.getParameter("currentPage")+"'");
			out1.println("</script>");
			out1.flush();
			out1.close();
			
		}
		
	}

}
