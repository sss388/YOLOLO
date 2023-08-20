<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<jsp:include page="/views/common/header.jsp" />



<!-- 모임후기 뷰 -->

<style>

#create_write {
   	font-size: 20px;
   	border: none;
   	cursor: pointer;
   	background-color: #AAC4FF; 
   	padding: 7.5px 15px;
   	border-radius: 10px;
   	color: #FFF;
   	margin-right: 5%;
   	transition: background-color 0.1s ease;
   	box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);
}

#create_write:hover {
	background-color: #668FD8;
}

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

.img_box .empty_img {
	width: 100%; 
	height: 200px;
	text-align: center;
}

.img_box img:hover {
	transform: scale(1.25);
	
}

#deleteTrigger {
	padding: 0 5px;
	border-radius: 7.5px;
	cursor: pointer;
}

#deleteTrigger:hover {
	color: red;
}

.img_info {
	text-align: left;
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

</style>


<section style="justify-content: center; display: flex;"> 
	<div style="width: 100%; min-width: 800px; max-width: 1280px; positon: relative;
		justify-content: center; display: flex; margin: 50px 0">
		<!-- 사이드바 추가 -->
		<jsp:include page="/views/common/sidebar2.jsp" /> 
		
		<div style="width: 100%; text-align: center;">
			<h1 style="text-align: center; font-size: 2em; color: #AAC4FF;"><i class="fa-solid fa-hand-holding-hand"></i>&nbsp;모임후기</h1>
			<c:if test="${ not empty param.no }">
				<jsp:include page="/views/community/reviewDetail.jsp" />
			</c:if> 	
			
			<c:if test="${ empty param.no and empty param.keyword }">
				<h2 style="text-align: center;">모임 후기를 들려주세요</h2>
			</c:if>
			<c:if test="${ not empty param.keyword }">
				<c:if test="${ list.size() == 0 }">
           			<h2 style="text-align: center; margin-bottom: 50px;">검색 결과가 없습니다.</h2>
           		</c:if>
           		<c:if test="${ list.size() != 0 }">
					<h2 style="text-align: center;">"${ param.keyword }"의 검색 결과는 ${ list.size() }개 입니다.</h2>
				</c:if>
			</c:if>
			
			<h3 style="text-align: center; position: relative;">
				<c:if test="${ empty param.no and empty param.keyword }">
					즐거웠던 추억을 모두와 공유해주세요!
				</c:if>
				<c:if test="${ loginMember.role == 1 }">
					<span id="deleteTrigger" onclick="handleDeleteTriggerButton()" 
					style="position: absolute; right: 0;"><i class="fa-regular fa-trash-can"></i></span>
				</c:if>
			</h3>
			
			<div class="board" style="width: 100%;">
		    	<div>
		    		<c:if test="${ not empty list }">
	                	<div style="display: flex;">
				    		<c:forEach var="item" items="${list}" varStatus="status" end="3">
							    <div class="img_box" onclick="showDetailPage(${ item.no })">
							        <div style="width: 100%; height: 200px; overflow: hidden; border-radius: 10px; box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);">
					            		<c:if test="${ empty item.thumb }">
					            			<img src="${ path }/resources/images/example.png">
					            		</c:if>
					            		<c:if test="${ not empty item.thumb }">
					            			<img src="${ item.thumb }">
				            			</c:if>
							        </div>
							        <div class="img_info">
							            <span style="opacity: 50%; font-size: 12px;"><fmt:formatDate value="${item.createDate}" pattern="yyyy년 MM월 d일" /></span><br>
							            ${item.title}
							        </div>
							    </div>
							</c:forEach>
						</div>
						<br>
						<div style="display: flex;">
				    		<c:forEach var="item" items="${list}" varStatus="status" >
				    			<c:if test="${status.index >= 4}">
								     <div class="img_box" onclick="showDetailPage(${ item.no })">
								        <div style="width: 100%; height: 200px; overflow: hidden; border-radius: 10px; box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);">
						            		<c:if test="${ empty item.thumb }">
						            			<img src="${ path }/resources/images/example.png">
						            		</c:if>
						            		<c:if test="${ not empty item.thumb }">
						            			<img src="${ item.thumb }">
					            			</c:if>
								        </div>
								        <div class="img_info">
								            <span style="opacity: 50%; font-size: 12px;"><fmt:formatDate value="${item.createDate}" pattern="yyyy년 MM월 d일" /></span><br>
								            ${item.title}
								        </div>
								    </div>
							    </c:if>
							</c:forEach>
						</div>
					</c:if>
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
				</div>
			</div>
           
 
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
				<button class="pagenation_direct" onclick="location.href='${ path }/community/meetingReview?page=1'">
					<i class="fa-solid fa-angles-left"></i>
				</button>
	
				<!-- 이전 페이지로 -->
				<button class="pagenation_direct" onclick="location.href='${ path }/community/meetingReview?page=${ pageInfo.prevPage }'">
					<i class="fa-solid fa-angle-left"></i>
				</button>
	            
	            <c:forEach var="current" begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }">
	            	<c:choose>
						<c:when test="${ current == pageInfo.currentPage }">					
							<button class="pagenation" disabled>${ current }</button>			
						</c:when>
						<c:otherwise>
							<button class="pagenation" 
								onclick="location.href='${ path }/community/meetingReview?page=${ current }'">${ current }</button>			
						</c:otherwise>
					</c:choose>
	            </c:forEach>
            
	            <!-- 다음 페이지로 -->
				<button class="pagenation_direct" onclick="location.href='${ path }/community/meetingReview?page=${ pageInfo.nextPage }'">
					<i class="fa-solid fa-angle-right"></i>
				</button>

				<!-- 맨 끝으로 -->
				<button class="pagenation_direct" onclick="location.href='${ path }/community/meetingReview?page=${ pageInfo.maxPage }'">
					<i class="fa-solid fa-angles-right"></i>
				</button>
			</div>
		</div>
	</div>
	<form id="delete_review_form" method="POST" action="${ path }/community/reviewDelete" hidden>
		<input type="text" name="no" id="delete_review_no">
	</form>
</section>

<script>
let delState = false;

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
		location.href='${ path }/community/meetingReview?no=' + no;		
	} else {
		const isConfirmed = confirm('삭제하시겠습니까?');
	    if (isConfirmed) {
	      // 사용자가 '예'를 선택한 경우, 삭제 작업을 수행합니다.
	      $('#delete_review_no').val(no);
	      $('#delete_review_form').submit();
	    } else {
	      // 사용자가 '아니오'를 선택한 경우, 삭제 작업을 취소합니다.
	    }
	}
}

$(document).ready(() => {
	$('#create_write').on('click', () => {
	    location.assign('${ path }/community/reviewwrite?category=2');
	});

});

</script>


<jsp:include page="/views/common/footer.jsp" />