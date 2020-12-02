package servlet.board;

import java.io.File;
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
 * Servlet implementation class BoardContentModifyCtl
 */
@WebServlet("/BoardContentModifyCtl.do")
public class BoardContentModifyCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardContentModifyCtl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realFolder;
		request.setCharacterEncoding("utf-8"); 
		response.setContentType("text/html; charset=UTF-8"); 
		PrintWriter out = response.getWriter(); 
		String fileSavePath ="boardupload";
		int uploadSizeLimit = 10 * 1024 * 1024; 
		String encType ="UTF-8"; 
		ServletContext context = getServletContext();
		String uploadPath = request.getSession().getServletContext().getRealPath(fileSavePath);
		MultipartRequest multi = new MultipartRequest(request,uploadPath,uploadSizeLimit,encType,new DefaultFileRenamePolicy()); 
		Enumeration files = multi.getFileNames();
		realFolder = request.getSession().getServletContext().getRealPath(fileSavePath);
		int i = 1;
		BoardService sv = new BoardService();
		BaddVO vo = new BaddVO();
		int Bno =Integer.parseInt(multi.getParameter("B_id"));
		vo.setB_id(Bno);
		try {
		if((!(multi.getParameter("img1")==null)||(!multi.getParameter("img1").equals("")))) {
			vo.setBa_img1(multi.getParameter("img1"));
			File file2 = new File("C:\\Java_gjw\\PotatoBoardMVC2\\WebContent\\boardupload\\"+multi.getParameter("img1"));  
			
		} 
		if((!(multi.getParameter("img2")==null)||(!multi.getParameter("img2").equals("")))){
			File file2 = new File("C:\\Java_gjw\\PotatoBoardMVC2\\WebContent\\boardupload\\"+multi.getParameter("img2"));
			if( file2.exists() ){
				if(file2.delete()){
					}
				else{ 
					}
				}
				else{ 
				}
	
			
			
			vo.setBa_img2(multi.getParameter("img2"));
		}
			if((!(multi.getParameter("img3")==null)||(!multi.getParameter("img3").equals("")))) {
				vo.setBa_img3(multi.getParameter("img3"));
				File file2 = new File("C:\\Java_gjw\\PotatoBoardMVC2\\WebContent\\boardupload\\"+multi.getParameter("img3"));
				if( file2.exists() ){
					if(file2.delete()){
						}
					else{ 
					} 
					}else{ 
					}

				
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		if((!(multi.getParameter("img1")==null))&&(!(multi.getParameter("img2")==null))&&(!(multi.getParameter("img3")==null))) {
			
			sv.deleteImg(vo);
		}
		
		BaddVO vod = new BaddVO();
		while (files.hasMoreElements()) {       // �뾽濡쒕뱶 �맂 �뙆�씪 �씠由� �뼸�뼱�삤湲�    
			String file = (String) files.nextElement();
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
			vod.setB_id(Bno);
			sv.updateImg(vod);
		String Bcontent =multi.getParameter("B_content");
		char b_type = multi.getParameter("b_type").charAt(0);
		String Bsubject =multi.getParameter("B_title");
		BoardVO vof = new BoardVO();
		int b_scretnumber =0;
		try {
			b_scretnumber = Integer.parseInt(multi.getParameter("b_scretnumber"));
		vof.setB_secretnumber(b_scretnumber);
		}catch(Exception e) {
			b_scretnumber = 0;
		}
		char b_secret = multi.getParameter("checksecret").charAt(0);
		vof.setB_id(Bno);
		vof.setB_type(b_type);
		vof.setB_content(Bcontent);
		vof.setB_secret(b_secret);
		vof.setB_title(Bsubject);
		sv.updateBoard(vof);
		response.sendRedirect("BoardContentCtl.do?b_id="+Bno+"&currentPage="+multi.getParameter("currentPage"));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}