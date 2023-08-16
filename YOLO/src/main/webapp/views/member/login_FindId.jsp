<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />

<!-- 아이디찾기  -->

<style>
	section {
		max-width: 100%;
        text-align:center;
    }

    table {
        margin-bottom: 10px;
    }

    .fi_table th, .fi_table tr {
        padding: 5px;
    }

    input {
        width: 150px;
        height: 25px;
        border: 1px solid rgb(201, 201, 201);
        border-radius: 5px;
    }

    #fi_btn input {
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

    #fi_btn button:hover {
        background-color: #D2DAFF;
    }

    #fi_btn button:active {
        background-color: #B1B2FF;
    }
</style>

<section>
     <h1 align="center"> 아이디 찾기</h1>
          
     <div style="width: 100%; justify-content: center; display: flex">
          <form action="${path}/member/login_FindId_Result" method="POST">
               
               <table class="fi_table">
                    <tr>
                         <th>이름</th>
                         <td><input type="text" id="fi_name" name="name" placeholder =" 이름을 입력해주세요."></td>
                    </tr>     
                    <tr>
                         <th>이메일</th>
                         <td><input type="email" id="fi_email" name="email" placeholder =" 이메일을 입력해주세요."></td>
                    </tr>
               </table>
                   
               <div id="fi_btn" >
                    <input type="submit" id="find_id" value="찾기">
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