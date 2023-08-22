<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />

<link rel="stylesheet" type="text/css" href="../resources/css/ckeditor.css">

<style>
    .title{
        width: 50%;
    }

    .board th, .board td{
        padding: 10px 0;
    }
    
    .board td{
        opacity: 80%;
    }

    .board tr:not(:last-child) {
        border-bottom: 1px solid #ddd;
    }
    
    .board tr:not(:first-child){
    	cursor: pointer;
    }
    
    .board tr:not(:first-child):hover{
    	background-color: #D2DAFF;
    }
    
    .reply_clear{
    	background-color: #EEF1FF;
    }

    .board {
        border-collapse: collapse;
        border: 1px solid #000;
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
    
    .create_freeboard:hover {
    	background-color: #668FD8;
    }
    
    .board .delete:hover {
    	color: red;
    }
    
    /*
    #followMouseDiv {
        position: absolute;
        display: none;
    }
    */
    
    .current_board {
    	border-collapse: collapse;
    }
    
    .current_board tr:not(:last-child) {
        border-bottom: 1px solid #ddd;
    }
    
    .current_board button {
    	padding: 10px 20px;
    	margin: 0 1%;
    	border-radius: 10px;
    	cursor: pointer;
    }
    
    .current_board button:active {
    	background-color: gray;
    }
    
    .current_board textarea {
    	outline: 2px solid black;
    }
    
    #content {
		background: white;
		border-radius: 10px;
		overflow: auto;
		padding: 20px;
		text-align: left;
	}
	
}
    
</style>

<section style="justify-content: center; display: flex;">
	<div style="width: 100%; min-width: 800px; max-width: 1280px;
		justify-content: center; display: flex; margin: 50px 0">
		<jsp:include page="/views/common/sidebar3.jsp" /> 
		<div style="width: 100%; text-align: center; ">
			<h3 style="color: #AAC4FF; font-size: 2em; margin: 50px 0;">
				<i class="fa-regular fa-lightbulb"></i> 
				문의하기 
			</h3>
			<c:if test="${ not empty currentBoard }">
				<div style="border-radius: 10px; border: 2px solid gray; margin-bottom: 50px;">
					<table class="current_board" style="justify-content: space-between; width: 100%;">
						<tr>
							<th>카테고리</th>
							<th width="60%">제목</th>
							<th>작성자</th>
							<th>등록일</th>
						</tr>
						<tr>
							<td>${ currentBoard.type }</td>
							<td width="60%">${ currentBoard.title }</td>
							<td>${ currentBoard.name }</td>
							<td>${ currentBoard.createDate }</td>
						</tr>
						<tr>
							<td colspan="4">
								<div style="background: #AAC4FF; padding: 20px 0; border-radius: 10px;">
									<div class="centered" style="padding-top: 20px;">
										<div id="content" readonly >${ currentBoard.content }</div>
									</div>
									
									<div style="padding-top: 20px;">
										<c:if test="${ currentBoard.reply == 'N' }">
											<button class="reply_button" onclick="toggleReply()">답변하기</button>
										</c:if>
										<c:if test="${ currentBoard.reply == 'Y' }">
											<button class="reply_update_button" onclick="toggleReply()">답변수정</button>
										</c:if>
									</div>
								</div>
								
								<div class="reply_write" hidden>
									<div style="border: 2px solid gray; height: auto; margin-top:25px; border-radius: 10px; padding: 10px; background: #AAC4FF;">
										<form id="reply_form" action="${ path }/customerService/qnaReply" method="post">
										 	<input type="hidden" name="no" value="${param.no}" />
											<div class="centered" style="padding-top: 25px;">
												<textarea class="editor" name="content"
													style="width: 90%; border:none; border-radius: 10px; padding: 10px;" rows="5">${ reply.content }</textarea>
											</div>
											<div style="margin-top: 10px">
												<c:if test="${ empty reply }">
													<button type="submit">보내기</button>
												</c:if>
												<c:if test="${ not empty reply }">
													<button type="button" onclick="toggleUpdateReply()">수정하기</button>
												</c:if>
											</div>
										</form>
									</div>
								</div>
								
							</td>
						</tr>
					</table>
				</div>
			</c:if>
			<table class="board" style="justify-content: space-between; width: 100%; border: 1px solid #ddd;">
	            <tr>
	                <th>글번호</th>
					<th>카테고리</th>
					<th width="60%">제목</th>
					<th>작성자</th>
					<th>등록일</th>
	            </tr>
	            <c:if test="${ not empty list }">
		            <c:forEach var="board" items="${ list }">
		            	<c:if test="${ board.reply == 'N'}">
				            <tr onclick="handleClickBoard(${board.no})">
				                <td>${ board.rowNum } </td>
				                <td>${ board.type }</td>
				                <td width="60%">${ board.title }</td>
				                <td>${ board.name }</td>
				                <td>${ board.createDate }</td>
				                <td></td>
				            </tr>
			            </c:if>
			            <c:if test="${ board.reply == 'Y'}">
			            	<tr class="reply_clear" onclick="handleClickBoard(${board.no})">
				                <td>${ board.rowNum } </td>
				                <td>${ board.type }</td>
				                <td width="60%">${ board.title }</td>
				                <td>${ board.name }</td>
				                <td>${ board.createDate }</td>
				                <td>답변 완료</td>
				            </tr>
			            </c:if>
		            </c:forEach>
	            </c:if>
	            <c:if test="${ empty list }">
	            	<tr>
	            		<td colspan="5">게시글이 없습니다.</td>
	            	</tr>
	            </c:if>
	   		</table>
	   		<div style="text-align: center; margin-top: 50px;">
		   		<!-- 맨 처음으로 -->
				<button class="pagenation_direct" onclick="location.href='${ path }/customerService/qnaWrite?page=1'">
					<i class="fa-solid fa-angles-left"></i>
				</button>
				
				<!-- 이전 페이지로 -->
				<button class="pagenation_direct" onclick="location.href='${ path }/customerService/qnaWrite?page=${ pageInfo.prevPage }'">
					<i class="fa-solid fa-angle-left"></i>
				</button>
				         
				         <c:forEach var="current" begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }">
				         	<c:choose>
						<c:when test="${ current == pageInfo.currentPage }">					
							<button class="pagenation" disabled>${ current }</button>			
						</c:when>
						<c:otherwise>
							<button class="pagenation" 
								onclick="location.href='${ path }/customerService/qnaWrite?page=${ current }'">${ current }</button>			
						</c:otherwise>
					</c:choose>
				         </c:forEach>
				         
				         <!-- 다음 페이지로 -->
				<button class="pagenation_direct" onclick="location.href='${ path }/customerService/qnaWrite?page=${ pageInfo.nextPage }'">
					<i class="fa-solid fa-angle-right"></i>
				</button>
				
				<!-- 맨 끝으로 -->
				<button class="pagenation_direct" onclick="location.href='${ path }/customerService/qnaWrite?page=${ pageInfo.maxPage }'">
					<i class="fa-solid fa-angles-right"></i>
				</button>
	   		</div>
   		</div>
   		
   		<!--
   		<div id="followMouseDiv">ㅇㅇ</div> 
   		 -->
	</div>
</section>

<script src="../resources/js/ckeditor/script.js"></script>
<jsp:include page="/views/common/footer.jsp" />

<script>
let reply = false;

const toggleReply = () => {
	if(!reply){
		$(".reply_write").removeAttr("hidden");
		$(".reply_button").text("취소");
	}else {
		$(".reply_write").attr("hidden","true");
		$(".reply_button").text("답변하기");
	} reply = !reply;
}

const handleClickBoard = (no) => {
	location.href='${ path }/customerService/qnaWrite?page=${ pageInfo.currentPage }&no=' + no;
}

const toggleUpdateReply = () => {
	$('#reply_form').attr("action", "${ path }/customerService/qnaUpdateReply");
	$('#reply_form').submit();
}

//마우스 따라 보이기
/*const followMouseDiv = document.getElementById('followMouseDiv');
document.body.addEventListener('mousemove', (event) => {
    followMouseDiv.style.display = 'block';
    followMouseDiv.style.left = event.pageX + 'px';
    followMouseDiv.style.top = event.pageY + 'px';
});

document.body.addEventListener('mouseout', () => {
    followMouseDiv.style.display = 'none';
});*/

</script>