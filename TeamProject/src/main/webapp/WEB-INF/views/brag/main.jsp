<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>혼밥자랑 메인</title>

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
					<img width="450px" height="450px" class="card-img-top"
						src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
				</div>
			</div>
		</div>


		<div class="col mt-5">
			<div class="card p-4">
				<a href="/brag/best"><h5 class="fw-bolder">BEST</h5></a>
				<div class="card-body">
					<table>
						<tr>
							<td><img width="230px" height="230px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
						</tr>
						<tr>
							<td><img width="230px" height="230px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
						</tr>
					</table>

				</div>
			</div>
		</div>
	</div>

	<!-- 2. 글쓰기 버튼-->
	<div>
		<button class="make_btn btn-outline-secondary" id="bragMake"
			name="bragMake" type="button"
			style="float: right; width: 80px; height: 40px;">글쓰기</button>
		
	</div>

	<!--3. (일반) 혼밥자랑 게시판 구현 부분. 4개씩 2줄 출력(8개) -->
	<div>
		<div class="col mt-5">
			<div class="card p-4">
				<div class="text-center">
					<a href="/brag/brag"><h5 class="fw-bolder">혼밥자랑</h5></a>
				</div>
				<div class="card-body">
					<table>
						<tr>
							<td><img width="230px" height="230px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td><img width="230px" height="230px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td><img width="230px" height="230px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td><img width="230px" height="230px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
						</tr>
						<tr>
							<td><img width="230px" height="230px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td><img width="230px" height="230px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td><img width="230px" height="230px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td><img width="230px" height="230px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
						</tr>
					</table>

				</div>
			</div>
		</div>

		<!-- 4. 페이징 구현 부분 -->
		<div id="paging">
			${pageInfo } ${pageInfo.page }
			<!-- 1 -->
			${pageInfo.startPage }
			<!-- 1 -->
			${pageInfo.endPage }
			<!-- 10 -->
			${pageInfo.maxPage }
			<!-- 1 -->
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