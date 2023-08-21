package com.semi.yolo.program_create.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.yolo.program.model.service.ProgramService;
import com.semi.yolo.program.model.vo.Program;

@WebServlet(name = "programdetailedpage", urlPatterns = { "/program_create/detailedpage" })
public class ProgramDetailedpageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public ProgramDetailedpageServlet() {
    }
    
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int no = Integer.parseInt(request.getParameter("no"));
    	
    	Program program = new ProgramService().getProgramByNo(no);
    	
    	request.setAttribute("program", program); 
    	request.getRequestDispatcher("/views/program_create/detailedpage.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
