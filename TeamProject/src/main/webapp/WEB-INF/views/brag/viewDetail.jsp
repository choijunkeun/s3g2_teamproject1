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


<title>게시글 보기</title>

<style>
/* ckEditor 넓이 높이 조절 */
.ck.ck-editor {
	max-width: 500px;
	font-weight: bolder;
}

.ck-editor__editable {
	min-height: 300px;
}

#top {
	margin-top: 20px;
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

.ck-editor__editable {
	min-height: 550px;
	min-width: 550px;
	max-width: 100%;
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
<body>


	로그인한 유저 번호 : ${user.idx }
	<br> 로그인한 유저 이메일 : ${user.email }
	<br> 로그인한 유저 별명 : ${user.nickname }
	<br> 지금 보려는 글 정보 글 제목 : ${bboard.title } 글 내용 : ${bboard.content }
	<br>
	<div "style=width:200px; height: 200px;"글이미지파일명: ${imgSrc }></div>


	<!-- 좋아요 -->
	<button class="btn-sm border-danger rounded-pill bg-white text-danger"
		id="likebtn${bboard.articleNo }"
		onclick="toggleLikes(${bboard.articleNo})">
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
		<c:when test="${reply.blind eq false || reply.idx eq user.idx || bboard.idx eq user.idx}">
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
					<form id="replyReply" action="/brag/reReply" method="post">
						<input type="text" name="commentWrite">
						<input type="hidden" name="idx" value="${user.idx }">
						<input type="hidden" name="articleNo" value="${bboard.articleNo}">
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
	<form id="" action="/brag/comment" method="post">
		<input name="articleNo" type="hidden" value=${bboard.articleNo }></input>
		<input name="idx" type="hidden" value=${user.idx }></input>
		<textarea name="commentWrite"></textarea>
		<input id="blind" name="blind" type="checkbox" value="1">익명댓글
		<input id="commentBtn" type="submit" value="댓글작성">
	</form>


	<%-- 	<br> 글 작성자 번호 : ${bboard.idx }
	<br> ${bboard.idx == user.idx ? "수정, 삭제" : "안보여"} --%>

	<!--idx 매칭, 수정, 삭제 버튼 나타나게 하는 부분  -->
	<div class="row py-3">
		<div class="col text-center">
			<c:if test="${user.idx == bboard.idx}">
				<div class="if-thisArticle-mine text-end">
					<button class="btn border-dark"
						onclick="editWrite(${bboard.articleNo});">수정</button>
					<button class="btn border-dark"
						onclick="deleteWrite(${bboard.articleNo});">삭제</button>
				</div>
			</c:if>
			<c:if test="${user.grp == 2 }">
				<div class="if-thisArticle-mine text-end">
					<button class="btn border-dark"
						onclick="deleteWrite(${bboard.articleNo});">삭제</button>
				</div>
			</c:if>
		</div>
	</div>

<!-- 이전 목록 다음 -->
	<div class="PreListNext">
		<div style="text-align: left;">
			<button type="button" id="btnList" class="btn btn-default">이전</button>
		</div>
		<div style="text-align: center;">
			<button type="button" id="btnList" class="btn btn-default">목록</button>
		</div>
		<div style="text-align: right;">
			<button type="button" id="btnList" class="btn btn-default">다음</button>
		</div>
	</div>
	


	<!-- JavaScript -->
	<script type="text/javascript"
		src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
	
	
	 //목록 버튼
    $("#btnList").click(function(){
        location.href="/brag/brag/";
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
	
	/*수정버튼 누르면~  */
	function editWrite(articleNo){
		let f = document.createElement('form');
		
		f.appendChild(mIHObj('articleNo', articleNo));
	    f.appendChild(mIHObj('idx','${user.idx}'));
	    /* f.appendChild(mIHObj('place_name','${place.place_name}'));
	    f.appendChild(mIHObj('address_name','${place.address_name}'));
	    f.appendChild(mIHObj('road_address_name','${place.road_address_name}'));
	    f.appendChild(mIHObj('x','${place.x}'));
	    f.appendChild(mIHObj('y','${place.y}')); */
	    
	    
	    //f.setAttribute('enctype','application/json');
	    f.setAttribute('method', 'post');
	    f.setAttribute('action', '../editWrite');
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
		    f.setAttribute('action', '../deleteWrite'); // /brag/deleteWrite
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
		}
	}
</script>
	<%--댓글달기 한jsp에서 이렇게 ${function) 나만 된다 / 익명댓글 쓰기--%>
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
	<!-- 좋아요 -->
	<script>
function toggleLikes(articleNo){
	if(${empty user}){
		alert("로그인을 하셔야 사용하실 수 있는 기능입니다.");
		return false;
	} else {
		$.ajax({
			type:"POST",
			url:"/brag/likes/",
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
