package com.semi.yolo.member.mypage.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.semi.yolo.member.service.MemberService;
import com.semi.yolo.member.vo.Member;

// 회원 탈퇴하기

@WebServlet(name = "memberdelete", urlPatterns = { "/member/delete" })
public class MemberDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public MemberDeleteServlet() {
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();  // request 객체로 부터 session 객체를 얻어옴
    	Member loginMember = (Member) session.getAttribute("loginMember");
    	
    	if(loginMember != null) {
    		int result = new MemberService().delete(loginMember.getNo());
    		
    		if (result > 0) {
    			// 탈퇴 성공
    			request.setAttribute("msg", "정상적으로 탈퇴되었습니다.");
    			request.setAttribute("location", "/");    		
    		
    		} else {
    			// 탈퇴 실패
    			request.setAttribute("msg", "탈퇴에 실패하였습니다.");
    			request.setAttribute("location", "/member/myPage");    		
    		}
    	} else {
    		request.setAttribute("msg", "로그인 후 삭제해 주세요.");
    		request.setAttribute("location", "/");    		
    	}
    	request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}

}
