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
	<div style="width: 100%; min-width: 800px; max-width: 1280px;
	justify-content: center; display: flex; margin: 50px 0">
		<div style="width: 100%;">
			<h1 style="text-align: center; font-size: 2em; color: #AAC4FF; margin-bottom: 50px;">
				내가 참여한 모임
			</h1>
		
			<div style="display: flex; flex-wrap: wrap;">
				<c:if test="${ empty list }">
					<div style="text-align: center; width: 100%; margin: 100px;">
						내가 참여한 모임이 없습니다.
					</div>
				</c:if>
				
				<c:if test="${ not empty list }">
					<c:forEach var="item" items="${list}" varStatus="status">
						<div class="img_box" onclick="showDetailPage(${ item.no }, '${ item.category }')">
					        <!-- 상세페이지로 넘어가도록 경로 설정해둠 -->
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
</section>

<jsp:include page="/views/common/footer.jsp" />
	
<script>
const showDetailPage = (no, category) => {
	if(category == "oneday") {
		category = "oneDay";
	}
	
	location.href='${ path }/program/' + category + '?no=' + no;	
}
</script>
	
