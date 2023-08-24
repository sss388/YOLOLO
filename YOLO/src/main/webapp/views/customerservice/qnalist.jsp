<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />

<!-- 내가 문의한 내역 -->

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
    
    .board .delete:hover {
         color: red;
    }
    /* section#board-list-container{width:600px; margin:0 auto; text-align:center;} */
    /* section#board-list-container h2{margin:10px 0;} */
   /* table#tbl-board{width:100%; margin:0 auto; border:1px solid black; border-collapse:collapse; clear:both; }*/
   /* table#tbl-board th, table#tbl-board td {border:1px solid; padding: 5px 0; text-align:center;}*/
         
          
</style>
     
     
<section style="justify-content: center; display: flex;"> 
   <div style="width: 100%; min-width: 800px; max-width: 1280px;
        justify-content: center; margin: 50px 0;">
	 <div style="width: 100%; text-align: center;">
        <c:if test="${ not empty loginMember }">
        </c:if>

        <div style="width: 100%; text-align: center;">
	        <h3 style="color: #AAC4FF; font-size: 2em; margin: 50px 0;">
	             <i class="fa-solid fa-comments"></i>&nbsp;내 문의글
	        </h3>
	             
	             
	        <table class="board" style="justify-content: space-between; width: 100%; border: 1px solid #ddd;">
	             <tr>
	                  <th>번호</th>
	                  <th>작성자</th>
	                  <th>이메일</th>
	                  <th>문의유형</th>
	                  <th>제목</th>                  
	                  <th>작성일</th>
	                  <th>처리여부</th>
	             </tr>
	
				<c:if test="${ not empty list }">
				    <c:forEach var="board" items="${ list }">
				        <tr onclick="location.href='${ path }/customerService/qnaView?no=${ board.no }'">
				            <td>${ board.rowNum } </td>
				            <td>${ board.name }</td>
				            <td>${ board.email }</td>
				            <td>${ board.type }</td>
				            <td>${ board.title }</td>
				            <td>${ board.createDate }</td>
				            <td>${ board.reply }</td>
				        </tr>
				    </c:forEach>
				</c:if>
	             <c:if test="${ empty list }">
	                  <tr>
	                       <td colspan="8">
	                            문의하신 내용이 없습니다.
	                       </td>
	                  </tr>
	             </c:if>
        	</table>
       	</div>
        
        <br>
		
		
	   <!-- 밑에 페이지 넘기기  -->
			<!-- 맨 처음으로 -->
			<button class="pagenation_direct" onclick="location.href='${ path }/customerService/qnalist?page=1'">
				<i class="fa-solid fa-angles-left"></i>
			</button>

			<!-- 이전 페이지로 -->
			<button class="pagenation_direct" onclick="location.href='${ path }/customerService/qnalist?page=${ pageInfo.prevPage }'">
				<i class="fa-solid fa-angle-left"></i>
			</button>
            
            <c:forEach var="current" begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }">
            	<c:choose>
					<c:when test="${ current == pageInfo.currentPage }">					
						<button class="pagenation" disabled>${ current }</button>			
					</c:when>
					<c:otherwise>
						<button class="pagenation" 
							onclick="location.href='${ path }/customerService/qnalist?page=${ current }'">${ current }</button>			
					</c:otherwise>
				</c:choose>
            </c:forEach>
            
            <!-- 다음 페이지로 -->
			<button class="pagenation_direct" onclick="location.href='${ path }/customerService/qnalist?page=${ pageInfo.nextPage }'">
				<i class="fa-solid fa-angle-right"></i>
			</button>

			<!-- 맨 끝으로 -->
			<button class="pagenation_direct" onclick="location.href='${ path }/customerService/qnalist?page=${ pageInfo.maxPage }'">
				<i class="fa-solid fa-angles-right"></i>
			</button>
		</div>
	</div>
</section>

<jsp:include page="/views/common/footer.jsp" />