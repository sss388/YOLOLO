<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>


<jsp:include page="/views/common/header.jsp" />
<br><br>

<section id="home">
    <div style="width: 100%; min-width: 800px; max-width: 1280px;
                justify-content: center; display: flex;">
        <div style="width: 90%">
            <div style="justify-content: center; display: flex">
                <div class="swiper" style="height: 250px">
                    <!-- Additional required wrapper -->
                    <div class="swiper-wrapper">
                        <!-- Slides -->
                        <div class="swiper-slide">
                            <div class="banner oneDay" style="background-image: url('resources/images/banner1.jpg');">
                                <div>
                                    똑같은 일상을 다채롭게만들어 줄 원데이 모임
                                </div>
                            </div>
                        </div>

                        <div class="swiper-slide">
                            <div class="banner club" style="background-image: url('resources/images/banner2.jpg');">
                                <div>
                                    지속형 모임으로 계속해서 친하게 지내요
                                </div>
                            </div>
                        </div>

                        <div class="swiper-slide">
                            <div class="banner challenge" style="background-image: url('resources/images/banner3.jpg');">
                                <div>
                                    같은 목표를 가진멤버들과 함께 도전해요
                                </div>
                                &nbsp;
                            </div>
                        </div>

                    </div>

                    <!-- If we need navigation buttons -->
                    <div class="swiper-button-prev" style="color: #EEF1FF"></div>
                    <div class="swiper-button-next" style="color: #EEF1FF"></div>
                </div>
            </div>
            
            <br>
            
            <div>
                <h3>마감 임박</h4>
                <div style="display: flex;">
                	<c:if test="${ empty closeDeadLine }">
                		<div style="width: 100%; padding: 50px 0; text-align: center; display: center;">
                			마감 임박한 프로그램이 없습니다!!
                		</div>
                	</c:if>
                	<c:if test="${ not empty closeDeadLine }">
	                	<c:forEach var="item" items="${ closeDeadLine }" varStatus="status">
	                		<div class="img_box" onclick="showProgramDetailPage(${ item.no }, `${ item.category }`)">
		                        <div style="width: 100%; height: 200px; overflow: hidden; border-radius: 10px; overflow: hidden; box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);">
	                        		<div style="width: 100%; height: 100%;">
			                        	<c:if test="${ not empty item.thumb }">
		                        			<img src="resources/upload/main_file/${ item.thumb }">
		                            	</c:if>
			                            <c:if test="${ empty item.thumb }">
		                            		<img src="resources/images/example.png">
			                            </c:if>
		                            </div>
		                        </div>
		                        <div>
		                            <span style="color: red">
		                            	<c:if test="${ remainDate[status.index] == 0 }">
		                            		오늘 마감!!!
		                            	</c:if>
		                            	<c:if test="${ remainDate[status.index] != 0 }">
		                            		${ remainDate[status.index] }일 남음!!
		                            	</c:if>
	                            	</span> <br>
		                            ${ item.title }
	                        </div>
	                    </div>
	                	</c:forEach>
                	</c:if>
                </div>
            </div>

            <br>
            
            <div>
                <h3>최근 추가된 프로그램</h4>
                <div style="display: flex;">
                	<c:if test="${ empty recentProgram }">
                		<div style="width: 100%; padding: 50px 0; text-align: center; display: center;">
                			프로그램이 없습니다!!
                		</div>
                	</c:if>
                	<c:if test="${ not empty recentProgram }">
                    <c:forEach var="item" items="${ recentProgram }" varStatus="status">
                		<div class="img_box" onclick="showProgramDetailPage(${ item.no }, `${ item.category }`)">
	                        <div style="width: 100%; height: 200px; overflow: hidden; border-radius: 10px; overflow: hidden; box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);">
                        		<div style="width: 100%; height: 100%;">
		                        	<c:if test="${ not empty item.thumb }">
	                            		<img src="resources/upload/main_file/${ item.thumb }">
		                            </c:if>
		                            <c:if test="${ empty item.thumb }">
	                            		<img src="resources/images/example.png">
		                            </c:if>
                            	</div>
	                        </div>
	                        <div>
	                            <span>
	                            	<fmt:formatDate value="${ item.createDate }" pattern="yyyy년 MM월 d일"/>
                            	</span> <br>
	                            ${ item.title }
                        	</div>	
                    	</div>
                	</c:forEach>
                	</c:if>
                </div>
            </div>

            <br>
            
            <div>
                <h3>최근 모임 후기</h3>
                <div style="display: flex;">
                	<c:if test="${ empty recentReviewBoard }">
                		<div style="width: 100%; padding: 50px 0; text-align: center; display: center;">
                			모임 후기가 없습니다!!
                		</div>
                	</c:if>
                	<c:if test="${ not empty recentReviewBoard }">
                    <c:forEach var="item" items="${ recentReviewBoard }" varStatus="status">
                		<div class="img_box" onclick="showReviewDetailPage(${ item.no }, '${ item.category }')">
	                        <div style="width: 100%; height: 200px; overflow: hidden; border-radius: 10px; overflow: hidden; box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);">
                        		<div style="width: 100%; height: 100%;">
                            		<c:if test="${ empty item.thumb }">
				            			<img src="resources/images/example.png">
				            		</c:if>
				            		<c:if test="${ not empty item.thumb }">
				            			<img src="${ item.thumb }">
			            			</c:if>
                            	</div>
	                        </div>
	                        <div>
	                            <span>
	                            	<fmt:formatDate value="${ item.createDate }" pattern="yyyy년 MM월 d일"/>
                            	</span> <br>
	                            ${ item.title }
                        </div>
                    </div>
                	</c:forEach>
                	</c:if>
                </div>
            </div>

            <br>

           <div>
              	<h4>지금 바로 시작해보세요</h4>
               	<div style="justify-content: center; display: flex; margin-top: -25px">
                    <div style="width: 40%; display: flex; flex-direction: column; align-items: center;">
                        <a href="${ path }/program_create/createwrite" style="cursor: pointer"><img src="${ path }/resources/images/example2.png"></a>
                        <br>
                        <b>모임 만들기</b>
                        <p style="text-align: center; opacity: 70%; font-size: 14px">
                            지금 당장 무언가 같이 하고 싶은 친구가 필요한가요?<br>
                            지금 바로 모임을 만들어 보세요
                        </p>
                    </div>
                    <div style="width: 40%; display: flex; flex-direction: column; align-items: center;">
                        <a href="${ path }/program/oneDay" style="cursor: pointer"><img src="resources/images/example3.png" "></a>
                        <br>
                        <b>모임 참여하기</b>
                        <p style="text-align: center; font-size: 16px">
                            내가 모임을 만들기 부담스럽다면<br>
                            누군가 만든 모임에 참여해 보면 어떤가요?!
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="/views/common/footer.jsp" />

<script>
	$('.oneDay').on('click', () => {
		location.assign('${ path }/program/oneDay');
	});
	
	$('.club').on('click', () => {
		location.assign('${ path }/program/club');
	});
	
	$('.challenge').on('click', () => {
		location.assign('${ path }/program/challenge');
	});
	
	$('#mg').on('click', () => {
		location.assign('${ path }/create/group');
	});


const swiper = new Swiper('.swiper', {
    // Optional parameters
    direction: 'horizontal',
    loop: true,
    autoplay: { // 옵션 추가
      delay: 2500, // 2.5초마다 자동 슬라이드 이동
      disableOnInteraction: false // 사용자의 슬라이드 동작에 의해 자동 슬라이드 정지 여부
    },

    // Navigation arrows
    navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
    },
});

const showProgramDetailPage = (no, category) => {
	if(category == "oneday") {
		category = "oneDay";
	}
	location.href='${ path }/program/' + category + '?no=' + no;		
}

const showReviewDetailPage = (no) => {
	location.href='${ path }/community/meetingReview?no=' + no;		
}
</script>