package com.semi.yolo.program_create.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.semi.yolo.common.util.FileRename;
import com.semi.yolo.member.vo.Member;
import com.semi.yolo.program.model.service.ProgramService;
import com.semi.yolo.program.model.vo.Program;

@WebServlet(name = "programUpdate", urlPatterns = { "/program/update" })
public class ProgramUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ProgramUpdateServlet() {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int no = Integer.parseInt(request.getParameter("no"));
        
        Program program = null;
        HttpSession session = request.getSession();
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember != null) {
            no = Integer.parseInt(request.getParameter("no"));
            program = new ProgramService().getProgramByNo(no);

            if (program != null && loginMember.getNo() == program.getUserno()) {
                request.setAttribute("program", program);
                request.getRequestDispatcher("/views/program_create/update.jsp").forward(request, response);
            } else {
                request.setAttribute("msg", "잘못된 접근입니다.");
                request.setAttribute("location", "/program/oneDay");
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
		HttpSession session = request.getSession();
	    Member loginMember = (Member) session.getAttribute("loginMember");
	    //int no = Integer.parseInt(request.getParameter("no"));
	    

	    if (loginMember != null) {         
	    	// 파일이 저장될 경로
	        String mainFileUploadPath = getServletContext().getRealPath("/resources/upload/main_file");

            // 파일의 최대 사이즈 지정 (10MB)
            int maxSize = 10485760;

            // 파일 인코딩 설정
            String encoding = "UTF-8";

            MultipartRequest mr = new MultipartRequest(request, mainFileUploadPath, maxSize, encoding, new FileRename());

            Program program = new Program();

            program.setUserno(loginMember.getNo());
            program.setTitle(mr.getParameter("title"));
            program.setNo(Integer.parseInt(mr.getParameter("no")));
            
            // 썸네일
            String mainFileName = mr.getFilesystemName("main_file");
            program.setThumb(mainFileName);
            
            //카테고리
            String category = mr.getParameter("category"); 
            program.setCategory(category);
	            
	        // 모임시작일, 모임종료일
            String startDateStr = mr.getParameter("start_date");
            String endDateStr = mr.getParameter("end_date");

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");

            try {
                if (!startDateStr.isEmpty() && !endDateStr.isEmpty()) {
                    Date startDate = dateFormat.parse(startDateStr);
                    Date endDate = dateFormat.parse(endDateStr);

                    program.setStartDate(startDate);
                    program.setExpireDate(endDate);
                }
            // 상세설명	    
	        program.setContent(mr.getParameter("content")); 
	        
	        // 장소
	        program.setAddress(mr.getParameter("address"));
	        
	        // 위도와 경도
	        double latitude = Double.parseDouble(mr.getParameter("latitude"));
	        double longitude = Double.parseDouble(mr.getParameter("longitude"));

	        program.setLatitude(latitude);
	        program.setLongitude(longitude);
	        
	        
	        // 작성자 이름 설정
	        program.setWritename(mr.getParameter("writename"));
	        
	        // 포함사항, 불포함사항, 준비물
	        program.setInclusion(mr.getParameter("inclusion"));
	        program.setNoninclusion(mr.getParameter("noninclusion"));
	        program.setSupplies(mr.getParameter("supplies"));
	            	            
            int result = new ProgramService().save(program);

            if (result > 0) {
                // 게시글 수정 성공
                request.setAttribute("msg", "게시글 수정 성공");
                request.setAttribute("location", "/program_create/detailedpage?no=" + program.getNo());
            } else {
                // 게시글 수정 실패
                request.setAttribute("msg", "게시글 수정 실패");
                request.setAttribute("location", "/program/update?no=" + program.getNo());
            }
        } catch (ParseException e) {
            e.printStackTrace();
            request.setAttribute("msg", "날짜 형식 오류");
            request.setAttribute("location", "/program/update?no=" + program.getNo());
        }
    } else {
        request.setAttribute("msg", "잘못된 접근입니다.");
        request.setAttribute("location", "/program/oneDay");
    }

        request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
    }

}