package com.semi.yolo.customerService.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.semi.yolo.customerService.service.commonService;
import com.semi.yolo.customerService.vo.Board;
import com.semi.yolo.member.vo.Member;


@WebServlet(name = "commonWrite", urlPatterns = { "/customerService/commonwirte" })
public class commonWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public commonWriteServlet() {
       
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
    	Member loginMember = (Member) session.getAttribute("loginMember");
    	
    	if (loginMember != null) {
    		request.getRequestDispatcher("/views/customerservice/commonwrite.jsp").forward(request, response);
    	} else {
    		request.setAttribute("msg", "로그인 후 작성해 주세요 ");
    		request.setAttribute("location", "/");
    		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
    	}	
    }

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
    	Member loginMember = (Member) session.getAttribute("loginMember");
    	
    	if (loginMember != null) {
    		// 파일이 저장될 경로 (getServletContext = jsp에서 application, getRealPath = 물리적인경로)
    		//String path = getServletContext().getRealPath("/resources/upload/board");
    		
    		// 파일의 최대 사이즈 지정 (바이트 단위로 10MB)
    		//int maxSize = 10485760;
    		
    		// 파일 인코딩 설정
    		//String encoding = "UTF-8";
    		
    		// DefaultFileRenamePolicy : 중복되는 파일 이름 뒤에 1 ~ 9999 붙인다.
//    		MultipartRequest mr = new MultipartRequest(request, path, maxSize, encoding, new DefaultFileRenamePolicy());
    		//MultipartRequest mr = new MultipartRequest(request, path, maxSize, encoding, new FileRename());
    		
    		Board board = new Board();
    		
    		// 게시글을 작성한 작성자의 No 값 
    		board.setWriterNo(loginMember.getNo());
    		
    		// 폼 파라미터로 넘어온 값들
    		String title = request.getParameter("title");
    		String content = request.getParameter("content");
    		board.setTitle(title);
    		board.setContent(content);
    		
    		// 파일에 대한 정보
    		//board.setRenamedFilename(request.getFilesystemName("upfile"));
    		//board.setOriginalFilename(request.getOriginalFileName("upfile"));
    	
    	// 파일을 서비스객체에 전달하고, (나중에 dao 객체를 사용해서 db에 저장)
    		int result = new commonService().save(board);
    		
    		if (result > 0) {
    			// 게시글 등록 성공
    			request.setAttribute("msg", "게시글 등록 성공");
        		request.setAttribute("location", "/customerService/commonlist");
    		} else {
    			// 게시글 등록 실패
    			request.setAttribute("msg", "게시글 등록 실패");
        		request.setAttribute("location", "/customerService/commonlist");
    		}
    		
    	} else {
    		request.setAttribute("msg", "로그인 후 작성해 주세요 ");
    		request.setAttribute("location", "/");
    	}	
    	// 무조건 포워딩 되게 else 밖으로
    	request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
		
	}
}
