<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<style>
footer td {
    padding-top: 12px;
    text-align: left;
}

footer tr:not(:first-child) td {
	color: black;
}

footer a {
	color: black;
}

</style>

<footer style="display: flex; justify-content: center;">
	<table style="min-width: 800px; max-width: 1280px; width: 100%; font-weight: bold; font-size: 12px;">
		<tr style="color: #AAC4FF">
			<td style="width: auto">욜로 정보</td>
			<td style="width: auto">소셜미디어</td>
			<td style="width: auto; padding-top: 0px; padding-right: 10%">
				<div style="justify-content: center; display: flex;">
					<a href="https://www.youtube.com/">
						<img src="https://cdn.icon-icons.com/icons2/1907/PNG/512/iconfinder-youtube-4555888_121363.png"
							style="width: 32px; height: 32px;">
					</a>

					<a href="https://www.instagram.com/">
						<img src="https://png.pngtree.com/png-clipart/20230401/original/pngtree-three-dimensional-instagram-icon-png-image_9015419.png"
							 style="width: 32px; height: 32px;">
					</a>

					<a href="https://ko-kr.facebook.com/">
						<img src="https://t1.daumcdn.net/cfile/tistory/994EAB4F5D2565432F"
							 style="width: 32px; height: 32px;">
					</a>

					<a href="https://www.twiter.com/">
						<img src="https://cdn.icon-icons.com/icons2/1109/PNG/512/1486053611-twitter_79195.png"
							 style="width: 32px; height: 32px;">
					</a>

					<a href="https://www.naver.com/">
						<img src="https://clova-phinf.pstatic.net/MjAxODAzMjlfOTIg/MDAxNTIyMjg3MzM3OTAy.WkiZikYhauL1hnpLWmCUBJvKjr6xnkmzP99rZPFXVwgg.mNH66A47eL0Mf8G34mPlwBFKP0nZBf2ZJn5D4Rvs8Vwg.PNG/image.png"
							 style="width: 32px; height: 32px;">
					</a>
				</div>
			</td>
			<td style="width: 28%;">
				주식회사 욜로
			</td>
		</tr>
		<tr>
			<td>
				<span id="mynotice" style="cursor: pointer">공지사항</span>
			</td>
			<td>
				<a href="https://www.instagram.com/">인스타그램</a>
			</td>
			<td></td>
			<td rowspan="4" style="padding-top: 0px; font-weight: normal;
				justify-content: start; opacity: 60%; font-size: 10px">
				대표 : 하이미디어 | 개인정보관리책임자 : 이명준 <br>
				이메일 : munto@munto.kr | 대표번호 : 070-7606-4793 <br>
				주소 : 서울시 서대문구 연세로 8-1 버티고타워 7층 <br>
				사업자등록번호 : 846-86-01452 | 통신판매 : 제 2022-서울시-00623 <br>
				고객센터 : @카카오톡채널 | 운영 시간 : (월~일) 오전 09:30 ~ 오후 6:00 <br>
			</td>
		</tr>
		<tr>
			<td>이벤트</td>
			<td>
				<a href="https://m.blog.naver.com/Recommendation.naver">네이버블로그</a>
			</td>
		</tr>
		<tr>
			<td>
				<span id="mycommon" style="cursor: pointer">자주 묻는 질문</span>
			</td>
		</tr>
		<tr>
			<td>제휴 및 입점 문의</td>
		</tr>
		<tr>
			<td>채용</td>
			<td colspan="2"></td>
			<td style="padding-top: 0px">
				이용약관 |
				사용자 처리 방식 |
				사업자 정보 확인
			</td>
		</tr>
	</table>
</footer>

</body>
</html> 
<script>
    $(document).ready(() => {
        $('#mynotice').on('click', () => {
            location.href = '${path}/customerService/notice';
        });

        $('#mycommon').on('click', () => {
            location.href = '${path}/customerService/faq';
        });
    });
</script>