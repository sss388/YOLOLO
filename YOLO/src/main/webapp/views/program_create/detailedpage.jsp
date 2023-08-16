<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />

<!-- 상세페이지 -->

<style>
     section {
	   max-width: 100%;
	   text-align:center;
	   margin-top: 20px;
     }

	#inter1 {
		width: 60%;
		height: 300px; 
        overflow: hidden; 
		
	}
	#inter2 {
		width: 100%;
		float: left;
		text-align: left;
	}
	
	/* 참가하기 버튼 */
	#btn_join {
		  background-color: rgb(170, 196, 255); 
          color: white;  
          width: 100px; 
          height: 50px;
          width: 100%;
          border: none;
          border-radius: 10px;
          
	}
	
	/* 글자정렬 */
	h4{
	 text-align: left;
	}
	
	/* 지도 */
	iframe {
	width: 500px; 
	height: 500px; 
	
	}
	
	/* 포함 사항, 불포함사항, 준비물 글씨 */
	#plus > p{
	font-size: 15px;
	color: black;
	text-align: left;
	margin-top: -10px;
	}
	
	/* 모임시작하기 / 모임종료하기 */
	.date > p {
	font-size: 15px;
	color: black;
	text-align: left;
	margin-top: -10px;
	}
	
	h5{
	margin-top: -5px;
	}
	
	#btn_login input {
	      background-color: rgb(170, 196, 255); 
          color: white;  
          border: none;
          width: 70px;
          height: 35px;
          text-align: center;
          font-size: medium;
          border-radius: 10px; 
          margin-bottom: 100px;
          cursor: pointer;
	}
	
	
	dl{width:600px;}
	dt{height:30px; background:#AAC4FF; color:#fff; font-weight:bold; border-bottom:1px solid #ccc; text-indent:20px;}/*text-indent 들여쓰기*/
	dd{margin:0; background:B1B2FF; padding:30px;}
	dt.over{background:#D2DAFF; cursor:pointer;}
	dt.selected{background:#B1B2FF; cursor:default;}/*cursor:default; 기본 커서*/

</style>

<section style="display: flex; justify-content: center;">
	<div style="width: 100%; justify-content: center; display: flex; min-width: 800px; max-width: 1280px; border: 1px solid black;">
		<div style="border: 1px solid black; width: 100%; justify-content: center; display: flex;">
			<div style="width: 100%;">
				<div style="border: 1px solid black; height: 300px; width: 80%;">
					
				</div>
				<table border="1" style="width: 100%;">
					<tr style="height: 300px;">
						<th id="inter1">
							<c:if test="${ empty program.thumb }">
								<img src="${path}/resources/images/example.png" style="width: 300px; height: 300px; object-fit: cover;">
							</c:if>
							<c:if test="${ not empty program.thumb }">
								<img src="${path}/resources/upload/main_file/${ program.thumb }" style="width: 300px; height: 300px; object-fit: cover;">
							</c:if>
						</th>
						<th id="inter2" style="height: 60px;">${ program.title }</th> 
						<!-- 모임 시작일/ 종료일 -->
						<th id="inter2" class="date" style="height: 150px;">
							<h5>모임 시작일</h5>
							<p>${ program.startDate }</p>
							<h5>모임 종료일</h5>
							<p>${ program.expireDate }</p>
						</th>
						<th id="inter2">
							<input type="button" id="btn_join" value="참가하기">
						</th>
						<th id="inter2" style="height: 30px;">${ program.writename }</th>
					</tr>
				</table>
				
				<div style="width:600px;">
					<h4>세부정보</h4>
					<div style="text-align: left; min-height: 300px;">
						${ program.content }
					</div>
				</div>
				
	
				<!-- 지도 -->
				<div style="width:600px">
					<h4>모이는 장소</h4>
					<iframe id="map-iframe" src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3162.947689065985!2d126.93466157647785!3d37.556296224714295!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca2e75d4a7c41%3A0x4916c3cc69cb6c2f!2z7ZWY7J2066-465SU7Ja07Lu07ZOo7YSw7ZWZ7JuQ7Iug7LSM7KCQ!5e0!3m2!1sko!2skr!4v1682394239329!5m2!1sko!2skr" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
				</div>
				
				<div id="plus" style="width:80%;">
					<h4>포함 사항</h4>
					<p>- ${ program.inclusion }</p>
					<h4>불포함 사항</h4>
					<p>- ${ program.noninclusion }</p>
					<h4>준비물</h4>
					<p>- ${ program.supplies }</p>
				
				</div>
	
					
				<!-- 수정 및 삭제 버튼 -->
				<div>
				    <div style="margin-top: 20px;" id="btn_login">	
					<c:if test="${(loginMember != null) || (loginMember.no == program.userno)}">
				    	<input type="button" onclick="location.href='${path}/program/update?no=${program.no}'" value="수정">
				    	<input type="button" id="btnDelete" value="삭제">
					</c:if>    	
				    	<input type="button" onclick="location.href='${ path }/program/oneDay'" value="목록으로">
				    </div>
				</div>
			</div>
		</div>
	</div>
</section>


<script>
		$(function(){
			//:not() 특정 선택자를 제외한 나머지 요소
			$("dd:not(:first)").css("display","none");
			$("dt:first").addClass("selected");
			$("dl dt").mouseover(function(){
				$(this).addClass("over");
			}).mouseout(function(){
				$(this).removeClass("over");
			}).click(function(){
				//if($(선택자).메서드()==조건){}
				//$("+요소명") 인접한 요소 선택자
				if($("+dd",this).css("display")=="none"){
					$("dd").slideUp("slow");
					$("+dd",this).slideDown("slow");

					$("dt").removeClass("selected");
					$(this).addClass("selected");
				}
			});
		});
		
		$(document).ready(() => {
			$('#btnDelete').on('click', () => {
				if (confirm('게시글을 삭제 하시겠습니까?')) {
					location.replace('${ path }//program/delete?no=${ program.no }');
				}
			});

		});

</script>

<jsp:include page="/views/common/footer.jsp" />