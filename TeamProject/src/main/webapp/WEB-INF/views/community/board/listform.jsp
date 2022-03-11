<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>MVC 게시판</title>
<style type="text/css">
h2 {
	text-align: center;
	margin-left: 80px;
}

a {
	text-decoration-line: none;
	color: black;
}

table {
	margin: auto;
	width: 950px;
}

#tr_top {
	background: #f6f3f3;
	text-align: left;
}

#pageList {
	margin: auto;
	width: 1000px;
	text-align: center;
}

#listForm {
	text-align: left;
}

#emptyArea {
	margin: auto;
	width: 950px;
	text-align: center;
}
</style>
</head>

<body>
	<!-- 게시판 리스트 -->

	<h2>
		커뮤니티
		<button class="btn btn-outline-dark" type="button"
			style="float: right;" onclick="location.href='writeform'">글쓰기</button>
	</h2>
	
	<c:choose>
		<c:when test="${commList!=null && pageInfo.listCount>0 }">
			<section id="listForm">
				<table>
					<tr id="tr_top">
						<td>번호</td>
						<td>제목</td>
						<td>작성자</td>
						<td>날짜</td>
						<td>조회수</td>
					</tr>

					<c:forEach var="article" items="${commList }">
						<tr>
			<%-- 				<td>${article.art }</td>
							<td><c:choose>
									<c:when test="${article.board_re_lev!=0}">
										<!-- 레벨 0 -->
										<c:forEach var="i" begin="0" end="${article.board_re_lev*2}">
											<!-- 댓글에는 레벨이 있음 레벨이 0이 아니면 2개씩 들여쓰기 -->
							&nbsp;                   <!-- 들여쓰기를 위한 코드 -->
										</c:forEach>
						▶
					</c:when>
									<c:otherwise>▶</c:otherwise>
								</c:choose> --%>
								 <a
								href="./community/viewform/${article.articleNo}">
									<!-- 링크 --> ${article.title} <!-- 아티클 번호 -->
							</a></td>
							<td>${article.idx }</td>
							<!-- 보드명 날짜 리드카운트 . 컨텐트는 없음 -->
							<td>${article.date }</td>
							<td>${article.views }</td>
						</tr>
					</c:forEach>
				</table>
			</section>
			<section id="pageList">
				<!-- 페이지 목록 -->
				<!-- if else 랑 같음.  페이지가 1보다 작거나 같으면 이전페이지로 -->
				<c:choose>
					<c:when test="${pageInfo.page<=1}">
					[이전]&nbsp;
				</c:when>
					<c:otherwise>
						<a href="boardlist?page=${pageInfo.page-1}">[이전]</a>&nbsp;
				</c:otherwise>
				</c:choose>
				<c:forEach var="i" begin="${pageInfo.startPage }"
					end="${pageInfo.endPage }">
					<!-- end page 마지막 페이지 -->
					<!-- 현재페이지. 1페이지에서는 현재와 이전페이지 클릭될 필요가없음.-->
					<!-- 현재페이지를 제외한 나머지페이지 -->
					<c:choose>
						<c:when test="${pageInfo.page==i }">[${i }]</c:when>
						<c:otherwise>
							<a href="boardlist?page=${i}">[${i }]</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${pageInfo.page>=pageInfo.maxPage }">
					[다음]
				</c:when>
					<c:otherwise>
						<a href="boardlist?page=${pageInfo.page+1}">[다음]</a>
					</c:otherwise>
				</c:choose>
				<!-- 페이지에 답변 달았으면 그 페이지 목록이 보여야함. -->
				<!-- 눈에 보이진 않지만 페이지를 달고다님. -->
			</section>
		</c:when>
		<c:otherwise>
			<section id="emptyArea">등록된 글이 없습니다.</section>
		</c:otherwise>
	</c:choose>
</body>
</html>