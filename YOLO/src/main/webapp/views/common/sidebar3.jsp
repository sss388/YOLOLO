<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<style>
	#sidebar3 {
		width: 12%;
		margin-right: 5%;
	}
	
	#sidebar3>div{
		top: 35%;
		width: 10%;
		color: white;
	  	position: fixed;
	  	display: flex;
	  	justify-content: center;
	}
	
	#sidebar3 td{
		text-align: center;
		font-size: 22px;
		padding-top: 20%;
		color: gray;
		opacity: 80%;
		text-shadow: 1px 1px white, -0.5px -0.5px black;
	}
	
	#sidebar3 td>div{
		cursor: pointer;
	}
	
	#sidebar3 .active{
		color: #AAC4FF;
	}
</style>

<section id="sidebar3">
	<div>
		<table>
			<tr>
				<td>
					<div class="faq">자주 묻는 질문</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="notice">공지사항</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="qna">문의하기</div>
				</td>
			</tr>
		</table>
	</div>
</section>

<script>
	switch(page){
	case '/YOLO/views/customerservice/FAQ.jsp':
	case '/YOLO/views/customerservice/FAQcreate.jsp':
		$('.faq').addClass("active");
		break;
	case '/YOLO/views/customerservice/notice.jsp':
	case '/YOLO/views/customerservice/noticeCreate.jsp':
		$('.notice').addClass("active");
		break;
	case '/YOLO/views/customerservice/qnaAdmin.jsp':
	case '/YOLO/views/customerservice/qna.jsp':
		$('.qna').addClass("active");
		break;
	}
	
	$('.faq').on('click', () => {
		location.assign('${ path }/customerService/faq');
	});
	
	$('.notice').on('click', () => {
		location.assign('${ path }/customerService/notice');
	});
	
	$('.common').on('click', () => {
		location.assign('${ path }/board/commonlist');
	});
	
	$('.clubMenu').on('click', () => {
		location.assign('${ path }/program/club');
	});
	
	$('.qna').on('click', () => {
		location.assign('${ path }/customerService/qna');
	});
</script>