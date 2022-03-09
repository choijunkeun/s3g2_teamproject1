<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	${BragBest1.user_PK } ${BragBest1.content } ${BragBest1.location }

	<div class="row justify-content-center">
		<!-- 글쓰기 -->
		<div>
			<button class="make_btn btn-outline-secondary" id="bragMake"
				name="bragMake" type="button"
				style="float: right; width: 80px; height: 40px;">글쓰기</button>
		</div>
		<div class="col mt-5">
			<div class="card p-4">
				<h5 class="fw-bolder">이달의혼밥</h5>
				<div class="card-body">
					<img width="450px" height="450px" class="card-img-top"
						src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
				</div>

			</div>
		</div>

		<div class="col mt-5">
			<a href="/brag/best"><h5 class="fw-bolder">BEST</h5></a>
			<div class="card-body">
				<table>
					<tr>
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
					</tr>
					<tr>
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