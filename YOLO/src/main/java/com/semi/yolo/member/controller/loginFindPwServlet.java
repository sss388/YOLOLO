package com.semi.yolo.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "loginfindPw", urlPatterns = { "/member/login_FindPw" })
public class loginFindPwServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public loginFindPwServlet() {
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// 비밀번호 찾기로 포워딩
    	request.getRequestDispatcher("/views/member/login_FindPw.jsp").forward(request, response);
	}

  
}
