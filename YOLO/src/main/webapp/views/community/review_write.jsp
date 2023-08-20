<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />
<link rel="stylesheet" type="text/css" href="../resources/css/ckeditor.css">

<!-- 모임만들기 글쓰기 -->

<style>
section #joinform input {
 	margin:7px;
}

.create_write {
	border-collapse: collapse;
}

.create_write tr {
	border-bottom: 1px solid rgb(150, 150, 150);
}

.create_write td {
	text-align: left;
	padding-left: 10px;	
}

.create_write th {
	text-align: center;
	background-color: rgb(238, 241, 255);
	height: 50px;
	width: 100px;        
}
     
     /*  input */
     input {
     	width: 250px;
	     height: 30px;
	     border: 1px solid rgb(201, 201, 201);
	     border-radius: 5px;
     }
     
     /* 맨밑 등록 , 취소 버튼 */
     #submit_btn input {
          background-color: rgb(170, 196, 255); 
          color: white;  
          border: none;
          width: 70px;
          height: 35px;
          text-align: center;
          font-size: medium;
          border-radius: 10px; 
          margin-bottom: 100px;
          cursor: pointer;
          transition: background-color 0.1s ease;
     }

     #btn button:hover {
          background-color: #668FD8;
     }
     .create_freeboard {
    	font-size: 20px;
    	border: none;
    	background: none;
    	cursor: pointer;
    	background-color: #AAC4FF; 
    	padding: 7.5px 0;
    	width: 100%;
    	border-radius: 10px;
    	color: #FFF;
    	margin-right: 5%;
    	transition: background-color 0.1s ease;
    	box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);
    	text-align: center;
    }
    
    .create_freeboard:hover {
    	background-color: #668FD8;
    }

</style>
     
<section style="justify-content: center; display: flex; text-align:center;">
	<div style="width: 100%; min-width: 800px; max-width: 1280px;
		justify-content: center; display: flex; margin: 50px 0">
		<div>			
			<c:if test="${ not empty board }">
				<h1>게시글 수정</h1>
			</c:if>
			<c:if test="${ empty board }">
				<h1>게시글 작성</h1>
			</c:if>
			<div id="joinform" style="width: 100%; justify-content: center; display: flex; padding-top: 30px;">
			<form action="${ path }/community/reviewwrite" method="POST" enctype="multipart/form-data">
				<c:if test="${ not empty board }">
					<input type="text" name="no" value="${ board.no }" hidden>
				</c:if>
				<table class="create_write">
		            <tr>
		                 <th>제목</th>
		                 <td><input type="text" name="title" id="groupname" value="${ board.title }"></td>
		            </tr>
		
		            <tr>
		                 <th>작성자</th>
		                 <td>
		                 	<c:if test="${ not empty board }">
		                 		<p style="font-size: 16px; color: black;" >${ board.userName }</p>
		                 	</c:if>
		                 	<c:if test="${ empty board }">
		                 		<p style="font-size: 16px; color: black;" >${ loginMember.name }</p>
		                 	</c:if>
		                 </td>
		            </tr>
					
					
		             <tr>
		                  <th>카테고리</th>
		                  <td>
                    		<select name="category" id="category" style="width:30%; font-size: 16px;">
		                          <option value="freeboard">자유 게시판</option>
		                          <c:if test="${ not empty kind }">
		                          	<option value="meetingreview" selected>모임 후기 게시판</option>
		                          </c:if>
		                          <c:if test="${ empty kind }">
		                          	<option value="meetingreview">모임 후기 게시판</option>
		                          </c:if>  
	                     	</select>
		                  </td>
		             </tr>
		                  
		              <tr>
		             		<th>상세내용</th>
		              	 	<td>
		               			<textarea name="content" id="content" class="editor">${ board.content }</textarea>
		                	</td>
		              </tr>
		
		
	             </table>
	             <div style="margin-top: 30px;">
	               	<button class="create_freeboard" id="refind">등록</button>	
	             </div>
			</form>
		</div>
		</div>
	</div>
</section>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>

	if(${param.category} == 2){
		$('#category').val('meetingreview');
	}

     function addToList(inputId, listId) {
          var inclusionText = document.getElementById(inputId).value;
          
          if (inclusionText.trim() === "") {
               return; // 입력 내용이 없을 경우 아무 작업도 하지 않음
          }

          var list = document.getElementById(listId);
          var newItem = document.createElement("li");
          newItem.appendChild(document.createTextNode(inclusionText));
          list.appendChild(newItem);

          document.getElementById(inputId).value = "";
     }
     
     // 주소검색
     function open_Postcode() {
     new daum.Postcode({
          oncomplete: function(data) {
               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

               // 각 주소의 노출 규칙에 따라 주소를 조합한다.
               // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
               var addr = ''; // 주소 변수
               var extraAddr = ''; // 참고항목 변수

               //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
               if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
               } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
               }

               // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
               if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("address2").value = extraAddr;
               
               } else {
                    document.getElementById("address2").value = '';
               }

               // 우편번호와 주소 정보를 해당 필드에 넣는다.
               document.getElementById('postcode').value = data.zonecode;
               document.getElementById("address1").value = addr;
               // 커서를 상세주소 필드로 이동한다.
               document.getElementById("address2").focus();
          }
     }).open();
}
     
</script>
     

<script src="../resources/js/ckeditor/script.js"></script>
<jsp:include page="/views/common/footer.jsp" />