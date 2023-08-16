<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />

<!-- 회원가입  -->

<style>
     section {
          max-width: 100%;
          text-align:center;
          
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
          border-bottom: 1px solid rgb(150, 150, 150);
     }

     .join th {
          text-align: center;
          background-color: rgb(238, 241, 255);
          
     }

     /* input  */
     /* input 전체 */
     input {
          width: 250px;
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

     /* 휴대전화 */
     #phone1,#phone2, #phone3 {
          width: 50px;
          height: 30px;
          text-align: center;
          margin-left: 10px;
     }

     /* 이메일 */
     select{
          height: 30px;
     }


     /*    버튼   */
     /* 주소검색 버튼, 중복확인 버튼 */
     #postcode_button, #isUserIdExists, #isUserEmailExists {
          background-color: rgb(170, 196, 255); 
          color: white;  
          border: none;
          width: 70px;
     }
     
     #postcode_button:hover, #isUserIdExists:hover, #isUserEmailExists:hover, #btnJoin:hover {
        background-color: #D2DAFF;
        cursor: pointer;
     }
     
     #postcode_button:active, #isUserIdExists:active, #isUserEmailExists:active, #btnJoin:active {
     	background-color: #B1B2FF;
     }
     
     /* 회원가입 버튼 */
     #btnJoin {
          background-color: rgb(170, 196, 255); 
          color: white;  
          border: none;
          padding: 10px 30px;
          margin-bottom: 100px;
          border-radius: 10px;
          
     }

</style>

<section>
     <h1 align="center">회원가입</h1>

     <div id="joinform" style="width: 100%; justify-content: center; display: flex">
          <form action="${path}/member/createAccount" method="POST">
               <table class="join">
                    <tr>
                         <th>아이디</th>
                         <td>
                              <input pattern="^[a-zA-Z0-9]{4,16}$" title="4~16자의 영문 대소문자와 숫자로만 입력해주세요." 
                              	type="text" name="userId"  id="userId" placeholder="아이디를 입력해주세요."  required>
                              <input type="button" id="isUserIdExists" value="중복확인" style="margin-left: -8px">
                         </td>
                    </tr>
     
                    <tr>
                         <th>비밀번호</th>
                         <td>
                         	<input pattern="^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{4,16}$" title="4~16자의 영문자와 숫자를 포함하여 입력해주세요." 
                         		type="password" name="userpw"  id="userpw" placeholder="비밀번호를 입력해주세요." required>
                         </td>
                    </tr>
                    
                    <tr>
                         <th>비밀번호 확인</th>
                         <td>
                         	<input type="password" name="Rpw"  id="Rpw" required>
                         	<span id="passwordMatch" style="color: red;"></span>
                         </td>
                    </tr>
     
                    <tr>
                         <th>이름</th>
                         <td><input type="text" name="name"  id="name" required></td>
                    </tr>
     
                    <!-- 주소 -->
                    <tr>
                         <th>주소</th>
                         <td class="address"> 
                              <input type="text" name="postcode" id="postcode" placeholder="우편번호" size="5" readonly > 
                              <input type="button" id="postcode_button" onclick="open_Postcode()" size="5" value="주소검색"
                              		  style="margin-left: -8px">
                              <br>
                              <input type="text" name="address1" id="address1" placeholder="기본 주소" readonly>
                              <br>
                              <input type="text" name="address2" id="address2" placeholder="나머지주소(선택입력가능)">
                         </td>   
                    </tr>
     
                    <tr>
                         <th>휴대전화</th>
                         <td>
                              <select name="phone1" id="phone1">
                                   <option value="010" selected>010</option>
                              </select>
                              - 
                              <input type="text" name="phone2" id="phone2"  maxlength="4" required>
                              - 
                              <input type="text" name="phone3" id="phone3"  maxlength="4" required>
                         </td>
                    </tr>
     
                    <tr>
                         <th>이메일</th>
                         <td>
                         	<input type="email" name="email"  id="email" required>
                         	<input type="button" id="isUserEmailExists" value="중복확인" style="margin-left: -8px">
                         </td>
                    </tr>
               </table>
     
               <br>
               <div  class="button">
                    <button type="submit" id="btnJoin">회원가입</button>
               </div>
     
          </form>
     </div>
</section>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	// 아이디 중복 확인
	$(document).ready(() => {
		$('#isUserIdExists').on('click', () => {
			let userId = $('#userId').val().trim();
			
			if(userId === ''){
				alert('아이디를 입력해 주세요');
			} else {
				$.ajax({
					type: 'GET',
					url: '${ path }/member/Check',
					dataType: 'json',
					data: {
						userId // 'userId' : userId
					},
					success: (obj) => {
						console.log(obj);
						
						if(obj.duplicate) {
							alert('이미 사용중인 아이디 입니다.')
						} else {
							alert('사용 가능한 아이디 입니다.')							
						}
					},
					error: (error) => {
						console.log(error);
					}
				});
			}
		});
	});
	
	// 이메일 중복 확인
	$(document).ready(() => {
		$('#isUserEmailExists').on('click', () => {
			let email = $('#email').val().trim();
			
			if(email === ''){
				alert('이메일를 입력해 주세요');
			} else {
				$.ajax({
					type: 'GET',
					url: '${ path }/member/Check',
					dataType: 'json',
					data: {
						email 
					},
					success: (obj) => {
						console.log(obj);
						
						if(obj.duplicate) {
							alert('이미 존재하는 이메일 입니다.')
						} else {
							alert('사용 가능한 이메일 입니다.')							
						}
					},
					error: (error) => {
						console.log(error);
					}
				});
			}
		});
	});
	
	// 비밀번호 확인
	$(document).ready(function() {
    $('#Rpw').on('keyup', function() {
        var password = $('#userpw').val();
        var confirmPassword = $(this).val();
        var matchMessage = $('#passwordMatch');

        if (password === confirmPassword) {
            matchMessage.text('일치');
            matchMessage.css('color', 'green');
        } else {
            matchMessage.text('일치하지 않음');
            matchMessage.css('color', 'red');
	        }
	    });
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
                         document.getElementById("address2").value = extraAddr;
                    
                    } else {
                         document.getElementById("address2").value = '';
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('postcode').value = data.zonecode;
                    document.getElementById("address1").value = addr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById("address2").focus();
               }
          }).open();
     }
</script>

<jsp:include page="/views/common/footer.jsp" />
