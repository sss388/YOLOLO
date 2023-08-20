<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<jsp:include page="/views/common/header.jsp" />

<style>
	.title{
        width: 50%;
    }

    .board {
        border-collapse: collapse;
        border: 1px solid #000;
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
    
    .create_freeboard {
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
    	box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);
    }
    
    .create_freeboard:hover {
    	background-color: #668FD8;
    }
    
   
  
    section#board-list-container{width:600px; margin:0 auto; text-align:center;}
	section#board-list-container h2{margin:10px 0;}
    table#tbl-board{width:100%; margin:0 auto; border:1px solid black; border-collapse:collapse; clear:both; }
	table#tbl-board th, table#tbl-board td {border:1px solid; padding: 5px 0; text-align:center;} 
	.img_box {
	    width: 22%;
	    height: 50%;
	    line-height: 1em;
	    margin-right: 3%;
	    cursor: pointer;
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
	#deleteTrigger {
		padding: 0 5px;
		border-radius: 7.5px;
		cursor: pointer;
	}

	#deleteTrigger:hover {
		color: red;
	}
</style>

<section style="justify-content: center; display: flex;">
	<div style="width: 100%; min-width: 800px; max-width: 1280px;
	justify-content: center; display: flex; margin: 50px 0">	
		<!-- 사이드바 추가 -->
		<jsp:include page="/views/common/sidebar.jsp" /> 
		
		<div style="width: 100%;">
			<h1 style="text-align: center; font-size: 2em; color: #AAC4FF;"><i class="fa-solid fa-users fa-bounce"></i>&nbsp;클럽</h1>
			
			<c:if test="${ not empty program }">
				<jsp:include page="/views/program_create/detailedpage.jsp" /> 		
			</c:if>
			
			<c:if test="${ empty program and empty param.keyword }">
				<h2 style="text-align: center;">지속형 모임으로 계속해서 친하게 지내요</h2>
			</c:if>
			
			<c:if test="${ not empty param.keyword }">
				<h2 style="text-align: center;">"${ param.keyword }"의 검색 결과는 ${ list.size() }개 입니다.</h2>
			</c:if>
			
			<h3 style="text-align: center; position: relative;">
				<c:if test="${ empty program and empty param.keyword }">
					나와 같은 관심사를 가진 친구들과 매일 함께하고 싶다면 클럽에서 만나요!
				</c:if>
				
				<c:if test="${ loginMember.role == 1 }">
					<span id="deleteTrigger" onclick="handleDeleteTriggerButton()" 
					style="position: absolute; right: 0;"><i class="fa-regular fa-trash-can"></i></span>
				</c:if>
			</h3>
			<table class="board" style="justify-content: space-between; width: 100%; border: 1px solid #ddd;">
                <div style="display: flex; flex-wrap: wrap;">
                	<c:if test="${ empty list }">
                		<div style="width:100%; height: 300px; display: flex; align-items: center; justify-content: center;">
                			<c:if test="${ not empty param.keyword }">
                				검색 결과가 없습니다.
                			</c:if>
                			<c:if test="${ empty param.keyword }">
               					모임이 없습니다. ㅠㅠ
               				</c:if>
                		</div>
                	</c:if>
                	<c:if test="${ not empty list }">
					    <c:forEach var="item" items="${list}" varStatus="status">
					        <div class="img_box" onclick="showDetailPage(${ item.no })">
					            <div style="width: 100%; height: 200px; overflow: hidden; border-radius: 10px; box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);">
					                <c:if test="${ empty item.thumb }">
				            			<img src="${path}/resources/images/example.png">
					            	</c:if>
					            	<c:if test="${ not empty item.thumb }">
				                		<img src="${path}/resources/upload/main_file/${item.thumb}" alt="${item.title}">
					                </c:if>
					            </div>
					            <div class="img_info">
					                <span><fmt:formatDate value="${item.createDate}" pattern="yyyy년 MM월 d일" /></span><br>
					                ${item.title}
					            </div>
					        </div>
					    </c:forEach>
				    </c:if>
				</div>
			</table>
           
 
            <br>
            <div style="position: relative; justify-content: center; display: flex; align-items: center;">
            	<div style="position: absolute; width: 100%; text-align: right;">
            		<button class="create_freeboard" id="create_write">글쓰기</button>
           		</div>	
            	<jsp:include page="/views/common/search.jsp" /> 
            </div>
			
              
			<br>
            
            <div style="display:flex; justify-content: center;">
            <!-- 맨 처음으로 -->
			<button class="pagenation_direct" onclick="location.href='${path}/program/oneDay?page=1'">
				<i class="fa-solid fa-angles-left"></i>
			</button>

			<!-- 이전 페이지로 -->
			<button class="pagenation_direct" onclick="location.href='${path}/program/oneDay?page=${pageInfo.prevPage}'">
				<i class="fa-solid fa-angle-left"></i>
			</button>
            
            <c:forEach var="current" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
            	<c:choose>
					<c:when test="${current == pageInfo.currentPage}">					
						<button class="pagenation" disabled>${current}</button>			
					</c:when>
					<c:otherwise>
						<button class="pagenation" onclick="location.href='${path}/program/oneDay?page=${current}'">${current}</button>			
					</c:otherwise>
				</c:choose>
            </c:forEach>
            
            <!-- 다음 페이지로 -->
			<button class="pagenation_direct" onclick="location.href='${path}/program/oneDay?page=${pageInfo.nextPage}'">
				<i class="fa-solid fa-angle-right"></i>
			</button>

			<!-- 맨 끝으로 -->
			<button class="pagenation_direct" onclick="location.href='${path}/program/oneDay?page=${pageInfo.maxPage}'">
				<i class="fa-solid fa-angles-right"></i>
			</button>
			</div>
			
			</div>
			
		</div>
		
	<form id="delete_program_form" method="POST" action="${ path }/program/adminDeleteProgram" hidden>
		<input type="text" name="category" value="club">
		<input id="delete_program_no" type="text" name="delete_program_no">
	</form>
</section>

<script>
let delState = false;

$(document).ready(() => {
	$('#create_write').on('click', () => {
		location.assign('${ path }/program_create/createwrite');
	});

});

const handleDeleteTriggerButton = () => {
	if(!delState){
		$('#deleteTrigger').css('background', 'red');
		$('#deleteTrigger').css('color', 'white');
	} else {
		$('#deleteTrigger').css('background', 'none');
		$('#deleteTrigger').css('color', 'black');
	}
	delState = !delState;
}

const showDetailPage = (no) => {
	if(!delState){
		location.href='${ path }/program/club?no=' + no;		
	} else {
		const isConfirmed = confirm('삭제하시겠습니까?');
	    if (isConfirmed) {
	      // 사용자가 '예'를 선택한 경우, 삭제 작업을 수행합니다.
	      $('#delete_program_no').val(no);
	      $('#delete_program_form').submit();
	    } else {
	      // 사용자가 '아니오'를 선택한 경우, 삭제 작업을 취소합니다.
	    }
	}
}


</script>


<jsp:include page="/views/common/footer.jsp" />