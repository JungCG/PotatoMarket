package common;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class MyFilter implements Filter {
	 @Override
	 public void init(FilterConfig arg0) throws ServletException {
	 System.out.println("MyFilter.init() 호출~!");
	 }
	 @Override
	 public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)	// 값들 request 와, 화면에 뿌려줄 response를 WAS 형태로 던져줌.
	 throws IOException, ServletException {

	 HttpServletRequest h_request = (HttpServletRequest) request;	//형변환 해줌.	//[이 순간] 까지는 주소복사임.

	 //기존 입력한 pwd 값을 psdChk라는 Attribute 에 잠시 저장함. ㅡ> 왜? request 값을 암호화로 바꿀거니까 원본값 저장하는 것. setAttribute : 전달하고 싶은 값을 String 이름으로 Object 에 저장하는 메소드
	 request.setAttribute("pwdChk", h_request.getParameter("pwd"));
	 LoginWrapper lw = new LoginWrapper(h_request);		//암호화 수행	// [이 순간] lw 객체를 하나 생성하는 개념	// 생성할 때 (자식인)LoginWrapper 로 생성했으니 Override 된 (자식의)메소드 사용
	 chain.doFilter(lw, response);	//request 자리에 lw 넣어준 것. 이 자리의 값들을 화면에 보여줄 때 까지 가지고 다님.
	 }
	 @Override
	 public void destroy() {
	 System.out.println("Myfilter.destroy() 호출!!");
	 }
	}