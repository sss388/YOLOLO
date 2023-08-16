package com.semi.yolo.program_create.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.semi.yolo.member.vo.Member;
import com.semi.yolo.program.model.service.ProgramService;
import com.semi.yolo.program.model.vo.Program;

@WebServlet(name = "programDelete", urlPatterns = { "/program/delete" })
public class ProgramDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ProgramDeleteServlet() {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 로그인 체크 & 본인 게시글 여부 확인
        int no = Integer.parseInt(request.getParameter("no"));
        HttpSession session = request.getSession();
        Member loginMember = (Member) session.getAttribute("loginMember");
        Program program = new ProgramService().getProgramByNo(no);

        if (program != null && loginMember != null) {
            if (program.getUserno() == loginMember.getNo()) {
                int result = new ProgramService().delete(no);
                if (result > 0) {
                    // 삭제 성공
                    request.setAttribute("msg", "게시글 삭제 성공");
                    request.setAttribute("location", "/program/oneDay");
                } else {
                    // 삭제 실패
                    request.setAttribute("msg", "게시글 삭제 실패");
                    request.setAttribute("location", "/program_create/detailedpage?no=" + no);
                }
            } else {
                request.setAttribute("msg", "잘못된 접근입니다.");
                request.setAttribute("location", "/program/oneDay");
            }
        } else {
            // 게시글 없음 처리
        }

        request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
    }
}