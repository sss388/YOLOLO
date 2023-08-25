<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />

<!-- 로그인  -->
<style>
	  #login {
	       text-align: center;
	  }
     #login input {
          width: 250px;
          height: 30px;
          border: 1px solid rgb(201, 201, 201);
          border-radius: 10px;
          margin: 5px;
          font-size: 16px;
          padding: 2px 7px;
     }

     #login button {
          width: 255px;
          height: 40px;
          background-color: rgb(170, 196, 255); 
          color: white;  
          border: none;
          margin: 5px;
          margin-top: 10px;
          font-size: 16px;
          border-radius: 10px;
          cursor: pointer;
          text-align: center;
     }
     
     #login button:hover {
     	background-color: #D2DAFF;
     }
     
     #login button:active {
     	background-color: #B1B2FF;
     }
     
     #findinfo {
   		margin-bottom: 100px;
     }
     
     #findinfo a {
   		margin-bottom: 100px;
    	cursor: pointer;	
     }
     
     #login input[type="checkbox"] {
     		width: 16px;
     		height: 16px;
     }
     
     #saveId{
     	cursor: pointer;
     }

</style>
<section>
    <div style="width: 100%; justify-content: center; display: flex">
     <form action="${ path }/member/login" method="POST">
          <h1 align="center">로그인</h1>

          <!-- 아이디, 비밀번호, 로그인버튼 -->
          <div id="login">
               <input pattern="^[a-zA-Z0-9]{4,16}$" title="4~16자의 영문 대소문자와 숫자로만 입력해주세요." 
               		type="text" name="userId" placeholder="아이디" value="${ savedId }" required> <br>
               <input pattern=".{8,20}" 
			       title="8~20자 입력해주세요." 
			       type="password" name="userPw" id="userpw" placeholder="비밀번호를 입력해주세요." required>
          </div>
               
          <div style="font-size: 12px; display: flex; align-items: center; margin-left: 5px;">
               <input type="checkbox" id="saveId" name="saveId" ${empty cookie.saveId ? "" : "checked" } style="position: relative;"/>
               <label for="saveId">ID 저장</label>
          </div>
               
          <div id="login">
               <button type="submit">로그인</button>
          </div>


          <!-- 아이디찾기, 비밀번호찾기, 회원가입 -->
          <div id="findinfo" style="font-size: 12px; color: rgb(71, 70, 70);"  align="center">
                   <a id="fi_ID">아이디 찾기 </a>|
                   <a id="fi_PW">비밀번호 찾기 </a>|
                   <a id="CAccount">회원가입 </a>
              </div>
         </form>
    </div>
</section>

<script>
$(document).ready(() => {
	$('#fi_ID').on('click', () => {
		location.assign('${ path }/member/login_FindId');
	});
	
	$('#fi_PW').on('click', () => {
		location.assign('${ path }/member/login_FindPw');
	});
	
	$('#CAccount').on('click', () => {
		location.assign('${ path }/member/createAccount');
	});
});
</script>

<jsp:include page="/views/common/footer.jsp" />