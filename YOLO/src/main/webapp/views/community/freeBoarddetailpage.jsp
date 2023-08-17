<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>
<jsp:include page="/views/common/header.jsp" />

<!-- 자유게시판 상세페이지  -->

<style>
#freeboard_detail #rb_buttons button {
	font-size: 20px;
	border: none;
	background: none;
	cursor: pointer;
	background-color: #AAC4FF; 
	padding: 7.5px 15px;
	border-radius: 10px;
	color: #FFF;
	margin-right: 5%;
	transition: background-color 0.1s ease;
}
    
#freeboard_detail #rb_buttons button:hover {
	background-color: #668FD8;
}

#freeboard_detail td {
	border-bottom: 1px solid #ddd;
	padding: 10px 0;
}

#freeboard_detail tr td:nth-child(2) {
	text-align: left;
}
</style>

<section id="freeboard_detail" style="justify-content: center; display:flex;">   
	<div style="width: 90%; max-width: 800px; min-width: 1280px; margin: 100px 0; border-radius: 10px;">
		<div style="justify-content: center; display:flex; padding: 0 5%;">
			<table style="width: 100%; text-align: center; padding: 0 5%; border-collapse: collapse;">
				<tr>
					<td width="20%">제목</td>
					<td>${ board.title }</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td>${ member_name }</td>
				</tr>
			</table>
		</div>
		<div style="padding: 0 10%; padding: 30px 5%;">
			<div style="min-height: 300px; border-bottom: 1px solid #ddd; padding: 30px 5%">
				<div id="content">${ board.content }</div>
				<div id="content_editor" style="display: none">
					<form id="modify_form" method="POST" action="">
						<input name="no" type="text" value="${ board.no }" hidden>
						<textarea name="content" class="editor"></textarea>
					</form>
				</div>
			</div>
			<div id="rb_buttons" style="margin-top:50px; justify-content: center; display: flex">
				<c:if test="${ ( loginMember.no == board.userNo ) || loginMember.role == 1 }">
					<button id="modify_complete" onclick="handleModifyComButton()" hidden>수정확인</button>
					<button id="modify_button" onclick="handleModifyButton()">수정하기</button>
					<button onclick="handleDeleteButton()" >삭제하기</button>	
				</c:if>
				<button onclick="window.history.back();">뒤로가기</button>
			</div>
		</div>
	</div>
</section>

<jsp:include page="/views/common/footer.jsp" />