<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MVC 게시판</title>
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
		<h2>커뮤니티</h2>
		
	<section id="articleContentArea">
	<section id="basicInfoArea">
			제 목 : ${article.title}<br>
			<%-- 첨부파일 :
			<c:if test="${article.idx!=null }">
				<a href="file_down?downFile=${article.idx}"> ${article.idx} </a>
			</c:if> --%>
		
			<a href="./listform?page=${page}" style="text-align: left"> ${article.idx}</a>
			 조회수 : ${article.views}  작성일 : ${article.date}
	</section><br><br>
		${article.content}
	</section>
	</section>
	<section id="commandList">
		<a href="replyform?articleNo=${article.articleNo}&page=${page}"> [답변] </a> 
		<a href="modifyform?articleNo=${article.articleNo}"> [수정] </a> 
		<a href="deleteform?articleNo=${article.articleNo}&page=${page}"> [삭제] </a>
		<a href="listform?page=${page}"> [목록]</a>&nbsp;&nbsp;
	</section>
</body>
</html>