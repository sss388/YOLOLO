<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<style>
#comment button {
	font-size: 16px;
   	border: none;
   	background: none;
   	cursor: pointer;
   	background-color: #AAC4FF; 
   	padding: 7.5px 15px;
   	border-radius: 10px;
   	color: #FFF;
   	transition: background-color 0.1s ease;
   	box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);
}	

#comment button:hover {
  	background-color: #668FD8;
}

#modifyCommentButton,
#deleteCommentButton {
	font-size: 16px;
	cursor: pointer;;
}

#modifyCommentButton:hover {
	color: skyblue;
}

#deleteCommentButton:hover {
	color: orangered;
}
</style>

<section id="comment">
	<div>
		<c:forEach var="item" items="${ comment_list }">
			<div id="normal_comment_${ item.no }" style="padding: 0 2.5%; margin-top: 5px; display: flex;">
				<table style="width: 100%;">
					<tr>
						<th width="10%" style="text-align: center;">
							${ item.userName }
						</th>
						<td>
							${ item.content }
						</td>
						<c:if test="${ (loginMember.no == item.userNo) || (loginMember.role == 1) }">
							<td width="10%" style="text-align: right;">
								<span onclick="modifyCommentButton(${item.no})">
									<i id="modifyCommentButton" class="fa-solid fa-pen"></i>
								</span>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<span onclick="deleteCommentButton(${item.no})">
									<i id="deleteCommentButton" class="fa-solid fa-trash-can"></i>
								</span>
							</td>
						</c:if>
					</tr>
				</table>
			</div>
	
			<div id="modify_comment_${ item.no }" style="padding: 0 2.5%; display: none; margin-top: 25px;">
				<div style="background-color: #EEF1FF; width: 100%; display: flex; padding: 25px;
				border-radius: 10px; padding-bottom: 10px;">
					<div style="width: 5%;">
						${ item.userName }
					</div>
					<form method="POST" action="${ path }/community/modifyComment"
						style="width: 95%; justify-content: flex-end; display: flex;">
						<div style="width: 95%; display: inline-block;">
							<input name="comment_no" value="${ item.no }" hidden>
							<textarea name="content" style="width: 97.5%; border-radius: 10px; resize: none; padding: 5px;" maxlength="100" rows="3">${ item.content }</textarea>
							
							<div style="justify-content: flex-end; display: flex; margin-top: 10px;">
								<button style="margin-right: 2.5%;">수정</button>
								<button type="button" onclick="cancelModifyCommentButton(${ item.no })">취소</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</c:forEach>
	</div>
	
	<c:if test="${ not empty loginMember }">
		<div id="create_comment" style="padding: 0 2.5%; display: flex; margin-top: 25px;">
			<div style="background-color: #EEF1FF; width: 100%; display: flex; padding: 25px;
			border-radius: 10px; padding-bottom: 10px;">
				<div style="width: 5%;">
					${ loginMember.name }
				</div>
				<form method="POST" action="${ path }/community/commentSave"
					style="width: 95%; justify-content: flex-end; display: flex;">
					<div style="width: 95%; display: inline-block;">
						<input name="board_no" value="${ board.no }" hidden>
						<textarea name="content" style="width: 97.5%; border-radius: 10px; resize: none; padding: 5px;" maxlength="100" rows="3"></textarea>
						
						<div style="justify-content: flex-end; display: flex; margin-top: 10px;">
							<button>등록</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</c:if>
	<form id="delete_comment_form" method="POST" action="${ path }/community/deleteComment" hidden>
		<input type="text" id="delete_comment_no" name="delete_comment_no" />
	</form>
</section>

<script>

const deleteCommentButton = (no) => {
	$('#delete_comment_no').val(no);
	$('#delete_comment_form').submit();
}

const modifyCommentButton = (no) => {
	$('#create_comment').css('display','none');
	$('#modify_comment_'+no).css('display','flex');
	$('#normal_comment_'+no).css('display','none');
}

const cancelModifyCommentButton = (no) => {
	$('#create_comment').css('display','flex');
	$('#modify_comment_'+no).css('display','none');
	$('#normal_comment_'+no).css('display','flex');
}

</script>