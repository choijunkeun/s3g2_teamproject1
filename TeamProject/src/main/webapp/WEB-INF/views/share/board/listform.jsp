<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%-- <%@ page import="java.text.SimpleDateFormat"%> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>반찬공유 게시판</title>
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
/* 공시사항 게시글 배경색깔 */
.noti {
	background-color: #E3E3E3;
	opacity:0.8;
	color: black !important;
	font-weight: bold;
}
</style>
</head>

<body>
<!-- 글쓰기 버튼 -->
	<div>
	<table>
	<tr style="text-align: center;">
	<th style="font-size: 30px;"><i class="fa fa-exclamation-circle">&nbsp;</i>반찬공유 게시판</th>
        <button class="btn btn-outline-dark" 
				id="shareMake" name="shareMake" type="button"
				style="float: right; width: 80px; height:40px;">글쓰기</button>
		
	</tr>
	</table><br>
		<%-- <a href="${pageContext.request.contextPath}/share/board/writeform"> --%>
			
		<!-- </a> -->
	</div>

	<!-- 게시판 리스트 -->

	<div class="row justify-content-center">
		<div class="content">
			<c:choose>
				<c:when test="${shareList!=null && pageInfo.listCount>0 }">
					
					<hr>
					<section id="listForm">
						<table class="table">
							<tr id="tr_top">
								<td>말머리</td>
								<td>제목</td>
								<td>위치</td>
								<td>작성자</td>
								<td>날짜/시간</td>
								<td>조회수</td>
							</tr>
					<c:forEach var="shboard" items="${shareList }">
					<tr class=${shboard.grp == 2 ? "noti" : "normal" }>
						<%-- <c:if test="${status.index<15}"> --%>
								<td>${shboard.headerTag eq 0? "공유중" : shboard.headerTag eq 1? "공유완료": shboard.headerTag eq 2? "공지글" :"알 수 없음" }</td>

								<td>
									<a href="./viewform/${shboard.articleNo }?page=${pageInfo.page}">${shboard.title }</a>
								</td>
								<td>
									<a href="./viewform/${shboard.articleNo }?page=${pageInfo.page}"> ${shboard.subway }</a>
								</td>
								<td>
									<a href="./viewform/${shboard.articleNo }?page=${pageInfo.page}">${shboard.nickname }</a>
								</td>
								<td>
									<a href="./viewform/${shboard.articleNo }?page=${pageInfo.page}">
										<fmt:parseDate value="${shboard.date }" type="date" pattern="yyyy-MM-dd'T'HH:mm" var="formatDate"/>
										<fmt:formatDate value="${formatDate }" type="date" pattern="yyyy-MM-dd HH:mm"/>
									</a>
								</td>
								<td>
									<a href="./viewform/${shboard.articleNo }?page=${pageInfo.page}">${shboard.readCount }</a>
								</td>
							</tr>
					<%-- 	</c:if>	 --%>
					</c:forEach>
						</table>
					</section>
					<hr>
					<nav id="pageList">
				<ul class="pagination justify-content-center">
				<!-- 페이지 목록 -->
				<!-- if else 랑 같음.  페이지가 1보다 작거나 같으면 이전페이지로 -->
				<c:choose>
					<c:when test="${pageInfo.page<=1}">
					<li class="page-item"><a class="page-link" href="#">이전</a></li>
				</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link" 
								href="listform?page=${pageInfo.page-1}">이전</a></li>
					</c:otherwise>
				</c:choose>
				<c:forEach var="i" begin="${pageInfo.startPage }"
					end="${pageInfo.endPage }">
					<!-- end page 마지막 페이지 -->
					<!-- 현재페이지. 1페이지에서는 현재와 이전페이지 클릭될 필요가없음.-->
					<!-- 현재페이지를 제외한 나머지페이지 -->
					<c:choose>
						<c:when test="${pageInfo.page==i }">
							<li class="page-item active">
								<a class="page-link" href="#">${i }</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link" 
									href="listform?page=${i}">${i }</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${pageInfo.page>=pageInfo.maxPage }">
					<li class="page-item"><a class="page-link" href="#">다음</a></li>
				</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link" 
								href="listform?page=${pageInfo.page+1}">다음</a></li>
					</c:otherwise>
				</c:choose>
				<!-- 페이지에 답변 달았으면 그 페이지 목록이 보여야함. -->
				<!-- 눈에 보이진 않지만 페이지를 달고다님. -->
				</ul>
			</nav>
		</c:when>
		<c:otherwise>
			<section id="emptyArea">등록된 글이 없습니다.</section>
		</c:otherwise>
	</c:choose>
		</div>
	</div>
	<script>
	$(document).ready(function(){
		$('#shareMake').on('click',function(){
			if('${user.idx }' == ''){
				alert("회원이 아닙니다. 로그인을 해주세요!")
				location.href="/login";
			} else {
				location.href="/share/board/writeform";	
			}
		});
	});

	</script>
</body>
</html>