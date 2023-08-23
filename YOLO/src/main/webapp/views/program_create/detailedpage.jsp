<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

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
	#btn_join,
	#btn_join_chk {
		background-color: rgb(170, 196, 255); 
		color: white;  
		width: 100px; 
		height: 50px;
		width: 100%;
		border: none;
		border-radius: 10px;
		font-size: 20px;
		box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);
		cursor: pointer;
	}
	
	#btn_join:hover,
	#btn_join_chk:hover {
		background-color: #668FD8;
	}
	
	/* 글자정렬 */
	h4{
	 text-align: left;
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

	.thumb_style {
		width: 100%; height: 300px; object-fit: cover; box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5); border-radius: 10px;
	}
	
	
	#modal_background {
		width: 100%; height: 100%;
		background: rgba(0,0,0,0.5);
		z-index: 100;
		position: fixed; 
		top: 0; left: 0;
		display: flex; 
		justify-content: center;
		align-items: center;
		display: none;
	}
	
	#entry_modal {
		width: 500px; 
		height: 500px; 
		background: white; 
		box-shadow: 4px 4px 4px rgba(0, 0, 0, 0.5); 
		border-radius: 10px; 
		border: 1px solid #ddd;
		justify-content: center; 
		display: flex;
	}
	
	#entry_empty {
		box-shadow: inset 2px 2px 2px rgba(0, 0, 0, 0.5); 
		width: 400px;
		height: 400px;
		border-radius: 10px;
		overflow: auto;
		justify-content: center; 
		align-items: center;
		display: flex;
	}
</style>

<section style="display: flex; justify-content: center;">
	<div style="width: 100%; justify-content: center; display: flex; padding: 50px; 2.5%;">
		<div style="width: 100%;">
			<table style="width: 100%;">
				<tr style="height: 300px;">
					<th id="inter1">
						<div style="margin-right: 25px;">
							<c:if test="${ empty program.thumb }">
								<img src="${path}/resources/images/example.png" class="thumb_style">
							</c:if>
							<c:if test="${ not empty program.thumb }">
								<img src="${path}/resources/upload/main_file/${ program.thumb }" class="thumb_style">
							</c:if>
						</div>
					</th>
					<th id="inter2" style="height: 60px; font-size: 20px; text-align: center;">
						  <div style="height: 60px; line-height: 60px;">${ program.title }</div>
					</th> 
					<!-- 모임 시작일/ 종료일 -->
					<th id="inter2" class="date" style="height: 150px;">
						<h5>모임 시작일</h5>
						<p>${ program.startDate }</p>
						<h5>모임 종료일</h5>
						<p>${ program.expireDate }</p>
					</th>
					<th id="inter2">
						<c:if test="${ loginMember.no == program.userno }">
							<input type="button" id="btn_join_chk" value="참가자 확인">
						</c:if>
						<c:if test="${ loginMember.no != program.userno }">
							<c:if test="${ entry_state == 0}">
								<input type="button" id="btn_join" value="참가하기">
							</c:if>
							<c:if test="${ entry_state == 1}">
								<input type="button" id="btn_join" value="취소하기">
							</c:if>
						</c:if>
					</th>
					<th id="inter2" style="display: flex; margin-top: 5px; height: 50px;">
						<div style="height:50px; width: 50px; overflow:hidden; border-radius: 50px; margin-right: 5px;">
							<img src="${ member.profileImg }" style="width:100%; height:100%; object-fit: cover;">
						</div>
						<div style="font-size: 16px; padding-top: 9.5px;">
							${ member.name }
						</div>
					</th>
				</tr>
			</table>

			<div style="display: flex;">				
				<div style="width: 75%;">
					<h4>세부정보</h4>
					<div style="text-align: left; min-height: 300px;">
						${ program.content }
					</div>
				</div>
				
				<div id="plus">
					<h4>포함 사항</h4>
					<p>- ${ program.inclusion }</p>
					<h4>불포함 사항</h4>
					<p>- ${ program.noninclusion }</p>
					<h4>준비물</h4>
					<p>- ${ program.supplies }</p>
				
				</div>
			</div>

			<!-- 지도 -->
			<div>
				<h4>모이는 장소</h4>
				<div id="map"  style="width: 100%; height: 350px"></div>
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
	
	<div id="modal_background">
		<div id="entry_modal">
			<div>
				<h1>참가자 명단</h1>
				<c:if test="${ empty entryMemberList }">
					<div id="entry_empty">
						참가자가 없습니다.
					</div>
				</c:if>
			</div>
		</div>	
	</div>
	<form id="entry_button" method="POST" action="${ path }/program/entry" hidden>
		<input type="text" value="${ loginMember.no }" name="user_no">
		<input type="text" value="${ program.no }" name="program_no">
	</form>
</section>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=874176aa26c8be96cf01e374fe87f3ed"></script>
<script>
	$('#btn_join').on('click', () => {
		if (confirm('참가하시겠습니까?')) {
			$('#entry_button').submit();
		}
	});
	
	$('#btn_join_chk').on('click', () => {
		$('#modal_background').css('display', 'flex');
	});
	
	$('#modal_background').on('click', (e) => {
		if (e.target == $('#modal_background')[0]) {
			$('#modal_background').css('display', 'none');			
		}
	});
	
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
	
	// 지도
	var mapContainer = document.getElementById('map');
    var mapOption = {
        center: new kakao.maps.LatLng(${program.latitude}, ${program.longitude}),
        level: 3
    };

    var map = new kakao.maps.Map(mapContainer, mapOption);

    var markerPosition = new kakao.maps.LatLng(${program.latitude}, ${program.longitude});

    var marker = new kakao.maps.Marker({
        position: markerPosition
    });

    marker.setMap(map);

</script>

