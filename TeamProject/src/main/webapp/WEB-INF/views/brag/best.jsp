<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BEST</title>
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"> -->
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>

/* 400 x 600 size 사진 */

/* 
/* 200 x 200 size 사진 */
.200table {
	width: 800px;
	table-layout: fixed;
	border-spacing: 100px;
}

* /
	/* 제목 한줄 이상이면 ...으로, 마우스 오버하면 보이게  */ 
td {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
.btn-follow {
	border-color: #ff3f3f !important;
	color: #ffffff;
	text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
	background-color: #ff3f3f !important;
	border-color: #ff3f3f !important;
}

</style>
<link rel="stylesheet" href="/css/brag.css">
</head>
<body>
	<!-- 1. 글쓰기 버튼 -->
	<div class="row d-flex justify-content-between">
		<h2 class="fw-bolder align-self-start w-auto"><a href="./"><i class="px-3 fa fa-angle-left"></i></a></h2>
		<h2 class="align-self-center w-auto"><a href="/brag/best"><h5 class="fw-bolder">BEST</h5></a></h2>
		<button class="btn btn-outline-secondary align-self-end d-inline" id="bragMake"
			name="bragMake" type="button"
			style="float: right; width: 80px; height: 40px;">글쓰기</button>
	</div>
	<!-- <a></a> BEST게시판 이동 링크 -->
	<div class="row justify-content-center">
		<div class="col-sm-6">
			<div class="card p-4 h-100">
					<h2 class="fw-bolder">이 달의 혼밥</h2>
					<div class="card-body">
						<div class="card border-right">
							<div class="card-header justify-content-between">
								<div class="row mb-2">
									<div class="col-sm-3">
										<button type="button" class="btn btn-secondary">${bestbragList[0].moonpa ? "사먹파" : "해먹파"}</button>
									</div>
								</div>
								
								<div class="row mb-2">
									<div class="col-sm-5">
										<a href="/userInfo/${writerInfo.idx }">
											<img
												style="border-radius: 50px; width: 40px; height: 40px; margin: 0 auto;"
												src='/profile/${writerInfo.profileImg }'>
											<div class="border pb-2 pt-1 mx-1 rounded" style="display:inline; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">
													${writerInfo.nickname }님</div>
											<span
												class="badge bg-danger rounded-pill m-2">Lv.
													${writerInfo.honbabLevel }</span>
										</a>
									</div>
									<div class="col-sm-3">
									</div>
									<div class="col-sm-4">
										<c:if test="${!(empty user) && !(writerInfo.idx  eq user.idx) }">
											<button class="btn btn-follow text-white align-self-center"
													style="height: fit-content;" id="writerInfofollow${userInfo.idx}"
													onclick="togglefollow(`${writerInfo.idx}`);">${didIFollowed>0? "언팔로우": "팔로우"}</button>
										</c:if>
											<!-- <a href="#" class="btn btn-primary text-white align-self-center" style="height: fit-content;">팔로우</a> -->
									</div>
								</div>
								
								<div class="row">
									<i class="fa fa-map-marker m-2" aria-hidden="true">&nbsp;${bestbragList[0].location }</i>

									<a class="mw-100"
										href="/brag/viewdetail/${bestbragList[0].articleNo }"> <br>
										<div
											class="img-container  mx-auto d-block position-relative overflow-hidden"
											style="vertical-align: middle; object-fit: cover; max-width: 600px; width: inherit;">
											<img class="img-item " src="${bestbragList[0].content}"
													name="brag_content"> ${bestbragList[0].title }
										</div>
									</a>
								</div>
									
								<div class="row">
									<div class='col-sm-3'>
										<button class="btn-sm border-0 bg-transparent text-danger mx-2"
											id="likebtn${bboard.articleNo }"
											onclick="toggleLikes(${bboard.articleNo})">
										<i class="fa fa-lg ${didILiked>0 ? 'fa-heart' : 'fa-heart-o' }"
											aria-hidden="true">${likes }</i>
										</button>
									</div>
									<div class='col-sm-6'>
									</div>
									<div class='col-sm-3'>
										<i class="fa fa-commenting fa-lg mx-2" aria-hidden="true">${countComment }</i>
									</div>
										
								<!-- 좋아요 border-danger rounded-pill bg-white  -->
							</div>
							</div>
						</div>
					</div>
			</div>
		</div>


		<div class="col-sm-6">
			<!-- <a href="/brag/best"><h5 class="fw-bolder">BEST</h5></a> -->
			
			<div class="card-body">
				<div class="text-center">
					<c:forEach var="bboard" begin="1" end="6" items="${bestbragList}" varStatus="status">
						<c:choose>
							<c:when test="${status.index mod 2 == 1}">
								<div class="row">
							</c:when>
						</c:choose>
						<div class='col-sm-6'>
							<a href="./viewdetail/${bboard.articleNo }"> ${bboard.title }
								<div class="img-container table240  mx-auto d-block position-relative overflow-hidden" 
									style="vertical-align:middle; object-fit:cover; width: inherit">
									<img src="${bboard.content}" name="brag_content" class="img-item table200-item" />
								</div>
							</a>
						</div>
						<c:choose>
							<c:when test="${status.index mod 2 == 0}">
								</div>
				</c:when>
				</c:choose>
				</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<div>
		<div class="card-body">
			<c:forEach var="bboard" begin="7" items="${bestbragList}"
				varStatus="status">
				<c:choose>
					<c:when test="${status.index mod 4 == 3}">
						<div class="row">
					</c:when>
				</c:choose>
				<div class='col-sm-3'>
					<a href="./viewdetail/${bboard.articleNo }"> ${bboard.title }
						<div class="img-container table240  mx-auto d-block position-relative overflow-hidden" 
							style="vertical-align:middle; object-fit:cover; width: inherit">
							<img src="${bboard.content}" name="brag_content" class="img-item table200-item" />
						</div>
					</a>
				</div>
				<c:choose>
					<c:when test="${status.index mod 4 == 2}">
		</div>
		</c:when>
		</c:choose>
		</c:forEach>
	</div>
	</div>

	<script>
		console.log(${pageInfo.page});
 		// $(function(){
		// 	$("#todayMake").click(function(){
		// 		let id = $('#user_id').val();
		// 		if(id == ''){
		// 			alert("로그인 먼저 진행해주세요");
		// 		}else{
		// 			console.log("값넘기는거확인1");
		// 			return "today_make";
		// 		}
		// 	});
		// }); 
		
		$(document).ready(function(){
			$('#bragMake').on('click',function(){
				location.href="/brag/writeform";
			});
			

		});
	</script>
</body>
</html>