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
	max-width: 1200px;
	height: 100%;
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


.d-inline-flex{
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
.PreListNext{
display: inline-block;
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
			
			<div><h2> [ ${shboard.headerTag eq 0? "공유중" : shboard.headerTag eq 1? "공유완료" : shboard.headerTag eq 2? "공지글": "알 수 없음"} ] ${shboard.title }</h2></div>
			<div>작성자 : ${userinfo.nickname} </div>
			<div>작성일 : ${shboard.date} </div>
			<div>조회수 : ${shboard.readCount} </div>
			<div>위치 : ${shboard.subway }</div>
			<hr>
			
			<br>글 내용 : ${shboard.content }
			<div "style=width:200px; height: 200px;"글이미지파일명: ${imgSrc }></div>
			
			
			</section>
			</div>
		</section>
		


	<!-- 좋아요 -->
	<button class="btn-sm border-danger rounded-pill bg-white text-danger"
		id="likebtn${shboard.articleNo }"
		onclick="toggleLikes(${shboard.articleNo})">
		<i class="fa ${didILiked>0 ? 'fa-heart' : 'fa-heart-o' }"
			aria-hidden="true">${likes }</i>
	</button>
	<br>
<!-- 게시글 제목 -->
<div class="card justify-content-center text-center border-right">
	<div class="card-header">
  		<button type="button" class="btn btn-secondary" style="display: flex;">
  			${shboard.headerTag eq 0 ? "공유중" : shboard.headerTag eq 1 ? "공유완료" : "알 수 없음" }</button>
  		<h2 class="card-title fw-bolder">${shboard.title }</h2>
  	</div>
  	<div class="card-body">
  		<div class="row">
  			<div class="col-sm-2">
  				<a href="/myPage/${userinfo.idx }">
  					<img style="border-radius: 50px; width: 60px; height: 60px; margin: 0 auto;" 
  						src='/profile/${userinfo.profileImg }'>
  					<br>
					<span class="badge bg-danger rounded-pill mb-2">
						Lv.${userinfo.honbabLevel }</span>
					<span class="border pb-2 pt-1 m-2 mx-auto rounded" style="display: inline; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">
							${userinfo.nickname }님
					</span>
  				</a>
  				<!-- <br> <a href="#" class="btn btn-primary">팔로우</a> -->
  			</div>
  			<div class="col-sm-4">
		  	</div>
		  	<div class="col-sm-2">
		 	</div>
		  	<div class="col-sm-2">
				조회수 : ${shboard.readCount }
		  	</div>
		  	<div class="col-sm-2">
		  		작성일 : ${shboard.date }
		  	</div>
  		</div>
  		<hr> <!-- 게시글 본문 -->
  		<div class="row" style="display: block"> 
  			<strong>공유 장소 : 🚉 ${shboard.subway }</strong> 
		</div>
		<div class="row">&nbsp;</div>
  		<div class="row">
	  		<article id="boardContent">
				${shboard.content }
			</article>	
  		</div>
  	</div>
</div>
<!-- 게시글 하단 -->
<div class="card-footer">
	<div class="row">
		<div class="col-8">
			<form id="comment" action="/share/board/comment" method="post">
				<input name="articleNo" type="hidden" value=${shboard.articleNo }>
				<input name="idx" type="hidden" value=${user.idx }>
				<textarea name="commentWrite" cols=75></textarea>
				<input id="blind" name="blind" type="checkbox" value="1">익명댓글
				<input id="commentBtn" type="submit" value="댓글작성">
			</form>
		</div>
		<div class="col-4">
		<!-- 좋아요 -->
			<button class="btn-sm border-danger rounded-pill bg-white text-danger" 
				id="likebtn${shboard.articleNo }" onclick="toggleLikes(${shboard.articleNo})">
			<i class="fa ${didILiked>0 ? 'fa-heart' : 'fa-heart-o' }"
				aria-hidden="true">${likes }</i>
			</button>
		</div>
	</div>
	<hr>
<!-- 게시글 제목 -->
<div class="card justify-content-center text-center border-right">
	<div class="card-header">
  		<button type="button" class="btn btn-secondary" style="display: flex;">
  			${shboard.headerTag eq 0 ? "공유중" : shboard.headerTag eq 1 ? "공유완료" : "알 수 없음" }</button>
  		<h2 class="card-title fw-bolder">${shboard.title }</h2>
  	</div>
  	<div class="card-body">
  		<div class="row">
  			<div class="col-sm-2">
  				<a href="/myPage/${userinfo.idx }">
  					<img style="border-radius: 50px; width: 60px; height: 60px; margin: 0 auto;" 
  						src='/profile/${userinfo.profileImg }'>
  					<br>
					<span class="badge bg-danger rounded-pill mb-2">
						Lv.${userinfo.honbabLevel }</span>
					<span class="border pb-2 pt-1 m-2 mx-auto rounded" style="display: inline; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">
							${userinfo.nickname }님
					</span>
  				</a>
  				<!-- <br> <a href="#" class="btn btn-primary">팔로우</a> -->
  			</div>
  			<div class="col-sm-4">
		  	</div>
		  	<div class="col-sm-2">
		 	</div>
		  	<div class="col-sm-2">
				조회수 : ${shboard.readCount }
		  	</div>
		  	<div class="col-sm-2">
		  		작성일 : ${shboard.date }
		  	</div>
  		</div>
  		<hr> <!-- 게시글 본문 -->
  		<div class="row" style="display: block"> 
  			<strong>공유 장소 : 🚉 ${shboard.subway }</strong> 
		</div>
		<div class="row">&nbsp;</div>
  		<div class="row">
	  		<article id="boardContent">
				${shboard.content }
			</article>	
  		</div>
  	</div>
</div>
<!-- 게시글 하단 -->
<div class="card-footer">
	<div class="row">
		<div class="col-8">
			<form id="comment" action="/share/board/comment" method="post">
				<input name="articleNo" type="hidden" value=${shboard.articleNo }>
				<input name="idx" type="hidden" value=${user.idx }>
				<textarea name="commentWrite" cols=75></textarea>
				<input id="blind" name="blind" type="checkbox" value="1">익명댓글
				<input id="commentBtn" type="submit" value="댓글작성">
			</form>
		</div>
		<div class="col-4">
		<!-- 좋아요 -->
			<button class="btn-sm border-danger rounded-pill bg-white text-danger" 
				id="likebtn${shboard.articleNo }" onclick="toggleLikes(${shboard.articleNo})">
			<i class="fa ${didILiked>0 ? 'fa-heart' : 'fa-heart-o' }"
				aria-hidden="true">${likes }</i>
			</button>
		</div>
	</div>
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
							<div class="d-inline-flex" style="align-items: center">
							<c:choose>
								<c:when test="${reply.lev != 0 }">
									<c:forEach var="i" begin="1" end="${reply.lev*5 }">
										&nbsp;
									</c:forEach>
								</c:when>
							</c:choose>
							<div class="text-center px-2">
								<img style="border-radius: 50px; width: 30px; height: 30px;" src=/profile/${commentUserList[status.index].profileImg}>
								<p class="m-0">${commentUserList[status.index].nickname }</p>
							</div>
							<div class="px-2">
								<p style="width:500px" id="comm${reply.commentNo}">${reply.comment }</p>
								<input type="hidden" style="width:500px" id="comment${reply.commentNo}" value="${reply.comment }"></input>
							</div>
							<div class="px-2">
								<p class="m-0">${reply.date }</p>
							</div>
							<div class="px-2 float-right">
								<c:if test="${user != null }">
									<button class="btn border-dark" 
										onclick="document.getElementById('replyReply${reply.commentNo}').style.display='flex';">대댓글쓰기</button>
								</c:if>
								<c:if test="${user.idx == reply.idx || user.grp == 2}">
									<c:if test="${user.idx == reply.idx }">
										<button class="btn border-dark" onclick="editReply(${reply.commentNo},${reply.articleNo});">수정</button>
									</c:if>
									<button class="btn border-dark" onclick="deleteReply(${reply.commentNo},${reply.articleNo});">삭제</button>
								</c:if>
							</div>					
							</div>
						<div class="row" id="replyReply${reply.commentNo }" style="display:none;">
							<form id="replyReply" action="/brag/reReply" method="post">
								<input type="text" name="commentWrite">
								<input type="hidden" name="idx" value="${user.idx }">
								<input type="hidden" name="articleNo" value="${shboard.articleNo}">
								<input type="hidden" name="commentNo" value="${reply.commentNo}">
								<input type="checkbox" name="blind" id="blind${reply.commentNo }" value="1">
								<label for="blind${reply.commentNo }">비밀댓글</label>
								<input type="submit" value="답글쓰기">
							</form>
						</div>
					</c:if>
					<c:if test="${user.idx == reply.idx || user.grp == 2 }">
						<div class="if-thisArticle-mine text-end">
							<c:if test="${user.idx == reply.idx }">
							<button class="btn border-dark"
								onclick="editReply(${reply.commentNo},${reply.articleNo});">수정</button>
							</c:if>
							<button class="btn border-dark"
								onclick="deleteReply(${reply.commentNo},${reply.articleNo});">삭제</button>
						</div>
					</c:if>
					
				</div>
				<div class="row" id="replyReply${reply.commentNo }" style="display:none;">
					<form id="replyReply" action="/share/reReply" method="post">
						<input type="text" name="commentWrite">
						<input type="hidden" name="idx" value="${user.idx }">
						<input type="hidden" name="articleNo" value="${shboard.articleNo}">
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
</div>
	<div class="row">
		<div class="col" style="text-align: center;">
		<c:if test="${user.idx == shboard.idx || user.grp == 2}">
			<c:if test="${user.idx == shboard.idx }">
				<a href="/share/board/modifyform?articleNo=${shboard.articleNo}">
					<button class="btn border-dark">수정</button>
				</a>
			</c:if>
				<a href="/share/board/deleteform?articleNo=${shboard.articleNo}&page=${page}">
					<button class="btn border-dark">삭제</button>
				</a>
		</c:if>
		</div>
	</div>

<!-- 이전 목록 다음 -->
				
	<div class="row">
		<div class="col" style="text-align: left;">
			<button type="button" id="btnList" class="btn btn-default">이전</button>
		</div>
		<div class='col' style="text-align: center;">
			<button type="button" id="btnList" class="btn btn-default">목록</button>
		</div>

		<div class='col' style="text-align: right;">
			<button type="button" id="btnList" class="btn btn-default">다음</button>
		</div>
	</div>
	
		<%-- 	<!-- 말머리 바꾸기 -->
		<c:if test="${user.idx eq shboard.idx && user.grp eq 1}">
		<form id="headerChange" action="/share/header" method="post">
			<input type="hidden" name="headerTag">
			<input type="hidden" name="articleNo" value=${shboard.articleNo}>
			<div class="if-thisArticle-mine text-end">
				<button type="button" class="btn btn-secondary dropdown-toggle" id="sortDropdown"
					data-bs-toggle="dropdown" aria-expanded="false">말머리 변경</button>
				<ul class="dropdown-menu text-center" aria-labelledby="sortDropdown">
					<li><button class="dropdown-item" type="button"
						onclick="headerChange(0)">공유중</button></li>
					<li><button class="dropdown-item" type="button"
						onclick="headerChange(1)">공유완료</button></li>
				</ul>
			<input id="headerChange" type="submit" value="말머리 변경"> 
			</div>
		</form>		
		</c:if> --%>
		
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
				url:"/brag/editReply",
				cache: false,
				data:{"commentNo": commentNo,"articleNo": articleNo, "comment":comment},
				async:false,
				complete:function(){
					window.location.href="/brag/viewdetail/"+articleNo;
				}
			})
		}
	}

	/*댓글 삭제버튼 누르면~  */
	function deleteReply(commentNo, articleNo){
		if(confirm("게시글을 삭제하시겠습니까?")){
			let f = document.createElement('form');
			
			f.appendChild(mIHObj('commentNo', commentNo));
		    f.appendChild(mIHObj('articleNo',articleNo));
		   
		    f.setAttribute('method', 'post');
		    f.setAttribute('action', '../deleteReply'); // /brag/deleteReply
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
	}
	
	/* 말머리 변경 */
	function headerChange(arg) {
			document.getElementsByName('headerTag').value=arg; 
			
			if (arg == 0)
				document.getElementById('sortDropdown').innerText='공유중';
			else if (arg == 1)
				document.getElementById('sortDropdown').innerText='공유완료';
			
			$('#headerChange').submit();
			$.ajax({
				type:"POST",
				url:"/share/board/header",
				cache: false,
				data: {
					"headerTag": headerTag
					},
				async: false,
				complete:function() {
					console.log(headerTag);
					windiw.location.href="share/board/viewform/"+articleNo;
				}
			})
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
function toggleLikes(articleNo){
	if(${empty user}){
		alert("로그인을 하셔야 사용하실 수 있는 기능입니다.");
		return false;
	} else {
		$.ajax({
			type:"POST",
			url:"/share/likes/",
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


</body>
</html>