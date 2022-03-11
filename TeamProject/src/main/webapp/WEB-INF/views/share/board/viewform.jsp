<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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

<title>반찬공유 게시판 게시글 보기</title>
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
.ck-editor__editable {
	min-height: 550px;
	min-width: 550px;
	max-width: 100%;
}
</style>
<style type="text/css">
#articleForm {
	width: 700px;
	height: 500px;
	/* border: 1px solid red; */
	margin: auto;
}

h2 {
	text-align: center;
}

a {
	text-decoration-line: none;
	color: black;
}

#basicInfoArea {
	height: 40px;
	text-align: left;
}

#articleContentArea {
	background:  #f6f3f3;
	margin-top: 10px;
	height: 410px;
	text-align: center;
	overflow: auto;
}

#commandList {
	margin: auto;
	width: 700px;
	text-align: center;
}
</style>
</head>
<body>
<!-- 게시판 수정 -->
	<section id="articleForm">
	<h2>반찬공유 게시판</h2>
		<section id="articleContentArea">
			<div>
			<section id="basicInfoArea">
				로그인한 유저 번호 : ${user.idx }
				<br> 로그인한 유저 이메일 : ${user.email }
				<br> 로그인한 유저 별명 : ${user.nickname }
				<br> 지금 보려는 글 정보
				<br> 글 제목 : ${shboard.title }
				<br> 글 내용 : ${shboard.content }
				<br> 글 이미지 파일명: ${imgSrc } 글 작성자 번호 : ${shboard.idx }
				<br> ${shboard.idx == user.idx ? "수정, 삭제" : "안보여"}
			</section>
			</div>
		</section>
		<div>
			<section id="commandList">
				<a href="replyform?board_num=${articleNo}&page=${page}"> [답변] </a> 
				<a href="modifyform?board_num=${articleNo}"> [수정] </a> 
				<a href="deleteform?board_num=${articleNo}&page=${page}"> [삭제] </a>
				<a href="./boardlist?page=${page}"> [목록]</a>&nbsp;&nbsp;
			</section>
		</div>
	</section>

	<script>
	/* -1. ekEditor -내용(content)부분 : img 이동경로 지정 코드 */	
	$(function(){
	      ClassicEditor.create(document.querySelector("#editor"), {
	    	  initialData : '${viewdetail.content}'
	      }).then(editor=> {
    		window.editor=editor;
    		})
		   .catch((error) => {
		   	console.error(error);
		    });
		});
</script>
</body>
</html>