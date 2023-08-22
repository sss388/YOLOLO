package com.semi.yolo.customerService.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.yolo.customerService.service.QnaBoardService;
import com.semi.yolo.customerService.vo.QnaReply;
import com.semi.yolo.customerService.vo.Qna_Board;



@WebServlet(name = "qnaView", urlPatterns = { "/customerService/qnaView" })
public class QnaViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public QnaViewServlet() {
      
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int no = Integer.parseInt(request.getParameter("no"));

//        System.out.println("게시글 번호 : " + no);

        Qna_Board board = new QnaBoardService().getBoardAndReplyByNo(no);
        QnaReply reply = null;
        if (board.getReply().equals("Y")) {
            reply = new QnaBoardService().getReplyByBoardNo(board.getNo());
        }

        request.setAttribute("board", board);
        request.setAttribute("reply", reply);
        request.getRequestDispatcher("/views/customerservice/qnaView.jsp").forward(request, response);
	
        
    }

}