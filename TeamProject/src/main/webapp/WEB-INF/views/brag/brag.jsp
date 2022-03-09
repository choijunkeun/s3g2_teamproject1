<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>혼밥자랑</title>

</head>
<body>
	<!-- 1. 글쓰기 버튼 -->
	<div>
		<button class="make_btn btn-outline-secondary" id="bragMake"
			name="bragMake" type="button"
			style="float: right; width: 80px; height: 40px;">글쓰기</button>
	</div>

	<!-- 2. (일반) 혼밥자랑 게시판 구현 부분. 4개씩 4줄 출력(16개) -->
	<div class="row justify-content-center">
		<div class="content">
			<c:choose>
				<c:when test="${bragList!=null && pageInfo.listCount>0 }">
					<div class="col mt-5">
						<div class="card p-4">
							<h5 class="fw-bolder">혼밥자랑</h5>
							<div class="card-body">
								<table>
									<!-- <div class="border mycard" > -->
									<tr>
										<c:forEach var="bboard" items="${bragList}" varStatus="status">
											<c:if test="${status.index<4}">
												<td><a href="brag/viewdetail/${bboard.articleNo }">
														<!--타이틀, 사진--> ${bboard.title } <br> <img
														src="${bboard.content}" name="brag_content" width="200px"
														height="200px" class="card-img-top" />
												</a></td>
											</c:if>
											<c:if test="${status.index==3}">
									</tr>
									<tr>
										</c:if>
										<c:if test="${status.index>3 && status.index<8}">
											<td>${bboard.title }<br> <img
												src="${bboard.content}" name="brag_content" width="200px"
												height="200px" class="card-img-top" /></td>
										</c:if>
										<c:if test="${status.index==7}">
									</tr>
									<tr>
										</c:if>

										<c:if test="${status.index>7 && status.index<12}">
											<td>${bboard.title }<br> <img
												src="${bboard.content}" name="brag_content" width="200px"
												height="200px" class="card-img-top" /></td>
										</c:if>
										<c:if test="${status.index==11}">
									</tr>
									<tr>
										</c:if>

										<c:if test="${status.index>11 && status.index<16}">
											<td>${bboard.title }<br> <img
												src="${bboard.content}" name="brag_content" width="200px"
												height="200px" class="card-img-top" /></td>
										</c:if>

										</c:forEach>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</c:when>
			</c:choose>

			<!-- 3. 페이징 구현 부분 -->
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
	</div>



	<!-- 기존 4X4 더미코드
		<div class="col mt-5">
			<div class="card p-4">
				<a href="/brag/best"><h5 class="fw-bolder">혼밥자랑</h5></a>
				<div class="card-body">
					<table>
						<tr>
							<td><img width="200px" height="200px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td><img width="200px" height="200px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td><img width="200px" height="200px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td><img width="200px" height="200px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
						</tr>
						<tr>
							<td><img width="200px" height="200px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td><img width="200px" height="200px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td><img width="200px" height="200px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td><img width="200px" height="200px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
						</tr>
						<tr>
							<td><img width="200px" height="200px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td><img width="200px" height="200px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td><img width="200px" height="200px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td><img width="200px" height="200px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
						</tr>
						<tr>
							<td><img width="200px" height="200px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td><img width="200px" height="200px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td><img width="200px" height="200px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td><img width="200px" height="200px" class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
						</tr>
					</table>
				</div>

			</div>
		</div> -->




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
				location.href="/brag/writeform";
			});
		});
 
 
</script>
</body>
</html>