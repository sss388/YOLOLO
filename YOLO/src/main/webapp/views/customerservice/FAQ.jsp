<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />

<style>
.que:first-child{
    border-top: 1px solid black;
}
  
.que{
  position: relative;
  padding: 17px 0;
  cursor: pointer;
  font-size: 14px;
  border-bottom: 1px solid #dddddd;
}

  
.que::before{
  display: inline-block;
  content: 'Q';
  font-size: 14px;
  color: #AAC4FF;
  margin: 0 5px;
}

.que.on>span{
  color: skyblue;
}
  
.anw {
  display: none;
  overflow: hidden;
  font-size: 14px;
  background-color: #f4f4f2;
  padding: 27px 0;
}
  
.anw::before {
  display: inline-block;
  content: 'A';
  font-size: 14px;
  font-weight: bold;
  color: #AAC4FF;
  margin: 0 5px;
}

.arrow-wrap {
  position: absolute;
  top:50%; right: 10px;
  transform: translate(0, -50%);
}

.que .arrow-top {
  display: none;
}
.que .arrow-bottom {
  display: block;
}
.que.on .arrow-bottom {
  display: none;
}
.que.on .arrow-top {
  display: block; 
}
.create_button {
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
   	position: absolute;
   	right:0;
   	margin-top: 30px;
}

.create_button:hover {
  	background-color: #668FD8;
}
</style>

<section style="justify-content: center; display: flex;">
	<div style="width: 100%; min-width: 800px; max-width: 1280px;
		justify-content: center; display: flex; margin: 50px 0">
		<jsp:include page="/views/common/sidebar3.jsp" /> 
		<div style="width: 100%; text-align: center;">
			 <h3 style="color: #AAC4FF; font-size: 2em; margin: 50px 0;">
            	<i class="fa-regular fa-circle-question fa-spin"></i>&nbsp;자주 묻는 질문
           	</h3> 
			<div id="Accordion_wrap">
				<div class="que">
					<span>This is first question.</span>
				</div>
				<div class="anw">
				 	<span>This is first answer.</span>
				</div>
				<div class="que">
				 	<span>This is second question.</span>
				</div>
				<div class="anw">
				 	<span>This is second answer.</span>
				</div>
				 	<div class="que">
				 <span>This is third question.</span>
				</div>
				<div class="anw">
				 	<span>This is third answer.</span>
				</div>
			</div>
			
			<div style="position: relative; margin-bottom: 100px;">
				<button class="create_button">글쓰기</button>
			</div>
		</div>
	</div>
</section>

<script>
$(".que").click(function() {
	$(this).next(".anw").stop().slideToggle(300);
	$(this).toggleClass('on').siblings().removeClass('on');
	$(this).next(".anw").siblings(".anw").slideUp(300); // 1개씩 펼치기
});
</script>

<jsp:include page="/views/common/footer.jsp" />