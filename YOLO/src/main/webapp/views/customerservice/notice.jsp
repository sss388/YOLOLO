<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />

<link rel="stylesheet" type="text/css" href="../resources/css/ckeditor.css">

<style>
    .title{
        width: 50%;
    }

    .board th, .board td{
        padding: 10px 0;
    }
    
    .board td{
        opacity: 80%;
    }

    .board tr:not(:last-child) {
        border-bottom: 1px solid #ddd;
    }
    
    .board tr:not(:first-child){
    	cursor: pointer;
    }
    
    .board tr:not(:first-child):hover{
    	background-color: #D2DAFF;
    }

    .board {
        border-collapse: collapse;
        border: 1px solid #000;
    }
    
    .pagenation {
    	font-size: 20px;
    	border: none;
    	background: none;
    	color: gray;
		opacity: 60%;
    	cursor: pointer;
    }
    
    .pagenation:disabled {
    	color: #AAC4FF;
    	opacity: 100%;
    	text-decoration: underline;
    }
    
    .pagenation_direct {
    	font-size: 20px;
    	border: none;
    	background: none;
    	color: #AAC4FF;
    	cursor: pointer;
    }
    
    .create_button {
    	font-size: 20px;
    	border: none;
    	background: none;
    	cursor: pointer;
    	background-color: #AAC4FF; 
    	padding: 7.5px 15px;
    	border-radius: 10px;
    	color: #FFF;
    	margin-right: 5%;
    	transition: background-color 0.1s ease;
    	box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);
    }
    
    .create_button:hover {
    	background-color: #668FD8;
    }
    
    .board .delete:hover {
    	color: red;
    }
    section#board-list-container{width:600px; margin:0 auto; text-align:center;}
	section#board-list-container h2{margin:10px 0;}
    table#tbl-board{width:100%; margin:0 auto; border:1px solid black; border-collapse:collapse; clear:both; }
	table#tbl-board th, table#tbl-board td {border:1px solid; padding: 5px 0; text-align:center;}
	
	.current_board {
    	border-collapse: collapse;
    } 
    
    .current_board tr:not(:last-child) {
        border-bottom: 1px solid #ddd;
    }
    
    .current_board button {
    	padding: 10px 20px;
    	margin: 0 1%;
    	border-radius: 10px;
    	cursor: pointer;
    	transition: transform 0.01s ease-in;
    	color: white;
    }
    
    .current_board button:active {
    	transform: scale(1.2);
    }
    
    #current_board_title {
    	border: none;
    	font-size: 16px;
    	text-align: center;
    	border-radius: 10px;
    	outline: none;
    }
    
    #create_title {
    	border: none;
    	font-size: 16px;
    	text-align: center;
    	border-radius: 10px;
    	outline: 2px solid black;
    }

	#content {
		background: white;
		border-radius: 10px;
		overflow: auto;
		padding: 20px;
		text-align: left;
	}
	
	#content .image {
		text-align: center;
	}
	
	#content .text-big {
		font-size: 16px;
	}
	
	#content .text-huge {
		font-size: 20px;
	}
</style>

<section id="notice" style="justify-content: center; display: flex;">
    <div style="width: 100%; min-width: 800px; max-width: 1280px;
		justify-content: center; display: flex; margin: 50px 0">
		<jsp:include page="/views/common/sidebar3.jsp" /> 
        <div style="width: 100%; text-align: center;">
            <h3 style="color: #AAC4FF; font-size: 2em; margin: 50px 0;">
            	<i class="fa-solid fa-circle-exclamation fa-beat" style="color: #AAC4FF;"></i>&nbsp;공지사항
           	</h3> 
           	
           	<c:if test="${ not empty currentBoard }">   
    			<jsp:include page="/views/customerservice/noticeDetail.jsp" />
           	</c:if>
           	
           	<c:if test="${ not empty param.keyword }">
           		<c:if test="${ list.size() == 0 }">
           			<h2 style="text-align: center; margin-bottom: 50px;">검색 결과가 없습니다.</h2>
           		</c:if>
           		<c:if test="${ list.size() != 0 }">
					<h2 style="text-align: center; margin-bottom: 50px;">"${ param.keyword }"의 검색 결과는 ${ list.size() }개 입니다.</h2>
				</c:if>
           	</c:if>
           	
            <table class="board" style="justify-content: space-between; width: 100%; border: 1px solid #ddd;">
                <tr>
                    <th>글번호</th>
                    <th width="70%">제목</th>
                    <th>등록일</th>
                </tr>
                <c:if test="${ not empty list }">
	                <c:forEach var="board" items="${ list }">
		                <tr>
		                    <td onclick="handleClickBoard(${board.no})">${ board.rowNum } </td>
		                    <td onclick="handleClickBoard(${board.no})">${ board.title }</td>
		                    <td onclick="handleClickBoard(${board.no})">${ board.createDate }</td>
		                    <c:if test="${ loginMember.role == 1 }">
		                    	<td class="delete">
		                    		<i class="fa-regular fa-trash-can" onclick="deleteNotice(${ board.no })"></i>
		                    	</td>
		                    </c:if>
		                </tr>
	                </c:forEach>
                </c:if>
                <c:if test="${ empty list }">
                	<tr>
                		<td colspan="4">
                			게시글이 없습니다.
                		</td>
                	</tr>
                </c:if>
            </table>
            
            <br>
           
	            <div style="position: relative; justify-content: center; display: flex; align-items: center;">
	             	<c:if test="${ loginMember.role == 1 }">
		            	<div style="position: absolute; width: 100%; text-align: right;">
		            		<button type="button" class="create_button" onclick="createNoticeButton()">
		            			글쓰기
		            		</button>	
		            	</div>
		            </c:if>
	            	<jsp:include page="/views/common/search.jsp" />
	            </div>
            
            <!-- 맨 처음으로 -->
			<button class="pagenation_direct" onclick="location.href='${ path }/customerService/notice?page=1'">
				<i class="fa-solid fa-angles-left"></i>
			</button>

			<!-- 이전 페이지로 -->
			<button class="pagenation_direct" onclick="location.href='${ path }/customerService/notice?page=${ pageInfo.prevPage }'">
				<i class="fa-solid fa-angle-left"></i>
			</button>
            
            <c:forEach var="current" begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }">
            	<c:choose>
					<c:when test="${ current == pageInfo.currentPage }">					
						<button class="pagenation" disabled>${ current }</button>			
					</c:when>
					<c:otherwise>
						<button class="pagenation" 
							onclick="location.href='${ path }/customerService/notice?page=${ current }'">${ current }</button>			
					</c:otherwise>
				</c:choose>
            </c:forEach>
            
            <!-- 다음 페이지로 -->
			<button class="pagenation_direct" onclick="location.href='${ path }/customerService/notice?page=${ pageInfo.nextPage }'">
				<i class="fa-solid fa-angle-right"></i>
			</button>

			<!-- 맨 끝으로 -->
			<button class="pagenation_direct" onclick="location.href='${ path }/customerService/notice?page=${ pageInfo.maxPage }'">
				<i class="fa-solid fa-angles-right"></i>
			</button>
        </div>
    </div>
    <form id="delete_notice_form" method="POST" action="${ path }/customerService/noticeDelete" hidden>
    	<input type="text" id="delete_notice_no" name="delete_notice_no"/>
    </form>
</section>

<script>
let create = false;
let modify = false;

const handleClickBoard = (no) => {
	location.href='${ path }/customerService/notice?page=${ pageInfo.currentPage }&no=' + no;
}

const toggleModifyButton = () => {
	//$('#content_area').css('outline', '2px solid gray');
	if($('.modify_button').text() == '수정하기'){		
		//$('#content_area').css('outline', '4px solid #62CDFF');
		//$('#content_area').removeAttr('readonly');
		
		$('#content_update').css('display', 'flow');
		$('#content').css('display', 'none');
		
		$('.modify_button').css('background', 'inline-block');
		$('.modify_button').text('수정취소');
		$('#update_button').removeAttr('hidden');
		$('#current_board_title').removeAttr('readonly');
		$('#current_board_title').css('outline', '2px solid #62CDFF');
		
		//const editorContent = editor.getData(); // 에디터의 컨텐츠 가져오기		
		//$('.output').html(editorContent);
		
		editor.setData($(content).html());
		
	} else {
		//$('#content_area').css('outline', '2px solid black');
		
		$('#content_update').css('display','none');
		$('#content').css('display', 'flow');
		
		$('.modify_button').css('background', 'blue');
		$('.modify_button').text('수정하기');
		$('#update_button').attr('hidden', 'true');
		$('#current_board_title').attr('readonly', 'true');
		$('#current_board_title').css('outline', 'none');
	}
}

const updateContentButton = () => {
	$('#update_title').val($('#current_board_title').val());
	//console.log($('#update_title').val()); 
	
	$('#content_form').submit();
}

const deleteNotice = (no) => {
	$('#delete_notice_no').val(no);
	$('#delete_notice_form').submit();
}

const createNoticeButton = () => {
	location.href=`${ path }/customerService/noticeCreate`;
}

</script>

<script src="../resources/js/ckeditor/script.js"></script>
<jsp:include page="/views/common/footer.jsp" />
