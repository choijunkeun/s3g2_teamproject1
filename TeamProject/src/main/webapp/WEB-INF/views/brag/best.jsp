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

</head>
<body>
	<!-- <a></a> BEST게시판 이동 링크 -->
	<div class="row justify-content-center">
		<!-- 1. 글쓰기 버튼 -->
		<div>
			<button class="make_btn btn-outline-secondary" id="bragMake"
				name="bragMake" type="button"
				style="float: right; width: 80px; height: 40px;">글쓰기</button>
		</div>
		
		
		
		
		<div class="col mt-5">
			<div class="card p-4">
				<h5 class="fw-bolder">이달의혼밥</h5>
			<div class="card-body">
				<a href="./viewdetail/${bestbragList[0].articleNo }">
					${bestbragList[0].title } <br> <img class="card-img-top"
					src="${bestbragList[0].content}" name="brag_content" width="300px"
					height="450px" class="card-img-top" />
				</a>
			</div>

		</div>
	</div>

	<div class="col mt-5">
		<a href="/brag/best"><h5 class="fw-bolder">BEST</h5></a>
		<div class="card-body">
			<table>
				<!-- <div class="border mycard" > -->
				<tr>
					<c:forEach var="i" begin="1" end="2">
						<td title="${bestbragList[i].title }"><a
							href="./viewdetail/${bestbragList[i].articleNo }">
								${bestbragList[i].title } <br> <img
								src="${bestbragList[i].content}" name="brag_content"
								width="200px" height="200px" class="card-img-top" />
						</a></td>
					</c:forEach>
				</tr>
				<tr>
					<c:forEach var="i" begin="3" end="4">
						<td title="${bestbragList[i].title }"><a
							href="./viewdetail/${bestbragList[i].articleNo }">
								${bestbragList[i].title } <br> <img
								src="${bestbragList[i].content}" name="brag_content"
								width="200px" height="200px" class="card-img-top" />
						</a></td>
					</c:forEach>
				</tr>
				<tr>
					<c:forEach var="i" begin="5" end="6">
						<td title="${bestbragList[i].title }"><a
							href="./viewdetail/${bestbragList[i].articleNo }">
								${bestbragList[i].title } <br> <img
								src="${bestbragList[i].content}" name="brag_content"
								width="200px" height="200px" class="card-img-top" />
						</a></td>
					</c:forEach>
				</tr>
			</table>

		</div>

	</div>
	</div>
	<div class="card-body">
		<table>
			<!-- <div class="border mycard" > -->
			<tr>
				<c:forEach var="i" begin="7" end="10">
					<td title="${bestbragList[i].title }"><a
						href="./viewdetail/${bestbragList[i].articleNo }">
							${bestbragList[i].title } <br> <img
							src="${bestbragList[i].content}" name="brag_content"
							width="200px" height="200px" class="card-img-top" />
					</a></td>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach var="i" begin="11" end="14">
					<td title="${bestbragList[i].title }"><a
						href="./viewdetail/${bestbragList[i].articleNo }">
							${bestbragList[i].title } <br> <img
							src="${bestbragList[i].content}" name="brag_content"
							width="200px" height="200px" class="card-img-top" />
					</a></td>
				</c:forEach>
			</tr>
		</table>

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