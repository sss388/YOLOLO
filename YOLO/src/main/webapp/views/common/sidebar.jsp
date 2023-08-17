<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<style>
	#sidebar {
		width: 200px;
	}
	
	#sidebar>div{
		width: 100%;
		height: 100%;
		color: white;
		display: flex;
	  	align-items: center;
	  	justify-content: center;
	}
	
	#sidebar td{
		text-align: center;
		font-size: 22px;
		padding-top: 20%;
		color: gray;
		opacity: 80%;
		text-shadow: 1px 1px white, -0.5px -0.5px black;
	}
	
	#sidebar td>div{
		cursor: pointer;
	}
	
	.active{
		color: #AAC4FF;
	}
</style>

<section id="sidebar">
	<div>
		<table>
			<tr>
				<td>
					<div class="oneDayMenu">원데이</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="clubMenu">클럽</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="challengeMenu">챌린지</div>
				</td>
			</tr>
		</table>
	</div>
</section>

<script>
	switch(page){
	case '/YOLO/views/program/oneDay.jsp':
		$('.oneDayMenu').addClass("active");
		break;
	case '/YOLO/views/program/club.jsp':
		$('.clubMenu').addClass("active");
		break;
	case '/YOLO/views/program/challenge.jsp':
		$('.challengeMenu').addClass("active");
		break;
	}
	
	$('.oneDayMenu').on('click', () => {
		location.assign('${ path }/program/oneDay');
	});
	
	$('.clubMenu').on('click', () => {
		location.assign('${ path }/program/club');
	});
	
	$('.challengeMenu').on('click', () => {
		location.assign('${ path }/program/challenge');
	});
</script>