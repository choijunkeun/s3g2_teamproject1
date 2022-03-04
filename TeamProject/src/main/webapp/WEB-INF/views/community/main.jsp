<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>MVC 게시판</title>
<style type="text/css">
.container-comm {
	margin: 10px auto;
	padding: 20px auto;
	background-color: #f6f3f3
}
.fa {
	font-size: 20px;
}
.commboard, .notiboard {
	font-size: 14px;
}

a {
	text-decoration-line: none;
	color: black;
}

</style>

</head>

<body>
	<!-- 공지사항 리스트 -->
	<h2 class="fa fa-exclamation-circle">공지사항 </h2>
	<button class="btn btn-outline-dark" type="button" style="float:right; "
	onclick="location.href='comm/boardlistN'">더보기</button>
	
	
	<div class="container-comm">
		<!-- Content here -->
		<!-- 임시 공지사항 -->
		<div class="container">
			<div class="column notiboard">
			
			<a href="/comm/boardlistN/1" >
				<div class="row">1. 커뮤니티 게시판 이용가이드1 .1ver
					<div class="col" style="text-align: right;">2022-02-22 18:20</div>
				</div>
			</a>
			
			<a href="/comm/boardlistN/2" >
				<div class="row">2. [Event]나혼자SSul다 - 혼자 살 때의 에피소드를 올려주세요!
					<div class="col" style="text-align: right;">2022-02-22 18:30</div>
				</div>
			</a>
			
			<a href="/comm/boardlistN/3" >
				<div class="row">3. 자취방 구하기 꿀팁
					<div class="col" style="text-align: right;">2022-02-22 19:28</div>
				</div>
			</div>
			</a>
		</div>
	</div>

	<br><br>
	
	<h2 class="fa fa-exclamation-circle">커뮤니티 </h2>
	<button class="btn btn-outline-dark" type="button" style="float:right; "
	onclick="location.href='comm/boardlist'">더보기</button>

	
	<div class="container-comm">
		<!-- Content here -->
		<div class="container">
			<div class="row commboard" style="text-align: center;">
				<div class="col">No</div>
				<div class="col-5" style="text-align: left;">제목</div>
				<div class="col" >작성자</div>
				<div class="col-2" >작성일</div>
				<div class="col" >조회수</div>
				<div class="col" >추천수</div>
			</div>
			
			<!-- 임시 게시물 -->
			<a href="/comm/boardlist/1" >
				<div class="row commboard" style="text-align: center;">
					<div class="col">1</div>
					<div class="col-5" style="text-align: left; ">혼자사는 꿀팁!</div>
					<div class="col" >혼밥고수</div>
					<div class="col-2" >2022-02-22 02:28</div>
					<div class="col" >45</div>
					<div class="col" >20</div>
				</div>
			</a>
			
			<a href="/comm/boardlist/2" >
			<div class="row commboard" style="text-align: center;">
				<div class="col">2</div>
				<div class="col-5" style="text-align: left;">종량제 쓰레기 봉투 버릴 때</div>
				<div class="col" >촤인뀨</div>
				<div class="col-2" >2022-02-22 02:28</div>
				<div class="col" >1</div>
				<div class="col" >2</div>
			</div>
			</a>
		</div>
	</div>














	<!-- 게시판 (미구현) -->
</body>
</html>