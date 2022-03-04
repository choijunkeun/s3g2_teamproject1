<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 목업 코드, 아래 영역을 주석처리하면 로그아웃 처리된 것으로 짜볼 수 있음 -->
<%@ page import="com.ilinbun.mulcam.dto.User"%>
<%!User user = new User("mockup@mock.up", "목업", "", "#", 5, 1);%>
<c:set var="user" value='<%=user%>' />
<!-- 목업 코드 -->

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
		  width: 200px;
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
						<i class="fa fa-angle-left"></i> <strong>${place_name }</strong></a>
				</h2>
			</div>
			<!-- <div class="placeImgSection">
				<img src="#">
			</div> -->
		</div>
		<form action="../writeReview" method="post" enctype="multipart/form-data" id="prForm">
		<!-- <form id="prForm"> -->
			<input type="hidden" name="user_PK" id="user_PK" value="1"> <!-- 목업 유저정보 코드 -->
			<input type="hidden" name="id" id="id" value="${id }"> <!-- 장소값 코드 -->
			<div class="container p-2 ">
				<div class="row p-1 text-center ">
					<div class="col"> <!-- https://codepen.io/jexordexan/pen/yyYEJa -->
						<table style="width: fit-content; margin: 0 auto;">
							<tr>
								<td>혼밥레벨</td>
								<td id="honbabLv" class="btn-group flex-wrap justify-content-center">
									<!-- <div class="w-100"></div> -->
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
						</table>

					</div>
					<div class="col">
						<input type="checkbox" id="rejectedCount" name="rejectedCount" value="true">
						<label for="rejectedCount">1인 출입 가능 업장</label>
						<input type="text" name="honbabReason" id="honbabReason" style="width: 100%;" placeholder="제목을 써주세요">
					</div>
				</div>
				<div class="row p-1">
					<div class="col">
						<!-- https://codepen.io/emiemi/pen/zxNXWR -->
						<div class="card border rounded text-center justify-content-center">
							<!-- <input type="file" name="revImgFile" style="width: 100%;" placeholder="사진을 이 곳에 업로드 해주세요"> -->
							<div class="btn-container">
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
					</div>
					<div class="col">
						<textarea name="reviewContent" id="reviewContent" style="width: 100%; height: 100%;"
							placeholder="상세 내용을 입력해주세요"></textarea>
					</div>
				</div>
			</div>
			<div class="row py-3">
				<div class="col text-center">
					<button class="btn border bd-secondary">취소</button>
					<input type="submit" class="btn border bd-secondary" value="등록"/>
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
	      
	        $('#namefile').css({"color":"gray","font-weight":700});
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
		$('#prForm').submit(function(){
			console.log("ENTERED TO SUBMITTING");
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
		        timeout: 600000,  
				success:function(data, textStatus) {
					
					alert(data);
					//location.window.href="/search";		
				},
				error: function(data, textStatus){
					alert(data);
					//return false;
				}
			});
			
			return false; 
		});
	</script>
</body>
</html>