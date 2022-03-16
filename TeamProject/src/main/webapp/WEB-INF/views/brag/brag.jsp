<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>혼밥자랑</title>
<style>
/* img{
	transform : translateX(-50%) translateY(-50%);
	top : 50%;
	left : 50%;
	min-width : 100%;
	min-height : 100%;
	width : auto;
	height : auto;
} */
/* .image {
	position: absolute;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
	background-size: cover;
	background-repeat: no-repeat;
	background-position: 50% 50%;
} */
/* image {
background-size:contain;
} */
/* 200 x 200 size 사진 */
table {
	width: 800px;
	table-layout: fixed;
	border-spacing: 100px;
}
/* 제목 한줄 이상이면 ...으로, 마우스 오버하면 보이게  */
td {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	width: 100px;
	height: 20px;
}

#ellipsis {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
/* .img-item {
	width: 200px;
	height: 200px;
	min-width: 200px;
	min-height: 200px;
	max-width: 200px;
	max-height: 200px;
} */
.img-item {
	width:100%;
    height:100%;
    object-fit:cover;
    transform:scale(1.0);
    transition: all 0.3s ease-in-out;
}
.img-item:hover{
	transform:scale(1.1);
}
.img-container {
	max-width:auto;
	height:auto;
}
</style>
<link rel="stylesheet" href="/css/brag.css">
</head>
<body>
	<!-- 1. 글쓰기 버튼 -->
	<div class="row justify-content-end"></div>

	<!-- 2. (일반) 혼밥자랑 게시판 구현 부분. 4개씩 4줄 출력(16개) -->
	<div class="row justify-content-center">
		<div class="content">
			<c:choose>
				<c:when test="${bragList!=null && pageInfo.listCount>0 }">
					<div class="col mt-5">
						<div class="card p-4">
							<div>
								<h2 class="fw-bolder float-start"><a href="./"><i class="px-3 fa fa-angle-left"></i></a>혼밥자랑</h2>
								<button class="btn btn-outline-secondary float-end"
									id="bragMake" name="bragMake" type="button"
									style="float: right; width: 80px; height: 40px;">글쓰기</button>
							</div>
							<div class="card-body"></div>
							<!-- <div class="border mycard" > -->
							<c:forEach var="bboard" items="${bragList}" varStatus="status">
							<c:choose>
							<c:when test="${status.index mod 4 == 0}">
							<div class="row mb-3">
							</c:when>
							</c:choose>
								<div class='col-sm-3'>
									<a href="/brag/viewdetail/${bboard.articleNo }">
										<div id="ellipsis">${bboard.title }</div> 
										<div class="img-container table200 mx-auto d-block position-relative overflow-hidden" 
											style="vertical-align:middle; object-fit:cover; width: inherit;">
										<img src="${bboard.content}" name="brag_content" class="img-item table200-item" />
										</div>
									</a>
								</div>
							<c:choose>
							<c:when test="${status.index mod 4 == 3}">
							</div>
							</c:when>
							</c:choose>
							</c:forEach>
						</div>
					</div>
				</c:when>
			</c:choose>
		</div>
	</div>
	<%-- 	<!-- 3. 페이징 구현 부분 -->
			<div id="paging">
				<c:choose>
					<c:when test="${pageInfo.page<=1}">
							[이전]&nbsp;
						</c:when>
					<c:otherwise>
						<a href="brag?page=${pageInfo.page-1}">[이전]</a>&nbsp;
						</c:otherwise>
				</c:choose>
				<c:forEach var="i" begin="${pageInfo.startPage }"
					end="${pageInfo.endPage }">
					<c:choose>
						<c:when test="${pageInfo.page==i }">[${i }]</c:when>
						<c:otherwise>
							<a href="brag?page=${i}">[${i }]</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${pageInfo.page>=pageInfo.maxPage }">
						[next]
						</c:when>
					<c:otherwise>
						<a href="brag?page=${pageInfo.page+1}">[next]</a>
					</c:otherwise>
				</c:choose>
			</div> --%>


	<nav class=" my-2" id="pageList">
		<ul class="pagination justify-content-center">
			<!-- 페이지 목록 -->
			<!-- if else 랑 같음.  페이지가 1보다 작거나 같으면 이전페이지로 -->
			<c:choose>
				<c:when test="${pageInfo.page<=1}">
					<li class="page-item"><a class="page-link" href="#">이전</a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link"
						href="brag?page=${pageInfo.page-1}">이전</a></li>
				</c:otherwise>
			</c:choose>
			<c:forEach var="i" begin="${pageInfo.startPage }"
				end="${pageInfo.endPage }">
				<!-- end page 마지막 페이지 -->
				<!-- 현재페이지. 1페이지에서는 현재와 이전페이지 클릭될 필요가없음.-->
				<!-- 현재페이지를 제외한 나머지페이지 -->
				<c:choose>
					<c:when test="${pageInfo.page==i }">
						<li class="page-item active"><a class="page-link" href="#">${i }</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link"
							href="brag?page=${i}">${i }</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:choose>
				<c:when test="${pageInfo.page>=pageInfo.maxPage }">
					<li class="page-item"><a class="page-link" href="#">다음</a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link"
						href="brag?page=${pageInfo.page+1}">다음</a></li>
				</c:otherwise>
			</c:choose>
			<!-- 페이지에 답변 달았으면 그 페이지 목록이 보여야함. -->
			<!-- 눈에 보이진 않지만 페이지를 달고다님. -->
		</ul>
	</nav>


	<!-- JavaScript -->
	<script type="text/javascript"
		src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
	/*수정요. 비회원 클릭 시 로그인으로 넘어감. 세션값 필요  */
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
		
 		
 /*1-1. 글쓰기 버튼 #bragMake 클릭 시 글쓰기writeform으로 이동  */
$(document).ready(function(){
	$('#bragMake').on('click',function(){
		if('${user.idx }' == ''){
			location.href="/login";
		} else {
			location.href="/brag/writeform";	
		}
	});
});
 
</script>
</body>
</html>
