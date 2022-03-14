<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일인분(마이페이지)</title>
<style>
	.card{
		height : 500px;
	}
	#user_info {
		font-size: 40px;
		font-weight: bold;
	}
	#user_level {
		font-size: 30px;
		font-weight: bold;
	}
	
	table { table-layout : fixed; }
	td {
		overflow:hidden;
		text-overflow:ellipsis;
		white-space:nowrap;
	}
	</style>
</head>
<body>
	<!-- Modal -->
	<div class="modal fade" id="ModalFollower" tabindex="-1" aria-labelledby="ModalFollower" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-scrollable">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title">팔로워</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
	            </div>
	            <div class="modal-body">
	            	<ul class="list-group" id="ListFollower">

			    	</ul>
	            </div>
	        </div>
	    </div>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="ModalFollowing" tabindex="-1" aria-labelledby="ModalFollower" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-scrollable">
	        <div class="modal-content">
	        	<div class="modal-header">
	                <h5 class="modal-title">팔로잉</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
	            </div>
	            <div class="modal-body">
	            	<ul class="list-group" id="ListFollowing">

			    	</ul>
	            </div>
	        </div>
	    </div>
	</div>

	<c:choose>
	<c:when test="${userinfo.idx != user.idx }">
	<div class="row justify-content-center">
		<div class="col mt-5">
			<div class="card">
				<div class="card-body p-4">
					<div class="text-center">
						<img style="border-radius: 200px; width: 150px; height: 150px;"
							src="/profile/${userinfo.profileImg }">
						<div id="user_info">${userinfo.nickname}</div>
						<span class="badge bg-danger rounded-pill" style="font-size: 1.5rem;">Lv.${userinfo.honbabLevel}</span>
					</div>
				</div>
				<div class="card-body p-4">
					<div class="text-center">
						<button class="btn fs-5" id="btnFollower" data-bs-toggle="modal" 
						data-bs-target="#ModalFollower">팔로워 
							<span class="fw-bolder" id="follower">${follower}</span></button>
					 	&emsp;&emsp;&emsp; 
					 	<button class="btn fs-5" id="btnFollowing" data-bs-toggle="modal" 
					 		data-bs-target="#ModalFollowing">팔로잉
							<span class="fw-bolder" id="following">${following}</span></button>
					</div>
				</div>
				<div>
					<div style="text-align:center;">
						<!-- <a class="btn btn-outline-dark mt-auto mx-3" 
						id="search-nav" href="">팔로우</a> -->
						<!-- <button class="btn btn-outline-dark mt-auto mx-3"
							id="follow" href="">팔로우</button> -->
						<c:if test="${not empty user}">
						<button class="btn btn-outline-dark mt-auto mx-3" 
							id="follow${userinfo.idx }" onclick="togglefollow(${userinfo.idx})">
							<i class="fa ${didIFollowed>0 ? 'fa-minus' : 'fa-plus' }"
							aria-hidden="true">&nbsp;${didIFollowed>0 ? '언팔로우' : '팔로우'}</i>
							</button>
						</c:if>
					</div>
				</div>

				<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
					
				</div>
			</div>
		</div>
		
		
		<div class="col mt-5">
			<div class="card">
				<div class="card-body p-4">
					<div class="text-center">
						<h5 class="fw-bolder">${userinfo.nickname } 님이 작성한 리뷰</h5>
					</div>
				</div>
				<div class="card-body p-4">
					<div class="text-center" >
						<table class="table table-striped">
							<thead>
							<tr>
								<th>혼밥레벨</th>
								<th>제목</th>
								<th>내 평점</th>						
							</tr>
							</thead>
							<tbody id="myReview">
							</tbody>										
						</table>					
					</div>
				</div>																			
			</div>
		</div>
		</div>	
	<div class="row justify-content-center">
		<div class="col mt-5">
			<div class="card p-4" style="height:500px">
				<div class="text-center">
					<h5 class="fw-bolder">반찬공유</h5>
				</div>
				
				<div class="table-responsive">
					<table class="table table-striped">
						<thead>
						<tr>
							<th class="col-xs-12 col-md-8">제목</th>
							<th class="col-xs-6 col-md-4">조회수</th>
						</tr>
						</thead>
						<tbody id="myShare">
						</tbody>
					</table>	
				</div>			
				
			</div>
		</div>
		
		
		<div class="col mt-5">
			<div class="card p-4" style="height:500px">
				<div class="text-center">
					<h5 class="fw-bolder">혼밥자랑</h5>
				</div>
				<div class="table-responsive">
					<table class="table table-striped">
						<thead>
						<tr>
							<th class="col-xs-12 col-md-8">제목</th>
							<th class="col-xs-6 col-md-4">조회수</th>
						</tr>
						</thead>
						<tbody id="myBrag">
						</tbody>
					</table>	
				</div>					
			</div>
		</div>
		
		
		<div class="col mt-5">
			<div class="card p-4" style="height:500px">
				<div class="text-center">
					<h5 class="fw-bolder">커뮤니티</h5>
				</div>
				
				
				<div class="table-responsive">
					<table class="table table-striped">
						<thead>
						<tr>
							<th class="col-xs-12 col-md-8">제목</th>
							<th class="col-xs-6 col-md-4">조회수</th>
						</tr>
						</thead>
						<tbody id="myCommunity">
						</tbody>
					</table>	
				</div>			
				
			</div>
		</div>
	</div>
	<script>     
		//혼밥자랑 게시글
		$(function() {
			$.ajax({
				url:'/bragPosting',		
				type: 'POST',
				datatype : "json",
				data: {"idx": ${userinfo.idx}},
				success: function(data) {
					/* $("#myBrag").text(data[0].title); */
					$.each(data, function(index, item) { 
						$("#myBrag").append("<tr><td><a href=/brag/viewdetail/"+item.articleNo+">"
						+item.title + "</a></td><td>"
						+item.readCount + "</td></tr><br>");
						});
					}
		      }),
			
		//반찬공유 게시글
			$.ajax({
				url:'/sharePosting',		
				type: 'POST',
				datatype:"json",
				data: {"idx": ${userinfo.idx}},
				success: function(data){
					$.each(data, function(index, item) { 
						$("#myShare").append("<tr><td><a href=/brag/viewdetail/"+item.articleNo+">"
						+item.title + "</a></td><td>"
						+item.readCount + "</td></tr><br>");
						});
					
				}		
			}),
		//커뮤니티 게시글
			$.ajax({
				url:'/communityPosting',		
				type: 'POST',
				datatype:"json",
				data: {"idx": ${userinfo.idx}},
				success: function(data){
					$.each(data, function(index, item) { 
						$("#myCommunity").append("<tr><td><a href=/comm/boardlist/"+item.articleNo+">"
						+item.title + "</a></td><td>"
						+item.views + "</td></tr><br>");
						});
				}		
			}),
			// 리뷰 게시글
			$.ajax({
				url:'/reviewPosting',		
				type: 'POST',
				datatype : "json",
				data: {"idx": ${userinfo.idx}},
				success: function(data) {			
					$.each(data, function(index, item) { 
						var index = (item.serviceRate+item.interiorRate+item.priceRate+item.tasteRate)/4;
						/* console.log(index); */
						
						$("#myReview").append("<tr><td><span class='badge bg-danger rounded-pill' style='font-size:0.75rem'>Lv."+
								+item.honbabLv + "</span></td><td>"
								+item.honbabReason + "</td><td>"+index+"</td></a></tr>");
								});
					
					
					//url 경로연결은 카카오API 경로 지원 문제 떄문에 사용하지 못함.
					/* $("#myReview").append("<tr><td><span class='badge bg-danger rounded-pill' style='font-size:0.75rem'>Lv."+
							+item.honbabLv + "</span></td><td><a href=/place/"+item.id+">"
							+item.honbabReason + "</a></td><td>"+index+"</td></a></tr>");
							}); */
		
					}
		      })
		
			$('#btnFollower').click(function(){getFollowerList()});
			$('#btnFollowing').click(function(){getFollowingList()});
			
			function getFollowerList(){
				$('#ListFollower').html('');
				$.ajax({
					type:"post",
					url:"/followerList",
					async:false,
					data:{"idx":${userinfo.idx}, "page" : $('#followerpage').val()},
					success:function(data){
						var l = JSON.parse(data);
						var f = l.followerList;
						var obj = "";
						if(f.length <1){
							obj = '팔로워가 없습니다.';
						} else{
							for(let i = 0; i<f.length; i++){
	 							obj = '<li class="list-group-item">';
	 							obj += '<a href="/userInfo/' + f[i].idx + '"><img src="/profile/'+ f[i].profileImg + '" width="30px" height="30px">&nbsp;'
	 								+ '<span>' + f[i].nickname + '</span></a></li>';
	 							
	 							
	 						}
						}
						$('#ListFollower').html($('#ListFollower').html()+obj); 
					},
					error: function(){
						$('#ListFollower').html('<li class="list-group-item">정보를 가져올 수 없습니다. 나중에 다시 시도해주세요.</li>'); 
					}
				})
			}
			function getFollowingList(){
				$('#ListFollowing').html(''); 
				$.ajax({
					type:"post",
					url:"/followingList",
					async:false,
					data:{"idx":${userinfo.idx}, "page" : $('#followingpage').val()},
					success:function(data){
						var l = JSON.parse(data);
						var f = l.followingList;
						console.log(f);
						var obj = "";
						if(f.length <1){
							obj = '팔로잉이 없습니다.';
						} else{
							for(let i = 0; i<f.length; i++){
	 							obj = '<li class="list-group-item">';
	 							obj += '<a href="/userInfo/' + f[i].idx + '"><img src="/profile/'+ f[i].profileImg + '" width="30px" height="30px">&nbsp;'
	 								+ '<span>' + f[i].nickname + '</span></a></li>';
	 						}
						}
						$('#ListFollowing').html($('#ListFollowing').html()+obj);
					},
					error: function(){
						$('#ListFollowing').html('<li class="list-group-item">정보를 가져올 수 없습니다. 나중에 다시 시도해주세요.</li>'); 
					}
				})
			}
		})
	</script>
	
	</c:when>
	<c:otherwise>
	<script>
		window.location="/myPage";
	</script>
	</c:otherwise>
	</c:choose>
</body>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>
	function togglefollow(idx){
		if(${empty user}){
			alert("로그인을 하셔야 사용하실 수 있는 기능입니다.");
			return false;
		} else {
			$.ajax({
				type:"POST",
				url:"/follow/",
				cache: false,
				data:{"idx": ${userinfo.idx}},
				async:false,
				success: function(data){
					result = JSON.parse(data);
					if(result.didIFollowed >0){
						$('#follow' + idx).children('i').removeClass('fa-plus');
						$('#follow' + idx).children('i').addClass('fa-minus');
						$('#follow' + idx).children('i').text('팔로우');
					} else if(result.didIFollowed <=0){
						$('#follow' + idx).children('i').removeClass('fa-minus');
						$('#follow' + idx).children('i').addClass('fa-plus');
						$('#follow' + idx).children('i').text('언팔로우');
					}
					$('#follower').text(result.follower);
				},
				error:function(data){
					alert('팔로잉을 처리하는 동안 문제가 있었습니다. 나중에 다시 시도해주세요.');
				}
			})
		}
	}
	
	
</script>
</html>