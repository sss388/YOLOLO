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
  padding: 20px 0;
  cursor: pointer;
  font-size: 16px;
  border-bottom: 1px solid #dddddd;
}

  
.que::before{
  display: inline-block;
  content: 'Q';
  font-size: 16px;
  color: #AAC4FF;
  margin: 0 5px;
}

.que.on>span{
  color: #B1B2FF;
}
  
.anw {
  display: none;
  overflow: hidden;
  font-size: 16px;
  background-color: #EEF1FF;
  padding: 27px 0;
}
  
.anw::before {
  display: inline-block;
  content: 'A';
  font-size: 16px;
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
   	box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);
}

.create_button:hover {
  	background-color: #668FD8;
}

.pagenation {
  	font-size: 20px;
  	border: none;
  	background: none;
  	color: gray;
	opacity: 60%;
  	cursor: pointer;
}
  
.pagenation:disabled {
  	color: #AAC4FF;
  	opacity: 100%;
  	text-decoration: underline;
}
  
.pagenation_direct {
  	font-size: 20px;
  	border: none;
  	background: none;
  	color: #AAC4FF;
  	cursor: pointer;
}

#modifyButton,
#deleteButton {
	font-size: 16px;
}

#modifyButton:hover {
	color: skyblue;
}

#deleteButton:hover {
	color: orangered;
}

#search_keyword {
	width: 60%;
	height: 35px;
	margin-bottom: 50px;
	font-size: 16px;
}

#search_button {
	width: 10%;
	height: 40px;
	text-align: center;
	font-size: 20px;
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
	           	
	           	<jsp:include page="/views/common/search.jsp" />
	           	
	           	<c:if test="${ not empty list }">
					<div id="Accordion_wrap">
						<c:forEach var="board" items="${ list }">
							<div class="que" style="position: relative;">
								<span>${ board.title }</span>
								<c:if test="${ loginMember.getRole() == 1 }">
									<span style="position: absolute; right: 5%;">
										<button onclick="location.href=`${ path }/customerService/faqCreate?no=${ board.no }`;">
											<i id="modifyButton" class="fa-solid fa-pen"></i>
								    	</button>
										&nbsp;&nbsp;&nbsp;&nbsp;
										<button onclick="deleteNotice(${board.no})">
											<i id="deleteButton" class="fa-solid fa-trash-can"></i>
										</button>
									</span>
								</c:if>
							</div>
							<div class="anw">
							 	<span>${ board.content }</span>
							</div>
						</c:forEach>
					</div>
				</c:if>
				
				<div style="position: relative; margin-bottom: 100px;">
					<c:if test="${ loginMember.role == 1 }">
						<button class="create_button" onclick="location.href=`${ path }/customerService/faqCreate`;">글쓰기</button>
					</c:if>
				</div>
					
				
				<!-- 맨 처음으로 -->
				<button class="pagenation_direct" onclick="location.href='${ path }/customerService/faq?page=1'">
					<i class="fa-solid fa-angles-left"></i>
				</button>
		
				<!-- 이전 페이지로 -->
				<button class="pagenation_direct" onclick="location.href='${ path }/customerService/faq?page=${ pageInfo.prevPage }'">
					<i class="fa-solid fa-angle-left"></i>
				</button>
		           
		           <c:forEach var="current" begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }">
		           	<c:choose>
						<c:when test="${ current == pageInfo.currentPage }">					
							<button class="pagenation" disabled>${ current }</button>			
						</c:when>
						<c:otherwise>
							<button class="pagenation" 
								onclick="location.href='${ path }/customerService/faq?page=${ current }'">${ current }</button>			
						</c:otherwise>
					</c:choose>
		           </c:forEach>
		           
		           <!-- 다음 페이지로 -->
				<button class="pagenation_direct" onclick="location.href='${ path }/customerService/faq?page=${ pageInfo.nextPage }'">
					<i class="fa-solid fa-angle-right"></i>
				</button>
		
				<!-- 맨 끝으로 -->
				<button class="pagenation_direct" onclick="location.href='${ path }/customerService/faq?page=${ pageInfo.maxPage }'">
					<i class="fa-solid fa-angles-right"></i>
				</button>
		</div>
	</div>
	<form id="delete_notice_form" method="POST" action="${ path }/customerService/noticeDelete" hidden>
    	<input type="text" id="delete_notice_no" name="delete_notice_no"/>
    </form>
</section>

<script>
$(".que").click(function() {
	$(this).next(".anw").stop().slideToggle(300);
	$(this).toggleClass('on').siblings().removeClass('on');
	$(this).next(".anw").siblings(".anw").slideUp(300); // 1개씩 펼치기
});

const deleteNotice = (no) => {
	$('#delete_notice_no').val(no);
	$('#delete_notice_form').submit();
}
</script>

<jsp:include page="/views/common/footer.jsp" />