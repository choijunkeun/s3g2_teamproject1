<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>혼밥자랑</title>
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"> -->
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>
<body>
	<!-- <a></a> BEST게시판 이동 링크 -->
	${BragBest1.user_PK } ${BragBest1.content } ${BragBest1.location }

	<div class="row justify-content-center">
		<!-- 글쓰기 -->
		<div>
			<button class="make_btn btn-outline-secondary" id="bragMake"
				name="bragMake" type="button"
				style="float: right; width: 80px; height: 40px;">글쓰기</button>
		</div>
		
		
		
		<div class="content">
				<!---------------페이지 내용------------------------------------------------ -->
				<c:choose>
					<c:when test="${bragList!=null && pageInfo.listCount>0 }">
						<div class="col mt-5">
			<div class="card p-4">
				<a href="/brag/best"><h5 class="fw-bolder">혼밥자랑</h5></a>
				<div class="card-body">
									<!--1행 1열-->
									<table>
									<tr>
									<c:forEach var="bboard" items="${bragList}" varStatus="status">
									<!-- 	<div class="border mycard" > -->
										
										<c:if test = "${status.index<4}">
										<td><a href="brag/viewdetail/${bboard.articleNo }">
										<!--타이틀, 사진-->
										${bboard.title } <br>
										<img src="${bboard.content}" name="brag_content"  width="200px" height="200px" class="card-img-top" /></a></td>
										</c:if>
										<c:if test = "${status.index==3}">
									</tr><tr>
										</c:if>
										
										
										<c:if test = "${status.index>3 && status.index<8}">
										<td>
										${bboard.title } <br>
										<img src="${bboard.content}" name="brag_content"  width="200px" height="200px" class="card-img-top" /></td>
										</c:if>
										<c:if test = "${status.index==7}">
										</tr><tr>
										</c:if>
										
										<c:if test = "${status.index>7 && status.index<12}">
										<td>
										${bboard.title } <br>
										<img src="${bboard.content}" name="brag_content"  width="200px" height="200px" class="card-img-top" /></td>
										</c:if>
										<c:if test = "${status.index==11}">
										</tr><tr>
										</c:if>
										
										<c:if test = "${status.index>11 && status.index<16}">
										<td>
										${bboard.title } <br>
										<img src="${bboard.content}" name="brag_content"  width="200px" height="200px" class="card-img-top" /></td>
										</c:if>
										
										
										

										<%-- <!-- 회원이미지, 아이디, 날짜/시간 -->
										<header	class="border">
											<div class="">
												<span class="col-lg">
													<span><img class="profile" src='DEFAULT.png' width=10px height=10px>i</span> <span id="user_id">${tboard.user_id}</span>
												</span>
											</div>
											<span class="" id="brag_date">${bboard.date}</span>
											 <input type="hidden" id="bboard_articleNo" name="bboard_articleNo" value="${bboard.articleNo}">
										</header>

										<!--타이틀-->
										<div class="border" id="bboard_title">${bboard.title }</div>
										<!--컨텐츠(나중에 사진 분리)-->
										<section class="bg-white">
													<a href="viewDetail/${bboard.articleNo}"><img src="/boardupload/${bboard.content}"
															id="brag_content" name="brag_content"  width="120px" height="120px" /></a>
										</section>

										<!-- 조회, 좋아요, 숫자 -->
										<footer class="d-flex">
											<span class="d-flex justify-content-start">
												<img class="heart" src="images/heart.png" style="width: 30px; height: 30px;">
											</span>
											<span>
												<input type="text" id="brag_likes" value='${tboard.today_likes}'
													style="width: 30px; display: inline-block; vertical-align: middle; margin-bottom: 20px; font-size: 15px; font-weight: bold; border: none; background-color: white;"
													disabled>
											</span>
											<span class="d-flex justify-content-end" id="brag_readCount">${bboard.readCount}
											</span>
										</footer> --%>
									
									</c:forEach>
									</tr>

										</table>
						</div>
						</div>
						</div>
					</c:when>
				</c:choose>
				<div id="paging">
				${pageInfo }
				${pageInfo.page } <!-- 1 -->
				${pageInfo.startPage } <!-- 1 -->
				${pageInfo.endPage } <!-- 10 -->
				${pageInfo.maxPage } <!-- 1 -->
					<c:choose>
						<c:when test="${pageInfo.page<=1}">
							[이전]&nbsp;
						</c:when>
						<c:otherwise>
						<a href="brag?page=${pageInfo.page-1}">[이전]</a>&nbsp;
						</c:otherwise>
					</c:choose>
					<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }">
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
			

		
		
<!-- 		<div class="col mt-5">
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