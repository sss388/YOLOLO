package com.semi.yolo.common.encrypt;

import java.nio.charset.Charset;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class EncryptUtil {

	// 단방향 암호화(MD2, MD5, SHA, SHA-1, SHA-256, SHA-512를 지원한다.)
	public static String oneWayEnc(String message, String algorithm) {
		byte[] digest;
		String encMessage = "";
		
		try {
			// 메시지 다이제스트란, 입력 값의 길이에 상관없이 수학적인 연산을 항상 동일한 길이의 해시 값을 만들어낸다.
			MessageDigest md = MessageDigest.getInstance(algorithm);
			
			// 평문(Message)을 byte[] 변환하여 메시지 다이제스트로 전달한다.
			md.update(message.getBytes(Charset.forName("UTF-8")));
			
			// 암호화 형식에 맞게 변경하여 byte[]로 반환하는 메소드이다.
			digest = md.digest();
			
			// Base64를 사용하여 byte 형식의 데이터를 문자열로 Encoding 한다.
			encMessage = Base64.getEncoder().encodeToString(digest);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		return encMessage;
	}
}