<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일인분 : 혼밥 정보가 필요할 땐, 일인분</title>
<style>
	.mainShortcut>a {
		max-width: auto;
		display: inline-block;
		text-overflow: ellipsis;
		white-space: nowrap;
		overflow: hidden;

	}
/*배너 이미지 사이즈 조절 코드 크롬에서만 됨  */	
	.banner{ 
  object-fit: cover;
  width: 100%; height: 100%;
}
</style>
</head>
<body>
	<div id="carousel" class="carousel carousel-dark slide" data-bs-ride="carousel" data-bs-interval="3000" style="max-width: 100%;">
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="${path}/banner/1.svg" class="banner" type="image / svg + xml" codebase="http://www.adobe.com / svg / viewer / install " />
			</div>
			<div class="carousel-item">
				<img src="${path}/banner/banner1.svg" class="banner" type="image / svg + xml" codebase="http://www.adobe.com / svg / viewer / install " />
			</div>
			<div class="carousel-item">
				<img src="${path}/banner/banner2.svg" class="banner" type="image / svg + xml" codebase="http://www.adobe.com / svg / viewer / install " />
			</div>
			<div class="carousel-item">
				<img src="${path}/banner/banner3.svg" class="banner" type="image / svg + xml" codebase="http://www.adobe.com / svg / viewer / install " />
			</div>
			<div class="carousel-item">
				<img src="${path}/banner/banner4.svg" class="banner" type="image / svg + xml" codebase="http://www.adobe.com / svg / viewer / install " />
			</div>
		</div>
		<button class="carousel-control-prev" type="button" data-bs-target="#carousel" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			<span class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button" data-bs-target="#carousel" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span>
			<span class="visually-hidden">Next</span>
		</button>
	</div>
	<!-- https://getbootstrap.com/docs/5.1/components/carousel/ -->

	<div class="row justify-content-center">
		<div class="col mt-5">
			<div class="card">
				<div class="card-body p-4">
					<div class="text-center mainShortcut">
						<h5 class="fw-bolder">반찬공유 최신글</h5>
						<c:forEach var="i" begin="0" end="2">
							<a title="${shareList[i].title }"
								href="/share/board/viewform/${shareList[i].articleNo }">${shareList[i].title }</a>
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
					<div class="text-center mainShortcut">
						<h5 class="fw-bolder">혼밥자랑 최신글</h5>
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
					<div class="text-center mainShortcut">
						<h5 class="fw-bolder">커뮤니티 최신글</h5>
						<c:forEach var="i" begin="0" end="2">
							<a title="${commList[i].title }"
								href="/comm/viewform/${commList[i].articleNo }">${commList[i].title }</a>
							
							<br>
						</c:forEach>
					</div>
				</div>
				<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
					<div>
						<!-- + 클릭 시 상세보기로 이동 -->
						<a class="btn btn-outline-dark mt-auto" href="/comm/listform">+</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="row justify-content-center">
		<div class="col mt-5">
			<div class="card p-4">
					<h3 class="fw-bolder">이달의혼밥</h3>
				<div class="card-body">
					<a href="brag/viewdetail/${bestbragList[0].articleNo }">
						${bestbragList[0].title } <br> <img class="card-img-top"
						src="${bestbragList[0].content}" name="brag_content" width="300px"
						height="450px" class="card-img-top" />
					</a>
				</div>
				<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
					<!-- + 클릭 시 상세보기로 이동 -->
					<a class="btn btn-outline-dark mt-auto" href="/brag">+</a>
				</div>
			</div>
		</div>

		<div class="col mt-5">
			<div class="card p-4">
			<h5 class="fw-bolder">혼밥자랑 BEST</h5>
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