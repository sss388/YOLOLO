<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<style>
	#sidebar2 {
		width: 12%;
		margin-right: 5%;
	}
	
	#sidebar2>div{
		top: 35%;
		width: 10%;
		color: white;
	  	position: fixed;
	  	display: flex;
	  	justify-content: center;
	}
	
	#sidebar2 td{
		text-align: center;
		font-size: 22px;
		padding-top: 20%;
		color: gray;
		opacity: 80%;
		text-shadow: 1px 1px white, -0.5px -0.5px black;
	}
	
	#sidebar2 td>div{
		cursor: pointer;
	}
	
	#sidebar2 .active{
		color: #AAC4FF;
	}
</style>

<section id="sidebar2">
	<div>
		<table>
			<tr>
				<td>
					<div class="freeBoard">자유 게시판</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="meetingReview">모임 후기</div>
				</td>
			</tr>

		</table>
	</div>
</section>

<script>
	switch(page){
	case '/YOLO/views/community/freeBoard.jsp':
		$('.freeBoard').addClass("active");
		break;
	case '/YOLO/views/community/meetingReview.jsp':
		$('.meetingReview').addClass("active");
		break;
	}
	
	$('.freeBoard').on('click', () => {
		location.assign('${ path }/community/freeBoard');
	});
	
	$('.meetingReview').on('click', () => {
		location.assign('${ path }/community/meetingReview');
	});
	
</script>