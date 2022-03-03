<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일인분 : 혼밥 정보가 필요할 땐, 일인분</title>
</head>
<body>
	<div class="container mb-2">
		<form class="row">
			<div class="col-4 text-center">
				<!-- 클릭 시 팝오버 설명 -->
				<a class="btn-outline-dark" style="margin: 0 auto;">혼밥 레벨이란?</a> <br>

				<!-- 레벨 선택 -->
				<!-- 클릭 시 색상 변경 -->
				<div id="level" class="btn-group flex-wrap justify-content-center">
					<div class="w-100"></div>
					<input type="radio" name="level-group" class="btn-check" id="lv1">
					<label class="btn btn-outline-danger btn-sm rounded-left" for="radioBtn1">레벨 1</label>
					<input type="radio" name="level-group" class="btn-check" id="lv2"> 
					<label class="btn btn-outline-danger btn-sm" for="radioBtn2">레벨 2</label>
					<input type="radio" name="level-group" class="btn-check" id="lv3"> 
					<label class="btn btn-outline-danger btn-sm" for="radioBtn3">레벨 3</label>
					<input type="radio" name="level-group" class="btn-check" id="lv4">
					<label class="btn btn-outline-danger btn-sm" for="radioBtn4">레벨 4</label>
					<input type="radio" name="level-group" class="btn-check" id="lv5"> 
					<label class="btn btn-outline-danger btn-sm" for="radioBtn5">레벨 5</label>
				</div>
			</div>
			<div class="input-group col">
				<input class="form-control" type="text" placeholder="검색어를 입력하세요">
				<button class="btn btn-danger" type="button">검색</button>
			</div>
		</form>
	</div>
	<img src="https://dummyimage.com/1200x300/000/ffffff.jpg&text=explain" style="max-width: 100%; height: auto;">
	
	<div class="row justify-content-center">
		<div class="col mt-5">
			<div class="card">
				<div class="card-body p-4">
					<div class="text-center">
						<h5 class="fw-bolder">반찬공유 최신글 제목</h5>
						반찬공유 최신글 내용
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
		
		<div class="col mt-5">
			<div class="card">
				<div class="card-body p-4">
					<div class="text-center">
						<h5 class="fw-bolder">혼밥자랑 최신글 제목</h5>
						혼밥자랑 최신글 내용
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
					<img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
				</div>
				<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
					<!-- + 클릭 시 상세보기로 이동 -->
					<a class="btn btn-outline-dark mt-auto" href="#">+</a>
				</div>
			</div>
		</div>
		
		<div class="col mt-5">
			<div class="card p-4">
				<div class="card-body">
					<table>
						<tr>
							<td>
								<img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td>
								<img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
						</tr>
						<tr>
							<td>
								<img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td>
								<img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
						</tr>
					</table>
					
				</div>
			</div>
		</div>
	</div>
</body>
</html>