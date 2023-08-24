<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>    

<jsp:include page="/views/common/header.jsp" />


<!-- 문의하기 수정하기  -->

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
      #btnqna button{
      background-color: rgb(170, 196, 255); 
      color: white;  
      border: none;
      padding: 10px 30px;
      margin-bottom: 100px;
      border-radius: 10px;
      margin-top: 20px;   
 	}
</style>

<section style="justify-content: center; display: flex;">
    	<div style="width: 100%; min-width: 800px; max-width: 1280px;
	     justify-content: center; display: flex; margin: 50px 0">
         <div style="width: 100%; text-align: center;">
         <h1 align="center" style="color: #AAC4FF; font-size: 2em; margin: 50px 0 20px 0;">문의하기</h1>
         <h3 align="center">무엇을 도와드릴까요?</h3>
         
         <div style="justify-content: center; display: flex">
    
              <form action="${ path }/customerService/update" method="post">
              <input type="hidden" name="no" value="${board.no}">
         
                   <h4>문의유형</h4>
                   <select name="type" id="type" required>
                        <option value="member_info">회원정보</option>
                        <option value="program_info">프로그램관련</option>
                        <option value="etc">기타</option>
                   </select>
         
                   <h4>이름</h4>
                   <input type="text" id="name" name="name" value="${ board.name }" required>
         
                   <h4>이메일</h4>
                   <input type="text" id="email" name="email"  value="${ board.email }" required>
         
                   <h4>휴대폰번호</h4>
                   <input type="text" id="phone" name="phone" value="${ board.phone }" required> 

                   <h4>제목</h4>
                   <input type="text" id="title" name="title" value="${ board.title }" maxlength="25"  required> 
         
                   <h4>문의내용</h4>
                   <textarea name="content" id="content" maxlength="3000" style="width: 400px; height: 150px;" required >${ board.content }</textarea>                  
                   
                   <div id="btnqna">
                    	<button type="submit"  onclick="location.href='${ path }/customerService/update?no=${ board.no }">수정하기</button>
                    	<button type="button"  onclick="location.replace('${path}/customerService/qnalist')">목록으로</button>
                   </div>
              </form>
         </div>
      </div>
</section>

<jsp:include page="/views/common/footer.jsp" />