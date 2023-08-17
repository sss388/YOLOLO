<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>
<jsp:include page="/views/common/header.jsp" />

	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
	<style>
		
		.wrap {
            width: 1280px;
            text-align: center;
        }
		aside {
            width: 20%;
            height: 100%;
            box-sizing: border-box;
            float: left;

        }
        #sect1 {
            width: 60%;
            height: 100%;
            box-sizing: border-box;
            float: left;

        }
        #sect2 {
            width: 20%;
            height: 100%;
            box-sizing: border-box;
            float: left;
        }
        .pic1 {
        	margin-top: 50px;
        }
        .pic {
        	text-align: center;
        }
        h1 {
		color: #AAC4FF;
		}
		header button{
		border: none;
		font-size: 20px;
		margin-top: 100px;
		padding: 0 30px;
		cursor: pointer;
		border-radius: 10px;
	}
	body > p{text-align:center; padding:0 50px 50px 0;}
        
	</style>

	<section style="justify-content: center; display: flex;">
		<div class="wrap">
		<aside></aside>
		<article id="sect1">
			<header>
				<button onclick="fnMove('1')">Yolo란?</button>
				<span style="color: #B1B2FF;">|</span>
				<button onclick="fnMove('2')">멤버들의 한마디</button>
				<span style="color: #B1B2FF;">|</span>
				<button onclick="fnMove('3')">모임만들기</button>
			</header>
			
			<span><img class="pic1" src="${ path }/resources/images/1.jpg"></span>
			<div>
				<div id="section1"><h1 style="font-size: 2em;">You Only Live Once</h1></div>
				
				<h5>: 인생은 한번뿐이다</h5>
				<h5>: 욜로 모이다 (여기로 모이다의 경상도 사투리)</h5>
				<h3>우리 사이트를 이용하는 모든 고객들이 현재 자신의 행복을 가장 중시하며 미래 또는 타인을 위해<br> 희생하지 않고
	현재를 행복하게 소비하는 라이프스타일을 가졌으면 하는 마음에<br> YOLO라는 이름으로 탄생하게 되었습니다.<br>
	지금 바로 시작해보세요!! </h3>
			</div>
			
			
			<br><br><br><br><br>
			
			<div>
			<div id="section2"><h1 style="font-size: 2em;">욜로 멤버들의 한마디 !</h1></div>
			
			<h5 >욜로의 이런점이 좋아요</h5>
			</div>
			<div class="swiper mySwiper">
		   	    <div class="swiper-wrapper">
		        <div class="swiper-slide"><img class="pic1" src="${ path }/resources/images/int1.jpg"></div>
		        <div class="swiper-slide"><img class="pic1" src="${ path }/resources/images/int2.jpg"></div>
		        <div class="swiper-slide"><img class="pic1" src="${ path }/resources/images/int3.jpg"></div>
		        <div class="swiper-slide"><img class="pic1" src="${ path }/resources/images/int4.jpg"></div>
		        <div class="swiper-slide"><img class="pic1" src="${ path }/resources/images/int5.jpg"></div>
		    </div>
			    <div class="swiper-button-next"></div>
			    <div class="swiper-button-prev"></div>
			</div>
			
			<br><br><br><br><br>
			
			<div id="section3"><h1 >모임 만들기</h1></div>
			
			<div style="justify-content: center; display: flex; margin-top: -25px">
                    <div style="width: 40%; display: flex; flex-direction: column; align-items: center;">
                        <a href="http://localhost:8090/YOLO/program_create/createwrite"><img src="${ path }/resources/images/example2.png"></a>
                        <br>
                        <b>모임 만들기</b>
                        <p style="text-align: center; opacity: 80%; font-size: 14px">
                            지금 당장 무언가 같이 하고 싶은 친구가 필요한가요?<br>
                            지금 바로 모임을 만들어 보세요
                        </p>
                    </div>
                    <div style="width: 40%; display: flex; flex-direction: column; align-items: center;">
                        <a href="http://localhost:8090/YOLO/program/oneDay"><img src="${ path }/resources/images/example3.png" ></a>
                        <br>
                        <b>모임 참여하기</b>
                        <p style="text-align: center; opacity: 80%; font-size: 14px">
                            내가 모임을 만들기 부담스럽다면<br>
                            누군가 만든 모임에 참여해 보면 어떤가요?!
                        </p>
                    </div>
                </div>
		
		</article>
		<article id="sect2"></article>
		</div>
	</section>
	
	<br><br><br><br><br><br><br><br>
	<p><a href="#" id="scrollTop"><img src="${ path }/resources/images/top.jpg"></a></p>
	<br><br><br>
	
	
	<script>
	function fnMove(seq){
		//offset() 좌표값,위치
		//var 변수 선언
		var offset = $("#section"+seq).offset();
		$("html, body").animate({
			scrollTop : offset.top-10
		},400);
	}
	
    var swiper = new Swiper(".mySwiper", {
      navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
      },
    });
    
    $(document).ready(() => {
    	$('#create_write').on('click', () => {
    		location.assign('${ path }/program_create/createwrite');
    	});

		
    });
    </script>

<jsp:include page="/views/common/footer.jsp" />