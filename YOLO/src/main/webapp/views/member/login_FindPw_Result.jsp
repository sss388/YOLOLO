<%@page import="com.semi.yolo.member.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />

<!-- 비밀번호 찾은 정보  -->

<style>
    section {
         max-width: 100%;
         text-align:center;
    }

    #fp_btn input {
         background-color: rgb(170, 196, 255); 
         color: white;  
         border: none;
         width: 70px;
         height: 30px;
         font-size: 15px;
         text-align: center;
         margin-bottom: 100px;
         border-radius: 10px;
    }

    #fp_btn2 input {
         background-color: rgb(170, 196, 255); 
         color: white;  
         border: none;
         width: 75px;
         height: 30px;
         font-size: 15px;
         text-align: center;
         margin-bottom: 100px;
         border-radius: 10px;
    }

    #fp_btn button:hover {
         background-color: #D2DAFF;
    }

    #fp_btn button:active {
         background-color: #B1B2FF;
    }
</style>

<section>
	 <h2>비밀번호 찾기 결과</h2>
	 
     <div style="width: 100%; justify-content: center; display: flex">
     
     <form action="${path}/member/login_FindPw_Result" method="POST">
     
	     <c:choose>
	     <c:when test="${not empty member}">
        	 <div class = "found-success">
        	 	<div>
                  <h4>회원님의 비밀번호는 ${member.userPw} 입니다 </h4>  
                </div>
             
	             <div id="fp_btn">
	             	<input type="button" id="backlogin" value="로그인">         	
	             </div>
             
             </div>
          </c:when>
          <c:otherwise>
              <div class="found-fail">
                <div>
                  <h4>등록된 정보가 없습니다</h4>  
                </div>

                <div id="fp_btn2">
                  <input type="button" id="refind" value="다시찾기">
                  <input type="button" id="createAccount" value="회원가입">
                </div>
              </div>
          </c:otherwise>
          </c:choose>
     </form>
     </div>
</section>

<script>
	$(document).ready(() => {	
		$('#refind').on('click', () => {
			location.assign('${ path }/member/login_FindPw');
		});
		
		$('#createAccount').on('click', () => {
			location.assign('${ path }/member/createAccount');
		});
		
		$('#backlogin').on('click', () => {
			location.assign('${ path }/member/login');
		});
	
	});
	

</script>
<jsp:include page="/views/common/footer.jsp" />