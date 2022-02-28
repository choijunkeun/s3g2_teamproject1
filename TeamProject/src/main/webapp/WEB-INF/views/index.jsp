<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 목업 코드 -->
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
<<<<<<< HEAD
<<<<<<< HEAD
	최준근 첫번째 깃 연습
=======
		<div>
			
=======
		<div class="uppernav pt-5" style="display:inline;">
			<c:choose>
				<c:when test="${empty user }">
					<div class="btn">Login</div>
					<div class="btn">Join</div>
				</c:when>
				<c:otherwise>
					<div class="btn bg-primary">Logout</div>
					<div class="membersection p-2" style="white-space: nowrap; float:right; ">
						<span class="badge bg-danger rounded-pill">Lv. ${user.user_honbabLevel }</span>
						<div class="form-control" style="display: inline;">${user.user_nickname } 님</div>
						<img style="border-radius: 50px; width: 30px; height: 30px;" src="http://placehold.co/100x100">
					</div>
				</c:otherwise>
			</c:choose>
>>>>>>> branch 'dev' of https://github.com/choijunkeun/s3g2_teamproject1.git
		</div>
		<div class="header text-center p-4" style="font-size: 5rem;">
			일인분
		</div>
		<nav class="nav justify-content-center rounded" style="background: #DDDDDD">
			<a class="btn" href="/search">혼밥추천</a>
			<a class="btn" href="/brag">혼밥자랑</a>
			<a class="btn" href="#">반찬공유</a>
			<a class="btn" href="#">커뮤니티</a>
		</nav>
<<<<<<< HEAD
>>>>>>> branch 'main' of https://github.com/choijunkeun/s3g2_teamproject1.git
=======
>>>>>>> branch 'dev' of https://github.com/choijunkeun/s3g2_teamproject1.git
	</div>
	<div style="width: 100%; align-content: center;" >
		<c:if test="${not empty cpage }">
			<jsp:include page="${cpage }.jsp" />
		</c:if>
	</div>
	<script>
	
		$(function(){
			$('.btn').click(function(){
				alert("와 테스트에요");
			})
		})
	</script>
</body>
</html>