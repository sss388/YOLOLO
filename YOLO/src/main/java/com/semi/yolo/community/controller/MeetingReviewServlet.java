package com.semi.yolo.community.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.yolo.common.util.PageInfo;
import com.semi.yolo.community.model.service.BoardService;
import com.semi.yolo.community.model.service.CommentService;
import com.semi.yolo.community.model.vo.Board;
import com.semi.yolo.community.model.vo.Comment;
import com.semi.yolo.member.service.MemberService;
import com.semi.yolo.program.model.service.ProgramService;
import com.semi.yolo.program.model.vo.Program;

@WebServlet(name = "mettingReview", urlPatterns = { "/community/meetingReview" })
public class MeetingReviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MeetingReviewServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int page = 1; // 기본 페이지 번호를 1로 설정
        int listCount = 0;
        int no = 0;
        
        PageInfo pageInfo = null;
        List<Board> list = null;

        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
            // 페이지 번호가 파라미터로 전달되지 않은 경우 처리
        }
        
        try {
        	no = Integer.parseInt(request.getParameter("no"));
        	
        	Board board = new BoardService().getProgramByNo(no);
        	String member_name = new MemberService().getMemberNameByNo(board.getUserNo());
			
			request.setAttribute("member_name", member_name);
	    	request.setAttribute("board", board); 
	    	
	    	List<Comment> comment_list = new CommentService().getCommentListByBoardNo(board.getNo());
	    	request.setAttribute("comment_list", comment_list);
        	
        } catch (NumberFormatException e) {
        	
        }
        
        // Service를 통해 데이터 가져오기
        BoardService boardservice = new BoardService();
        
        try {
        	// 검색했을 때
        	String keyword = request.getParameter("keyword");
        	
        	if( !keyword.isEmpty() ) {
        		listCount = boardservice.getBoardCountByKeyword(2, keyword);
        		pageInfo = new PageInfo(page, 10, listCount, 8);
        		list = new BoardService().getBoardListByKeyword(pageInfo, 2, keyword);
        	}
        	
        } catch (NullPointerException e) {
        	// 안했을 때
        	listCount = boardservice.getBoardCount(2);
        	pageInfo = new PageInfo(page, 10, listCount, 8);
        	list = new BoardService().getBoardList(pageInfo, 2);
        }

        request.setAttribute("pageInfo", pageInfo);
        request.setAttribute("list", list);
		
		request.getRequestDispatcher("/views/community/meetingReview.jsp").forward(request, response); 

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
