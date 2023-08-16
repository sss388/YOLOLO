package com.semi.yolo.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.yolo.member.dao.MemberDao;
import com.semi.yolo.member.vo.Member;


@WebServlet(name = "login_FindId_Result", urlPatterns = { "/member/login_FindId_Result" })
public class LoginFindIdResultServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public LoginFindIdResultServlet() {

    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        
        MemberDao memberDao = new MemberDao();
        Member member = memberDao.findMemberByNameAndPhone(name, email);
        
        request.setAttribute("member", member);
        
        request.setAttribute("name", name);
        request.setAttribute("email", email);
        
        
        // JSP로 포워딩
        request.getRequestDispatcher("/views/member/login_FindId_Result.jsp").forward(request, response);
	}

}
