package com.semi.yolo.member.mypage.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.sql.Blob;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.rowset.serial.SerialBlob;

import com.semi.yolo.member.service.MemberService;
import com.semi.yolo.member.vo.Member;

@WebServlet(name = "myInfoupdate", urlPatterns = { "/myInfo/update" })
public class MyInfoUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MyInfoUpdateServlet() {

    }
	
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	
		//1. 로그인 된 사용자인지 체크
    	Member member = null;
    	HttpSession session = request.getSession();
    	Member loginMember = (Member)session.getAttribute("loginMember");
    	
    	if(loginMember != null) {
    		// 2. 사용자가 수정한 내용을 가지고 Member 객체를 생성
    		member = new Member();
        	
    		member.setNo(loginMember.getNo());  // 수정 못하도록 
        	member.setUserId(loginMember.getUserId());  // 수정 못하도록
        	member.setName(request.getParameter("name"));
        	
        	// 주소 정보 처리
    		String postcode = request.getParameter("postcode");
    		String address1 = request.getParameter("address1");
    		String address2 = request.getParameter("address2");
    		
    		member.setPostcode(postcode);
    		member.setAddress1(address1);
    		member.setAddress2(address2);
    		
    		
    		member.setPhone(request.getParameter("phone"));
        	member.setEmail(request.getParameter("email"));
        	member.setProfileImg(request.getParameter("profile_img_blob"));
        	
//        	String profileImgString = request.getParameter("profile_img_blob");
//        	ByteArrayInputStream inputStream = new ByteArrayInputStream(profileImgString.getBytes("UTF-8"));
//        	Blob profileImgBlob;
//        	
//			try {
//				profileImgBlob = new SerialBlob(inputStream.readAllBytes());
//				member.setProfileImg(profileImgBlob);
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}
        	
//        	System.out.println(member); // 확인

        	// 회원 정보를 수정
        	int result = new MemberService().save(member);
        	
        	if(result > 0) {
        		// 정보 수정 성공
        		// 세션을 갱신한다.
        		session.setAttribute("loginMember", new MemberService().findMemberById(loginMember.getUserId()));
        		request.setAttribute("msg", "회원 정보 수정 완료");
        		request.setAttribute("location", "/mypage/mypage_myInfo");
        		
        	} else {
        		// 정보 수정 실패
        		request.setAttribute("msg", "회원 정보 수정 실패");
        		request.setAttribute("location", "/mypage/mypage_myInfo");
        	}
    		
    	} else {
    		request.setAttribute("msg", "로그인 후 수정해 주세요");
    		request.setAttribute("location", "/");    		
    	}
    	request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	
	}

}
