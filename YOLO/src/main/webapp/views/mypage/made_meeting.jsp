<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />

<style>
.title{
        width: 50%;
    }

    .board {
        border-collapse: collapse;
    }
    
    
   
	.text {
		text-align: center;
		margin-bottom: 10px;
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

    section#board-list-container{width:600px; margin:0 auto; text-align:center;}
	section#board-list-container h2{margin:10px 0;}
    table#tbl-board{width:100%; margin:0 auto; border-collapse:collapse; clear:both; }
	table#tbl-board th, table#tbl-board td {border:1px solid; padding: 5px 0; text-align:center;} 
	.img_box {
    width: 22%;
    height: 50%;
    line-height: 1em;
	}
	.img_box img {
		width: 100%; 
		height: 200px;
		object-fit: cover;
		transition: transform 0.2s ease-in-out;
	}
	.img_box img:hover {
	transform: scale(1.25);
	}	
	.img_box div:nth-child(2){
    font-size: 14px;
    font-weight: bold;
    margin-bottom: 5px;
    padding-bottom: 10px;
	}
	.img_box span {
    opacity: 60%;
    font-size: 11px;
	}
	
	a {
		color: black;
	}
</style>

<section>
	<div style="display:flex; justify-content: center;">
		<div style="width: 100%; min-width: 800px; max-width: 1280px; margin-top: 100px;">
		
			<h1 style="text-align: center; font-size: 2em; color: #AAC4FF; margin-bottom: 50px;">
				내가 만든 모임
			</h1>

                <div style="display: flex; flex-wrap: wrap; justify-content: space-between;">
                	<c:if test="${ empty list }">
                		<div style="padding: 50px 0; width: 100%; text-align: center;">
                			내가 만든 모임이 없습니다.
                		</div>
                	</c:if>
                	
                	<c:if test="${ not empty list }">
					    <c:forEach var="program" items="${ list }" end="3">
					        <div class="img_box">
					          <a href="${ path }/program_create/detailedpage?no=${ program.no }">
					            <div style="width: 100%; height: 200px; overflow: hidden; border-radius: 10px; box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);">
					            	<c:if test="${ empty program.thumb }">
					            		<img src="${path}/resources/images/example.png">
					            	</c:if>
					            	<c:if test="${ not empty program.thumb }">
					                	<img src="${path}/resources/upload/main_file/${ program.thumb }" alt="${ program.title }">
					                </c:if>
					            </div>
					            <div class="img_info">
					                <span><fmt:formatDate value="${ program.createDate }" pattern="yyyy년 MM월 d일" /></span>
					                <br>
					                ${ program.title }
					            </div>
					        </div>
					    </c:forEach>
					    <c:forEach var="program" items="${ list }" varStatus="status" end="7">
					    	<c:if test="${ status.count > 4}">
					        <div class="img_box">
					          <a href="${ path }/program_create/detailedpage?no=${ program.no }">
					            <div style="width: 100%; height: 200px; overflow: hidden; border-radius: 10px; box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);">
					               <c:if test="${ empty program.thumb }">
					            		<img src="${path}/resources/images/example.png">
					            	</c:if>
					            	<c:if test="${ not empty program.thumb }">
					                	<img src="${path}/resources/upload/main_file/${ program.thumb }" alt="${ program.title }">
					                </c:if>
					            </div>
					            <div class="img_info">
					                <span><fmt:formatDate value="${ program.createDate }" pattern="yyyy년 MM월 d일" /></span>
					                <br>
					                ${ program.title }
					            </div>
					        </div>
					        </c:if>
					    </c:forEach>
				    </c:if>
				</div>
		</div>
	</div>
			   
   <div style="display:flex; justify-content: center; margin-bottom: 100px;"> 
      <!-- 맨 처음으로 -->
		<button class="pagenation_direct" onclick="location.href='${path}/made/meeting?page=1'">
			<i class="fa-solid fa-angles-left"></i>
		</button>

		<!-- 이전 페이지로 -->
		<button class="pagenation_direct" onclick="location.href='${path}/made/meeting?page=${pageInfo.prevPage}'">
			<i class="fa-solid fa-angle-left"></i>
		</button>
           
           <c:forEach var="current" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
           	<c:choose>
				<c:when test="${current == pageInfo.currentPage}">					
					<button class="pagenation" disabled>${current}</button>			
				</c:when>
				<c:otherwise>
					<button class="pagenation" onclick="location.href='${path}/made/meeting?page=${current}'">${current}</button>			
				</c:otherwise>
			</c:choose>
           </c:forEach>
           
           <!-- 다음 페이지로 -->
		<button class="pagenation_direct" onclick="location.href='${path}/made/meeting?page=${pageInfo.nextPage}'">
			<i class="fa-solid fa-angle-right"></i>
		</button>

		<!-- 맨 끝으로 -->
		<button class="pagenation_direct" onclick="location.href='${path}/made/meeting?page=${pageInfo.maxPage}'">
			<i class="fa-solid fa-angles-right"></i>
		</button> 
	</div>
</section>

<jsp:include page="/views/common/footer.jsp" />