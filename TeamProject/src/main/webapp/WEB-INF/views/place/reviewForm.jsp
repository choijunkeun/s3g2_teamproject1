<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<style>
		#top {
		  margin-top: 20px;
		}
		.btn-container {
		  background: #fff;
		  border-radius: 5px;
		  padding-bottom: 20px;
		  margin-bottom: 20px;
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
		h4 > strong {
		  color: #ff3f3f;
		}
		.btn-primary {
		  border-color: #ff3f3f !important;
		  color: #ffffff;
		  text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
		  background-color: #ff3f3f !important;
		  border-color: #ff3f3f !important;
		}
		
		/*these two are set to not display at start*/
		.imgupload.ok {
		  display: none;
		  color: #ff3f3f;
		}
		.imgupload.stop {
		  display: none;
		  color: #ff3f3f;
		}
		
		/*this sets the actual file input to overlay our button*/
		#file {
		  opacity: 0;
		  -moz-opacity: 0;
		  filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0);
		  /* width: 200px; */
		  cursor: pointer;
		  position: absolute;
		  left: 50%;
		  transform: translateX(-50%);
		  bottom: 40px;
		  height: 50px;
		}
		
		/*switch between input and not active input*/
		#submitbtn {
		  padding: 5px 50px;
		  display: none;
		}
		#fakebtn {
		  padding: 5px 40px;
		}
		
		/*www.emilianocostanzo.com*/
		#sign {
		  color: #1e2832;
		  position: fixed;
		  right: 10px;
		  bottom: 10px;
		  text-shadow: 0px 0px 0px #1e2832;
		  transition: all.3s;
		}
		#sign:hover {
		  color: #1e2832;
		  text-shadow: 0px 0px 5px #1e2832;
		}
		
		
	</style>
	<style>
		input.star{
			display: none;
		}
		label.star {
			float: right;
			padding: 5px;
			font-size: 20px;
			color: #444;
			/* transition: all .2s; */
		}
		
		input.star:checked ~ label.star:before {
			content: '\f005';
			color: #FD4;
			/* transition: all .25s; */
		}
		
		/* input.star-5:checked ~ label.star:before {
			color: #FE7;
			text-shadow: 0 0 20px #952;
		}
		
		input.star-1:checked ~ label.star:before {
			color: #F62;
		}
		
		label.star:hover {
			transform: rotate(-15deg) scale(1.3);
		} */
		
		label.star:before {
			content: '\f006';
			font-family: FontAwesome;
		}
</style>
<style>
	tr{
		width:100%;
	}
	tr>td:first-child{
		width: 150px;
		max-width: 150px;
		font-weight: bold;
	}
	tr>td:nth0child(2){
		width: 100%;
	}
	
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<h2>
		<strong>혼밥 맛집 리뷰하기</strong>
	</h2>
	<div class="container pb-3 bg-light">
		<div class="row p-2">
			<div class="placeInfoSection p-2">
				<!-- <div>용궁반점 여기에 대충 위치 표시하는 용도</div> -->
				<h2>
					<a href="javascript:window.history.back();" style="text-decoration: none; color: black;">
						<i class="fa fa-angle-left"></i> <strong>${place.place_name }</strong></a>
				</h2>
				<p>${place.address_name}</p>
			</div>
			<!-- <div class="placeImgSection">
				<img src="#">
			</div> -->
		</div>
		<form class="container" action="../writeReview" method="post" enctype="multipart/form-data" id="prForm">
		<!-- <form id="prForm"> -->
			<input type="hidden" name="user_PK" id="user_PK" value="${user.idx }"> <!-- 목업 유저정보 코드 -->
			<input type="hidden" name="id" id="id" value="${place.id }"> <!-- 장소값 코드 -->
			
			<table class="justify-content-center" style="width:100%;">
				<tr>
					<td>
						1인 출입 가능 업장
					</td>
					<td>
						<input type="checkbox" id="rejectedCount" name="rejectedCount" value="true">
						<label for="rejectedCount">1인 출입 가능 업장</label>
					</td>
					
				</tr>
				<tr>
					<td>제목</td>
					<td><input type="text" name="honbabReason" id="honbabReason" style="width: 100%;" placeholder="제목을 써주세요"></td>
				</tr>
				<tr>
					<td>상세내용</td>
					<td>
						<textarea name="reviewContent" id="reviewContent" placeholder="상세 내용을 입력해주세요"
						style="width: 100%; height: auto; margin: 10px 0" rows=10></textarea>
					</td>
				</tr>
				<tr>
					<td>혼밥레벨</td>
					<td id="honbabLv" class="btn-group flex-wrap justify-content-center">
						<input type="radio" name="honbabLv" class="btn-check" id="lv1" value="1">
						<label class="btn btn-outline-danger btn-sm rounded-left" for="lv1">레벨 1</label>
						<input type="radio" name="honbabLv" class="btn-check" id="lv2" value="2"> 
						<label class="btn btn-outline-danger btn-sm" for="lv2">레벨 2</label>
						<input type="radio" name="honbabLv" class="btn-check" id="lv3" value="3"> 
						<label class="btn btn-outline-danger btn-sm" for="lv3">레벨 3</label>
						<input type="radio" name="honbabLv" class="btn-check" id="lv4" value="4">
						<label class="btn btn-outline-danger btn-sm" for="lv4">레벨 4</label>
						<input type="radio" name="honbabLv" class="btn-check" id="lv5" value="5"> 
						<label class="btn btn-outline-danger btn-sm" for="lv5">레벨 5</label>
					</td>
				</tr>
				<tr>
					<td>가격</td>
					<td>
						<div class="rating priceRate" style="display: inline-block;">
							<input class="star star-5" id="price-5" type="radio" name="priceRate" value="5" />
							<label class="star star-5" for="price-5"></label>
							<input class="star star-4" id="price-4" type="radio" name="priceRate" value="4" />
							<label class="star star-4" for="price-4"></label>
							<input class="star star-3" id="price-3" type="radio" name="priceRate" value="3" />
							<label class="star star-3" for="price-3"></label>
							<input class="star star-2" id="price-2" type="radio" name="priceRate" value="2" />
							<label class="star star-2" for="price-2"></label>
							<input class="star star-1" id="price-1" type="radio" name="priceRate" value="1" />
							<label class="star star-1" for="price-1"></label>
						</div>
					</td>
				</tr>
				<tr>
					<td>맛</td>
					<td>
						<div class="rating tasteRate" style="display: inline-block;">
							<input class="star star-5" id="taste-5" type="radio" name="tasteRate" value="5" />
							<label class="star star-5" for="taste-5"></label>
							<input class="star star-4" id="taste-4" type="radio" name="tasteRate" value="4" />
							<label class="star star-4" for="taste-4"></label>
							<input class="star star-3" id="taste-3" type="radio" name="tasteRate" value="3" />
							<label class="star star-3" for="taste-3"></label>
							<input class="star star-2" id="taste-2" type="radio" name="tasteRate" value="2" />
							<label class="star star-2" for="taste-2"></label>
							<input class="star star-1" id="taste-1" type="radio" name="tasteRate" value="1" />
							<label class="star star-1" for="taste-1"></label>
						</div>
					</td>
				</tr>
				<tr>

					<td>서비스</td>
					<td>
						<div class="rating serviceRate" style="display: inline-block;">
							<input class="star star-5" id="service-5" type="radio" name="serviceRate" value="5" />
							<label class="star star-5" for="service-5"></label>
							<input class="star star-4" id="service-4" type="radio" name="serviceRate" value="4" />
							<label class="star star-4" for="service-4"></label>
							<input class="star star-3" id="service-3" type="radio" name="serviceRate" value="3" />
							<label class="star star-3" for="service-3"></label>
							<input class="star star-2" id="service-2" type="radio" name="serviceRate" value="2" />
							<label class="star star-2" for="service-2"></label>
							<input class="star star-1" id="service-1" type="radio" name="serviceRate" value="1" />
							<label class="star star-1" for="service-1"></label>
						</div>
					</td>
				</tr>
				<tr>
					<td>멋(인테리어)</td>
					<td>
						<div class="rating interiorRate" style="display: inline-block;">
							<input class="star star-5" id="interior-5" type="radio" name="interiorRate" value="5" />
							<label class="star star-5" for="interior-5"></label>
							<input class="star star-4" id="interior-4" type="radio" name="interiorRate" value="4" />
							<label class="star star-4" for="interior-4"></label>
							<input class="star star-3" id="interior-3" type="radio" name="interiorRate" value="3" />
							<label class="star star-3" for="interior-3"></label>
							<input class="star star-2" id="interior-2" type="radio" name="interiorRate" value="2" />
							<label class="star star-2" for="interior-2"></label>
							<input class="star star-1" id="interior-1" type="radio" name="interiorRate" value="1" />
							<label class="star star-1" for="interior-1"></label>
						</div>
					</td>
				</tr>
				<tr class="text-center">
					<td>파일</td>
					<td>
					<div class="card border rounded" style="width: 100%;">
						<div class="btn-container text-center justify-content-center">
							<!--the three icons: default, ok file (img), error file (not an img)-->
							<h1 class="imgupload"><i class="fa fa-file-image-o"></i></h1>
							<h1 class="imgupload ok"><i class="fa fa-check"></i></h1>
							<h1 class="imgupload stop"><i class="fa fa-times"></i></h1>
							<!--this field changes dinamically displaying the filename we are trying to upload-->
							<p id="namefile">사진만 올려주세요!(jpg,jpeg,bmp,png)</p>
							<!--our custom btn which which stays under the actual one-->
							<button type="button" id="btnup" class="btn btn-primary btn-lg">파일 선택</button>
							<input type="file" value="" name="file" id="file">
						</div>
					</div>
					</td>
				</tr>
				
			</table>
			<div class="row p-2 ">
				<div class="col p-1 text-center ">
					<div class="row"> <!-- https://codepen.io/jexordexan/pen/yyYEJa -->
						<table style="width: fit-content; margin: 0 auto;">
							
						</table>

					</div>
					<div class="row text-truncate" >
						<!-- https://codepen.io/emiemi/pen/zxNXWR -->
						
					</div>
				</div>
				<div class="col p-1">
					
				</div>
			</div>
			<div class="row py-3">
				<div class="col text-center">
					<button class="btn border bd-secondary">취소</button>
					<input type="button" id="prFormSubmit" class="btn border bd-secondary" value="등록"/>
				</div>
			</div>
		</form>
	</div>

	<script>
	$('#file').change(function(){
		//here we take the file extension and set an array of valid extensions
	    var res=$('#file').val();
	    var arr = res.split("\\");
	    var filename=arr.slice(-1)[0];
	    filextension=filename.split(".");
	    filext="."+filextension.slice(-1)[0];
	    valid=[".jpg",".png",".jpeg",".bmp"];
		//if file is not valid we show the error icon, the red alert, and hide the submit button
	    if (valid.indexOf(filext.toLowerCase())==-1){
	        $( ".imgupload" ).hide("slow");
	        $( ".imgupload.ok" ).hide("slow");
	        $( ".imgupload.stop" ).show("slow");
	      
	        $('#namefile').css({"color":"gray","font-weight":700, "text-overflow": "ellipsis", "overflow": "hidden"});
	        $('#namefile').html(filename+" 파일은 사진이 아닌 것 같습니다.");
	        
	    } else{
	        //if file is valid we show the green alert and show the valid submit
	        $( ".imgupload" ).hide("slow");
	        $( ".imgupload.stop" ).hide("slow");
	        $( ".imgupload.ok" ).show("slow");
	      
	        $('#namefile').css({"color":"#ff3f3f","font-weight":700});
	        $('#namefile').html(" 업로드한 파일 : " + filename);
	      
	    }
	});
	
	</script>
	<script>
		$('#prFormSubmit').click(function(){
			if($('#honbabReason').val() == null){
				alert('리뷰 제목을 입력해주세요')
			} else if($('#reviewContent').val() == null){
				alert('리뷰 내용을 입력해주세요')
			} else if($('input[name="honbabLv"]:checked').val() == null){
				alert('혼밥 레벨을 선택해주세요')
			} else if($('input[name="priceRate"]:checked').val() == null){
				alert('가격 평점을 선택해주세요')
			} else if($('input[name="tasteRate"]:checked').val() == null){
				alert('맛 평점을 입력해주세요')
			} else if($('input[name="serviceRate"]:checked').val() == null){
				alert('서비스 평점을 입력해주세요')
			} else if($('input[name="interiorRate"]:checked').val() == null){
				alert('멋(인테리어) 평점을 입력해주세요')
			} else{
				var formData = new FormData();
				var data = {
			        "id":$('#id').val(),
			        "user_PK":$('#user_PK').val(),
			        "reviewContent":$('#reviewContent').val(),
			        "rejectedCount":($('input[name="rejectedCount"]:checked').val() != null)? $('input[name="rejectedCount"]:checked').val() : "false",
			        "honbabReason":$('#honbabReason').val(),
			        "honbabLv":$('input[name="honbabLv"]:checked').val(),
			        "interiorRate":$('input[name="interiorRate"]:checked').val(),
			        "serviceRate":$('input[name="serviceRate"]:checked').val(),
			        "priceRate":$('input[name="priceRate"]:checked').val(),
			        "tasteRate":$('input[name="tasteRate"]:checked').val(),
			        
			    };
	
			    formData.append("file",$('#file')[0].files[0]);
			    formData.append("key", new Blob([JSON.stringify(data)], {type:"application/json"}));
				
				$.ajax({
					url:"../writeReview",
					type:"post",
					enctype: 'multipart/form-data',		
					processData: false, 
					contentType: false,
					data: formData,
					cache: false,
					async:false,
			        timeout: 600000,  
					success:function(data, textStatus) {
						alert("리뷰가 작성되었습니다.");
						location.href = "../${place.id}?place_name=" + encodeURI("${place.place_name}");
					},
					error: function(data, textStatus){
						alert("리뷰 작성 오류");
						return false; 
					}
				});
				
			}
			return false;
		});
	</script>
	<script> // 좋아요 관련 코드
		$(function(){
			$.ajax(){
				
			}
			
		})
	</script>
</body>
</html>