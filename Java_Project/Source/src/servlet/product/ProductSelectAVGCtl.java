package servlet.product;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import service.ProductService;

/**
 * Servlet implementation class ProductSelectAVGCtl
 */
@WebServlet("/ProductSelectAVGCtl.do")
public class ProductSelectAVGCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductSelectAVGCtl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String select = request.getParameter("searchbox_box");
		ProductService sv = new ProductService();
		int avg[]= new int[4];
		avg =sv.selectProuctAVG(select);
		JSONObject obj = new JSONObject();
		System.out.println(avg[0]);
		System.out.println(avg[1]);
		System.out.println(avg[2]);
		System.out.println(avg[3]);
		obj.put("avg8",avg[0]);
		obj.put("avg9",avg[1]);
		obj.put("avg10",avg[2]);
		obj.put("avg11",avg[3]);
		PrintWriter out = response.getWriter();
		out.print(obj);
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
