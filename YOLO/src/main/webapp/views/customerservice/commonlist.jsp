<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />
<!DOCTYPE html>
<html>
<head>
<style>
  #tbl-board {
    border-collapse: collapse;
    width: 100%;
    border: 1px solid white;
  }
  <%-- #tbl-board th, td {
    border: 1px solid black;
    padding: 8px;
    text-align: center;
  } --%>
     section {
     max-width: 100%;
     text-align:center;
     }
	
	dl{width:600px;}
	dt{height:30px; background:#AAC4FF; color:#fff; font-weight:bold; border-bottom:1px solid #ccc; text-indent:20px;}/*text-indent 들여쓰기*/
	dd{margin:0; background:#D2DAFF; padding:50px;}
	dt.over{background:#AAC4FF; cursor:pointer;}
	dt.selected{background:#AAC4FF; cursor:default;}/*cursor:default; 기본 커서*/
</style>
</head>
<body>
<section>
<div style="display:flex; justify-content: center; padding-bottom: 100px;">
	
<!-- 사이드바 추가 -->
<jsp:include page="/views/common/sidebar3.jsp"/>
		
<div style="width: 100%; max-width: 1280px">
<h1 style="text-align: center; font-size: 2em; color: #AAC4FF;">자주묻는질문</h1>
<div id="board-list-container">
	<table id="tbl-board" style="justify-content: space-between; width: 100%; border: 1px solid #ddd;">
  		<dl border="1" style="width:100%; border-color: #D2DAFF;">
						<dt id="text1">🤟 'YOLO' 내의 서비스에 대해 자세히 설명해주세요.</dt>
						<dd>
✔️세상 모든 경험의 시작, 욜로(YOLO)는 취미 여가 플랫폼입니다.<br>
누구나 원하는 취미 여가를 쉽고 당연하게 즐길 수 있도록, <br>
세상을 더 경험할 수 있도록 도와주는 서비스 플랫폼입니다.<br>
						</dd>
						<dt id="text2">🤟 원데이, 클럽, 챌린지 차이점이 뭔가요??</dt>
						<dd><br>
✔️원데이(ONEDAY)는 1회성 참여가 가능하여 욜로 서비스를 처음 접하는 회원 분들이 부담없이 이용하기 좋은 서비스입니다.<br>
✔️클럽(CLUB)은 같은 지역, 같은 취미를 가진 멤버들과 정기적으로 참여할 수 있도록 소셜 네트워크를 만들어주어 서비스입니다.<br>
✔️챌린지(challenge)는 같은 목표를 가진 멤버들끼리 함께 도전하며 성취감을 얻어갈 수 있는 서비스입니다.<br>
						</dd>
						<dt id="text3">🤟 'YOLO' 모임은 누가 진행하나요?</dt>
						<dd><br>
✔️'YOLO' 회원이라면 누구나 메인페이지 및 소개페이지에 있는 모임 생성하기 버튼을 통해 개설할 수 있습니다.<br>
이제 혼자하지말고 욜로 모여서 같이하세요^^<br>
						</dd>
						<dt id="text4">🤟 비회원도 'YOLO'를 이용할 수 있나요?</dt>
						<dd>
✔️'YOLO'는 회원 개개인의 정보 보안에 힘쓰고 있습니다.<br>
비회원 분들의 참여는 조금 어려우니 회원가입 후 이용을 부탁드리겠습니다.
						</dd>
						<dt id="text5">🤟 'YOLO' 내의 패널티에 대해 궁금합니다.</dt>
						<dd>
✔️모임참여를 누르고 당일 펑크를 낼 시 경고가 주어지며,
여러차례 반복이 되면 회원 탈퇴가 될 수 있음을 안내드립니다.
						</dd>
						<dt id="text6">🤟 비밀번호를 잊었는데 어떻게 찾나요?</dt>
						<dd>
✔️로그인 페이지의 비밀번호 찾기를 통해 암호화된 비밀번호를 받아볼 수 있습니다.
						</dd>
						<dt id="text7">🤟 회원 탈퇴는 어떻게 하나요?</dt>
						<dd>
✔️나의 정보 수정 밑에 있는 버튼으로 회원 탈퇴가 가능합니다.
						</dd>
						<dt id="text8">🤟 'YOLO' 모임 신청 방법이 궁금해요.</dt>
						<dd>
✔️모임 참여하기 버튼을 통해 참여하고싶은 모임 상세페이지로 가게되면 참가하기 버튼이 있습니다.<br>
참가하기 버튼을 누른 뒤, 마이페이지 -> 내가 참여한 모임에서 신청한 모임을 확인하실 수 있습니다.
						</dd>
						<%-- 
						 <dt id="text9">🤟 </dt>
						<dd>
✔️
						</dd>
						<dt id="text10">🤟 </dt>
						<dd>
✔️
						</dd>
						 --%>
			</dl>
</table>
</body>
</html>
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
</script>

<jsp:include page="/views/common/footer.jsp" />