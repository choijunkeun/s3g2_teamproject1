<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- ckEditor code -->
<script src="https://cdn.ckeditor.com/ckeditor5/32.0.0/classic/ckeditor.js"></script>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.13.1/themes/smoothness/jquery-ui.css">
<title>게시글 수정</title>

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
								<!--1. 문파선택  -->
								
								<div class="d-flex flex-nowrap input-group">
									<span class="input-group-text bg-secondary text-white">${bboard.moonpa? '사먹파':'해먹파' }</span>
									<input type="hidden" name="moonpa" id="moonpa" value="${bboard.moonpa }">
									<!--2. 위치 선택 (문파 기반) -->
									<!-- <div class="input-group" style="max-width: auto; flex-shrink: 1;"> -->
										<input type="text" class="form-control" id="location" maxlength="40" value="${bboard.location}"
											name="location" placeholder="위치를 ${bboard.moonpa? '검색해 보':'입력해 주'}세요!" aria-label="위치">
										<!-- 검색하기 버튼 아니고, 위치 DB에 있으면 자동으로 뜨고 그걸 선택하면 들어가게  -->
									<!-- </div> -->
								</div> 
								<!--3. 제목  -->
								<div class="input-group">
									<input type="text" name="title" id="title" class="form-control" maxlength="40"
										placeholder="제목을 입력해주세요!" required="required" value="${bboard.title }">
								</div>

								<!-- 4. ckEditor 입력 : content(사진, 내용) -->
								<div>
									<textarea id="editor" name="content"
										placeholder="내용을 입력해주세요!"></textarea>
								</div>
							</div>

							<!-- 5. 취소, 전송 버튼 -->
							<div class="row py-3">
								<div class="col text-center">
									<!-- 수정요. 취소버튼 누르면 원래 있던 목록 화면으로 돌아가기  -->
									<button type="button" class="btn border bd-secondary"
										id="writeFormCancel" name="write_cancel" onclick="javascript:window.location.href='/brag/viewdetail/${bboard.articleNo}'">취소</button>
									<input type="submit" class="btn border bd-secondary"
										id="writeFormSubmit" name="write_post" value="전송" />
								</div>
							</div>
						</div>
					</div>
					<!-- 
					<section id="commandCell">
						<a href="javascript:modifyboard()">[수정]</a>&nbsp;&nbsp; <a
							href="javascript:history.go(-1)">[뒤로]</a>
					</section> -->
				</form>
			</div>
		</div>
	</section>




	<!-- JavaScript -->
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.min.js"></script>
	<script>

/* 4-1. ekEditor -내용(content)부분 : img 저장폴더경로 지정 코드 */	
	$(function(){
        ClassicEditor
        	.create(document.querySelector("#editor"), {
        		ckfinder : {
        			uploadUrl : "/brag/upload"
        		}
        	}).then(editor=> {
        		//window.editor=editor;
        		editor.setData('${bboard.content}');
        	})
        	.catch((error) => {
        		console.error(error);
        	});
		});
	
	
/* 	$('#fileChange').click(function(){
		$('#file').prop('disabled', !$('#file').prop('disabled'));
		if($('#file').prop('disabled')){
			$('#btnup').addClass('btn-secondary');
			$('#btnup').removeClass('btn-danger');
		} else{
			$('#btnup').addClass('btn-danger');
			$('#btnup').removeClass('btn-secondary');
		}
	}) */
/*5-1. 수정완료 버튼 누르면 alert 부분  
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
				url:"../editReview",
				type:"post",
				enctype: 'multipart/form-data',		
				processData: false, 
				contentType: false,
				data: formData,
				cache: false,
				async:false,
		        timeout: 600000,  
				success:function(data, textStatus) {
					alert("리뷰가 수정되었습니다.");
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

<c:if test="${bboard.moonpa}">
<script>
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
</script>
</c:if>
</body>
</html>
