package com.semi.yolo.community.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.semi.yolo.common.util.FileRename;
import com.semi.yolo.community.model.service.BoardService;
import com.semi.yolo.community.model.vo.Board;
import com.semi.yolo.member.vo.Member;
import com.semi.yolo.program.model.service.ProgramService;

@WebServlet(name = "boardwrite", urlPatterns = { "/community/reviewwrite" })
public class BoardWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BoardWriteServlet() {
    }
    
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
    	Member loginMember = (Member) session.getAttribute("loginMember");
    	
    	if (loginMember != null) {			
    		request.getRequestDispatcher("/views/community/review_write.jsp").forward(request, response);
		} else {
			request.setAttribute("msg", "로그인 후 작성해 주세요.");
			request.setAttribute("location", "/views/member/login.jsp");
			request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
		}
    }
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		int no = 0;
		
		if(loginMember != null) {
			// 파일이 저장될 경로
	        String mainFileUploadPath = getServletContext().getRealPath("/resources/upload/board/");

            // 파일의 최대 사이즈 지정 (10MB)
            int maxSize = 10485760;

            // 파일 인코딩 설정
            String encoding = "UTF-8";

            MultipartRequest mr = new MultipartRequest(request, mainFileUploadPath, maxSize, encoding, new FileRename());
			
			Board board = new Board();
			
			try {
				no = Integer.parseInt(mr.getParameter("no"));
				
				board.setNo(no);
			} catch (NumberFormatException e) {				
				// 게시글을 작성한 작성자의 NO 값
				board.setUserNo(loginMember.getNo());
			}
			
			
			// 폼 파라미터로 넘어온 값들
			board.setTitle(mr.getParameter("title"));
			board.setContent(mr.getParameter("content"));

			if(mr.getParameter("category").equals("meetingreview")) {
				board.setKind(2);
			} else {
				board.setKind(1);
			}
            
            board.setContent(mr.getParameter("content")); // 상세설명
			// 파일에 대한 정보	
            
            int result = new BoardService().save(board);
            
            if (result > 0) {
	        	// 게시글 등록 성공
            	if(no != 0) {
            		request.setAttribute("msg", "게시글 수정 성공");
            	} else {
            		request.setAttribute("msg", "게시글 등록 성공");
            	}
            	
                if(mr.getParameter("category").equals("meetingreview")) {
                	request.setAttribute("location", "/community/meetingReview"); 
    			} else {
    				request.setAttribute("location", "/community/freeBoard?no=" + board.getNo());
    			}
	        } else {
	        	request.setAttribute("msg", "게시글 등록 실패");
	        	request.setAttribute("location", "/");
	        }
		}  else {
	        // 로그인되어 있지 않을 경우에는 로그인 페이지로 이동
	        request.setAttribute("msg", "로그인이 필요한 서비스입니다");
	        request.setAttribute("location", "/member/login");
		}
    	
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}  

}