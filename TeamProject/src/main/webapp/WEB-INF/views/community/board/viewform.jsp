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
	width: 710px;
	height: auto;
	text-align: left;
	overflow: auto;
}

#commandList {
	margin: auto;
	width: 700px;
	text-align: center;
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
</style>

</head>

<body>
	<!-- 게시판 수정 -->
	<section id="articleForm">
		<h2>커뮤니티</h2>
	<table>
	
	<td>
	<section id="articleContentArea">
	<section id="basicInfoArea">
			제 목 : ${cboard.title}<br>
			작성자 : <a href="../../userInfo/${cboard.idx}">${nickname}</a> 작성일 : ${cboard.date} 조회수 : ${cboard.views}
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
	</td>
	</table>
	<td>

	<section id="commandList">
		<%-- <a href="/comm/replyform?articleNo=${cboard.articleNo}&page=${page}"> [답변] </a>  --%>
		<a class="onlyWriter" href="/comm/modifyform?articleNo=${cboard.articleNo}"> [수정] </a> 
		<a class="onlyWriter" href="/comm/deleteform?articleNo=${cboard.articleNo}&page=${page}"> [삭제] </a>
		<a href="/comm/listform?page=${page}"> [목록]</a>&nbsp;&nbsp;
	</section>
	</td>
	
	<!-- 댓글 보기 -->
	<!-- 프사, 아이디, : 내용, 작성일, (내가 쓴 댓글 시) 수정/삭제 버튼  -->
	<!--commentUserList commentList-->
	<div class="container">
		<c:forEach var="reply" items="${commentList}" varStatus="status">
		<c:choose>
		<c:when test="${reply.blind eq false || reply.idx eq user.idx || cboard.idx eq user.idx}">
			<div class="row">
				<div class="col">
					<img style="border-radius: 50px; width: 30px; height: 30px;"
						src=/profile/${commentUserList[status.index].profileImg}>
					<a href="../../userInfo/${commentUserList[status.index].idx }"><p>${commentUserList[status.index].nickname }</p> </a>
				</div>
				<div class="col">
					<input type="text" id="comment${reply.commentNo}"
						value="${reply.comment }" readOnly></input>
				</div>
				<div class="col">
					<p>${reply.date }</p>
				</div>
				<div class="col">
					<c:if test="${user!=null}">
						<div class="if-thisArticle-mine text-end">
							<button class="btn border-dark"
								onclick="document.getElementById('replyReply${reply.commentNo}').style.display='flex';">
								대댓글쓰기</button>							
						</div>
					</c:if>
					<c:if test="${user.idx == reply.idx}">
						<div class="if-thisArticle-mine text-end">
							<button class="btn border-dark"
								onclick="editReply(${reply.commentNo},${reply.articleNo});">댓글수정</button>

							<button class="btn border-dark"
								onclick="deleteReply(${reply.commentNo},${reply.articleNo});">댓글삭제</button>
						</div>
					</c:if>
					<c:if test="${user.grp == 2 }">
						<div class="if-thisArticle-mine text-end">
							<button class="btn border-dark"
								onclick="deleteReply(${reply.commentNo},${reply.articleNo});">댓글삭제</button>
						</div>
					</c:if>
				</div>
				<div class="row" id="replyReply${reply.commentNo }" style="display:none;">
					<form id="replyReply" action="/comm/reReply" method="post">
						<input type="text" name="commentWrite">
						<input type="hidden" name="idx" value="${user.idx }">
						<input type="hidden" name="articleNo" value="${cboard.articleNo}">
						<input type="hidden" name="commentNo" value="${reply.commentNo}">
						<input type="checkbox" name="blind" id="blind${reply.commentNo }" value="1">
						<label for="blind${reply.commentNo }">비밀댓글</label>
						<input type="submit" value="답글쓰기">
					</form>
					
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="row">
				<span>해당 댓글은 비밀댓글입니다. 글 작성자와 댓글 작성자만 볼 수 있습니다.</span>
			</div>
		</c:otherwise>
		</c:choose>
		</c:forEach>
	</div>
	<br>
	<!--댓글 작성  -->
	<form id="" action="/comm/comment" method="post" style="text-align: center">
		<input name="articleNo" type="hidden" value=${cboard.articleNo }></input>
		<input name="idx" type="hidden" value=${user.idx }></input>
		<textarea name="commentWrite"></textarea>
		<input id="blind" name="blind" type="checkbox" value="1">익명댓글
		<input id="commentBtn" type="submit" value="댓글작성">
	</form>


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

<script>
/*댓글 수정버튼 누르면~  */
	function editReply(commentNo, articleNo){
 		
		let isReadOnly = $('#comment'+commentNo).attr("readOnly")
		if(isReadOnly){
			$('#comment'+commentNo).attr("readOnly", false) 
		} else{
			let comment = $('#comment'+commentNo).val()
			
			$.ajax({
				type:"POST",
				url:"/comm/editReply",
				cache: false,
				data:{"commentNo": commentNo,"articleNo": articleNo, "comment":comment},
				async:false,
				complete:function(){
					window.location.href="/comm/viewform/"+articleNo;
				}
				
			})
		}
	}

	

	
	/*댓글 삭제버튼 누르면~  */
	function deleteReply(commentNo, articleNo){
		let comment = $('#comment'+commentNo).val()
		if(confirm("게시글을 삭제하시겠습니까?")){
			let f = document.createElement('form');
			
		   
		    f.setAttribute('method', 'post');
		    f.setAttribute('action', '../deleteReply'); 
		    document.body.appendChild(f);
		    f.submit();
		    
		    $.ajax({
				type:"POST",
				url:"/comm/deleteReply",
				cache: false,
				data:{"commentNo": commentNo,"articleNo": articleNo, "comment":comment},
				async:false,
				complete:function(){
					console.log(commentNo);
					window.location.href="/comm/viewform/"+articleNo;
				}
				
			})
		}
		
		
	}
</script>

<script>
$(function(){ /* 로그인 해야 댓글 작성 가능 */
	$("#commentBtn").click(function(){
		if(${empty user}){
			alert("로그인을 하셔야 사용하실 수 있는 기능입니다.");
			return false;
		}
		
	})
})

</script>

<script>
<!-- 좋아요 -->
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


