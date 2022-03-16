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
			<div class="card p-4">
				<h5 class="fw-bolder">이 달의 혼밥</h5>
				<div class="card-body">
					<a href="./viewdetail/${bestbragList[0].articleNo }">
						${bestbragList[0].title } 
						<div class="img-container  mx-auto d-block position-relative overflow-hidden" 
							style="vertical-align:middle; object-fit:cover; max-width: 600px; width: inherit;">
							<img class="img-item" src="${bestbragList[0].content}" name="brag_content" />
						</div>
					</a>
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