<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />

<!-- 비밀번호찾기  -->

<style>
	section {
		max-width: 100%;
        text-align:center;
    }

    table {
        margin-bottom: 10px;
    }

    .fp_table th, .fp_table tr {
        padding: 5px;
    }

    input {
        width: 150px;
        height: 25px;
        border: 1px solid rgb(201, 201, 201);
        border-radius: 5px;
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

    #fp_btn button:hover {
        background-color: #D2DAFF;
    }

    #fp_btn button:active {
        background-color: #B1B2FF;
    }
</style>

<section>
     <h1 align="center"> 비밀번호 찾기</h1>
          
     <div style="width: 100%; justify-content: center; display: flex">
          <form action="${path}/member/login_FindPw_Result" method="POST">
               
               <table class="fp_table">
                    <tr>
                         <th>아이디</th>
                         <td><input type="text" id="fp_id" name="userId" placeholder =" 아이디를 입력해주세요."></td>
                    </tr>     
                    <tr>
                         <th>이름</th>
                         <td><input type="text" id="fp_name" name="name" placeholder =" 이름을 입력해주세요."></td>
                    </tr>     
                    <tr>
                         <th>이메일</th>
                         <td><input type="email" id="fp_email" name="email" placeholder =" 이메일을 입력해주세요."></td>
                    </tr>
               </table>
                   
               <div id="fp_btn" >
                    <input type="submit" id="find_pw" value="찾기">
                    <input type="button" id="cancel" value="취소">
               </div>
     
          </form>

     </div>

</section>
<script>
	$(document).ready(() => {
	    $('#cancel').on('click', () => {
	        location.assign('${path}/member/login');
	    });
	});
	
</script>


<jsp:include page="/views/common/footer.jsp" />