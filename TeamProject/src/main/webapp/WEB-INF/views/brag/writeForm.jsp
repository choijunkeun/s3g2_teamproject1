<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- ckEditor code -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
<script src="https://cdn.ckeditor.com/ckeditor5/32.0.0/classic/ckeditor.js"></script>

<title>게시글 작성</title>

<style>
/* ckEditor 넓이 높이 조절 */
.ck.ck-editor {
	max-width: 100%;
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
<link rel="stylesheet" href="http://code.jquery.com/ui/1.13.1/themes/smoothness/jquery-ui.css">
</head>
<body>
	<!--수정요. session 코드. 위의 목업 user 코드와 함께 수정요.  -->
	<section class="container" id="./writeForm">
		<!-- writeForm -->
		<div>
			<div class="container pb-3 bg-light outer  border rounded">
				<h5 class="fw-bolder pt-3 pb-2" style="margin-left: 0%;">혼밥자랑</h5>
				<!-- Controller의 @PostMapping breagwrite 이어주는 코드 -->
				<form action="bragwrite" method="post" name="bragform" id="bwForm">
			<!-- <form id="bwForm"> -->
			<input type="hidden" name="idx" id="idx" value="${user.idx }"> 
			<!-- 목업 유저정보 코드 -> ??? -->
					<div>
						<div class="row p-2 ">
							<div class="col text-center ">
								<div class="d-flex flex-wrap" >
									<table style="width: 100%; min-width: 100%; max-width: 100%;">
										<tr>
											<td>
												<!--1. 문파선택  -->
												<div class="d-flex" style="flex-wrap: nowrap;">
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
													<!--2. 위치 선택 (문파 기반) -->
													<div class="input-group" id="locationDiv" style="max-width: auto; flex-shrink: 1; display: none;">
														<input type="hidden" id="locationId">
														<input type="text" class="form-control" id="location" maxlength="40"
															name="location" placeholder="위치를 검색해 보세요!" aria-label="위치">
														<!-- 검색하기 버튼 아니고, 위치 DB에 있으면 자동으로 뜨고 그걸 선택하면 들어가게  -->
													</div>
												</div> 
											</td>
										</tr>
										<tr>
											<td>
												<!--3. 제목  -->
												<div class="input-group">
													<input type="text" name="title" id="title" class="form-control" maxlength="40"
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
										id="writeFormCancel" name="write_cancel">취소</button>
									<input type="submit" class="btn border bd-secondary"
										id="writeFormSubmit" name="write_post" value="전송" />
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
	<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.min.js"></script>
	<script>
		let idx = ${not empty user.idx? user.idx : false };
		if (idx == false) {
			alert("로그인을 하셔야 글 작성을 하실 수 있습니다. 로그인 해주세요.");
			location.href = "/login"
		}
	
		$('#writeFormSubmit').click(function(){
			if($('#moonpa').val() == null || $('#moonpa').val() == "" ){
				alert('문파를 선택해주세요!');
				return false;
			} else if($('#')){
				
			}
		});
	
	
	/*1-1. 문파선택 : dropbox에서 선택 시 그 문파이름으로 고정되게 하는 코드  */
		function moonpaChange(arg) {
			document.getElementById('moonpa').value=arg; 
			
			if(arg == 'true'){
				document.getElementById('sortDropdown').innerText='사먹파';
				document.getElementById('locationDiv').style.display="flex";
				/* document.getElementById('location'). */
			}
			else{
				document.getElementById('sortDropdown').innerText='해먹파';
				document.getElementById('locationDiv').style.display="none";
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
		// 훈 : 위치 검색 자동완성 구현 실험중
		$("#location").autocomplete({
			source: function(request, response){
				$.ajax({
					type:"GET",
					url:"/search/q?keyword=" + encodeURI($('#location').val()),
					async: false,
					success:function(data){
						var result = JSON.parse(data);
						var list = result["documents"];
						console.log(list);
						
						response(
							$.map(list, function(item){
								return {
									label: item.place_name + "(" + item.address_name + ")",
									value: item.place_name,
									'data-id': item.id
								};
							})
						);
					},
					error:function(){
						console.log("error");
						return false;
					}
				})
			},
			focus : function(event, ui) { // 방향키로 자동완성단어 선택 가능하게 만들어줌	
				return false;
			}, 
			select: function(event, ui){
				$('#locationId').val(${ui.item['data-id']});
			},
			minLength:1,
			delay:500,
			autoFocus: true
		});
	});
	
	
/*5-1. 완료 버튼 누르면 빈 공간 alert 및 작성 후 alert 부분  
	$('#writeFormSubmit').click(function(){
		if($('input[name="moonpa"]:checked').val() == null){
			alert('사먹었나요? 해먹었나요? 문파를 선택해 주세요')
		} else if($('#location').val() == null){
			alert('위치를 입력해 주세요')
		} else if($('#title').val() == null){
			alert('제목을 입력해주세요')
		} else if($('#content ').val() == null){
			alert('내용을 입력해주세요')
		} else{
			var formData = new FormData();
			var data = {
				"moonpa":$('input[name="moonpa"]:checked').val(),
		        "location":$('#location').val(),
		        "title":$('#title').val(),
		        "content":$('#content').val(),
		    };

		    formData.append("file",$('#file')[0].files[0]);
		    formData.append("key", new Blob([JSON.stringify(data)], {type:"application/json"})); 
			
			$.ajax({
				url:"./writeForm"
				type:"post",
				enctype: 'multipart/form-data',		
				processData: false, 
				contentType: false,
				data: formData,
				cache: false,
				async:false,
		        timeout: 600000,  
				success:function(data, textStatus) {
					alert("리뷰가 작성되었습니다.");
			location.href = "../${place.id}?place_name=" + encodeURI("${place.place_name}"); 
				},
				error: function(data, textStatus){
					alert("리뷰 작성 오류");
					return false; 
				}
			});
			
		}
		return false;
	});
	 */

	 
</script>
</body>
</html>
