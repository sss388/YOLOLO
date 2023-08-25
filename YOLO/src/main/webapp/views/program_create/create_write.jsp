<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.time.LocalDate" %>
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
     
     #coordinate input {
     width: 20%;
     height: 30px;
     border: 1px solid rgb(201, 201, 201);
     border-radius: 5px;
     }
     
     /* 버튼 */
     
     /* 주소검색 버튼 */
     #postcode_button {
          background-color: #AAC4FF; 
          color: white;  
          border: none;
          width: 75px;
          height: 30px;
          font-size: 15px;
          text-align: center;
          margin-bottom: 100px;
          border-radius: 10px;
          box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);
          cursor: pointer;
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
          background-color: #AAC4FF; 
          color: white;  
          border: none;
          width: 70px;
          height: 35px;
          text-align: center;
          font-size: medium;
          border-radius: 10px; 
          margin-bottom: 100px;
          cursor: pointer;
          box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);
     }

	#postcode_button:hover,
    #submit_btn input:hover {
         background-color: #668FD8;
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
		                        <td><input type="text" name="title" id="title" required="required"></td>
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
		                         <td>
		                         	<input type="date" name="start_date" id="start_date" min="<%= LocalDate.now().toString() %>"  required/>
		                         <!-- 
		                         <input type="text" name="start_date" id="start_date" placeholder=" YYYY/MM/DD형식으로 작성해주세요." 
		                         pattern="^(19|20)\d\d/(0[1-9]|1[012])/(0[1-9]|[12][0-9]|3[01])$" title=" YYYY/MM/DD형식으로 작성해주세요.">
		                          -->
		                         </td>
		                         
		                   </tr>
		               
		                   <tr>
		                         <th>모임 종료일</th>
		                         <td>
		                         	<input type="date" name="end_date" id="end_date" disabled required/>
		                         <!-- 
		                         <input type="text" name="end_date" id="end_date"  placeholder=" YYYY/MM/DD형식으로 작성해주세요."   
		                         pattern="^(19|20)\d\d/(0[1-9]|1[012])/(0[1-9]|[12][0-9]|3[01])$" title=" YYYY/MM/DD형식으로 작성해주세요.">
		                          -->
		                         </td>
		                   </tr>
		
							<tr>
								<th>모임 최대 인원</th>
								<td style="display: flex; align-items: center;">
									<input id="maximum" type="range" min="2" max="30" value="2" name="maximum">
									<div id="maximum_label" style="font-size: 20px;">2명</div> 
								</td>
							</tr>
					
		                   <tr>
			                    <th>상세설명</th>
			                    <td>
			                    	<textarea name="content" id="content" class="editor"></textarea>
			                    </td>
		                   </tr>
		         
		                   <tr>
							    <th>장소</th>
							    <td class="address"> 
							        <input type="text" name="address" id="address" placeholder="주소를 검색해주세요." readonly>
							        <input type="button" id="postcode_button" onclick="open_Postcode()" size="5" value="주소검색" style="margin-left: -8px">
							        <div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>							    
							    </td>   
		                   </tr>
		
		                   <tr id="coordinate" style="display: none;">
		                        <th>좌표</th>
		                        <td>
		                            위도:<input type="text" name="latitude" id="latitude">
		                            경도:<input type="text" name="longitude" id="longitude">
		                        </td>
		                   </tr>
		                   
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

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=874176aa26c8be96cf01e374fe87f3ed&libraries=services"></script>
<script>
	$('#maximum').on('input', function() {
    	$('#maximum_label').text($(this).val() + "명");
  	});

	$('#start_date').on('change', function() {
		let start_date = new Date($(this).val());
	    let end_date = new Date($('#end_date').val());
	    if (start_date > end_date) {
	        $('#end_date').val($(this).val());
	    }
		    
    	$('#end_date').attr('min', $(this).val());
    	$('#end_date').removeAttr('disabled');
	});

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });


    function open_Postcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("address").value = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                        
                        // 위도와 경도를 input 필드에 설정
                        document.getElementById("latitude").value = result.y;
                        document.getElementById("longitude").value = result.x;
                    }
                });
            }
        }).open();
    }
    
</script>


<script src="../resources/js/ckeditor/script.js"></script>
<jsp:include page="/views/common/footer.jsp" />