<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />

<link rel="stylesheet" type="text/css" href="../resources/css/ckeditor.css">

<style>
#review_detail #rb_buttons button {
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
    
#review_detail #rb_buttons button:hover {
	background-color: #668FD8;
}
</style>

<section id="review_detail" style="justify-content: center; display:flex;">
	<div style="width: 90%; border: 2px solid #ddd; max-width: 800px; min-width: 1280px; margin: 100px 0; border-radius: 10px;">
		<div style="justify-content: center; display:flex; padding: 10px 5%;">
			<table style="width: 100%; text-align: center; padding: 0 10px;">
				<tr>
					<td rowspan="2" width="5%">
						<div style="justify-content: center; display:flex; padding: 5px 0; width: 50px; height: 50px; border: 2px solid #AAC4FF; overflow:hidden; border-radius: 20px;">
							<c:if test="${ not empty board.thumb }">
								<img src="${ path }/resources/upload/board/${ board.thumb }" style="width: 100%; height: 100%; object-fit: cover">
							</c:if>
							<c:if test="${ empty board.thumb }">
								<img src="${ path }/resources/images/example.png" style="width: 100%; height: 100%; object-fit: cover">
							</c:if>
						</div>
					</td>
					<td width="70%">제목</td>
					<td>작성자</td>
				</tr>
				<tr>
					<td>${ board.title }</td>
					<td>${ member_name }</td>
				</tr>
			</table>
		</div>
		<div style="padding: 0 5%; padding-bottom: 30px;">
			<div style="min-height: 300px; padding: 0 25px;">
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
	<form id="delete_review_form" method="POST" action="${ path }/community/reviewDelete" hidden>
		<input type="text" name="no" value="${ board.no }">
	</form>
</section>

<script>
let modify = false;

const handleModifyButton = () => {
	if (!modify) {
		$('#modify_button').text('수정취소');
		$('#content_editor').css('display','flow');
		$('#content').css('display','none');
		$('#modify_complete').removeAttr('hidden');
		
		editor.setData($('#content').html());
	} else {
		$('#modify_button').text('수정하기');
		$('#content_editor').css('display','none');
		$('#content').css('display','flow');
		$('#modify_complete').attr('hidden', 'true');
	} modify = !modify
}

const handleModifyComButton = () => {
	$('#modify_form').submit();
}

const handleDeleteButton = () => {
	const isConfirmed = confirm('삭제하시겠습니까?');
	if (isConfirmed) {
		$('#delete_review_form').submit();		
	}
}
</script>

<script src="../resources/js/ckeditor/script.js"></script>

<jsp:include page="/views/common/footer.jsp" />