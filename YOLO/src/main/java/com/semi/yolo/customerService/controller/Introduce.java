package com.semi.yolo.customerService.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "introduce", urlPatterns = { "/service/introduction" })
public class Introduce extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Introduce() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/views/service/introduction.jsp").forward(request, response); //포워딩
	}

}
