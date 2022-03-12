<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>


<html>
<head>
<meta charset="UTF-8">
<!-- ckEditor -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, viewport-fit=cover">
<!-- 클래식 에디터 -->
<script	src="https://cdn.ckeditor.com/ckeditor5/32.0.0/classic/ckeditor.js"></script>
<script>
	$(function(){
        ClassicEditor
        	.create(document.querySelector("#editor"), {
        		ckfinder : {
        			uploadUrl : "/comm/upload"
        		}
        	}).then(editor=> {
        		window.editor=editor;
        	})
        	.catch((error) => {
        		console.error(error);
        	});
	});
</script>

<title>커뮤니티</title>
<script type="text/javascript">
	function modifyboard(){
	modifyform.submit();
	}
</script>


<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
	
<style type="text/css">
h5 {
	/* text-align: center; */
	font-size: 30px;
	margin-left: 0%
}

#commandCell {
	text-align: center;
}


/* @@@@@@  ck에디터   @@@@@@@ */
.ck-editor__editable {
	min-height: 550px;

	max-width: 100%;
}







</style>

</head>
<body>
	<!-- 게시판 등록 -->

<section id="./writeForm">

	<div >
		<div class="container pb-3 bg-light" class="outer" >
			<h5 class="fw-bolder" >커뮤니티 글수정</h5>

			<form action="modifyform" method="post" enctype="multipart/form-data" name="modifyform" >
				<div>
					<input type="hidden" id="articleNo" name ="articleNo" value="${article.articleNo}">
					<div class="container p-2 ">
						<div class="row p-1 text-center ">
							<div class="col">
								<input name="title" id="title" style="display: inline-block;width:100%;" value='${article.title}' placeholder="제목을 입력해주세요!" required="required">
									<!-- ckEditor -->	
									<textarea id="editor" name="content" placeholder="내용을 입력해주세요!" >${article.content}</textarea>
							</div>
						</div>
					</div>

					<div class="row py-3">
						<div class="col text-center">
							<!-- <input type="reset" value="다시쓰기" /> -->
							<section id = "commandCell">
							<a class="btn border bd-secondary" href="javascript:history.go(-1)">취소</a>
							<a class="btn border bd-secondary" href="javascript:modifyboard()">수정</a>
							</section>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	</section>



	



</body>
</html>




