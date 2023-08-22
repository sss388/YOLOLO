package com.semi.yolo.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.yolo.member.service.MemberService;
import com.semi.yolo.member.vo.Member;

// 회원가입
@WebServlet(name = "createAccount", urlPatterns = { "/member/createAccount" })
public class CreateAccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CreateAccountServlet() {
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 회원가입 페이지로 포워딩
		request.getRequestDispatcher("/views/member/CreateAccount.jsp").forward(request, response); 
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		Member member = new Member();
		
		member.setUserId(request.getParameter("userId"));  // 아이디
//		member.setUserPw(request.getParameter("userPw"));  // 비밀번호 이 방법으로는 null뜸 
		
		// 비밀번호  => 이방법으로는 제대로 가져옴 
		// "userPw" 파라미터를 가져와서
		String userPw = request.getParameter("userpw");   // 비밀번호
        String encryptedPassword = new MemberService().encryptSHA256(userPw);
        member.setUserPw(encryptedPassword);
            	    
		member.setName(request.getParameter("name"));      // 이름
		
	    // 주소 정보 처리
		String postcode = request.getParameter("postcode");
		String address1 = request.getParameter("address1");
		String address2 = request.getParameter("address2");
		
		member.setPostcode(postcode);
		member.setAddress1(address1);
		member.setAddress2(address2);
	    
	    
	    // 휴대전화 정보 처리
	    String phone1 = request.getParameter("phone1");
	    String phone2 = request.getParameter("phone2");
	    String phone3 = request.getParameter("phone3");
	    member.setPhone(phone1 + "-" + phone2 + "-" + phone3);
	    
	    // 이메일
	    member.setEmail(request.getParameter("email"));
	    
		// 동의내용
	    member.setAgree(request.getParameter("agree"));
	    
	    System.out.println(member); // 확인
	    
	    int result = new MemberService().save(member);  // 회원 정보 저장에서 가져옴
	    
	  	if(result > 0) {
    		// 회원가입 완료 => 홈으로 보냄
    		request.setAttribute("msg", "회원가입 성공");
    		request.setAttribute("location", "/");    		
    	} else {
    		// 회원가입 실패 => 회원가입 페이지로 보냄
    		request.setAttribute("msg", "회원가입에 실패하였습니다.");
    		request.setAttribute("location", "/member/createAccount");
    	}
    	
    	request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
    }
}
