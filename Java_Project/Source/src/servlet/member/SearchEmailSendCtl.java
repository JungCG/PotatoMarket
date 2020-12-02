package servlet.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.Gmail;
import service.MemberService;
import vo.MemberVO;

/**
 * Servlet implementation class EmailSendCtl
 */
@WebServlet("/SearchEmailSendCtl.do")
public class SearchEmailSendCtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchEmailSendCtl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter script = response.getWriter();
		
		script.append("<script src = \"./js/jquery-3.5.1.js\" type = \"text/javascript\"></script>");
		script.append("<h1 align = \"center\">임시 비밀번호 이메일 전송중입니다.</h1>");
		script.append("<h3 id = \"info\" align = \"center\"></h3>");
		script.append("<style> #divv { text-align : center; } progress { padding : 0; margin : 0 auto; width : 500px; height : 500px;} </style>");
		script.append("<body> <div id = \"divv\"> <progress id = 'prog' max = \"100\" value = \"10\"></progress> </div> </body>");
		script.flush();
		try {
			Thread.sleep(500); //1초 대기
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		script.append("<script>");
		script.append("$('#prog').val('20');");
		script.append("</script>");
		script.flush();
		try {
			Thread.sleep(500); //1초 대기
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		MemberService service = new MemberService();
		String userID = (String) request.getAttribute("userID");
		// 사용자에게 보낼 메시지를 기입합니다.
		
		script.append("<script>");
		script.append("$('#info').text('사용자 이메일 확인')");
		script.append("</script>");
		script.append("<script>");
		script.append("$('#prog').val('30');");
		script.append("</script>");
		script.flush();
		try {
			Thread.sleep(500); //1초 대기
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		String host = "http://www.potato-market.com:8090/";
		// 개인 이메일 작성
		String from = "보내는 사람 이메일 주소";
		String to = service.getUserEmail(userID);
		String subject = "[감자마켓] 임시 비밀번호가 담긴 메일입니다.";
		
		MemberVO vo = service.searchUsingId(userID);
		String n_pwd = vo.getM_pw();
		
		String content = "임시 비밀번호는 아래와 같습니다." +"<br>"+n_pwd+ "<br>임시 비밀번호로 로그인 후 비밀번호를 변경해주세요!!!";
		
		script.append("<script>");
		script.append("$('#info').text('이메일 Contents 작성중')");
		script.append("</script>");
		script.append("<script>");
		script.append("$('#prog').val('40');");
		script.append("</script>");
		script.flush();
		try {
			Thread.sleep(500); //1초 대기
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		// SMTP에 접속하기 위한 정보를 기입합니다.
		
		Properties p = new Properties();
		p.put("mail.smtp.user", from);
		p.put("mail.smtp.host", "smtp.googlemail.com");
		p.put("mail.smtp.port", "456");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");
		
		script.append("<script>");
		script.append("$('#info').text('메일 서버 접속중')");
		script.append("</script>");
		script.append("<script>");
		script.append("$('#prog').val('50');");
		script.append("</script>");
		script.flush();
		try {
			Thread.sleep(500); //1초 대기
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		try {
			Authenticator auth = new Gmail();
			Session ses = Session.getInstance(p, auth);
			
			script.append("<script>");
			script.append("$('#info').text('세션 요청 중')");
			script.append("</script>");
			script.append("<script>");
			script.append("$('#prog').val('60');");
			script.append("</script>");
			script.flush();
			try {
				Thread.sleep(500); //1초 대기
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			
			ses.setDebug(true);
			MimeMessage msg = new MimeMessage(ses);
			msg.setSubject(subject);
			
			script.append("<script>");
			script.append("$('#info').text('메일 전송 중')");
			script.append("</script>");
			script.append("<script>");
			script.append("$('#prog').val('70');");
			script.append("</script>");
			script.flush();
			
			Address fromAddr = new InternetAddress(from);
			msg.setFrom(fromAddr);
			
			script.append("<script>");
			script.append("$('#prog').val('80');");
			script.append("</script>");
			script.flush();
			
			Address toAddr = new InternetAddress(to);
			msg.addRecipient(Message.RecipientType.TO, toAddr);
			
			script.append("<script>");
			script.append("$('#prog').val('90');");
			script.append("</script>");
			script.flush();
			
			msg.setContent(content, "text/html;charset=UTF-8");
			Transport.send(msg);
			
			script.println("<script>");
			script.println("alert('임시 이메일을 전송했습니다. 이메일 확인후 로그인해주세요!');");
			script.println("location.href = \"Login.jsp\";");
			script.println("</script>");
			script.close();
			
		} catch (Exception e) {
			script.println("<body>");
			script.println(e.getMessage());
			script.println("</body>");
			script.println("<script>");
			script.println("alert('오류가 발생했습니다..');");
			script.println("</script>");
			
			try {
				Thread.sleep(2000); //1초 대기
			} catch (InterruptedException e1) {
				e1.printStackTrace();
			}
			script.println("<script>");
			script.println("history.back();");
			script.println("</script>");
			script.close();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
