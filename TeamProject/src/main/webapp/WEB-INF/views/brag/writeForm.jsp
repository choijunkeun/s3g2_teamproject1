<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 목업 코드, 아래 영역을 주석처리하면 로그아웃 처리된 것으로 짜볼 수 있음 -->
<%@ page import="com.ilinbun.mulcam.dto.User"%>
<%!User user = new User(1, "mockup@mock.up", "목업", "", "#", 5, 1);%>
<c:set var="user" value='<%=user%>' />
<!-- 목업 코드 끝. 수정요. -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- ckEditor code -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, viewport-fit=cover">
<script
	src="https://cdn.ckeditor.com/ckeditor5/32.0.0/classic/ckeditor.js"></script>


<title>게시글 작성</title>

<style>
/* ckEditor 넓이 높이 조절 */
.ck.ck-editor {
	max-width: 500px;
	font-weight: bolder;
}

.ck-editor__editable {
	min-height: 300px;
}

#top {
	margin-top: 20px;
}

.btn-container {
	background: #fff;
	border-radius: 5px;
	padding-bottom: 20px;
	margin-bottom: 20px;
}

.nav_container {
	background-color: black !important;
	border: 0 !important;
}

.white {
	color: white;
}

.imgupload {
	color: #1e2832;
	padding-top: 40px;
	font-size: 7em;
}

#namefile {
	color: black;
}

h4>strong {
	color: #ff3f3f;
}

.btn-primary {
	border-color: #ff3f3f !important;
	color: #ffffff;
	text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
	background-color: #ff3f3f !important;
	border-color: #ff3f3f !important;
}

/*these two are set to not display at start*/
.imgupload.ok {
	display: none;
	color: green;
}

.imgupload.stop {
	display: none;
	color: red;
}

/*this sets the actual file input to overlay our button*/
#fileup {
	opacity: 0;
	-moz-opacity: 0;
	filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0);
	width: 200px;
	cursor: pointer;
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
	bottom: 40px;
	height: 50px;
}

/*switch between input and not active input*/
#submitbtn {
	padding: 5px 50px;
	display: none;
}

#fakebtn {
	padding: 5px 40px;
}

/*www.emilianocostanzo.com*/
#sign {
	color: #1e2832;
	position: fixed;
	right: 10px;
	bottom: 10px;
	text-shadow: 0px 0px 0px #1e2832;
	transition: all.3s;
}

#sign:hover {
	color: #1e2832;
	text-shadow: 0px 0px 5px #1e2832;
}
</style>
<style>
input.star {
	display: none;
}

label.star {
	float: right;
	padding: 5px;
	font-size: 20px;
	color: #444;
	/* transition: all .2s; */
}

input.star:checked ~ label.star:before {
	content: '\f005';
	color: #FD4;
	/* transition: all .25s; */
}

/* input.star-5:checked ~ label.star:before {
			color: #FE7;
			text-shadow: 0 0 20px #952;
		}
		
		input.star-1:checked ~ label.star:before {
			color: #F62;
		}
		
		label.star:hover {
			transform: rotate(-15deg) scale(1.3);
		} */
label.star:before {
	content: '\f006';
	font-family: FontAwesome;
}

.outer {
	text-align: center;
}
</style>
<style>
.ck-editor__editable {
	min-height: 550px;
	min-width: 550px;
	max-width: 100%;
}
</style>
<body>
	<!--수정요. session 코드. 위의 목업 user 코드와 함께 수정요.  -->
	<section id="./writeForm">
		<!-- writeForm -->
		<div>
			<div class="container pb-3 bg-light" class="outer">
				<h5 class="fw-bolder" style="margin-left: 0%;">혼밥자랑</h5>
				<!-- Controller의 @PostMapping breagwrite 이어주는 코드 -->
				<form action="./bragwrite" method="post" name="bragform" id="bwForm">
					<div>
						<!-- 수정요. session값 받아오는 코드. session, user와 함께 수정요.  -->
						<input type="hidden" id="idx" name="idx" value=${user.idx }>
						<div class="container p-2 ">
							<div class="col text-center ">
								<div class="d-flex flex-wrap">
									<table>
										<tr>
											<td>
												<!--1. 문파선택  -->
												<div>
													<input type="hidden" name="moonpa" id="moonpa">
													<div class="btn-group-sort" style="width: fit-content;">
														<button type="button"
															class="btn btn-secondary dropdown-toggle"
															id="sortDropdown" data-bs-toggle="dropdown"
															aria-expanded="false">문파선택</button>
														<ul class="dropdown-menu text-center"
															aria-labelledby="sortDropdown">
															<li><button class="dropdown-item" type="button"
																	onclick="moonpaChange('true')">사먹파</button></li>
															<li><button class="dropdown-item" type="button"
																	onclick="moonpaChange('false')">해먹파</button></li>
														</ul>
													</div>
												</div> <!--2. 위치 선택 (문파 기반) -->
												<div class="input-group" style="flex-shrink: 0;">
													<input type="text" class="form-control" id="location"
														name="location" placeholder="위치를 검색해 보세요!" aria-label="위치">
													<!-- 검색하기 버튼 아니고, 위치 DB에 있으면 자동으로 뜨고 그걸 선택하면 들어가게  -->
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<!--3. 제목  -->
												<div>
													<input name="title" id="title" size="55%"
														placeholder="제목을 입력해주세요!" required="required">
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<!-- 4. ckEditor 입력 : content(사진, 내용) -->
												<div>
													<textarea id="editor" name="content"
														placeholder="내용을 입력해주세요!"></textarea>
												</div>
											</td>
										</tr>
									</table>
								</div>
							</div>

							<!-- 5. 취소, 전송 버튼 -->
							<div class="row py-3">
								<div class="col text-center">
									<!-- 수정요. 취소버튼 누르면 원래 있던 목록 화면으로 돌아가기  -->
									<button type="button" class="btn border bd-secondary"
										id="write_cancel" name="write_cancel">취소</button>
									<input type="submit" class="btn border bd-secondary"
										id="write_post" name="write_post" value="전송" />
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</section>




	<!-- JavaScript -->
	<script type="text/javascript"
		src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
	/*1-1. 문파선택 : dropbox에서 선택 시 그 문파이름으로 고정되게 하는 코드  */
		function moonpaChange(arg) {
			document.getElementById('moonpa').value=arg; 
			
			if(arg == 'true'){
				document.getElementById('sortDropdown').innerText='사먹파';
				/* document.getElementById('location'). */
			}
			else{
				document.getElementById('sortDropdown').innerText='해먹파';
			}
		}

/* 4-1. ekEditor -내용(content)부분 : img 저장폴더경로 지정 코드 */	
	$(function(){
        ClassicEditor
        	.create(document.querySelector("#editor"), {
        		ckfinder : {
        			uploadUrl : "/brag/upload"
        		}
        	}).then(editor=> {
        		//window.editor=editor;
        		editor.setData('${content}');
        	})
        	.catch((error) => {
        		console.error(error);
        	});
		});
	
	
</script>
</body>
</html>
