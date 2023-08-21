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


@WebServlet(name = "myinfo", urlPatterns = { "/mypage/mypage_myInfo" })
public class MyInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MyInfoServlet() {
    }
    
    @Override
   	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

       	HttpSession session = request.getSession();
       	Member loginMember = (Member) session.getAttribute("loginMember");
       	
       	if(loginMember != null) {
       		// 로그인한 회원이 있다면, 회원 정보 페이지로 이동
       		request.getRequestDispatcher("/views/mypage/mypage_myInfo.jsp").forward(request, response);    		
       	} else {
       		// 로그인한 회원이 없다면, 메시지를 설정하고 메시지 페이지로 이동
       		request.setAttribute("msg", "로그인 후 수정해 주세요");
       		request.setAttribute("location", "/member/login");
       		
       		// 메시지 페이지로 포워딩
       		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
       	}
       	
   	}

}
