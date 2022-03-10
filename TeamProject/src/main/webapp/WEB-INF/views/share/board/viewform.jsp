<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반찬공유 게시판</title>
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
	<section id="basicInfoArea">
			제 목 : ${article.board_subject }<br>
			첨부파일 :
			<c:if test="${article.board_filename!=null }">
				<a href="file_down?downFile=${article.board_filename}"> ${article.board_filename} </a>
			</c:if>
			<br>
			<a href="./boardlist?page=${page}" style="text-align: left"> ${article.board_name }</a>
			 조회수 ${article.board_readcount }  작성일 ${article.board_date }
	</section><br><br>
		${article.board_content }
	</section>
	</section>
	<section id="commandList">
		<a href="replyform?board_num=${article.board_num}&page=${page}"> [답변] </a> 
		<a href="modifyform?board_num=${article.board_num}"> [수정] </a> 
		<a href="deleteform?board_num=${article.board_num}&page=${page}"> [삭제] </a>
		<a href="./boardlist?page=${page}"> [목록]</a>&nbsp;&nbsp;
	</section>
</body>
</html>