<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MVC 게시판</title>
<style type="text/css">
h2 {
	text-align: center;
}



#commandCell {
	text-align: center;
}


</style>
</head>
<body>
	<!-- 게시판 등록 -->

	<section id="./writeForm">
		<h2>커뮤니티 글쓰기</h2>
		<form action="./boardwrite" method="post"
			enctype="multipart/form-data" name="boardform">
			<div class="container pb-3 bg-light">


				<form>
					<div class="container p-2 ">
						<div class="row p-1 text-center ">
							<div class="col">
								<!-- https://codepen.io/jexordexan/pen/yyYEJa -->
								<table style="width: fit-content; margin: 0 auto;">
								
									<tr>
										<td colspan="2"></td>
										<td colspan="2">
											<div class="col">
												<textarea name="reviewContent"
													style="width: 100%; height: 100%;" placeholder="제목을 입력해주세요"></textarea>
											</div>
										</td>
									</tr>
									<tr rowspan="2">
										<td colspan="2">

											<div class="col">
												<!-- https://codepen.io/emiemi/pen/zxNXWR -->
												<div
													class="card border rounded text-center justify-content-center">
													<!-- <input type="file" name="revImgFile" style="width: 100%;" placeholder="사진을 이 곳에 업로드 해주세요"> -->
													<div class="btn-container">
														<!--the three icons: default, ok file (img), error file (not an img)-->
														<h1 class="imgupload">
															<i class="fa fa-file-image-o"></i>
														</h1>
														<h1 class="imgupload ok">
															<i class="fa fa-check"></i>
														</h1>
														<h1 class="imgupload stop">
															<i class="fa fa-times"></i>
														</h1>
														<!--this field changes dinamically displaying the filename we are trying to upload-->
														<p id="namefile">사진만 올려주세요!(jpg,jpeg,bmp,png)</p>
														<!--our custom btn which which stays under the actual one-->
														  <!-- 내장버튼인가 <button type="button" id="btnup" class="btn btn-primary">파일 선택2</button> -->
														<input type="file" value="" name="fileup" id="fileup" >
													</div>
												</div>
											</div>
										</td>
										&nbsp;
										<td colspan="2">
											<div class="col">
												<textarea name="reviewContent"
													style="width: 265px; height: 260px;"
													placeholder="사진에 대해 설명해 주세요"></textarea>
											</div>
										</td>
									</tr>
								</table>
							</div>
						</div>
					</div>

					<div class="row py-3">
						<div class="col text-center">
							<section id="commandCell">
								<button class="btn border bd-secondary">취소</button>
								<input type="submit" class="btn border bd-secondary" value="등록" />
							</section>
						</div>
					</div>

				</form>


			</div>
			</table>

		</form>
	</section>


	<!-- 게시판 등록 -->
</body>
</html>