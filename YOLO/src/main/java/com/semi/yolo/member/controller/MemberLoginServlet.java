package com.semi.yolo.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.semi.yolo.member.service.MemberService;
import com.semi.yolo.member.vo.Member;

// 로그인
@WebServlet(name = "memberLogin", urlPatterns = { "/member/login" })
public class MemberLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberLoginServlet() {
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 아이디 저장된 경우, 저장된 아이디 값을 불러와서 전달
		Cookie[] cookies = request.getCookies();
		String savedId = "";
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("saveId".equals(cookie.getName())) {
                    savedId = cookie.getValue();
                    break;
                }
            }
        }
        request.setAttribute("savedId", savedId);

        // 로그인 페이지로 포워딩
        request.getRequestDispatcher("/views/member/login.jsp").forward(request, response);
 
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// 아이디, 비밀번호, 저장된 아이디 정보처리
    	String userId = request.getParameter("userId");
    	
		String userPw = request.getParameter("userPw");   // 비밀번호
        String encryptedPassword = new MemberService().encryptSHA256(userPw);
        
    	String saveId = request.getParameter("saveId");
    	
    	// 콘솔로 확인
    	System.out.println(userId + ", " + userPw + ", " + saveId);
        
    	
    	if(saveId != null) {
    		Cookie cookie = new Cookie("saveId", userId);
    		
    		cookie.setMaxAge(604800);  // 7일 동안 유지
    		
    		response.addCookie(cookie);
    	} else {
    		
    		Cookie cookie = new Cookie("saveId", "");
    		
    		cookie.setMaxAge(0);
    		response.addCookie(cookie);
    	}
        
        Member loginMember = new MemberService().login(userId, encryptedPassword);
        
        // 로그인 결과로 얻은 loginMember 객체를 콘솔에 출력
    	//System.out.println(loginMember);
    	
    	// 로그인에 성공하고 실패했을 때
    	if(loginMember != null) {
    		// loginMember 세션에 저장
    		HttpSession session = request.getSession();
    		
            session.setAttribute("loginMember", loginMember);

            response.sendRedirect(request.getContextPath()+ "/");  // 로그인 성공시 홈으로 감
    	} else {
    		
    		request.setAttribute("msg", "아이디나 비밀번호가 일치하지 않습니다");
    		request.setAttribute("location", "/member/login");  // 다시 로그인화면으로 감
    		
    		 // 아이디 저장한 경우, 저장된 아이디 값을 전달
            if (saveId != null) {
                Cookie[] cookies = request.getCookies();
                String savedId = "";
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        if ("saveId".equals(cookie.getName())) {
                            savedId = cookie.getValue();
                            break;
                        }
                    }
                }
                request.setAttribute("savedId", savedId);
            }
    		

    		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
    	}
    }
} 

