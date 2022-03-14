<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>혼밥자랑 메인</title>

<style>

/* 200 x 200 size 사진 */
.200table{
	width: 800px;
	table-layout: fixed;
	border-spacing: 100px;
} 
/* 제목 한줄 이상이면 ...으로, 마우스 오버하면 보이게  */
td {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
.450300tr {
width : 450px !important;
height : 300px !important;
}

.img-latest {
	width: 200px;
	height:200px;
	min-width:200px;
	min-height:200px;
	max-width:200px;
	max-height:200px;
}

</style>
</head>
<body>
	<!-- 수정요. 컨텐츠 빼는 태그 -->
	<!--  ${BragBest1.content } -->

	<!--1. BEST 혼밥자랑 게시판 구현 부분. 1위(이달의혼밥) 크게 출력, 2,3위 작게 두개로 출력  -->
	<div class="row justify-content-center">
		<!--row-vh d-flex flex-row justify-content-center : row 방향으로 가로 배열할 때, 중앙 정렬   -->
		<div class="col mt-5">
			<!-- col mt-5 : margin top 5 -->
			<div class="card p-4">
				<!--card padding 4  -->
				<h5 class="fw-bolder">이달의혼밥</h5>
				<!--fw-bolder : font weight bolder  -->
				<div class="text-center"></div>
				<div class="card-body">
					<!--card body : box를 만들어 준다  -->
					<table>
						<!-- <div class="border mycard" > -->
						<tr>
							<td title="${bestbragList[0].title }">
								<a href="brag/viewdetail/${bestbragList[0].articleNo }">
									${bestbragList[0].title } <br>
									<img src="${bestbragList[0].content}" name="brag_content" 
									width="500px" height="700px"
									class="card-img-top" /></a>
							</td>
						</tr>
						</table>
				</div>
			</div>
		</div>


		<div class="col mt-5">
			<div class="card p-4">
				<a href="/brag/best"><h5 class="fw-bolder">BEST</h5></a>
				<div class="card-body">
					<table>
						<!-- <div class="border mycard" > -->
						<tr>
							<td title="${bestbragList[1].title }">
								<a href="brag/viewdetail/${bestbragList[1].articleNo }">
									${bestbragList[1].title } <br>
									<img src="${bestbragList[1].content}" name="brag_content"  width="450px" height="300px"
									class="card-img-top"/></a>
							</td>
						</tr>
						<tr>
							<td title="${bestbragList[2].title }">
							<a href="brag/viewdetail/${bestbragList[2].articleNo }">
									${bestbragList[2].title } <br> 
									<img src="${bestbragList[2].content}" name="brag_content" width="450px" height="300px"
									class="card-img-top" />
							</a></td>
						</tr>
					</table>

				</div>
			</div>
			
				<!-- 2. 글쓰기 버튼-->
	<div>
		<button class="btn m-2 btn-outline-secondary" id="bragMake"
			name="bragMake" type="button"
			style="float: right; ">글쓰기</button>
	</div>
			
		</div>
	</div>



	<!--3. (일반) 혼밥자랑 게시판 구현 부분. 4개씩 2줄 출력(8개) -->
	<div>
		<div class="col mt-5">
			<div class="card p-4">
				<div class="text-center">
					<a href="/brag/brag"><h5 class="fw-bolder">혼밥자랑</h5></a>
				</div>
				<div class="card-body">
					<c:forEach var="bboard" items="${bragList}" varStatus="status">
						<c:choose>
							<c:when test="${status.index mod 4 == 0}">
								<div class="row">
							</c:when>
						</c:choose>
							<div class='col-sm-3'>
							<a href="/brag/viewdetail/${bboard.articleNo }">
								${bboard.title } <br>
								<img src="${bboard.content}" name="brag_content" width="200px" height="200px" class="card-img-top" />
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
		</div>

	</div>




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
	
	
/*2-1. 글쓰기 버튼 #bragMake 클릭 시 글쓰기writeform으로 이동  */
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