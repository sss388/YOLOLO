<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>    

<jsp:include page="/views/common/header.jsp" />

<style>
      /* input 전체 */
      input, #type {
           width: 400px;
           height: 30px;
           border: 1px solid rgb(201, 201, 201);
           border-radius: 5px;
      }
      
      h4 {
      	margin-bottom: 5px; 
      }
      
      table {
      border-spacing: 0;
      }
      
      
      #table td{
           border: 1px solid black;
           box-sizing: border-box;
           border-spacing: 0;
           padding: 10px;
      }

      /* 회원가입 버튼 */
      #btnqna button {
      background-color: rgb(170, 196, 255); 
      color: white;  
      border: none;
      padding: 10px 30px;
      margin-bottom: 100px;
      border-radius: 10px;
      margin-top: 10px;   
 	}
</style>

 <section style="justify-content: center; display: flex;">
     	<div style="width: 100%; min-width: 800px; max-width: 1280px;
		     justify-content: center; display: flex; margin: 50px 0">
          <jsp:include page="/views/common/sidebar3.jsp" /> 
          <div style="width: 100%; text-align: center;">
          <h1 align="center" style="color: #AAC4FF; font-size: 2em; margin: 50px 0 20px 0;">문의하기</h1>
          <h3 align="center">무엇을 도와드릴까요?</h3>
          
          <div style="justify-content: center; display: flex">
     
               <form action="${path}/customerService/qnaWrite" method="post">
          
                    <h4>문의유형</h4>
                    <select name="type" id="type" required>
                         <option value="member_info">회원정보</option>
                         <option value="program_info">프로그램관련</option>
                         <option value="etc">기타</option>
                    </select>
          
                    <h4>이름</h4>
                    <input type="text" id="name" name="name" value="${ loginMember.name }" required>
          
                    <h4>이메일</h4>
                    <input type="text" id="email" name="email"  value="${ loginMember.email }" required>
          
                    <h4>휴대폰번호</h4>
                    <input type="text" id="phone" name="phone" value="${ loginMember.phone }" required> 

                    <h4>제목</h4>
                    <input type="text" id="title" name="title" maxlength="25" required> 
          
                    <h4>문의내용</h4>
                    <textarea name="contect" id="contect" maxlength="3000" style="width: 400px; height: 150px;" required ></textarea>
                    
                    <h4>개인 정보 수집 및 이용 동의서</h4>
                    
                    <p>
                    	개인 정보 수집 및 이용동의 <br>
                        귀하는 필수항목의 수집 이용에 대한 동의를 거부하실 수 있으나, 동의를 거부하는 경우 문의하기 서비스를 이용하실 수 없습니다.
                    </p>
          			
                    
                    <table>
                         <tr id="table">
                              <td>수집 목적</td>
                              <td>수집 항목</td>
                              <td>보유 기간</td>
                         </tr>
     
                         <tr id="table">
                              <td>문의자 확인 및 처리사항 전달</td>
                              <td>문의 유형, 성명, 이메일, 연락처, 내용</td>
                              <td>수집 후 1년</td>
                         </tr>
                    </table>

          			<div style="display: flex; align-items: center; margin-top: -15px">
	                    <input type="checkbox" id="checkbox" style="width: 10px; height: 10px" required>
	                    <h5>위 개인정보 수집 및 이용에 동의합니다 (비동의 시, 제출이 불가합니다) </h5> 
          			</div>	
                    
                    <div id="btnqna">
                         <button type="submit" id="btnqna">제출하기</button>
                    </div>
               </form>
          </div>
       </div>
     </section>

<jsp:include page="/views/common/footer.jsp" />
