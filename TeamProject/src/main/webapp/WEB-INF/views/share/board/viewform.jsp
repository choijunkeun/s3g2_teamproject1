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
	max-width: 1200px;
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
	<!-- 댓글 보기 -->
	<!-- 프사, 아이디, : 내용, 작성일, (내가 쓴 댓글 시) 수정/삭제 버튼  -->
	<!--commentUserList commentList-->
	<div class="container">
		<c:forEach var="reply" items="${commentList}" varStatus="status">
		<c:choose>
		<c:when test="${reply.blind eq false || reply.idx eq user.idx || shboard.idx eq user.idx}">
			<div class="row">
				<div class="col">
					<img style="border-radius: 50px; width: 30px; height: 30px;"
						src=/profile/${commentUserList[status.index].profileImg}>
					<p>${commentUserList[status.index].nickname }</p>
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
	<br>
	<!--댓글 작성  -->
	<form id="comment" action="/share/comment" method="post">
		<input name="articleNo" type="hidden" value=${shboard.articleNo }></input>
		<input name="idx" type="hidden" value=${user.idx }></input>
		<textarea name="commentWrite"></textarea>
		<input id="blind" name="blind" type="checkbox" value="1">익명댓글
		<input id="commentBtn" type="submit" value="댓글작성">
	</form>
		<!-- 말머리 바꾸기 -->
		<c:if test="${user.idx eq shboard.idx && user.grp eq 1}">
		<form id="headerChange" action="/share/header" method="post">
			<input type="hidden" name="headerTag">
			<input type="hidden" name="articleNo" value=${shboard.articleNo}>
			<div class="if-thisArticle-mine text-end">
				<button type="button"class="btn btn-secondary dropdown-toggle" id="sortDropdown"
					data-bs-tosggle="dropdown" aria-expanded="false">말머리 변경</button>
				<ul class="dropdown-menu text-center" aria-labelledby="sortDropdown">
					<li><button class="dropdown-item" type="button"
						onclick="headerChange(0)">공유중</button></li>
					<li><button class="dropdown-item" type="button"
						onclick="headerChange(1)">공유완료</button></li>
				</ul>
			</div>
		</form>		
		</c:if>
		
	<!--idx 매칭, 수정, 삭제 버튼 나타나게 하는 부분  -->
	<div class="row py-3">
		<div class="col text-center">
			<c:if test="${user.idx eq shboard.idx || user.grp eq 2}">
				<div class="if-thisArticle-mine text-end">
					<c:if test="${user.idx eq shboard.idx}">
						<button class="btn border-dark" onclick="editWrite(${shboard.articleNo});">수정</button>
					</c:if>
					<button class="btn border-dark" onclick="deleteWrite(${shboard.articleNo});">삭제</button>
				</div>
			</c:if>
		</div>
	</div>
	</section>

	<script>
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
	
	/*수정버튼 누르면~  */
	function editWrite(articleNo){
		let f = document.createElement('form');
		
		f.appendChild(mIHObj('articleNo', articleNo));
	    
	    f.setAttribute('method', 'post');
	    f.setAttribute('action', '/share/board/modifyform');
	    document.body.appendChild(f);
	    f.submit();
	}
	
	/*삭제버튼 누르면~  */
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
	
	/*댓글 수정버튼 누르면~  */
	function editReply(commentNo, articleNo){
 		
		let isReadOnly = $('#comment'+commentNo).attr("readOnly")
		if(isReadOnly){
			$('#comment'+commentNo).attr("readOnly", false) 
		} else{
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
	function deleteReply(commentNo, articleNo){
		if(confirm("게시글을 삭제하시겠습니까?")){
			let f = document.createElement('form');
			
			f.appendChild(mIHObj('commentNo', commentNo));
		    f.appendChild(mIHObj('articleNo',articleNo));
		   
		    f.setAttribute('method', 'post');
		    f.setAttribute('action', '../deleteReply'); // /brag/deleteReply
		    document.body.appendChild(f);
		    f.submit();
		    
		    $.ajax({
				type:"POST",
				url:"/share/board/deleteReply",
				cache: false,
				data:{"commentNo": commentNo,"articleNo": articleNo, "comment":comment},
				async:false,
				complete:function(){
					console.log(commentNo);
					window.location.href="/share/board/viewform/"+articleNo;
		}
	}
	/* 말머리 변경 */
	function headerChange(arg) {
			document.getElementsByName('headerTag')[0].value=arg; 
			
			if(arg == '0')
				document.getElementById('sortDropdown').innerText='공유중';
			else if (arg == '1')
				document.getElementById('sortDropdown').innerText='공유완료';
			$('#headerChange').submit();
		}
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
<%--댓글달기  / 익명댓글 쓰기--%>
<script>
$(function(){ 
	$("#commentBtn").click(function(){
		if(${empty user}){
			alert("로그인을 하셔야 사용하실 수 있는 기능입니다.");
			return false;
		}
		
	})
})

</script>

</body>
</html>