<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<style>
#notice_detail table tr td:nth-child(2) {
	text-align: left;
}

#notice_detail button {
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
    
#notice_detail button:hover {
   	background-color: #668FD8;
}
</style>

<section id="notice_detail">
	<div style="border:1px solid #ddd; margin-bottom: 30px; padding-top: 30px; border-radius: 10px;">
		<div style="justify-content: center; display:flex; padding: 0 5%;">
			<table style="width: 100%; text-align: center; padding: 0 5%; border-collapse: collapse;">
				<tr>
					<td width="20%">제목</td>
					<td>${ currentBoard.title }</td>
				</tr>
			</table>
		</div>
		<div style="padding: 0 5%; padding-top: 30px;">
			<div style="min-height: 300px; border-bottom: 1px solid #ddd; padding: 10px 10px;">
				<div id="content">${ currentBoard.content }</div>
			</div>
			<div id="rb_buttons" style="justify-content: center; display: flex; padding-top:30px;">
				<c:if test="${ loginMember.role == 1 }">
					<button onclick="modifyButton()">수정하기</button>
					<button>삭제하기</button>	
				</c:if>
			</div>
		</div>
	</div>
</section>

<script>
const modifyButton = () => {
	location.href=`${ path }/customerService/noticeCreate?no=${ param.no }`;
}
</script>






