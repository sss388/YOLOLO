<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />

<link rel="stylesheet" type="text/css" href="../resources/css/ckeditor.css">

<style>
#create_notice_form {
	margin: 0 5%;
	padding: 20px 0;
}

#create_notice_form #create_button {
	width: 100%;
	border-radius: 10px; 
	background-color: #AAC4FF; 
	text-align: center; 
	padding: 10px 0; 
	margin-top: 20px;
	cursor: pointer;
}

#create_notice_form #create_button:hover {
	background-color: #668FD8;
}
</style>

<section style="justify-content: center; display: flex;">
<div style="width: 100%; min-width: 800px; max-width: 1280px;
	justify-content: center; display: flex; margin: 50px 0">
	<jsp:include page="/views/common/sidebar3.jsp" /> 
	<div style="border: 2px solid gray; border-radius: 10px; width: 90%; margin-top: 50px; padding: 25px 0;">
		<form id="create_notice_form" method="POST" action="">
			<div style="text-align: center; justify-content: center; display: flex">
				<table style="border-collapse: collapse;">
					<input type="text" name="no" value="${ param.no }" hidden/>
					<tr>
						<td width="10%">
							제목
						</td>
						<td>
							<input type="text" name="title" style="width: 100%" value="${ board.title }"/>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="centered" style="padding: 10px 0;">
								<textarea class="editor" name="content">${ board.content }</textarea>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<button id="create_button">
								글쓰기
							</button>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
</div>
</section>

<script src="../resources/js/ckeditor/script.js"></script>
<jsp:include page="/views/common/footer.jsp" />