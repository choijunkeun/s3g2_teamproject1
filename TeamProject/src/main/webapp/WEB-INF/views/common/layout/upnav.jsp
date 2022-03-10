<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!-- 목업 코드, 아래 영역을 주석처리하면 로그아웃 처리된 것으로 짜볼 수 있음 -->
<%@ page import="com.ilinbun.mulcam.dto.User"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	.membersection {
		white-space: nowrap; 
		float: right;
	}
</style>
</head>
<body>
	<div class="container px-4 px-lg-5" style="max-width: 1200px; height: auto;">
		<div class="justify-content-center">
			<c:choose>
				<c:when test="${empty user }">
					<a href="/login"><div class="btn">Login</div></a>
					<a href="/join"><div class="btn">Join</div></a>
				</c:when>
				<c:otherwise>
					<a href="/logout"><div class="btn">Logout</div></a>
					<div class="membersection py-1">
						<!-- membersection도 나중에 쓸 것 같아서 임의로 붙인 클래스 -->
						<span class="badge bg-danger rounded-pill">Lv.${user.honbabLevel }</span>
						<div class="border pb-2 pt-1 rounded" style="display: inline;">${user.nickname } 님</div>
						<a href="../myPage"><img style="border-radius: 50px; width: 30px; height: 30px;"
							src="/profile/${user.profileImg }"></a>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</body>
</html>