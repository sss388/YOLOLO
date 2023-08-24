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
import com.semi.yolo.customerService.vo.Qna_Board;
import com.semi.yolo.member.vo.Member;
import com.semi.yolo.program.model.service.ProgramService;
import com.semi.yolo.program.model.vo.Program;



@WebServlet(name = "qnaBoardUpdate", urlPatterns = { "/customerService/update" })
public class QnaBoardUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public QnaBoardUpdateServlet() {
       
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int no = Integer.parseInt(request.getParameter("no"));
        
        Qna_Board board = null;
        HttpSession session = request.getSession();
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember != null) {
            no = Integer.parseInt(request.getParameter("no"));
            board = new QnaBoardService().getBoardByNo(no);

            if (board != null && loginMember.getNo() == board.getWriterNo()) {
                request.setAttribute("board", board);
                request.getRequestDispatcher("/views/customerservice/qnaUpdate.jsp").forward(request, response);
            } else {
                request.setAttribute("msg", "잘못된 접근입니다.");
                request.setAttribute("location", "/customerService/qnalist");
                request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("msg", "로그인 후 수정해 주세요.");
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

    		Qna_Board board = new Qna_Board();
    		
    		board.setNo(Integer.parseInt(request.getParameter("no")));
    		
    		// 게시글을 작성한 작성자의 No 값 
    		board.setWriterNo(loginMember.getNo());
    		
    		// 문의유형
    		String type = request.getParameter("type");

    		if (type.equals("member_info")) {
    		    board.setType("회원정보");
    		} else if (type.equals("program_info")) {
    		    board.setType("프로그램관련");
    		} else if (type.equals("etc")) {
    		    board.setType("기타");
    		}
    		
    		// 이름
    		board.setName(request.getParameter("name"));
    		
    		// 이메일
    		board.setEmail(request.getParameter("email"));
    		
    		// 휴대폰번호
    		board.setPhone(request.getParameter("phone"));
    		
    		// 제목
    		board.setTitle(request.getParameter("title"));
    		
    		// 문의내용
    		board.setContent(request.getParameter("content"));
    		
    		
    	    // 파일을 서비스객체에 전달하고, (나중에 dao 객체를 사용해서 db에 저장)
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
	    } else {
	        request.setAttribute("msg", "로그인 후 수정해 주세요 ");
	        request.setAttribute("location", "/");
	    }

    	
	    request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}

}
	
