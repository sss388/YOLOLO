<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YOLO</title>
<script src="${ path }/resources/js/jquery-3.7.0.js"></script>
<link rel="stylesheet" href="${path}/resources/css/style.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="https://use.fontawesome.com/releases/v6.4.2/js/all.js"></script>
<script src="../resources/js/ckeditor/ckeditor.js"></script> 
</head>

<style>
	/* 마이페이지 스타일 */ 
    .menuwrap {
		position: fixed;
        top: 0;
        right: -300px; /* 너비 300px 인 사이드바를 왼쪽으로 300px 이동시켜 화면에 보이지 않게 함 */
        z-index: 400;
        overflow: auto;
        width: 300px; /* 너비 */
        height: 100%;
        padding: 50px 20px;
        box-sizing: border-box;
        transition: right .3s ease-in-out; /* 0.3초 동안 이동 애니메이션 */
        background-color: #ffffff;
     }
     .menuwrap.on {
        right: 0;
     }

     /* 뒷 배경 어둡게 만들기 */ 
     #dimmed {
         display: none;
         position: fixed;
         top: 0;
         left: 0;
         z-index: 300;
         width: 100%;
         height: 100%;
         background-color: rgba(0, 0, 0, 0.5); /* 수정: 어둡게 만들기 */
      }

      /* 마이페이지 스타일  */
      button {
         background-color: white;
         border-style: none;
         margin-bottom: 10px;
         font-weight: bolder;
         text-align: left;
         cursor: pointer;
      }

      p {
         font-size: 10px;
         color: rgb(190, 190, 190);
         margin-top: 15px;
      }

      /* 이미지 동그랗게 설정 */
      .box {
          width: 100px;
          height: 100px; 
          border-radius: 70%;
          overflow: hidden;
      }

      /* 사진 안에 꽉차게 들어가도록 설정 */
      .profile {
          width: 100%;
          height: 100%;
          object-fit: cover;
      }

      /* 사진 옆에 사용자 정보 위치하도록 설정 */
      .profile-box {
          display: flex;
          align-items: center;
      }
          
      .profile-info {
          margin-left: 10px;
      }
      
      .profile-info p {
      		font-size: 12px;
          color: black;
      }
      /* 마이페이지 스타일 끝  */
      
      #closeButton {
      	cursor: pointer;
      }
      
.header_active {
	color: #AAC4FF;
}
      
</style>

<body>
	<header style="justify-content: center; display: flex">
		<table style="max-width: 1280px; min-width:800px; width: 100%;">
			<tr>
				<td colspan="4"></td>
				<td></td>
				<td style="justify-content: end; display: flex; font-size: 12px; color: gray;">
					<c:if test="${ empty loginMember }">
						<span id="login" style="cursor: pointer">
							로그인
						</span> 
						&nbsp; | &nbsp; 
						<span id="signUp" style="cursor: pointer">
							회원가입
						</span>
					</c:if>
					<c:if test="${ not empty loginMember }">
						<span id="logout" style="cursor: pointer">
							로그아웃
						</span> 
						&nbsp; | &nbsp;
						<span class="mobile-menu" id="myPage" style="cursor: pointer">
							마이페이지
						</span>
					</c:if>
				</td>
			</tr>
			<tr>
				<td>
					<a href="${ path }/">
						<img id="logo" src="${path}/resources/images/Logo.png" 
							style="width: 120px; cursor: pointer">
					</a>
				</td>
				<td>
					<span id="service" style="cursor: pointer">서비스 소개</span>
				</td>
				<td>
					<span id="program" style="cursor: pointer">프로그램</span>
				</td>
				<td>
					<span id="community" style="cursor: pointer">커뮤니티</span>
				</td>
				<td>
					<span id="customerService" style="cursor: pointer">고객센터</span>
				</td>
				<td></td>
			</tr>
		</table>
	</header> 
	
	<!-- 마이페이지 -->
     <section style="width: 100%; justify-content: center; display: flex">
          <div id="dimmed"></div>
          <div class="menuwrap">
          <div class="mypage" style="text-align: left" >
               <!--  X 버튼 -->
               <div class="close-button" id="closeButton">&times;</div>
               
               <h1 style="text-align: center; margin-bottom: 23px;">마이페이지</h1>
     
               <div class="profile-box" style="padding-bottom: 10px;">
                    <div class="box" style="background: #BDBDBD; border: 2px solid black;">
                    	<c:if test="${ not empty loginMember.profileImg }">
	                     	<img class="profile" src="${ loginMember.profileImg }">
                    	</c:if>
                    	<c:if test="${ empty loginMember.profileImg }">
                    		<img class="profile" src="${ path }/resources/images/example.png">
                    	</c:if>
                    </div>
                    <div class="profile-info">
                         <p>${loginMember.name}</p>
                         <p>${loginMember.email}</p>
                    </div>
               </div>
     
               <p>회원정보</p>
               <button type="submit" id="myInfo">회원정보 수정</button><br>
               <button type="submit" id="">비밀번호 변경</button><br>
               
               <p>프로그램</p>
               <button type="submit" id="made">내가 만든 모임</button><br>
               <button type="submit" id="myentry">내가 참여한 모임</button><br>
               
               <p>고객센터</p>
               <button type="submit" id="common" onclick="location.assign('${ path }/customerService/faq');">자주묻는질문</button><br>
               <button type="button" id="notice" onclick="location.assign('${ path }/customerService/notice');">공지사항</button><br>
               <button type="submit" id="qna" onclick="location.assign('${ path }/customerService/qna');">문의하기</button><br>
               <button type="submit" id="myqna">내 문의보기</button><br> 
          </div>

     </div>
</section>
	
<script>
	const page = '<%= request.getRequestURI() %>';
	console.log(page);
	
	switch(page){
	case '/YOLO/views/service/introduction.jsp':
		$('#service').addClass("header_active");
		break;
	case '/YOLO/views/program/oneDay.jsp':
	case '/YOLO/views/program/club.jsp':
	case '/YOLO/views/program/challenge.jsp':
		$('#program').addClass("header_active");
		break;
	case '/YOLO/views/community/freeBoard.jsp':
	case '/YOLO/views/community/meetingReview.jsp': 	
		$('#community').addClass("header_active");	
		break;
	case '/YOLO/views/customerservice/FAQ.jsp':
	case '/YOLO/views/customerservice/notice.jsp':
	case '/YOLO/views/customerservice/noticeCreate.jsp':
	case '/YOLO/views/customerservice/qnaAdmin.jsp':
	case '/YOLO/views/customerservice/qna.jsp':
	case '/YOLO/views/customerservice/FAQcreate.jsp':
		$('#customerService').addClass("header_active");
		break;
	}

	$(document).ready(() => {
		$('#login').on('click', () => {
			location.assign('${ path }/member/login');
		});
		
		$('#signUp').on('click', () => {
			location.assign('${ path }/member/createAccount');
		});
		
		$('#program').on('click', () => {
			location.assign('${ path }/program/oneDay');
		});
		
		$('#service').on('click', () => {
         	location.assign('${ path }/service/introduction');
      	});
		
		$('#customerService').on('click', () => {
			location.assign('${ path }/customerService/faq');
		});
			
		$('#community').on('click', () => {
			location.assign('${ path }/community/freeBoard');
		});
		
		$('#logout').on('click', () => {
			location.assign('${ path }/member/logout');
		});
		
		$('#myqna').on('click', () => {
			location.assign('${ path }/customerService/qnalist');
		});
		
		$('#myInfo').on('click', () => {
			location.assign('${ path }/mypage/mypage_myInfo');
		});

		$('#made').on('click', () => {
			location.assign('${ path }/made/meeting');
		});
		
		$('#myentry').on('click', () => {
			location.assign('${ path }/mypage/myentry');
		});
	  });
</script>

<!-- 마이페이지 -->
<script>
     document.addEventListener('DOMContentLoaded', function(){
     document.querySelector(".mobile-menu").addEventListener("click", function(e){
          if ( document.querySelector('.menuwrap').classList.contains('on') ){
               //메뉴닫힘
               document.querySelector('.menuwrap').classList.remove('on');
          } else {
               //메뉴펼침
               document.querySelector('.menuwrap').classList.add('on');

               //페이지 스크롤 락 레이어 추가
               let div = document.createElement('div');
               div.id = 'dimmed';
               document.body.append(div);

               //페이지 스크롤 락  모바일 이벤트 차단
               document.querySelector('#dimmed').addEventListener('scroll touchmove touchend mousewheel', function(e){
                    e.preventDefault();
                    e.stopPropagation();
                    return false;
               });
          }
     });  
               // X 버튼 클릭 이벤트 처리
               document.querySelector("#closeButton").addEventListener("click", function() {
               document.querySelector(".mobile-menu").click();
     });
     });
</script>