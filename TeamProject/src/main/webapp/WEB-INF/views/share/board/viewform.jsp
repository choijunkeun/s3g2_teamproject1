<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<!-- ckEditor code -->
			<meta http-equiv="X-UA-Compatible" content="IE=edge">
			<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
			<script src="https://cdn.ckeditor.com/ckeditor5/32.0.0/classic/ckeditor.js"></script>

			<title>반찬공유 게시판 게시글 보기</title>

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
					height: 100%;
					text-align: center;
					overflow: auto;
				}

				#commandList {
					margin: auto;
					width: 700px;
					text-align: center;
				}
			</style>
			<style>
				/* ckEditor 넓이 높이 조절 */
				.d-inline-flex {
					justify-content: space-around;
				}

				#top {
					margin-top: 20px;
				}

				#boardContent img {
					width: 450px;
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
				.PreListNext {
					display: inline-block;
				}
			</style>
		</head>

		<body>
			<!-- 게시글 제목 -->
			<div class="card justify-content-center text-center border-right">
				<div class="card-header d-flex justify-content-between">
					<button type="button" class="btn btn-secondary" style="display: flex;" >${shboard.headerTag eq 0 ?
						"공유중" : shboard.headerTag eq 1 ? "공유완료" : shboard.headerTag eq 2? "공지글" :"알 수 없음" }</button>
					<h2 class="fw-bolder my-auto">${shboard.title }</h2>
					<a href="/share/board/listform" class="my-auto"><i class="fa fa-times-circle fa-2x"
							aria-hidden="true"></i></a>
				</div>
				<div class="card-body">
					<div class="row mb-2">
						<div class="col-sm-4 d-flex align-self-center">
							<a href="/userInfo/${userinfo.idx }"> <img
									style="border-radius: 50px; width: 40px; height: 40px; margin: 0 auto;"
									src='/profile/${userinfo.profileImg }'>
								<div class="border pb-2 pt-1 mx-1 rounded"
									style="display: inline; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">
									${userinfo.nickname }님</div>
								<span class="badge bg-danger rounded-pill m-2">Lv. ${userinfo.honbabLevel }</span>
							</a>
							<c:if test="${not empty user && !(userinfo.idx eq user.idx) }">
								<button class="btn btn-primary text-white align-self-center"
									style="height: fit-content;" id="follow${userinfo.idx}"
									onclick="togglefollow(${userinfo.idx});">${didIFollowed>0? "언팔로우": "팔로우"}</button>
							</c:if>
							<!-- <br> <a href="#" class="btn btn-primary">팔로우</a> -->
						</div>
						<div class="col-sm-4 d-flex justify-content-center align-self-center">
							<strong>공유 장소 : 🚉 ${shboard.subway }</strong>
						</div>
						<div class="col-sm-4 d-flex justify-content-end text-end align-self-center">
							조회수 : ${shboard.readCount } | 작성일 : ${shboard.date }</div>
					</div>
					<hr>
					<!-- 게시글 본문 -->
					<div class="row">&nbsp;</div>
					<div class="row">
						<article id="boardContent">${shboard.content }</article>
					</div>
					<div class="row">
						<div class="col d-flex justify-content-end align-items-center">
							<!-- 좋아요 border-danger rounded-pill bg-white  -->
							<button class="btn-sm border-0 bg-transparent text-danger mx-2"
								id="likebtn${shboard.articleNo }" onclick="toggleLikes(${shboard.articleNo})">
								<i class="fa fa-lg ${didILiked>0 ? 'fa-heart' : 'fa-heart-o' }" aria-hidden="true">${likes
									}</i>
							</button>
							<div>
								<i class="fa fa-commenting fa-lg mx-2" aria-hidden="true">${countComment }</i>
							</div>
						</div>
					</div>
					<!-- 수정, 삭제, 말머리 변경 버튼 -->
					<div class="row">
						<div class="col" style="text-align: center;">
							<c:if test="${user.idx == shboard.idx || user.grp == 2}">
								<c:if test="${user.idx == shboard.idx }">
									<form id="headerChange" action="/share/board/header" method="post" style="display: inline-block;">
										<input type="hidden" name="headerTag" id="headerTag" value=${shboard.headerTag}>
										<input type="hidden" name="articleNo" value=${shboard.articleNo}>
										<button class="btn border-dark" style="display: inline-block;"
											onclick="headerChange(${shboard.articleNo},${shboard.headerTag});">말머리 수정</button>
									</form>
									<button class="btn border-dark" style="display: inline-block;"
										onclick="javascript:window.location.href='/share/board/modifyform?articleNo=${shboard.articleNo }'">수정</button>
								</c:if>
								<button class="btn border-dark" style="display: inline-block;"
									onclick="javascript:window.location.href='/share/board/deleteform?articleNo=${shboard.articleNo }'">삭제</button>
							</c:if>
						</div>
					</div>
				</div>
			
			<!-- 게시글 하단 -->
			<div class="card-footer">
				<form class="d-flex" action="/share/board/comment" method="post">
					<div class="p-3 align-items-center">
						<input name="articleNo" type="hidden" value=${shboard.articleNo }></input>
						<input name="idx" type="hidden" value=${user.idx }></input> <span>댓글</span>
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

			<c:if test="${not empty commentList}">
				<hr>
				<!-- 댓글 보기 -->
				<div class="container">
					<c:forEach var="reply" items="${commentList }" varStatus="status">
						<c:choose>
							<c:when test="${status.end == 0 }">
								댓글이 없습니다. 첫 댓글을 작성해 주세요!
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${reply.blind eq false || reply.idx eq user.idx || shboard.idx eq user.idx}">
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
												<div class="text-center px-2" style="width: fit-content;">
													<a href="/userInfo/${reply.idx }"> <img
															style="border-radius: 50px; width: 30px; height: 30px;"
															src="/profile/${commentUserList[status.index].profileImg}">
														<p class="m-0">${commentUserList[status.index].nickname }</p>
													</a>
												</div>
												<div class="px-2 flex-grow-1">
													<p style="width: 500px" id="comm${reply.commentNo}">${reply.comment
														}</p>
													<input type="hidden" style="width: 500px"
														id="comment${reply.commentNo}"
														value="${reply.comment }"></input>
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
											<form class="d-flex" id="replyReply" action="/share/reReply" method="post">
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
													<input type="hidden" name="articleNo" value="${shboard.articleNo}">
													<input type="hidden" name="commentNo" value="${reply.commentNo}">
													<label class="d-block"><input type="checkbox" name="blind"
															id="blind${reply.commentNo }" value="1">비밀댓글</label> <input
														class="btn btn-sm bg-danger text-white d-block" type="submit"
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
		</c:if>
		</div>

		<div class="row">
			<div class="col" style="text-align: left;">
				<a href="/share/board/viewform/${shboard.articleNo-1}">
					<button type="button" id="btnList" class="btn btn-default">이전</button>
				</a>
			</div>
			<div class='col' style="text-align: center;">
				<a href="/share/board/listform">
					<button type="button" id="btnList" class="btn btn-default">목록</button>
				</a>
			</div>
			<div class='col' style="text-align: right;">
				<a href="/share/board/viewform/${shboard.articleNo+1}">
					<button type="button" id="btnList" class="btn btn-default">다음</button>
				</a>
			</div>
		</div>
	
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>

	 //목록 버튼
    $("#btnList").click(function(){
        location.href="/share/board/listform";
    });
	 
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
	
	function mIHObj(key, value){ // makeInputHiddenObject : form 형식 만들기 귀찮아서 만듦
		let obj = document.createElement('input');
		obj.setAttribute('type', 'hidden');
	    obj.setAttribute('name', key);
	    obj.setAttribute('value', value);
	    return obj;
	}

	
	function deleteWrite(articleNo){
		if(confirm("게시글을 삭제하시겠습니까?")){
			let f = document.createElement('form');
			
			f.appendChild(mIHObj('articleNo', articleNo));
		    f.appendChild(mIHObj('idx','${user.idx}'));
		   
		    f.setAttribute('method', 'post');
		    f.setAttribute('action', '/share/board/deleteform'); // /brag/deleteWrite
		    document.body.appendChild(f);
		    f.submit();
		}
	}
	
	// editWrite deleteWrite -> a tag href로 수정
	/*댓글 수정버튼 누르면~  */
	function editReply(commentNo, articleNo){
		if($('#comment'+commentNo).attr("type") == 'hidden'){
			$('#comment'+commentNo).attr("type", "text")
			$('#comm'+commentNo).hide();
			return false;
		} else {
			let comment = $('#comment'+commentNo).val()
			$.ajax({
				type:"POST",
				url:"/share/editReply",
				cache: false,
				data:{"commentNo": commentNo,"articleNo": articleNo, "comment":comment},
				async:false,
				complete:function(){
					window.location.href="/share/board/viewform/"+articleNo;
				}
			})
		}
	}
	/*댓글 삭제버튼 누르면~  */
	function deleteReply(commentNo, articleNo) {
		if (confirm("게시글을 삭제하시겠습니까?")) {
			let f = document.createElement('form');

			f.appendChild(mIHObj('commentNo', commentNo));
			f.appendChild(mIHObj('articleNo', articleNo));

			f.setAttribute('method', 'post');
			f.setAttribute('action', '/share/deleteReply'); 
			document.body.appendChild(f);
			f.submit();

			/* $.ajax({
				type:"POST",
				url:"/share/board/deleteReply",
				cache: false,
				data:{"commentNo": commentNo,"articleNo": articleNo, "comment":comment},
				async:false,
				complete:function(){
					console.log(commentNo);
					window.location.href="/share/board/viewform/"+articleNo;
				}) */
		}
	}
					
	
	function headerChange(articleNo1, headerTag1){
		if(confirm("말머리를 ${shboard.headerTag eq 0? '공유완료':'공유중으'}로 변경하시겠습니까?")){
			$.ajax({
				type:"POST",
				url:"/share/board/header",
				cache: false,
				data:{"articleNo":articleNo1, "headerTag":headerTag1},
				async:false,
				success:function(){
					window.location.href="/share/board/viewform/"+articleNo;
				},
				error:function(){
					alert('말머리를 변경하는 데에 오류가 있었습니다. 나중에 다시 시도해주세요.');
				}
			})
		} else return false;
	}
	// 댓글 로그인 알림
	$(function(){ 
		$("#commentBtn").click(function(){
			if(${empty user}){
				alert("로그인을 하셔야 사용하실 수 있는 기능입니다.");
				return false;
			}
			
		})
	})

				</script>
				<!-- 좋아요 -->
				<script>
					function toggleLikes(articleNo) {
						if (${empty user }) {
							alert("로그인을 하셔야 사용하실 수 있는 기능입니다.");
							return false;
						} else {
							$.ajax({
								type: "POST",
								url: "/share/likes/",
								cache: false,
								data: { "articleNo": articleNo, "idx": ${ not empty user.idx ? user.idx : "0" }},
						async: false,
							success: function(data) {
								result = JSON.parse(data);
								$('#likebtn' + articleNo).children('i').text(result.currentLikes);
								if (result.processed > 0) {
									$('#likebtn' + articleNo).children('i').removeClass('fa-heart-o');
									$('#likebtn' + articleNo).children('i').addClass('fa-heart');
								} else if (result.processed < 0) {
									$('#likebtn' + articleNo).children('i').removeClass('fa-heart');
									$('#likebtn' + articleNo).children('i').addClass('fa-heart-o');
								}
							},
						error: function(data) {
							$('#likebtn' + articleNo).children('i').text('좋아요');
						}
					})
	}
}
				</script>
				<script>
					function togglefollow(idx) {
						if (${empty user }) {
							alert("로그인을 하셔야 사용하실 수 있는 기능입니다.");
							return false;
						} else {
							$.ajax({
								type: "POST",
								url: "/follow/",
								cache: false,
								data: { "idx": idx },
						async: false,
							success: function(data) {
								result = JSON.parse(data);
								if (result.didIFollowed > 0) { // 팔로우를 한 적이 없는 경우
									$('#follow' + idx).text('언팔로우');

								} else if (result.didIFollowed <= 0) { // 팔로우를 이미 한 경우
									$('#follow' + idx).text('팔로우');
								}
							},
						error: function(data) {
							alert('팔로잉을 처리하는 동안 문제가 있었습니다. 나중에 다시 시도해주세요.');
						}
					})
		}
	}
				</script>

		</body>

		</html>