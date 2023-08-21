<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<!-- 자유게시판 상세페이지  -->

<style>
#freeboard_detail {
	text-align: left;
}

#freeboard_detail table tr td:first-child {
	text-align: center;
}
</style>

<section id="freeboard_detail">   
	<div style="border:1px solid #ddd; margin-bottom: 30px; padding-top: 30px; border-radius: 10px;">
		<div style="justify-content: center; display:flex; padding: 0 5%;">
			<table style="width: 100%; text-align: left; padding: 0 5%; border-collapse: collapse;">
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
		<div style="padding: 0 5%; padding: 30px 5%;">
			<div style="border-bottom: 1px solid #ddd; padding: 15px 5%;">
				<div style="min-height: 300px;">
					<div id="content">${ board.content }</div>
				</div>
				
				<c:if test="${ not empty loginMember && ((loginMember.no == item.userNo) || (loginMember.role == 1)) }">
					<div style="justify-content: flex-end; display: flex;">
						<button onclick="modifyBoardButton(${board.no})">수정하기</button>
						<button>삭제하기</button>
					</div>
				</c:if>
			</div>
			<jsp:include page="/views/community/comment.jsp" />
		</div>
	</div>
	<form id="modify_board_form" method="POST" action="${ path }/community/modifyBoard" hidden>
		<input type="text" value="${ board.no }" name="board_no">
	</form>
</section>

<script>
const modifyBoardButton = (no) => {
	$('#modify_board_form').submit();
}
</script>