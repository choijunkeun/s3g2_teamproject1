<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일인분 : 혼밥 정보가 필요할 땐, 일인분</title>
</head>
<body>
	<!-- <div class="container mb-2">
		<form class="row" method="post" action="/search">
			<div class="col-4 text-center">
				클릭 시 팝오버 설명
				<a class="btn-outline-dark" style="margin: 0 auto;">혼밥 레벨이란?</a> <br> -->

	<!-- 레벨 선택 -->
	<!-- 클릭 시 색상 변경 -->
	<!-- <div id="level" class="btn-group flex-wrap justify-content-center">
					<div class="w-100"></div>
					<input type="radio" name="level-group" class="btn-check" id="lv1" value="1">
					<label class="btn btn-outline-danger btn-sm" for="lv1">레벨 1</label>
					<input type="radio" name="level-group" class="btn-check" id="lv2" value="2"> 
					<label class="btn btn-outline-danger btn-sm" for="lv2">레벨 2</label>
					<input type="radio" name="level-group" class="btn-check" id="lv3" value="3"> 
					<label class="btn btn-outline-danger btn-sm" for="lv3">레벨 3</label>
					<input type="radio" name="level-group" class="btn-check" id="lv4" value="4">
					<label class="btn btn-outline-danger btn-sm" for="lv4">레벨 4</label>
					<input type="radio" name="level-group" class="btn-check" id="lv5" value="5"> 
					<label class="btn btn-outline-danger btn-sm" for="lv5">레벨 5</label>
				</div>
			</div>
			<div class="input-group col">
				<input class="form-control" id="keyword" type="text" placeholder="검색어를 입력하세요">
				<input type="submit" class="btn btn-danger" type="button" value="검색">
			</div>
		</form>
	</div> -->

	<div id="carouselExampleSlidesOnly" class="carousel slide"
		data-bs-ride="carousel" style="max-width: 100%; height: 300px;">
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img
					src="https://dummyimage.com/1200x300/777/ff99ff.jpg&text=explain"
					class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img
					src="https://dummyimage.com/1200x300/555/99ffff.jpg&text=explain"
					class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img
					src="https://dummyimage.com/1200x300/999/ffff99.jpg&text=explain"
					class="d-block w-100" alt="...">
			</div>
		</div>
	</div>
	<!-- https://getbootstrap.com/docs/5.1/components/carousel/ -->


	<div class="row justify-content-center">
		<div class="col mt-5">
			<div class="card">
				<div class="card-body p-4">
					<div class="text-center">
						<h5 class="fw-bolder">반찬공유 최신글 제목</h5>
						<c:forEach var="i" begin="0" end="2">
							<a title="${shareList[i].title }"
								href="share/board/viewform/${shareList[i].articleNo }">${shareList[i].title }</a>
							<br>
						</c:forEach>
					</div>
				</div>
				<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
					<div>
						<!-- + 클릭 시 상세보기로 이동 -->
						<a class="btn btn-outline-dark mt-auto" href="share/board/listform">+</a>
					</div>
				</div>
			</div>
		</div>

		<div class="col mt-5">
			<div class="card">
				<div class="card-body p-4">
					<div class="text-center">
						<h5 class="fw-bolder">혼밥자랑</h5>
						<c:forEach var="i" begin="0" end="2">
							<a title="${bragList[i].title }"
								href="brag/viewdetail/${bragList[i].articleNo }">${bragList[i].title }</a>
							<br>
						</c:forEach>
					</div>
				</div>
				<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
					<div>
						<!-- + 클릭 시 상세보기로 이동 -->
						<a class="btn btn-outline-dark mt-auto" href="/brag">+</a>
					</div>
				</div>
			</div>
		</div>

		<div class="col mt-5">
			<div class="card">
				<div class="card-body p-4">
					<div class="text-center">
						<h5 class="fw-bolder">커뮤니티 최신글 제목</h5>
						커뮤니티 최신글 내용
					</div>
				</div>
				<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
					<div>
						<!-- + 클릭 시 상세보기로 이동 -->
						<a class="btn btn-outline-dark mt-auto" href="#">+</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="row justify-content-center">
		<div class="col mt-5">
			<div class="card p-4">
				<div class="text-center">
					<h5 class="fw-bolder">혼밥자랑 BEST 제목</h5>
				</div>
				<div class="card-body">
					<a href="brag/viewdetail/${bestbragList[0].articleNo }">
						${bestbragList[0].title } <br> <img class="card-img-top"
						src="${bestbragList[0].content}" name="brag_content" width="300px"
						height="450px" class="card-img-top" />
					</a>
				</div>
				<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
					<!-- + 클릭 시 상세보기로 이동 -->
					<a class="btn btn-outline-dark mt-auto" href="/brag/best">+</a>
				</div>
			</div>
		</div>

		<div class="col mt-5">
			<div class="card p-4">
				<div class="card-body">
					<table>
						<!-- <div class="border mycard" > -->
						<tr>
							<c:forEach var="i" begin="1" end="2">
								<td title="${bestbragList[i].title }"><a
									href="brag/viewdetail/${bestbragList[i].articleNo }">
										${bestbragList[i].title } <br> <img
										src="${bestbragList[i].content}" name="brag_content"
										width="200px" height="200px" class="card-img-top" />
								</a></td>
							</c:forEach>
						</tr>
						<tr>
							<c:forEach var="i" begin="3" end="4">
								<td title="${bestbragList[i].title }"><a
									href="brag/viewdetail/${bestbragList[i].articleNo }">
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
	</div>
	<script>
		var obj_length = document.getElementsByName("level-group").length;

		for (var i = 0; i < obj_length; i++) {
			if (document.getElementsByName("level-group")[i].checked == true) {
				alert(document.getElementsByName("level-group")[i].value);
			}
		}
		function alertbeforesend() {
			var obj = document
					.querySelector('input[name="level-group"]:checked');
			/* for(let item in obj)
				alert(item.value); */
			alert(obj.value);
			//return false;
		}
	</script>
</body>
</html>