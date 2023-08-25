<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />

<!-- 회원정보 수정  -->
<style>
     section {
          max-width: 100%;
          text-align:center;
          
     }

     section #joinform input {
          margin:7px;
     }
     
     section #joinform table {
          margin: auto;
     }
     
     section #joinform table td {
          padding:0  5px; 
          text-align:left;
     }

     .join th, .join td {
          padding: 10px;
          border-bottom: 1px solid rgb(150, 150, 150);
     }

     .join th {
          text-align: center;
          background-color: rgb(238, 241, 255);
          
     }

     /* input  */
     input {
          width: 250px;
          height: 30px;
          border: 1px solid rgb(201, 201, 201);
          border-radius: 5px;
     }    

     /* 수정하기 버튼 */
     #changePw {
          background-color: rgb(170, 196, 255); 
          color: white;  
          border: none;
          padding: 10px 30px;
          margin-top: 10px;
          margin-bottom: 100px;
          border-radius: 10px;
          box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);
     }


</style>

<section>
     <h1 align="center">비밀번호 변경하기</h1>
     <div id="joinform" style="width: 100%; justify-content: center; display: flex align-items: center;">
          <form action="${ path }/mypage/changepw" method="POST">
               <table class="join">
                    <tr>
                         <!-- 아이디는 변경 못하도록하고 아이디값만 가져오도록 함 -->
                         <th>아이디</th>
                         <td>&nbsp; ${loginMember.userId}</td>
                    </tr>
                    
                    <tr>
                         <th>현재 비밀번호</th>
                         <td>
                         	<input pattern=".{8,20}" 
       							title="8~20자 입력해주세요." 
       							type="password" name="userpw" id="userpw" placeholder="비밀번호를 입력해주세요." required>
                         </td>
                    </tr>
                    <tr>
                         <th>새로운 비밀번호</th>
                         <td>
                         	<input pattern="^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]{8,20}$" 
						       title="8~20자의 영문자와 숫자 그리고 특수문자를 포함하여 입력해주세요." 
						       type="password" name="userpw" id="userpw" placeholder="비밀번호를 입력해주세요." required>
						</td>
                    </tr>
                    <tr>
                         <th>새로운 비밀번호 확인</th>
                         <td><input type="text" name="name" id="name" required></td>
                    </tr>
               </table>
               
               <div>
                    <button type="submit" id="changePw">수정하기</button>
               </div>
     
          </form>
     </div>
</section>

<script>


</script>


<jsp:include page="/views/common/footer.jsp" />
    