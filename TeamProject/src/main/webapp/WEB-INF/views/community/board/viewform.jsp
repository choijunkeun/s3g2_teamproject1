<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	background: #f6f3f3;
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



body>div>p>img {
	max-width: 500px;
	height: auto;
}


</style>
<style>
.PreListNext{
display: inline-block;
}
</style>

</head>

<body>

	<div class="card justify-content-center text-center border-right">
		<div class="card-header d-flex justify-content-between">
		<button type="button" class="btn btn-secondary" style="display: flex;">제목</button>
			<h2 class="card-title fw-bolder">${cboard.title }</h2>
			<a href="/comm/listform" class="my-auto"><i class="fa fa-times-circle fa-2x"
							aria-hidden="true"></i></a>
		</div>
		<div class="card-body">
			<div class="row mb-2">
				<div class="col-sm-4 d-flex align-self-center">
					<a href="../../userInfo/${cboard.idx}"> <img
						style="border-radius: 50px; width: 40px; height: 40px; margin: 0 auto;"
						src='/profile/${user.profileImg }'>
						<div class="border pb-2 pt-1 mx-1 rounded"
							style="display: inline; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">
							${nickname}님</div>
						<span class="badge bg-danger rounded-pill m-2">Lv.${userinfo.honbabLevel}</span>
					</a>
					
					<c:if test="${not empty user && !(cboard.idx eq user.idx) }">
					<button class="btn btn-primary text-white align-self-center" style="height: fit-content;" 
					id="follow${cboard.idx}" onclick="togglefollow(${cboard.idx});">${didIFollowed>0? "언팔로우": "팔로우"}</button>
					</c:if>
				
					
				</div>
				<div class="col-sm-4 d-flex justify-content-center align-self-center">
					<strong style="font-size: 30px">🐻</strong>
				</div>
				<div class="col-sm-4 d-flex justify-content-end text-end align-self-center">
						조회수 : ${cboard.views } | 작성일 : ${cboard.date }</div>
				
			</div>
			<hr>
			<!-- 게시글 본문 -->
			<div class="row">&nbsp;</div>
			<div class="row">
				<article id="boardContent">${cboard.content }</article>

			</div>
		

		
			<div class="row">
				<div class="col d-flex justify-content-end align-items-center">
					<!-- 좋아요 -->
					<button
						class="btn-sm border-0 bg-transparent text-danger mx-2"
						id="likebtn${cboard.articleNo }" onclick="toggleLikes(${cboard.articleNo})">
						<i class="fa fa-lg ${didILiked>0 ? 'fa-heart' : 'fa-heart-o' }" aria-hidden="true">${likes }</i>
					</button>
					<div>
						<i class="fa fa-commenting fa-lg mx-2" aria-hidden="true">${countComment }</i>
					</div>
				</div>
				
			</div>
			<div class="row"> <!-- 글 수정, 삭제 -->
				<div class="col" style="text-align: center;">
					<c:if test="${user.idx == cboard.idx || user.grp == 2}">
						<c:if test="${user.idx == cboard.idx }">
							<a class="btn border-dark onlyWriter" style="color: black;"
								href="/comm/modifyform?articleNo=${cboard.articleNo}">수정</a>
						</c:if>
						<a class="btn border-dark onlyWriter" style="color: black;"
							href="/comm/deleteform?articleNo=${cboard.articleNo}&page=${page}">삭제</a>
					</c:if>
				</div>
			</div>
		</div>
		<div class="card-footer">
				<form class="d-flex" action="/comm/comment" method="post">
					<div class="p-3 align-items-center">
						<input name="articleNo" type="hidden" value=${cboard.articleNo }></input>
						<input name="idx" type="hidden" value=${user.idx }></input>
					</div>
					<div class="flex-grow-1">
						<textarea style="width: 100%;" name="commentWrite"></textarea>
					</div>
					<div class="p-2">
						<label class="d-block"><input id="blind" name="blind" type="checkbox" value="1">비밀댓글</label>
						<input class="d-block btn btn-danger" id="commentBtn" type="submit" value="댓글작성">
					</div>
				</form>
			</div>
	
	
	<hr>


	<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->



	

		<!-- 댓글 보기 -->
		<!-- 프사, 아이디, : 내용, 작성일, (내가 쓴 댓글 시) 수정/삭제 버튼  -->
		<!--commentUserList commentList-->

		<div class="container">
			<c:forEach var="reply" items="${commentList}" varStatus="status">
				<c:choose>
					<c:when test="${status.end == 0}">
				댓글이 없습니다. 첫 댓글을 작성해 주세요!
			</c:when>
					<c:otherwise>
						<c:choose>
							<c:when
								test="${reply.blind eq false || reply.idx eq user.idx || cboard.idx eq user.idx}">
								<!--다 보여주고 댓쓴이는 수정 삭제 보여줘(관리자는 삭제) + 대댓-->
								<div class="row my-3" style="text-align: left;">
								<div class=" d-flex" style="align-items: center">
									<div class="d-flex flex-grow-1">
									<div>
										<c:choose>
											<c:when test="${reply.lev != 0 }">
												<c:forEach var="i" begin="1" end="${reply.lev*8}">&nbsp;
												</c:forEach>
											<i class="bi bi-arrow-return-right"></i>
											</c:when>
										</c:choose>
									</div>
										<div class="text-center px-2 style="width: fit-content;">
											<a href="../../userInfo/${commentUserList[status.index].idx}">
											<img style="border-radius: 50px; width: 30px; height: 30px;"
												src="/profile/${commentUserList[status.index].profileImg}" >
											<p class="m-0">${commentUserList[status.index].nickname }</p></a>
										</div>
										<div class="px-2 flex-grow-1">
											<p style="width: 500px" id="comm${reply.commentNo}">${reply.comment }</p>
											<input type="hidden" style="width: 500px"
												id="comment${reply.commentNo}" value="${reply.comment }"></input>
										</div>
									</div>
									<div>
										<div class="px-2 float-end">
											<p class="m-0 float-right">${reply.date }</p>
										</div>
										<div class="px-2">
											<c:if test="${user!=null}">
												<button class="btn btn-sm border-dark"
													onclick="document.getElementById('replyReply${reply.commentNo}').style.display='flex';">대댓글쓰기</button>
											</c:if>
											<c:if test="${user.idx == reply.idx || user.grp == 2}">
												<c:if test="${user.idx == reply.idx }">
													<button class="btn btn-sm border-dark"
														onclick="editReply(${reply.commentNo},${reply.articleNo});">
														<i class="bi bi-pencil-square"></i>
														</button>
												</c:if>
												<button class="btn btn-sm border-dark"
													onclick="deleteReply(${reply.commentNo},${reply.articleNo});">
													<i class="bi bi-trash"></i>
													</button>
											</c:if>
										</div>
									</div>
								</div>
									<div class="row" id="replyReply${reply.commentNo }" style="display: none;">
										<form class="d-flex"id="replyReply" action="/comm/reReply" method="post">
										<div class="p-2" style="">
											<c:choose>
												<c:when test="${reply.lev != 0 }">
													<c:forEach var="i" begin="1" end="${reply.lev*8}">&nbsp;
													</c:forEach>
												</c:when>
											</c:choose>
										</div>
										<div class="p-2 flex-grow-1">
											<textarea name="commentWrite" style="width: 100%;"></textarea>
										</div>
										<div class="p-2">
											<input type="hidden" name="idx" value="${user.idx }">
											<input type="hidden" name="articleNo" value="${cboard.articleNo}">
											<input type="hidden" name="commentNo" value="${reply.commentNo}">
											<label class="d-block"><input type="checkbox" name="blind"
															id="blind${reply.commentNo }" value="1">비밀댓글</label> 
											<input class="btn btn-sm bg-danger text-white d-block" type="submit"
														value="답글쓰기">
										</div>
										</form>
									</div>
								</div>
								<c:if test="${not status.last }"><hr></c:if>
							</c:when>

							<c:otherwise>
								<div class="row">
									<span>해당 댓글은 비밀댓글입니다. 글 작성자와 댓글 작성자만 볼 수 있습니다.</span>
								</div>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</c:forEach>


		</div>
	</div>
	</div>
	</div>
	

	<!-- 이전 목록 다음 -->

	<%-- <div class="row">
		<div class="col" style="text-align: left;">
			<a type="button" id="btnList" class="btn btn-default" href="/comm/viewform/${articleNo+1}">이전</a>
		</div>
		<div class='col' style="text-align: center;">
			<a type="button" id="btnList" class="btn btn-default" href="/comm/listform?page=${page}">목록</a>
		</div>

		<div class='col' style="text-align: right;">
			<a type="button" id="btnList" class="btn btn-default" href="/comm/viewform/${articleNo-1}">다음</a>
		</div>
	</div>
 --%>










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
	function editReply(commentNo, articleNo) {
 		
		if($('#comment'+commentNo).attr("type") == 'hidden'){
			$('#comment'+commentNo).attr("type", "text")
			$('#comm'+commentNo).hide();
			return false;
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

<script>
/* 팔로우 기능 */
	function togglefollow(idx){
		if(${empty user}){
			alert("로그인을 하셔야 사용하실 수 있는 기능입니다.");
			return false;
		} else {
			$.ajax({
				type:"POST",
				url:"/follow/",
				cache: false,
				data:{"idx": idx},
				async:false,
				success: function(data){
					result = JSON.parse(data);
					if(result.didIFollowed >0){ // 팔로우를 한 적이 없는 경우
						$('#follow' + idx).text('언팔로우');
						
					} else if(result.didIFollowed <=0){ // 팔로우를 이미 한 경우
						$('#follow' + idx).text('팔로우');
					}
				},
				error:function(data){
					alert('팔로잉을 처리하는 동안 문제가 있었습니다. 나중에 다시 시도해주세요.');
				}
			})
		}
	}
</script>
</html>


