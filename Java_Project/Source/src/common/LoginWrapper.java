package common;

import java.nio.charset.Charset;
import java.security.MessageDigest;
import java.util.Base64;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

// LoginWrapper 는 HttpServletRequestWrapper 를 상속받은 클래스
public class LoginWrapper extends HttpServletRequestWrapper {
	public LoginWrapper(HttpServletRequest request) {
		super(request);	// 부모에게 값을 넘겨줌
	}
	
	// 모달창처럼 창이 여러개인 경우 response를 어디에 띄울건지 관리를 잘 해야한다.
	// form 을 통해서 온 데이터들은 request.getParameter를 하지만.
	// 이미지 가지고 가는애는 메소드 post를 주로 do post 로 들어온다. getParameter 를 할 수 밖에 없는 케이스 ㅡ> 보통 doPost 로 들어오면 doGet 으로 다시 보낸다.
	@Override
	public String getParameter(String name) {
		if (name != null && name.equals("pwd"))
			name = getSha512(super.getParameter(name)); // SHA-512 암호화 메소드
		else
			name = super.getParameter(name);	// 부모 메소드 호출 // name 변수 재활용 (이렇게 많이 씀)
		return name;
	}

	private static String getSha512(String pwd) {
		try { // SHA-512 암호화를 위한 로직 구현
			MessageDigest md = MessageDigest.getInstance("SHA-512");	//MessageDigest 객체 생성
			byte[] bytes = pwd.getBytes(Charset.forName("UTF-8"));
			md.update(bytes);
			return Base64.getEncoder().encodeToString(md.digest());
		} catch (Exception e) {
			System.out.println("Sha512 error.");
			e.printStackTrace();
			return null;
		}
	}
}