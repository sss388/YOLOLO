<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>    

<jsp:include page="/views/common/header.jsp" />

 <%-- 사진 넣기 위해서 사용 --%>
 <link rel="stylesheet" type="text/css" href="../resources/css/ckeditor.css"> 

<%-- class : . , id : # --%>
<style>
  
	div#qna-write
	{
		width:100%;
		margin:0 auto;
		text-align:center;
		margin-bottom: 10px;
	}
	
	/*글쓰기 버튼*/
	input[type="submit"] {
	 background-color: #AAC4FF;
	 font-size: 16px;
	 color: white;
	 width: 130px;
	 height: 35px;
	 border-radius: 5px;
	 outline: none;
	 border: white;
	 margin-top: 30px;
	 margin-bottom: 30px;
	 border-radius: 10px; 
	}

    h1 {
    	color : #AAC4FF;
    	text-align: center;
    	font-size: 2.5em;
    }
    
    h4 {
    	font-size: 1em;
    }
    
     div#side-bar {
    	margin-left: 130px;
    	margin-bottom: 150px;
    	width:400px;
    	float:left;
    }
    
    
    /* 글쓰기 */
      div#text-bar {
    	margin-bottom: 350px;
    	margin-right: 80px;
    	box-sizing: border-box;
    }
   
  
    /* 개인정보 */
    div#info-bar {
    	margin-bottom: 110px;
    	margin-right:260px;
        box-sizing: border-box;
    }
    
     input#text {
    	height: 10px;
    }
    
    
    
        
</style>

<section>
<h1><i class="fi fi-rr-edit"></i>문의하기</h1>
<div id="qna-write" >

<%-- 스타일 시트 넣으면 enctype="multipart/form-data 삭제해야함--%>
 <form action="${path}/customerService/qnaWrite" method="post">
 <input type="hidden" name="no" value="${ board.title }">
  
  <table style="width: 100%; justify-content: center; display: flex">	
  	 <tr>
  	 	<td>${ board.title }</td>
  	 </tr>
	 <tr>
	    <td>
	 	    <div id="side-bar"><jsp:include page="/views/common/sidebar3.jsp" /></div>
	 	</td>
		<td>
     		<div id="text-bar" style="width:350px; height:200px; float:left;">
                  <input type=text size=25 name="userName" id="userName" value="${ loginMember.name }" placeholder="Name" required>
                  <br><input type=text size=25 name="userEmail" id="userEmail" value="${ loginMember.email }"placeholder="Email" required>
                  <p><input type=text size=42 name="title" id="title" placeholder="문의제목" required></p> 
                  <p><textarea cols=35 rows=15 name="content" class="editor" placeholder="내용을 입력하세요."></textarea></p>
                  <%-- <p><input type="file" name="qnafile" placeholder="첨부파일">   --%>
                      <%-- 
                       <c:if test="${ not empty board.originalFilename }">
                         <span>${ board.originalFilename }</span>
                      </c:if>
                       --%>        
            </div>
        </td>
        <td>
		    <div id="info-bar" style="width:300px; height:450px; float:left;">
 			<h4>개인정보 수집 및 이용동의</h4> 
 			<br><br>
 			     <textarea class=qna cols=35 rows=22 name=copy placeholder="내용을 입력하세요." style="overflow:auto">
 				   이용자는 회원가입을 하지 않아도 정보 검색, 뉴스 보기 등 대부분의 회원과 동일하게 이용할 수 있습니다. 이용자가 메일, 캘린더, 카페, 블로그 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.
				   회원가입 시점에 욜로가 이용자로부터 수집하는 개인정보는 아래와 같습니다.
				   회원 가입 시 필수항목으로 아이디, 비밀번호, 이름, 생년월일, 성별, 휴대전화번호를, 선택항목으로 본인확인 이메일주소를 수집합니다. 실명 인증된 아이디로 가입 시, 암호화된 동일인 식별정보(CI), 중복가입 확인정보(DI), 내외국인 정보를 함께 수집합니다. 만14세 미만 아동의 경우,  법정대리인 정보(법정대리인의 이름, 생년월일, 성별, 중복가입확인정보(DI), 휴대전화번호)를 추가로 수집합니다.
				   비밀번호 없이 회원 가입 시에는 필수항목으로 아이디, 이름, 생년월일, 휴대전화번호를, 선택항목으로 비밀번호를 수집합니다.
				   단체 회원가입 시 필수 항목으로 단체아이디, 비밀번호, 단체이름, 이메일주소, 휴대전화번호를, 선택항목으로 단체 대표자명을 수집합니다.
				   서비스 이용 과정에서 이용자로부터 수집하는 개인정보는 아래와 같습니다.
				   회원정보 또는 개별 서비스에서 프로필 정보(별명, 프로필 사진)를 설정할 수 있습니다. 회원정보에 별명을 입력하지 않은 경우에는 마스킹 처리된 아이디가 별명으로 자동 입력됩니다.
				   욜로 내의 개별 서비스 이용, 이벤트 응모 및 경품 신청 과정에서 해당 서비스의 이용자에 한해 추가 개인정보 수집이 발생할 수 있습니다. 추가로 개인정보를 수집할 경우에는 해당 개인정보 수집 시점에서 이용자에게 ‘수집하는 개인정보 항목, 개인정보의 수집 및 이용목적, 개인정보의 보관기간’에 대해 안내 드리고 동의를 받습니다.
				   
				 </textarea>
     			 <br>
     			 
     			 <input type="checkbox" name="information" value="info">개인정보 수집 및 이용에 동의합니다.
     		</div>
     	 </td>
	   </tr>
	   <tr>	         
     	   <td colspan = "3"><input type="submit" value="글쓰기"></td>
	   </tr>
    </table>
  </form>
 </div>
</section>
 
 <%-- 사진 넣기 위해서 사용 --%>
<script src="../resources/js/ckeditor/script.js"></script>
<jsp:include page="/views/common/footer.jsp" />