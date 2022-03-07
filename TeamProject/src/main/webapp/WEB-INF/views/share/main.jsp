<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반찬공유 게시판</title>
<style type="text/css">
.container-share {
	margin: 10px auto;
	padding: 20px auto;
	background-color: #f6f3f3
}
.fa {
	font-size: 20px;
}
.shareboard, .notiboard {
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
	<h2 class="fa fa-exclamation-circle">공지사항</h2>
	<button class="btn btn-outline-dark" type="button" style="float:right; "
	onclick="location.href='share/boardlistN'">더보기</button>
	
	
	<div class="container-share">
		<!-- Content here -->
		<!-- 임시 공지사항 -->
		<div class="container">
			<div class="column notiboard">
			
			<a href="/comm/boardlistN/1" >
				<div class="row">1.  ★★★반찬공유 게시판 이용 가이드 1.1★★★
					<div class="col" style="text-align: right;">2022-02-22 18:20</div>
				</div>
			</a>
			
			<a href="/comm/boardlistN/2" >
				<div class="row">2. [INFO] 용산구 전통시장 할인 정보
					<div class="col" style="text-align: right;">2022-02-22 18:30</div>
				</div>
			</a>
			
			<a href="/comm/boardlistN/3" >
				<div class="row">3. [꿀팁] 음식물 깔끔하게 소분하는 법!!!
					<div class="col" style="text-align: right;">2022-02-22 19:28</div>
				</div>
			</div>
			</a>
		</div>
	</div>

	<br><br>
	
	<!-- 위치검색 쿼리 -->
        <div>
            <label for="location-subway">어디서 공유를 받고 싶으신가요?</label> <br>
            <select name="location" id="location-subway">
                <option value="">지역을 골라주세요!</option>
                <option value="용산역">용산역</option>
                <option value="효창공원역">효창공원역</option>
                <option value="남영역">남영역</option>
                <option value="삼각지역">삼각지역</option>
                <option value="숙대입구역">숙대입구역</option>
                <option value="이촌역">이촌역</option>
                <option value="서빙고역">서빙고역</option>
                <option value="한남역">한남역</option>
                <option value="한강진역">한강진역</option>
                <option value="이태원역">이태원역</option>
                <option value="녹사평역">녹사평역</option>
            </select>
            <button class="select button" type="button" value="검색">검색</button>
        </div>
        
       
       <a href="/share/writeform">
       <div style="float:right;">
       <button type="button" value="글쓰기">글쓰기</button>
       </div>
       </a>
       
       <br><br>
	
	<h2 class="fa fa-exclamation-circle">반찬공유 - 혼자 먹는 당신을 위해 나눠드립니다. </h2>
	<button class="btn btn-outline-dark" type="button" style="float:right; "
	onclick="location.href='share/boardlist'">더보기</button> <br>

	
	<div class="container-comm">
		<!-- Content here -->
		<div class="container">
			<div class="row shareboard" style="text-align: center;">
				<div class="col">No</div>
				<div class="col-6" style="text-align: left;">제목</div>
				<div class="col" >위치</div>
				<div class="col" >작성자</div>
				<div class="col-2" >작성일</div>
				<div class="col" >조회수</div>
				<div class="col" >추천수</div>
			</div>
			
			<!-- 임시 게시물 -->
			<a href="/share/boardlist/1" >
				<div class="row shareboard" style="text-align: center;">
					<div class="col">1</div>
					<div class="col-5" style="text-align: left; ">[공유완료] 콩나물 너무 많이 사버렸어요~~</div>
					<div class="col" >서울역</div>
					<div class="col" >혼밥고수</div>
					<div class="col-2" >2022-02-22 02:28</div>
					<div class="col" >45</div>
					<div class="col" >20</div>
				</div>
			</a>
			
			<a href="/share/boardlist/2" >
			<div class="row shareboard" style="text-align: center;">
				<div class="col">2</div>
				<div class="col-5" style="text-align: left;">[공유중] 삼각지 선착순 1분! 쌀 나눔합니다!</div>
				<div class="col" >삼각지역</div>
				<div class="col" >고시히까리</div>
				<div class="col-2" >2022-02-22 02:28</div>
				<div class="col" >1</div>
				<div class="col" >20</div>
			</div>
			</a>
			
			<a href="/share/boardlist/3" >
			<div class="row shareboard" style="text-align: center;">
				<div class="col">3</div>
				<div class="col-5" style="text-align: left;">[공유중] 간장게장 샀는데 냉장고에 다 안들어가네요 ㅠㅠ</div>
				<div class="col" >이태원역</div>
				<div class="col" >데자와</div>
				<div class="col-2" >2022-02-22 02:28</div>
				<div class="col" >1</div>
				<div class="col" >20</div>
			</div>
			</a>
		</div>
	</div>
	 
      
       
</body>
</html>