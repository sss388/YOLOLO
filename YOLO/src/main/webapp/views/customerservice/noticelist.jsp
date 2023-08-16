<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />

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
    }
    
    .create_button:hover {
    	background-color: #668FD8;
    }
    
    .board .delete:hover {
    	color: red;
    }
</style>

<section style="justify-content: center; display: flex;">
	<jsp:include page="/views/common/sidebar3.jsp" /> 

    <div style="width: 100%; min-width: 800px; max-width: 1280px;
		justify-content: center; display: flex; margin: 50px 0">
        <div style="width: 100%; text-align: center;">
            <h3 style="color: #AAC4FF; font-size: 40px">
            	<i class="fa-solid fa-comments"></i>&nbsp;공지사항
           	</h3> 
           	<br>
            <table class="board" style="justify-content: space-between; width: 100%; border: 1px solid #ddd;">
                <tr>
                    <th>글번호</th>
                    <th width="70%">제목</th>
                    <th>작성자</th>
                    <th>등록일</th>
                </tr>
                <c:forEach var="board" items="${ list }">
	                <tr>
	                    <td>${ board.rowNum } </td>
	                    <td>${ board.title }</td>
	                    <td>익명</td>
	                    <td>${ board.createDate }</td>
	                    <c:if test="${ loginMember.role == 1 }">
	                    	<td class="delete">
	                    		<i class="fa-regular fa-trash-can" onclick="deleteBoard(${ board.no })"></i>
	                    	</td>
	                    </c:if>
	                </tr>
                </c:forEach>
            </table>
            
            <br>
            <div style="text-align: right;">
            	<button class="create_button" >글쓰기</button>	
            </div>
            
            <!-- 맨 처음으로 -->
			<button class="pagenation_direct" onclick="location.href='${ path }/community/freeBoard?page=1'">
				<i class="fa-solid fa-angles-left"></i>
			</button>

			<!-- 이전 페이지로 -->
			<button class="pagenation_direct" onclick="location.href='${ path }/community/freeBoard?page=${ pageInfo.prevPage }'">
				<i class="fa-solid fa-angle-left"></i>
			</button>
            
            <c:forEach var="current" begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }">
            	<c:choose>
					<c:when test="${ current == pageInfo.currentPage }">					
						<button class="pagenation" disabled>${ current }</button>			
					</c:when>
					<c:otherwise>
						<button class="pagenation" 
							onclick="location.href='${ path }/community/freeBoard?page=${ current }'">${ current }</button>			
					</c:otherwise>
				</c:choose>
            </c:forEach>
            
            <!-- 다음 페이지로 -->
			<button class="pagenation_direct" onclick="location.href='${ path }/community/freeBoard?page=${ pageInfo.nextPage }'">
				<i class="fa-solid fa-angle-right"></i>
			</button>

			<!-- 맨 끝으로 -->
			<button class="pagenation_direct" onclick="location.href='${ path }/community/freeBoard?page=${ pageInfo.maxPage }'">
				<i class="fa-solid fa-angles-right"></i>
			</button>
        </div>
    </div>
</section>

<script>
const deleteBoard = (no) => {
	location.assign('${ path }/community/freeBoardDelete?no='+no);
}
</script>

<jsp:include page="/views/common/footer.jsp" />