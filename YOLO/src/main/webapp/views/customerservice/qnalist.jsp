<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />

<style>
	section#board-list-container{width:600px; margin:0 auto; text-align:center;}
	section#board-list-container h2{margin:10px 0;}
	table#tbl-board{width:1280px; margin:0 auto; border:1px solid white; border-collapse:collapse; clear:both; }
	table#tbl-board th, table#tbl-board td {border:1px solid white; padding: 5px 0; text-align:center;} 
	/*글쓰기버튼*/
	input#btn-add{float:right; margin: 0 0 15px;}
	/*페이지바*/
	div#pageBar{margin-top:200px; margin-bottom: 150px; text-align:center;}
	
	h2 {
		color : #B1B2FF;
		text-align:center;
	}
	table#tbl-board th {
		color : #B1B2FF;
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
    
    h2 {
      font-size: 2em;
    }
    
</style>
<section id="content">
	<h2>문의글</h2>
	<div id="board-list-container">
	<c:if test="${ not empty loginMember }">
	</c:if>
		<table id="tbl-board">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>

			</tr>
			
			<%-- 리스트 비어있으면 조회된 게시글이 없음 --%>
			<c:if test="${ empty list }">
				<tr>
					<td colspan="6">
						조회된 게시글이 없습니다.
					</td>
				</tr>	
			</c:if>
			
			<c:if test="${ not empty list }">
				<c:forEach var="board" items="${ list }">
					<tr>
						<td>${ board.rowNum }</td>
						<td>
							<a href="${ path }/customerService/update?no=${ board.no }">${ board.title }</a>
						</td>
						<td>${ board.writerId }</td>
						<td>${ board.createDate }</td>
						<%-- 
						<td>
							 실제 사용자가 업로드한 걸로 하려고 originalFilename 사용  
							<c:if test="${ empty board.originalFilename }">
								<span> - </span>
							</c:if>
			
							<c:if test="${ not empty board.originalFilename }">
								<span> ${ board.originalFilename }</span>
							</c:if>
						
						<td>${ board.modifyDate }</td>
						 --%>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		
	   <!-- 밑에 페이지 넘기기  -->
		<div id="pageBar">
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