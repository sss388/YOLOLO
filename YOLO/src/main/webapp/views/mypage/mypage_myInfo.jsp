<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />

<!-- 회원정보 수정  -->
<style>
     section {
          justify-content: center; 
          display: flex;
     }

     section #joinform input {
          margin:7px;
     }
     
     section #joinform table {
          margin: auto;
     }
     
     section #joinform table td {
          padding:0  5px; 
          text-align:left;
     }

     .join th, .join td {
          padding: 10px;
     }

     .join th {
          text-align: center;
          background-color: rgb(238, 241, 255);
          
     }
     
     .join tr {
     	border-bottom: 1px solid rgb(150, 150, 150);
     }
     
     .join {
     	border-collapse: collapse;
     }

     /* input  */
     /* input 전체 */
     input:not(#name, #postcode, #postcode_button) {
          width: 400px;
          height: 30px;
          border: 1px solid rgb(201, 201, 201);
          border-radius: 5px;
     }
     
     #name, #postcode, #postcode_button {
     	height: 30px;
          border: 1px solid rgb(201, 201, 201);
          border-radius: 5px;
     }
     
     /* 주소 input */
     .address  input{
          margin-bottom: 15px;
     }
     #postcode {
          width: 70px;
     }


     /* 이메일 */
     select{
          height: 30px;
     }


     /*    버튼   */
     /* 주소검색 버튼, 중복확인 버튼 */
     #postcode_button {
          background-color: rgb(170, 196, 255); 
          color: white;  
          border: none;
          width: 70px;
          box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);
          cursor: pointer;
     }
     
     #postcode_button:hover,
     #btnJoin:hover {
     	background-color: #668FD8;
     }
     
     /* 회원탈퇴 버튼 */
     #btnDelete{
          background-color: rgb(210, 218, 255); 
          color: white;  
          border: none;
          font-size: 5px;
          margin: 10px 0px 10px;
          border-radius: 10px;
          box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);
     }

     /* 회원가입 버튼 */
     #btnJoin {
        background-color: rgb(170, 196, 255); 
        color: white;  
        border: none;
        padding: 7.5px 20px;
        margin-bottom: 100px;
        border-radius: 10px;
        transition: background-color 0.1s ease;
        font-size: 20px;
    	box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);
     }
     
     #profile_img {
     	border-radius: 50px; 
     	border: 2px solid black; 
     	height: 100px; 
     	overflow: hidden;
     	position: relative;
     	user-select: none;
     	cursor: pointer;
     }
     
     #profile_img img{
     	width: 100%;
     	height: 100%;
     	object-fit: cover;
     }
     
    #profile_img.hover-image {
		display: block;
		width: 200px;
		height: 200px;
	}

	/* 배경색 */
	.hover-image:hover {
		filter: brightness(50%);
		transition: 0.3s ease-in-out;
	}
	
	.hover-text {
	  	display: none;
	  	position: absolute;
	  	top: 50%;
	  	left: 50%;
	  	transform: translate(-50%, -50%);
	  	opacity: 0.8;
	  	font-size: 16px;
	  	font-weight: bold;
	  	color: white;
	  	text-align: center;
	  	transition: 0.3s ease-in-out;
	}

</style>

<section>
     <div id="joinform" style="width: 100%; min-width: 800px; max-width: 1280px;
		justify-content: center; display: flex; margin: 50px 0">
		<div style="width: 100%; text-align: center;">
	    <h1 align="center">회원 정보 수정</h1>
        <form action="${ path }/myInfo/update" method="POST">
               <table class="join">
                    <tr>
                         <!-- 아이디는 변경 못하도록하고 아이디값만 가져오도록 함 -->
                         <th>아이디</th>
                         <td>&nbsp;${loginMember.userId}</td>
                         <td rowspan="2" width="100px">
                         	<div id="profile_img">
                         		<c:if test="${ empty loginMember.profileImg }">
                         			<img class="hover-image" src="${path}/resources/images/example.png">
                         		</c:if>
                         		<c:if test="${ not empty loginMember.profileImg }">
                         			<img class="hover-image" src="${ loginMember.profileImg }">
                         		</c:if>
                         		<div class="hover-text">사진 변경</div>
                         	</div>
                         	<input type="file" id="profile_img_select" hidden>
                         	<input type="text" id="profile_img_blob" name="profile_img_blob" hidden>
                         	
                         </td>
                    </tr>
                    
                    <tr>
                         <th>이름</th>
                         <td><input type="text" name="name" id="name" value="${loginMember.name}" required></td>
                    </tr>
     
                    <!-- 주소 -->
                    <tr>
                         <th>주소</th>
                         <td class="address" colspan="2" style="">
                              <input type="text" name="postcode" id="postcode" placeholder="우편번호" size="5" value="${loginMember.postcode}" readonly > 
                              <input type="button" id="postcode_button" onclick="open_Postcode()" 
                                             size="5" value="주소검색" style="margin-left: -8px">
                              <br>
                              <input type="text" name="address1" id="address1" placeholder="기본 주소" value="${loginMember.address1}" readonly>
                              <br>
                              <input type="text" name="address2" id="address2" placeholder="나머지주소(선택입력가능)" value="${loginMember.address2}">
                         </td>   
                    </tr>
     
                    <tr>
                         <th>휴대전화</th>
                         <td colspan="2">
                         	<input type="text" name="phone" id="phone" maxlength="13" value="${loginMember.phone}" placeholder =" '-'는 뺴고 입력해주세요." required>
                         </td>
                         
                    </tr>
     
                    <tr>
                         <th>이메일</th>
                         <td colspan="2"><input type="email" name="email" id="email" value="${loginMember.email}" required>
                    </tr>
               </table>
               
               <div>
                    <small style="color: rgb(150, 148, 148); font-size: 5;">회원정보를 삭제하시겠어요?</small>
                    <button type="button" id="btnDelete">회원탈퇴</button>
               </div>
               
               <div class="button">
                    <button type="submit" id="btnJoin">수정하기</button>
               </div>
     
          </form>
          </div>
     </div>
</section>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>

	$('#profile_img').on('click', function() {
		$('#profile_img_select').click();
	});
	
	$("#profile_img_select").on("change", function() {
		// 파일 선택 확인
		if (this.files && this.files[0]) {
			let file = this.files[0];

		    // FileReader 객체 생성
		    let reader = new FileReader();

		    reader.onload = function(event) {
				let dataURL = event.target.result; // Base64로 인코딩된 이미지 데이터
			    $(".hover-image").attr("src", dataURL); // img 태그에 데이터 설정
			    $("#profile_img_blob").val(dataURL);
		    };

		    // 파일을 읽어 Base64로 인코딩
		    reader.readAsDataURL(file);
		}
	});
	
	$('#profile_img').on('mouseover', () => {
		$('.hover-text').css('display', 'block');
		$('.hover-image').css('filter', 'brightness(50%)');
	});
	
	$('#profile_img').on('mouseleave', () => {
		$('.hover-text').css('display', 'none');
		$('.hover-image').css('filter', 'brightness(100%)');
	});

	// 탈퇴하기
	$(document).ready(() => {
		$('#btnDelete').on('click', () => {
			if (confirm('정말로 탈퇴하시겠습니까?')) {
				location.replace('${ path }/member/delete');
			}
		});
	});
	
    // 핸드폰 번호 - 자동으로 추가되도록 설정
	$('#phone').on('keyup', () => {
	   let phoneNum = $('#phone').val().replace(/-/g, '');
	   if (phoneNum.length >= 4 && phoneNum.length <= 7) {
	        phoneNum = phoneNum.replace(/(\d{3})(\d{1,4})/, '$1-$2');
	   } else if (phoneNum.length >= 8) {
	        phoneNum = phoneNum.replace(/(\d{3})(\d{4})(\d{1,4})/, '$1-$2-$3');
	   }
	   $('#phone').val(phoneNum);
	});
		

     // 주소검색
     function open_Postcode() {
          new daum.Postcode({
               oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = ''; // 주소 변수
                    var extraAddr = ''; // 참고항목 변수

                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                         addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                         addr = data.jibunAddress;
                    }

                    // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                    if(data.userSelectedType === 'R'){
                         // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                         // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                         if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                         extraAddr += data.bname;
                         }
                         // 건물명이 있고, 공동주택일 경우 추가한다.
                         if(data.buildingName !== '' && data.apartment === 'Y'){
                         extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                         }
                         // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                         if(extraAddr !== ''){
                         extraAddr = ' (' + extraAddr + ')';
                         }
                         // 조합된 참고항목을 해당 필드에 넣는다.
                         document.getElementById("address").value = extraAddr;
                    
                    } else {
                         document.getElementById("address").value = '';
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('postcode').value = data.zonecode;
                    document.getElementById("road_address").value = addr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById("address").focus();
               }
          }).open();
     }

</script>


<jsp:include page="/views/common/footer.jsp" />
    