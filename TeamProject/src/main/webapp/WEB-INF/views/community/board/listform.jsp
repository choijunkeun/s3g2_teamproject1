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

	<table>
	<tr style="text-align: center;">
	<th class="fa fa-exclamation-circle" style="font-size: 30px; margin-left: 150px;">커뮤니티</th>
        	<!-- 2. 글쓰기 버튼-->
		<button class="btn btn-outline-dark" id="commMake" name="commMake" type="button" style="float: right; width: 80px; height: 40px;">글쓰기</button>
	</tr>
	</table><br>
	


	<c:choose>
		<c:when test="${commList!=null && pageInfo.listCount>0 }">
			<section id="listForm">
				<table>
					<tr id="tr_top">
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>날짜</th>
						<th>조회수</th>
					</tr>

					<c:forEach var="article" items="${commList }">
		
						<tr>
							<td><a href="./community/viewform/${article.articleNo}">${article.articleNo}</a></td>
							<td><a href="./community/viewform/${article.articleNo}">${article.title}</a></td>
							<td><a href="./community/viewform/${article.articleNo}">${article.idx}</a></td>
							<td><a href="./community/viewform/${article.articleNo}">${article.date}</a></td>
							<td><a href="./community/viewform/${article.articleNo}">${article.views}</a></td>
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
						<a href="listform?page=${pageInfo.page-1}">[이전]</a>&nbsp;
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
							<a href="listform?page=${i}">[${i }]</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${pageInfo.page>=pageInfo.maxPage }">
					[다음]
				</c:when>
					<c:otherwise>
						<a href="listform?page=${pageInfo.page+1}">[다음]</a>
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
	
	
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	<script>
/*수정요. 비회원 클릭 시 로그인으로 넘어감. 세션값 필요  */
//	console.log(${pageInfo.page});
	// $(function(){
// 	$("#todayMake").click(function(){
// 		let id = $('#user_id').val();
// 		if(id == ''){
// 			alert("로그인 먼저 진행해주세요");
// 		}else{
// 			console.log("값넘기는거확인1");
// 			return "today_make";
// 		}
// 	});
// }); 
	
	
// 글쓰기 버튼 #bragMake 클릭 시 글쓰기writeform으로 이동  */
$(document).ready(function(){
	$('#commMake').on('click',function(){
		if('${user.idx }' == ''){
	        alert("회원이 아닙니다. 로그인을 해주세요!");
			location.href="/login";
		} else {
			location.href="/comm/writeform";	
		}
	});
});


</script>

</body>
</html>