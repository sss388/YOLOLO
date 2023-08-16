<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />
<link rel="stylesheet" type="text/css" href="../resources/css/ckeditor.css">

<!-- 모임만들기 글쓰기 -->

<style>
     section {
     text-align:center;
     }

     section #joinform input {
     margin:7px;
     }
     
     section #joinform table {
     	
     }

     section #joinform table td {
          padding:0  5px; 
          text-align:left;
     }
     
    .create_write th, .create_write td {
     padding: 10px;
     border-bottom: 1px solid rgb(150, 150, 150);
	}

     .create_write th {
          text-align: center;
          background-color: rgb(238, 241, 255);
          
     }
     
     /*  input */
     input {
     width: 50%;
     height: 30px;
     border: 1px solid rgb(201, 201, 201);
     border-radius: 5px;
     }
     
     /* 버튼 */
     /* 주소검색 버튼 */
     #postcode_button {
          background-color: rgb(170, 196, 255); 
          color: white;  
          border: none;
          width: 75px;
          height: 30px;
          font-size: 15px;
          text-align: center;
          margin-bottom: 100px;
          border-radius: 10px;
     }

     /* 등록버튼 */
     #btn1, #btn2, #btn3 {
          background-color: rgb(170, 196, 255); 
          color: white;  
          border: none;
          width: 55px;
          height: 30px;
          font-size: 15px;
          text-align: center;
          border-radius: 10px;
     }

	#submit_btn{
		margin-top: 25px;
	}

     /* 맨밑 등록 , 취소 버튼 */
     #submit_btn input {
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

     #submit_btn input:hover {
          background-color: #D2DAFF;
     }

     #submit_btn input:active {
          background-color: #B1B2FF;
     }
     
               
</style>
     
<section>
	<div style="display:flow; justify-content: center; padding-bottom: 100px;">
		<div style="min-width: 1100px; max-width: 1280xp;">
			<h1 align="center">모임만들기</h1>
			<div id="joinform" style="justify-content: center; display: flex; width: 100%; ">
				<form action="${ path }/program_create/createwrite" method="POST" enctype="multipart/form-data">
					<table class="create_write">
		                   <tr>
		                        <th>모임명</th>
		                        <td><input type="text" name="title" id="title"></td>
		                   </tr>
		
		                   <tr>
		                        <th>작성자</th>
		                        <td>
		                            <input type="text" name="writename" id="writename" value="${ loginMember.name }" readonly
		                            style="border:none;">
		                        </td>
		                   </tr>
		
		                   <tr>
		                        <th>대표이미지</th>
		                        <td>
		                        	<input type="file" name="main_file" style="border:none">
		                         </td>
		                    </tr>
		
		                    <tr>
		                         <th>카테고리</th>
		                         <td>
		                              <select name="category" id="category">
		                                   <option value="oneday">원데이</option>
		                                   <option value="club">클럽</option>
		                                   <option value="challenge">챌린지</option>
		                              </select>
		                         </td>
		                    </tr>
		
		                     <tr>
		                         <th>모임 시작일</th>
		                         <td><input type="text" name="start_date" id="start_date" placeholder=" YYYY/MM/DD형식으로 작성해주세요." 
		                         pattern="^(19|20)\d\d/(0[1-9]|1[012])/(0[1-9]|[12][0-9]|3[01])$" title=" YYYY/MM/DD형식으로 작성해주세요."></td>
		                    </tr>
		               
		                    <tr>
		                         <th>모임 종료일</th>
		                         <td><input type="text" name="end_date" id="end_date"  placeholder=" YYYY/MM/DD형식으로 작성해주세요."  
		                         pattern="^(19|20)\d\d/(0[1-9]|1[012])/(0[1-9]|[12][0-9]|3[01])$" title=" YYYY/MM/DD형식으로 작성해주세요."></td>
		                    </tr>
		
		                    <tr>
			                    <th>상세설명</th>
			                    <td>
			                    	<textarea name="content" id="content" class="editor"></textarea>
			                    </td>
		                    </tr>
		                   
		
		                   <!-- 
		
		                   <tr>
		                        <th>장소</th>
		                        <td class="address"> 
		                              <input type="text" name="address" id="address" placeholder=" 주소 검색해주세요.">
		                              <input type="button" id="postcode_button" onclick="open_Postcode()" size="5" value="주소검색" style="margin-left: -8px">
		                        </td>   
		                   </tr>
		
		                   <tr>
		                        <th>좌표</th>
		                        <td><input type="text" name=""" id="""></td>
		                   </tr>
		                   
		                    -->
							
		                   <tr>
		                        <th>포함 사항(선택)</th>
		                        <td>
		                        	
							        <input type="text" name="inclusion" id="inclusion" placeholder=" ','으로 구분해서 넣어주세요.">
							        <!--
							        <input type="button" id="btn1" value="등록" style="margin-left: -5px" onclick="addToList('inclusion', 'inclusion_List')">
							        <ul id="inclusion_List"></ul>
							          -->
		                        </td>
		                   </tr>
		
		                   <tr>
		                        <th>불포함 사항(선택)</th>
		                        <td>
							        <input type="text" name="noninclusion" id="noninclusion" placeholder=" ','으로 구분해서 넣어주세요.">
		                       		 <!--
							        <input type="button" id="btn2" value="등록" style="margin-left: -5px" onclick="addToList('noninclusion', 'noninclusion_List')">
							        <ul id="noninclusion_List"></ul>
							          -->
		                        </td>
		                   </tr>
		
		                   <tr>
		                        <th>준비물(선택)</th>
		                        <td>
							        <input type="text" name="supplies" id="supplies" placeholder=" ','으로 구분해서 넣어주세요.">
		                        	<!-- 
							        <input type="button" id="btn3" value="등록" style="margin-left: -5px" onclick="addToList('supplies', 'supplies_List')">
							        <ul id="supplies_List"></ul>
							         -->
		                        </td>
		                   </tr>
		             </table>
		                   
		             <div id="submit_btn">
		                  <input type="submit" id="refind" value="등록">
		                  <input type="reset" id="createAccount" value="취소">
		             </div>
				</form>
			</div>
		</div>
	</div>
</section>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


<script src="../resources/js/ckeditor/script.js"></script>
<jsp:include page="/views/common/footer.jsp" />