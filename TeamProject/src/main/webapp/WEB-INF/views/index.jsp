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
		<div class="uppernav pt-5" style="display:inline;"> <!-- uppernav는 나중에라도 쓸 것 같아서 임의로 붙인 클래스 -->
			<c:choose>
				<c:when test="${empty user }">
					<div class="btn">Login</div>
					<div class="btn">Join</div>
				</c:when>
				<c:otherwise>
					<div class="btn bg-primary">Logout</div>
					<div class="membersection p-2" style="white-space: nowrap; float:right; "> <!-- membersection도 나중에 쓸 것 같아서 임의로 붙인 클래스 -->
						<span class="badge bg-danger rounded-pill">Lv. ${user.user_honbabLevel }</span>
						<div class="form-control" style="display: inline;">${user.user_nickname } 님</div>
						<img style="border-radius: 50px; width: 30px; height: 30px;" src="http://placehold.co/100x100">
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="header text-center p-4" style="font-size: 5rem;">
			<a href="/" style="text-decoration: none;">일인분</a> 
		</div> <!-- 임시로 넣은 헤더영역 -->
		<nav class="nav justify-content-center rounded" style="background: #DDDDDD">
			<a class="btn" href="/search">혼밥추천</a>
			<a class="btn" href="/brag">혼밥자랑</a>
			<a class="btn" href="#">반찬공유</a>
			<a class="btn" href="#">커뮤니티</a>
		</nav>
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