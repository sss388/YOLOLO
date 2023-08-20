<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<style>

#search_button {
	border: none;
	background-color: #AAC4FF;
	padding: 5px 10px;
	border-radius: 10px;
	color: #FFF;
   	transition: background-color 0.1s ease;
   	box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);
}

#search_button:hover {
	background-color: #668FD8;
}

</style>

<div style="z-index: 1; position: relative;">
	<form method="GET" id="search_form" action="">
		<input name="keyword" type="text" style="border-radius: 10px; padding: 2.5px 5px;" required>
		<button id="search_button">검색</button>
	</form>
</div>