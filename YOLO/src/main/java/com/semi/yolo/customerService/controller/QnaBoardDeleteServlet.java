package com.semi.yolo.customerService.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.yolo.customerService.service.QnaBoardService;




@WebServlet(name = "boardDelete", urlPatterns = { "/customerService/delete" })
public class QnaBoardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public QnaBoardDeleteServlet() {
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	int no = 0;
    	int result = 0;
    	 
    	no = Integer.parseInt(request.getParameter("no"));
    	result = new QnaBoardService().delete(no); // no에 해당하는 게시글 삭제
    	
    	if (result > 0) {
    		// 게시글 삭제 성공
    		request.setAttribute("msg", "게시글 삭제 성공");
    	    request.setAttribute("location", "/customerService/qnalist");
    		
    	} else {
    		// 게시글 삭제 실패
    		request.setAttribute("msg", "게시글 삭제 실패");
    		request.setAttribute("location", "/customerService/update?no=" + no);
    		
    		
    	}
    	request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
