<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<div border-radius: 10px;">
	<div style="justify-content: center; display:flex; padding: 0 5%;">
		<table style="width: 100%; text-align: center; padding: 0 5%; border-collapse: collapse;">
			<tr>
				<td width="20%">제목</td>
				<td>${ currentBoard.title }</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>${ member_name }</td>
			</tr>
		</table>
	</div>
	<div style="padding: 0 10%; padding: 30px 5%;">
		<div style="min-height: 300px; border-bottom: 1px solid #ddd; padding: 30px 5%">
			<div id="content">${ currentBoard.content }</div>
			<div id="content_editor" style="display: none">
				<form id="modify_form" method="POST" action="">
					<input name="no" type="text" value="${ currentBoard.no }" hidden>
					<textarea name="content" class="editor"></textarea>
				</form>
			</div>
		</div>
		<div id="rb_buttons" style="margin-top:50px; justify-content: center; display: flex">
			<c:if test="${ ( loginMember.no == board.userNo ) || loginMember.role == 1 }">
				<button>수정하기</button>
				<button>삭제하기</button>	
			</c:if>
			<button onclick="window.history.back();">뒤로가기</button>
		</div>
	</div>
</div>