<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	
	<style>
	#user_info {
		font-size: 40px;
		font-weight: bold;
	}
	#user_level {
		font-size: 30px;
		font-weight: bold;
	}
	
	</style>
<title>일인분(마이페이지)</title>
</head>
<body>
	<div class="container mb-2">
		
	</div>
	
	
	<div class="row justify-content-center">
		<div class="col mt-5" style="height:700px">
			<div class="card">
				<div class="card-body p-4" style="height:275px">
					<div class="text-center">
						
						
						<img style="border-radius: 100px; width: 125px; height: 125px;"
							src="http://placehold.co/100x100">
							<div id="user_info">${user.nickname}</div>
							<div id="user_level">LV. ${user.honbabLevel}</div>
					</div>
				</div>
				
				
				<div class="card-body p-4">
					<div class="text-center">
						<h5 class="fw-bolder">팔로워 0 &emsp;&emsp;&emsp; 팔로잉 0</h5>
					</div>
				</div>
				
				<div>
					<div style="text-align:center;"><a class="btn btn-outline-dark mt-auto mx-3" id="search-nav" href="/editInfo">정보수정</a></div>
				</div>
				
				<div class="card-body p-4" style="height:250px">
				<div class="text-center">
						<h5 class="fw-bolder" style="padding:40px" >${user.nickname}님의 혼밥이 [oo]만큼 사랑받고 있어요</h5>
				</div>
				</div>
				
				
				
				<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
					
				</div>
			</div>
		</div>
		
		
		<div class="col mt-5">
			<div class="card"   style="height:670px;" >
				<div class="card-body p-4" >
					<div class="text-center" >
						<h5 class="fw-bolder">내가 리뷰한 혼밥집</h5>
					</div>
				</div>
				
				
				
				<div class="card-body p-4">
					<div class="text-center" >
						<h5 class="fw-bolder">제목 , 혼밥레벨, 종합평점, 위치 , 작성자 , 작성이 나오는 부분</h5>
					</div>
				</div>
				
				
				
				<div class="card-body p-4">
					<div class="text-center" >
						<h5 class="fw-bolder">게시글 목록 나오는부분</h5>
					</div>
				</div>
				<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
				</div>
			</div>
		</div>
		</div>
		
		
	
	<div class="row justify-content-center">
		<div class="col mt-5">
			<div class="card p-4" style="height:500px">
				<div class="text-center">
					<h5 class="fw-bolder">반찬공유</h5>
				</div>
				<div class="card-body" id="myShare">
					사용자의 반찬공유 게시글 나오는 부분 
				</div>
				<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
					<!-- + 클릭 시 상세보기로 이동 -->
					<a class="btn btn-outline-dark mt-auto" href="#">+</a>
				</div>
			</div>
		</div>
		
		
		<div class="col mt-5">
			<div class="card p-4" style="height:500px">
				<div class="text-center">
					<h5 class="fw-bolder">혼밥자랑</h5>
				</div>
				<div class="card-body" id="myBrag">					
				</div>
				<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
					<!-- + 클릭 시 상세보기로 이동 -->
					<a class="btn btn-outline-dark mt-auto" href="#">+</a>
				</div>
			</div>
		</div>
		
		
		<div class="col mt-5">
			<div class="card p-4" style="height:500px">
				<div class="text-center">
					<h5 class="fw-bolder">커뮤니티</h5>
				</div>
				<div class="card-body" id="myCommunity">
					사용자의 커뮤니티 게시글 나오는 부분
				</div>
				<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
					<!-- + 클릭 시 상세보기로 이동 -->
					<a class="btn btn-outline-dark mt-auto" href="#">+</a>
				</div>
			</div>
		</div>
		
		
		
		
		
	</div>
</body>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>

$(function() {
	$.ajax({
		url:'/MybragPosting',		
		type: 'POST',
		datatype : "json",
		success: function(data) {
			/* $("#myBrag").text(data[0].title); */
			$.each(data, function(index, item) { // 데이터 = item 
				$("#myBrag").append(item.articleNo + " ");
				$("#myBrag").append(item.title + " ");
				$("#myBrag").append(item.date + "<br>");
			});
		}
      }),
	
	
	
	$.ajax({
		url:'/MysharePosting',		// 컨트롤러 
		type: 'POST',
		datatype:"json",
		success: function(data){
			$.each(data, function(index, item) { // 데이터 = item 
				$("#myShare").append(item.articleNo + " ");
				$("#myShare").append(item.title + " ");
				$("#myShare").append(item.date + "<br>");
			});
			
		}		
	}),
	
	
	$.ajax({
		url:'/MycommunityPosting',		// 컨트롤러 
		type: 'POST',
		datatype:"json",
		success: function(data){
			$.each(data, function(index, item) { // 데이터 = item 
				$("#myCommunity").append(item.articleNo + " ");
				$("#myCommunity").append(item.title + " ");
				$("#myCommunity").append(item.date + "<br>");
				
			});
		}		
	})
})


</script>
</html>