<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 목업 코드, 아래 영역을 주석처리하면 로그아웃 처리된 것으로 짜볼 수 있음 -->
<%@ page import = "com.ilinbun.mulcam.dto.User" %>
<%!
	User user = new User("mockup@mock.up", "목업", "", "#", 5, 1);
%>
<c:set var="user" value='<%=user %>'/>
<!-- 목업 코드 -->

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일인분</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	
</head>
<body style="max-width: 1200px; margin: 0 auto;">
	<div>
		
	</div>
	<div style="width: 100%; align-content: center;" >
		<c:if test="${not empty cpage }">
			<jsp:include page="${cpage }.jsp" />
		</c:if>
	</div>
	<script>
	
		$(function(){
			
		})
	</script>
</body>
</html>