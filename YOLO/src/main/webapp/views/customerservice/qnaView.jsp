<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>
<jsp:include page="/views/common/header.jsp" />

<style>
    section>div#board-write-container{width:600px; margin:0 auto; text-align:center;}
    section>div#board-write-container h2{margin:10px 0;}
    table#tbl-board{width:500px; margin:0 auto; border:1px solid black; border-collapse:collapse; clear:both; }
    table#tbl-board th {width: 125px; border:1px solid; padding: 5px 0; text-align:center;} 
    table#tbl-board td {border:1px solid; padding: 5px 0 5px 10px; text-align:left;}
    div#comment-container button#btn-insert{width:60px;height:50px; color:white; background-color:#3300FF;position:relative;top:-20px;}
    
</style>
<section id="content">   
	<div id="board-write-container">
		<h2>로그인 시 나와야할 게시판</h2>
		<table id="tbl-board">
			<tr>
				<th>글번호</th>
				<td>${ board.no }</td>
			</tr>
			<tr>
				<th>제 목</th>
				<td>${ board.title }</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${ board.writerId }</td>
			</tr>
			<tr>
				<th>내 용</th>
				<td>${ board.content }</td>
			</tr>
			<%--글 작성자의 경우 수정삭제 가능 --%>
			<tr>
				<th colspan="2">
				<%-- <c:if test="${ not empty loginMember && loginMember.id == board.writerId }"> --%>
					
						<button type="button" onclick="location.href='${ path }/customerService/update?no=${ board.no }'">수정</button>
						<button type="button" id="btnDelete">삭제</button>
					<%-- </c:if> --%>
					
					<button type="button" onclick="location.href='${ path }/customerService/qnalist'">목록으로</button>
				</th>
			</tr>
		</table>
    </div>
</section>
<script>
// 첨부파일에서 업로드한 파일명 다르게 저장하는 방법 
	$(document).ready(() => {
		$('#btnDelete').on('click', () => {
			if (confirm('게시글을 삭제 하시겠습니까?')) {
				location.replace('${ path }/customerService/delete?no=${ board.no }');
			}
		});
	});
</script>

<jsp:include page="/views/common/footer.jsp" /> 