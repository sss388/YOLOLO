package com.semi.yolo.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "login_FindId", urlPatterns = { "/member/login_FindId" })
public class loginFindIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public loginFindIdServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 로그인 찾기로 포워딩
		request.getRequestDispatcher("/views/member/login_FindId.jsp").forward(request, response);
	}
}
