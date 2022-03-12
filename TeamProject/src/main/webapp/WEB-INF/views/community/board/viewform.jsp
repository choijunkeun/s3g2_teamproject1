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
			제 목 : ${cboard.title}<br>
			작성자 : ${nickname}  작성일 : ${cboard.date} 조회수 : ${cboard.views}
			<!-- 좋아요 -->
	<button class="btn-sm border-danger rounded-pill bg-white text-danger" 
		id="likebtn${cboard.articleNo }" onclick="toggleLikes(${cboard.articleNo})">
		<i class="fa ${didILiked>0 ? 'fa-heart' : 'fa-heart-o' }" 
		aria-hidden="true">${likes }</i>
		</button>
		<br>
			
	</section><br><br>
		${cboard.content}
	</section>
	</section>
	<section id="commandList">
		<%-- <a href="/comm/replyform?articleNo=${cboard.articleNo}&page=${page}"> [답변] </a>  --%>
		<a class="onlyWriter" href="/comm/modifyform?articleNo=${cboard.articleNo}"> [수정] </a> 
		<a class="onlyWriter" href="/comm/deleteform?articleNo=${cboard.articleNo}&page=${page}"> [삭제] </a>
		<a href="/comm/listform?page=${page}"> [목록]</a>&nbsp;&nbsp;
	</section>
</body>
<script>

/* @@@@@@@     관리자나 로그인한 사용자만 수정 삭제 보이게 구현    @@@@@@@*/
$(function() {
	
	let writerIdx = ${cboard.idx}; //작성자 정보
	let isLogined = ${user != null} // 로그인 유무
	
	$('.onlyWriter').css("display", "none"); // 일단 안보이게
	
	let loginIdx = `${user == null ? "" : user.idx}`; // 로그인 한 사용자 정보
	
	console.log(loginIdx);
	let isAdmin = ${user.grp == 2 }	// 로그인한 사용자가 관리자인지

	if ((loginIdx == writerIdx) || isAdmin) { // 만약에 작성자와 로그인한 사용자가 같거나 ,,, 관리자 라면
		$('.onlyWriter').css("display", "inline-block");	// 보이게 
	}
})

</script>

<!-- 좋아요 -->
<script>
function toggleLikes(articleNo){
	if(${empty user}){
		alert("로그인을 하셔야 사용하실 수 있는 기능입니다.");
		return false;
	} else {
		$.ajax({
			type:"POST",
			url:"/comm/likes/",
			cache: false,
			data:{"articleNo": articleNo, "idx":${not empty user.idx? user.idx:"0"}},
			async:false,
			success: function(data){
				result = JSON.parse(data);
				$('#likebtn' + articleNo).children('i').text(result.currentLikes);
				if(result.processed >0){
					$('#likebtn' + articleNo).children('i').removeClass('fa-heart-o');
					$('#likebtn' + articleNo).children('i').addClass('fa-heart');
				} else if(result.processed <0){
					$('#likebtn' + articleNo).children('i').removeClass('fa-heart');
					$('#likebtn' + articleNo).children('i').addClass('fa-heart-o');
				}
			},
			error:function(data){
				$('#likebtn' + articleNo).children('i').text('좋아요');
			}
		})
	}
}
</script>
</html>