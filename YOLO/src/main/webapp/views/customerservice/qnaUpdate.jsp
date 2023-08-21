<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />

<link rel="stylesheet" type="text/css" href="../resources/css/ckeditor.css">

<!-- 문의하기 수정하기  -->

<style>

	div#board-write-container
	{
		width: 1280px;
		margin:0 auto;
		text-align:center;
	}
	
	div#board-write-container h2
	{
		margin:10px 0;
	}
	
	table#tbl-board
	{
		width:1050px;
		margin:0 auto;
		border-collapse:collapse;
	}
	
	/*제목*/
	table#tbl-board th
	{
		width:300px;
		border:1px solid;
		padding:5px 0;
		text-align:center;
		background-color: rgb(238, 241, 255);
	}
	
	/* 내용 나오는 칸 */
	table#tbl-board td
	{
		width: 800px;
		border:1px solid;
		padding:5px 0 5px 10px;
		text-align:left;
	}
	
	h2 {
		color : #AAC4FF;
		text-align:center;
		font-size: 2em;
	}
	
	/*수정,삭제,목록으로 버튼*/
	input[type="submit"], input[type="button"] {
          background-color: rgb(170, 196, 255); 
          color: white;  
          border: none;
          width: 70px;
          height: 30px;
          text-align: center;
          font-size: medium;
          border-radius: 10px; 
    }
    
</style>
<section id="content">
	<div id='board-write-container'>
		<h2>내 문의글 수정하기</h2>
		<form action="${ path }/customerService/update" method="POST">
		<%-- enctype를 multipart로 보내면 서블릿 post에서 parameter를 변경해준다 --%>
		<input type="hidden" name="no" value="${ board.no }">
			<table id='tbl-board'>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" id="title" value="${ board.title }"></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td><input type="text" name="writer" value="${ board.writerNo }" readonly></td>
				</tr>
				<tr>
				</tr>	
				<tr>
					<th>내용</th>
					<td><textarea name="content" class="editor" cols="50" rows="15" >${ board.content }</textarea></td>
				</tr>
				<tr>
					
					 <th colspan="2">
						<input type="submit" onclick="location.href='${ path }/customerService/update?no=${ board.no }" value="수정">
						<input type="button" id="btnDelete" value="삭제">
						<input type="button" onclick="location.replace('${path}/customerService/qnalist')" value="목록으로">
					 </th>
			    </tr>
				
			</table>
		</form>
	</div>
</section>
<script>
$(document).ready(() => {
   $('#fileDown').on('click', () => {
			let oname = encodeURIComponent('${ board.originalFilename }');
			let rname = encodeURIComponent('${ board.renamedFilename }');
			
			console.log(oname, rname);
			
			location.assign('${ path }/board/fileDown?oname=' + oname + '&rname=' + rname);
		});
	
	$('#btnDelete').on('click', () => {
		if (confirm('게시글을 삭제 하시겠습니까?')) {
			location.replace('${ path }/customerService/delete?no=${ board.no }');
		}
	});
});

</script>

<script src="../resources/js/ckeditor/script.js"></script>
<jsp:include page="/views/common/footer.jsp" />