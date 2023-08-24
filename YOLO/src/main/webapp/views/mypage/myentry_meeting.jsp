<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<jsp:include page="/views/common/header.jsp" />

<section style="justify-content: center; display: flex;">
	<div style="width: 100%; min-width: 800px; max-width: 1280px;
	justify-content: center; display: flex; margin: 50px 0">
		<h1 style="text-align: center; font-size: 2em; color: #AAC4FF; margin-bottom: 50px;">
			내가 참여한 모임
		</h1>
	</div>
</section>
	
<jsp:include page="/views/common/footer.jsp" />	
