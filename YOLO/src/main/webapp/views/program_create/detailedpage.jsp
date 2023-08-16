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
	<div style="width: 100%; justify-content: center; display: flex; width: 800px; width: 1280px;">
		<div>
			<div style="width: 600px;">
				<table>
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
			</div>
			
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
			
			<div style="width:80%;">
				<table>
					<dl>
						<dt>'YOLO'는 어떤 서비스인가요?</dt>
						<dd>
							"YOLO"는 같은 관심사, 같은 취향을 가진 인접 지역 사람들과 만나는 '취미 모임'서비스 입니다.<br>
							취미 모임을 통해 오프라인 정모로 만나 함께 취미 활동을 즐기며 워라밸을 찾고 소확행 할 수 있습니다.<br>
							개인이 원하는 관심사의 모임을 찾아 가입해 활동하거나 또는 직접 모임장이 되어 모임을 개설하여 운영할 수도 있습니다.
						</dd>
				
						<dt>환불 정책</dt>
						<dd>
						✅[원데이/챌린지]<br>

모임 진행이 완료된 후 차주 수요일에 정산이 진행되므로, 환불 관련 처리는 모임 완료일 기준 차주 화요일까지 완료되어야 해요!<br>

환불 규정은 유료 모임 신청 및 취소 페이지에서도 확인하실 수 있습니다. 😊<br>

<br><br>



신결제 후 30분 경과 전: 전액 환불<br>
참가 신청 후 승인이 완료되지 않은 경우: 전액 환불<br>
승인 후 호스트에 의해 내보내진 경우: 전액 환불<br>
참여 확정 모임의 진행일 기준 4일 전까지: 전액 환불<br>
참여 확정 모임의 진행일 기준 3일 전부터: 환불 불가 (ex. 1월 7일 토요일에 진행되는 모임의 경우 1월 4일 수요일부터 환불 불가)<br>
모임 진행 당일에 신청한 경우: 환불 불가<br>

<br><br>
📌다음의 경우에는 자동으로 환불이 진행돼요! 개별적으로 취소할 경우 자동 환불이 되지 않으니 꼭 참고해주세요!<br>
<br>
소셜링 승인이 거절되었을 경우<br>
호스트가 내보내기를 진행했을 경우<br>
호스트가 소셜링을 폐강하거나 인원 미달로 자동 폐강될 경우<br>
<br><br>

📌다음의 경우에는 모임 진행 전 문토 카카오톡 고객센터로 연락주시면 문지기가 직접 상세 내용을 확인한 후 환불을 도와드려요!<br>
<br>
모임 정보가 변경된 경우(날짜, 장소, 인원 수, 활동 내용 등)<br>
소셜링 진행 3시간 전까지 소셜링 채팅방에 진행 여부(모임 장소 및 시간)에 대한 공지가 없는 경우<br>
외부 인원이 소셜링에 참여하거나, 모임 진행 전 연락처 등 개인정보를 요구하는 경우<br>
(1차 경고 후 수정되지 않을 시 환불)<br>


<br><br><br>

✅[클럽]<br>
<br>
활동비가 설정되어 있는 클럽의 경우 결제일 기준 다다음달 첫째주 수요일에 정산이 진행됩니다.<br>

따라서 환불 관련 처리는 매달 첫째주 화요일까지 완료해주세요!<br>

<br><br>

결제 후 30분 경과 전: 전액 환불<br>
참가 신청 후 승인이 완료되지 않은 경우: 전액 환불<br>
승인 후 호스트에 의해 내보내진 경우: 전액 환불<br>
결제일 14일 이내 클럽을 탈퇴할 경우: 전액 환불<br>
결제일 14일 경과 후 클럽을 탈퇴할 경우: 환불 불가<br>
호스트의 이용 정지 제재로 인해 클럽 활동이 불가한 경우: 정상적인 클럽 활동이 불가능하다고 인정되는 경우 전액 환불<br>

<br><br>
🤔환불 금액이 아직 확인되지 않아요!<br>

환불은 PG사 승인 취소 기간에 따라 주말, 공휴일을 제외한 영업일 기준 최대 3~5일 소요될 수 있어요.<br>

욜로 시스템에서 정상적으로 환불 처리가 되었음에도 해당 기간이 지난 후에도 카드 결제 취소가 완료되지 않았을 경우 카드사에 문의 부탁드립니다🙇<br><br>
						</dd>
				
						<dt>유의사항</dt>
						<dd>
						✅ 소셜링 참가비에 대한 추가적인 주의사항!<br>
<br>
소셜링 진행에 포함되는 모든 비용(식비, 음료비 등)이 참가비에 포함되어야 해요!<br>
소셜링이 끝나고 진행되는 '뒷풀이'는 1/n을 할 수 있는 기준에 모두 부합하는 경우에만 참가비에서 제외할 수 있으며, 그렇지 않을 경우 소셜링의 일부라고 판단되어 모든 비용을 참가비로 설정해주셔야 해요!<br>
욜로를 통해 진행하지 않고 멤버들끼리 개인적으로 결제 또는 입금을 진행하는 경우 가이드에 위반될 수 있으며, 문제가 발생할 경우 욜로가 별도의 조치를 취해드리기 어려워요😥<br>
노쇼비는 최소 [10,000원] 이상으로만 설정하실 수 있으며, 노쇼비는 유료 소셜링 정산과 동일하게 욜로 수수료가 공제된 후 정산됩니다.<br><br>
<br>
✅ 기타<br>
<br>
■ 단순 홍보 금지🗣️<br>

욜로 앱 내에서 취향과 관심사 중심의 교류가 목적이 아닌 특정 제품이나 서비스의 홍보 및 이벤트를 진행하거나 권유하는 행위는 엄격히 금지되고 있어요.<br>
다단계 영업, 제사 권유, 사행성 또는 사기성 행위 등을 시도하는 유저는 발견 즉시 영구 정지 처리되며, 관련된 모든 소셜링이나 게시물은 삭제됩니다.<br><br>
■ 1:1 소셜링 제한🚫<br>

욜로는 취향과 관심사를 다 함께 나누는 것을 지향하므로, 모든 소셜링은 모임 시간 기준 3시간 전까지 최소 3명 이상이 모였을 때에만 진행이 가능해요.<br><br>
■ 별도의 신청폼 활용 금지❌<br>
소셜링 신청이 완료된 멤버들에게 별도의 신청 과정을 추가로 요구하는 것은 금지됩니다. 신청 폼이나 면접 등의 과정은 삼가해주세요!🙏🏻<br><br>
■ 개인 정보 보호🛡️<br>
멤버들끼리 충분히 신뢰가 쌓이지 않은 상태에서 연락처, SNS 계정, 주소, 개인 사진 등의 개인 정보를 주고 받을 경우 문제가 발생할 수 있으므로, 소중한 개인 정보는 묻지도 말고 알려주지도 말아주세요!<br>
승인제 소셜링의 신청 질문을 통해 위에서 언급한 개인 정보를 물어보는 것은 엄격하게 금지됩니다. 혹시 개인정보를 물어보는 소셜링이 있다면 문지기들에게 꼭 알려주세요!<br><br>
■ 종교/사주 관련 소셜링 제한<br>

욜로에서 종교 포교는 엄격히 금지하고 있으며, 발견 즉시 영구 정지 조치되고 있어요.<br>
종교 관련 소셜링에서 발생되는 다양한 이슈들을 미연에 방지하고자 종교/사주 관련 활동을 함께 하는 소셜링 또한 제한하고 있어요.<br><br>
■ 참가자 특성에 따른 참가비 차등 적용 제한<br>

성별, 나이 등 참가자의 특성에 따라 참가비를 다르게 책정하는 것은 욜로가 추구하는 커뮤니티 방향성에 부합하지 않습니다😥<br>
💡 가이드를 준수하지 않는 소셜링이 발견될 경우 문지기들에 의해 폐강됩니다.<br>
<br><br>


						</dd>
				    </dl>
				</table>
				
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