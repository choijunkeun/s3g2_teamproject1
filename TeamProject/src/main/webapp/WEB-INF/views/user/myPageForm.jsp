<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일인분(마이페이지)</title>
<style>
	.card{
		height : 500px;
	}
	#user_info {
		font-size: 40px;
		font-weight: bold;
	}
	#user_level {
		font-size: 30px;
		font-weight: bold;
	}
	
	/* #myCommunity {
		width:300px;
		overflow:hidden;
		text-overflow:ellipsis;
		white-space:nowrap;
	} */
	
	table {
	table-layout : fixed;}
	td {
		overflow:hidden;
		text-overflow:ellipsis;
		white-space:nowrap;
	}
	</style>
</head>
<body>
	<div class="row justify-content-center">
		<div class="col mt-5">
			<div class="card">
				<div class="card-body p-4">
					<div class="text-center">
						<img style="border-radius: 200px; width: 150px; height: 150px;"
							src="/profile/${user.profileImg }">
						<div id="user_info">${user.nickname}</div>
						<span class="badge bg-danger rounded-pill" style="font-size: 1.5rem;">Lv.${user.honbabLevel}</span>
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

				<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
					
				</div>
			</div>
		</div>
		
		
		<div class="col mt-5">
			<div class="card">
				<div class="card-body p-4">
					<div class="text-center">
						<h5 class="fw-bolder">내가 작성한 리뷰</h5>
					</div>
				</div>
				<div class="card-body p-4">
					<div class="text-center" >
						<table class="table table-striped">
							<thead>
							<tr>
								<th>혼밥레벨</th>
								<th>제목</th>
								<th>내 평점</th>						
							</tr>
							</thead>
							<tbody id="myReview">
							</tbody>										
						</table>					
					</div>
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
				
				<div class="table-responsive">
					<table class="table table-striped">
						<thead>
						<tr>
							<th class="col-xs-12 col-md-8">제목</th>
							<th class="col-xs-6 col-md-4">조회수</th>
						</tr>
						</thead>
						<tbody id="myShare">
						</tbody>
					</table>	
				</div>			
				
			</div>
		</div>
		
		
		<div class="col mt-5">
			<div class="card p-4" style="height:500px">
				<div class="text-center">
					<h5 class="fw-bolder">혼밥자랑</h5>
				</div>
				<div class="table-responsive">
					<table class="table table-striped">
						<thead>
						<tr>
							<th class="col-xs-12 col-md-8">제목</th>
							<th class="col-xs-6 col-md-4">조회수</th>
						</tr>
						</thead>
						<tbody id="myBrag">
						</tbody>
					</table>	
				</div>					
			</div>
		</div>
		
		
		<div class="col mt-5">
			<div class="card p-4" style="height:500px">
				<div class="text-center">
					<h5 class="fw-bolder">커뮤니티</h5>
				</div>
				
				
				<div class="table-responsive">
					<table class="table table-striped">
						<thead>
						<tr>
							<th class="col-xs-12 col-md-8">제목</th>
							<th class="col-xs-6 col-md-4">조회수</th>
						</tr>
						</thead>
						<tbody id="myCommunity">
						</tbody>
					</table>	
				</div>			
				
			</div>
		</div>
		
		
		
		
		
	</div>
	
</body>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>     
// 혼밥자랑 게시글
$(function() {
	$.ajax({
		url:'/bragPosting',		
		type: 'POST',
		datatype : "json",
		data: {"idx": ${user.idx}},
		success: function(data) {
			/* $("#myBrag").text(data[0].title); */
			$.each(data, function(index, item) { 
				$("#myBrag").append("<tr><td><a href=/brag/viewdetail/"+item.articleNo+">"
				+item.title + "</a></td><td>"
				+item.readCount + "</td></tr><br>");
				});
			}
      }),
	
//반찬공유 게시글
	$.ajax({
		url:'/sharePosting',		
		type: 'POST',
		datatype:"json",
		data: {"idx": ${user.idx}},
		success: function(data){
			$.each(data, function(index, item) { 
				$("#myShare").append("<tr><td><a href=/brag/viewdetail/"+item.articleNo+">"
				+item.title + "</a></td><td>"
				+item.readCount + "</td></tr><br>");
				});
			
		}		
	}),
//커뮤니티 게시글
	$.ajax({
		url:'/communityPosting',		
		type: 'POST',
		datatype:"json",
		data: {"idx": ${user.idx}},
		success: function(data){
			$.each(data, function(index, item) { 
				$("#myCommunity").append("<tr><td><a href=/comm/boardlist/"+item.articleNo+">"
				+item.title + "</a></td><td>"
				+item.views + "</td></tr><br>");
				});
		}		
	}),
	// 리뷰 게시글
	$.ajax({
		url:'/reviewPosting',		
		type: 'POST',
		datatype : "json",
		data: {"idx": ${user.idx}},
		success: function(data) {			
			$.each(data, function(index, item) { 
				var index = (item.serviceRate+item.interiorRate+item.priceRate+item.tasteRate)/4;
				/* console.log(index); */
				
				$("#myReview").append("<tr><td><span class='badge bg-danger rounded-pill' style='font-size:0.75rem'>Lv."+
						+item.honbabLv + "</span></td><td>"
						+item.honbabReason + "</td><td>"+index+"</td></a></tr>");
						});
			
			
			//url 경로연결은 카카오API 경로 지원 문제 떄문에 사용하지 못함.
			/* $("#myReview").append("<tr><td><span class='badge bg-danger rounded-pill' style='font-size:0.75rem'>Lv."+
					+item.honbabLv + "</span></td><td><a href=/place/"+item.id+">"
					+item.honbabReason + "</a></td><td>"+index+"</td></a></tr>");
					}); */

			}
      })
})


</script>
</html>