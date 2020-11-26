package common;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator{
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		// 개인 이메일, 비밀번호 작성
		return new PasswordAuthentication("****@email.com", "password123");
	}
}