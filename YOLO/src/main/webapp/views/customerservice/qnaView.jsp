<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>
<jsp:include page="/views/common/header.jsp" />

<!-- 문의하기 상세페이지 -->

<style>
	section {
	    max-width: 100%;
	    text-align:center;
	    margin-top: 20px;
    }
    
    #fQna_detail{
         text-align: left;
    }
    
    #Qna_detail table tr td:first-child {
         text-align: center;
    }
    
    #btn button {
         background-color: rgb(170, 196, 255); 
         color: white;  
         border: none;
         width: 80px;
         height: 35px;
         text-align: center;
         font-size: medium;
         border-radius: 10px; 
         cursor: pointer;
    }
</style>

<section id="Qna_detail">   
     <div style="width: 100%; justify-content: center; display: flex" >
     <div style="border:1px solid #ddd; margin-bottom: 30px; padding-top: 30px; border-radius: 10px; width: 600px; " > 
          <h2>문의내용</h2>
          <h5 style="text-align: right;">${ board.createDate }</h5>
          
          <div style="justify-content: center; display:flex;">
               <table style="width: 100%; text-align: left;">
                    <tr>
                         <td >이름</td>
                         <td>${ board.name }</td>
                    </tr>

                    <tr>
                         <td >이메일</td>
                         <td>${ board.email }</td>
                    </tr>

                    <tr>
                         <td >휴대폰번호</td>
                         <td>${ board.phone }</td>
                    </tr>

                    <tr>
                         <td >문의유형</td>
                         <td>${ board.type }</td>
                    </tr>

               </table>
          </div>
          
          <div style="padding: 0 5%; padding: 30px 5%;">
               <div style="border-bottom: 1px solid #ddd; padding: 15px 5%;">
                    <div style="border-top: 1px solid #ddd; min-height: 300px;">
                         <p>문의내용</p>
                         <div id="content">${ board.content }</div>
                    </div>
                    
                    <c:if test="${ not empty loginMember && ((loginMember.no == item.userNo) || (loginMember.role == 1)) }">
                         <div id="btn">
                              <button onclick="location.href='${ path }/customerService/update?no=${ board.no }'">수정하기</button>
                              <button type="button" id="btnDelete">삭제하기</button>
                         </div>
                    </c:if>
           </div>

           <div style="padding: 0 5%; padding: 30px 5%;">
           		<h2>답변내용</h2>
		    	<c:choose>
		        <c:when test="${board.reply == 'N'}">
		        	<div style="margin-bottom: 10px">
		        	아직 답변이 등록되지 않았습니다.
		        	</div>
		        </c:when>
		        <c:otherwise>
		            <h5 style="text-align: right;">${reply.createDate}</h5>
		            <div style="min-height: 300px;">
		                ${reply.content}
		            </div>
		        </c:otherwise>
		    	</c:choose>
		    
             	<div  id="btn">
                  	<button type="button" onclick="location.href='${ path }/customerService/qnalist'">목록으로</button>
             	</div>
          </div>
     </div>
</section>
<script>
	$(document).ready(() => {
		$('#btnDelete').on('click', () => {
			if (confirm('게시글을 삭제 하시겠습니까?')) {
				location.replace('${ path }/customerService/delete?no=${ board.no }');
			}
		});
	});
</script>

<jsp:include page="/views/common/footer.jsp" /> 