package com.semi.yolo.program.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.List;

import com.semi.yolo.common.util.PageInfo;
import com.semi.yolo.community.model.service.BoardService;
import com.semi.yolo.member.service.MemberService;
import com.semi.yolo.member.vo.Member;
import com.semi.yolo.program.model.service.EntryMemberService;
import com.semi.yolo.program.model.service.ProgramService;
import com.semi.yolo.program.model.vo.EntryMember;
import com.semi.yolo.program.model.vo.Program;

@WebServlet(name = "oneDay", urlPatterns = { "/program/oneDay" })
public class oneDayServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public oneDayServlet() {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = 1; // 기본 페이지 번호를 1로 설정
        int listCount = 0;
        PageInfo pageInfo = null;
        List<Program> list = null;

        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
            // 페이지 번호가 파라미터로 전달되지 않은 경우 처리
        }
        
        try {
        	int no = Integer.parseInt(request.getParameter("no"));
        	int entry_state = 0;
        	
        	Program program = new ProgramService().getProgramByNo(no);
        	request.setAttribute("program", program);
        	
        	Member member = new MemberService().getMemberProfileByNo(program.getUserno());
        	request.setAttribute("member", member);
        	
        	List<EntryMember> entryMemberList = new EntryMemberService().getMembersByProgramNo(no);
        	
        	request.setAttribute("entryMemberList", entryMemberList);
        	
        	HttpSession session = request.getSession();
    		Member loginMember = (Member) session.getAttribute("loginMember");
    		
    		if(loginMember != null) {
    			for (EntryMember entryMember : entryMemberList) {
    				if (entryMember.getUserNo() == loginMember.getNo()) {
    					entry_state = 1;
    				}
    			}
    			request.setAttribute("entry_state", entry_state);
    		}
        	
        } catch (NumberFormatException e) {
        	
        }
        
        ProgramService programService = new ProgramService();
        
        try {
        	// 검색했을 때
        	String keyword = request.getParameter("keyword");
        	
        	if( !keyword.isEmpty() ) {
        		listCount = programService.getProgramCountByKeyword(keyword, "oneday");
        		pageInfo = new PageInfo(page, 10, listCount, 8);
        		list = new ProgramService().getBoardList(pageInfo, "oneday");
        	}
        	
		} catch (NullPointerException e) {
			listCount = programService.getOneDayCount();
			pageInfo = new PageInfo(page, 10, listCount, 8);
			list = new ProgramService().getBoardList(pageInfo, "oneday");
		}

        request.setAttribute("pageInfo", pageInfo);
        request.setAttribute("list", list);
        request.getRequestDispatcher("/views/program/oneDay.jsp").forward(request, response);
    }

}