package com.semi.yolo.common.encrypt;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

// 비밀번호 암호화
public class EncryptPassword extends HttpServletRequestWrapper {

	public EncryptPassword(HttpServletRequest request) {
		super(request);
	}

	// HttpServletRequest에서 재정의하고 싶은 메소드를 작성한다.
	@Override
	public String getParameter(String name) {
		
		// 클라이언트가 전달하는 값 중에 userPw 값만 암호화 처리해서 반환한다. 
		if (name.equals("userpw")) {
			return EncryptUtil.oneWayEnc(super.getParameter(name), "SHA-256");
		} else {
			return super.getParameter(name);			
		}
	}
}
