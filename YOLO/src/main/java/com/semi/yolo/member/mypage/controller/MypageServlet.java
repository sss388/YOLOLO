package com.semi.yolo.member.mypage.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.semi.yolo.member.vo.Member;

@WebServlet(name = "mypage", urlPatterns = { "/mypage" })
public class MypageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public MypageServlet() {

    }
    // 마이페이지 메인 화면에 이름, 이메일 정보 나오도록!
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       	HttpSession session = request.getSession();
       	Member loginMember = (Member) session.getAttribute("loginMember");
    }


}
