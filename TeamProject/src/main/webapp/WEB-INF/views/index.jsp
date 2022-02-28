<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<div>
<<<<<<< HEAD
	최준근 첫번째 깃 연습
=======
		<div>
			
		</div>
		<div class="header text-center">
			일인분
		</div>
		<nav class="text-center" style="background: #CCCCCC">
			<a class="btn" href="/brag">혼밥자랑</a>
		</nav>
>>>>>>> branch 'main' of https://github.com/choijunkeun/s3g2_teamproject1.git
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