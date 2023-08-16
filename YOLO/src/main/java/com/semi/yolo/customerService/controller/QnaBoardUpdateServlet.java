package com.semi.yolo.customerService.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.coyote.Request;

import com.oreilly.servlet.MultipartRequest;
import com.semi.yolo.common.util.FileRename;
import com.semi.yolo.community.model.service.BoardService;
import com.semi.yolo.customerService.service.QnaBoardService;
import com.semi.yolo.customerService.vo.Board;
import com.semi.yolo.member.vo.Member;



@WebServlet(name = "qnaBoardUpdate", urlPatterns = { "/customerService/update" })
public class QnaBoardUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public QnaBoardUpdateServlet() {
       
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int no = 0;
		Board board = null;
		HttpSession session = request.getSession();
    	Member loginMember = (Member) session.getAttribute("loginMember");
    	
    	if (loginMember != null) {
    		no = Integer.parseInt(request.getParameter("no"));
    		board = new QnaBoardService().getBoardByNo(no); // 가져온 no로 게시글 조회
    		
    		if (board != null && loginMember.getUserId().equals(board.getWriterId())) {
    			request.setAttribute("board", board);
    			request.getRequestDispatcher("/views/customerservice/qnaUpdate.jsp").forward(request, response);
    		} else {
    			request.setAttribute("msg", "잘못된 접근입니다.");
    			request.setAttribute("location", "/customerService/qnalist");
    			request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
    		}
    	} else {
    		request.setAttribute("msg", "로그인 후 수정해 주세요 ");
    		request.setAttribute("location", "/");
    		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
    	}	
    	 
    	
	}

	// 게시글 수정 누르고 제목이랑 내용 바꿀 땐 post에서 실행되도록 한다.
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int no = 0;
		Board board = null;
		HttpSession session = request.getSession();
    	Member loginMember = (Member) session.getAttribute("loginMember");
    	
    	System.out.println(request.getParameter("no"));
    	
    	if (loginMember != null) {
    		// 4개 추가해봄
    		//String path = getServletContext().getRealPath("/resources/upload/qna");
    		//int maxSize = 10485760;
    		//String encoding = "UTF-8";
    		//MultipartRequest mr = new MultipartRequest(request, path, maxSize, encoding, new FileRename());
    		
    		no = Integer.parseInt(request.getParameter("no"));
    		board = new QnaBoardService().getBoardByNo(no);  // no값으로 게시글 조회
    			
    		if (board != null && loginMember.getUserId().equals(board.getWriterId())) {
    			board.setTitle(request.getParameter("title"));
    			board.setContent(request.getParameter("content"));
    			
    			// 추가해봄 (int result = new QnaBoardService().save(board);)전까지
//    			String originalFileName = mr.getOriginalFileName("upfile");
//    			String filesystemName = mr.getFilesystemName("upfile");
//    			
//    			if (originalFileName != null && originalFileName!= null) {
//    				board.setOriginalFilename(originalFileName);
//    				board.setRenamedFilename(filesystemName);
//    			}
//    		
    			int result = new QnaBoardService().save(board);
    			
    			if (result > 0) {
    				// 게시글 수정 성공
    				request.setAttribute("msg", "게시글 수정 성공");
    				request.setAttribute("location", "/customerService/qnalist?no=" + board.getNo());
    			} else {
    				// 게시글 수정 실패
    				request.setAttribute("msg", "게시글 수정 실패");
    				request.setAttribute("location", "/customerService/update?no=" + board.getNo());	
    			}
    		} 
    	} else {
    		request.setAttribute("msg", "로그인 후 수정해 주세요 ");
    		request.setAttribute("location", "/");
    	}

    	request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}

}
