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
<title>게시글 수정</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>

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
		  color: green;
		}
		.imgupload.stop {
		  display: none;
		  color: red;
		}
		
		/*this sets the actual file input to overlay our button*/
		#fileup {
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
<body>

<section id = "writeForm">
<h2>게시판글수정</h2>
<form action="boardmodify" method="post" name = "modifyform">
<input type = "hidden" name = "board_num" value = "${article.board_num}"/>
<table>
	<tr>
		<td class="td_left">
			<label for = "board_name">글쓴이</label>
		</td>
		<td class="td_right">
			<input type = "text" name="board_name" id = "board_name" value = "${article.board_name}"/>
		</td>
	</tr>
	<tr>
		<td class="td_left">
			<label for = "board_pass">비밀번호</label>
		</td>
		<td class="td_right">
			<input name="board_pass" type="password" id = "board_pass"/>
		</td>
	</tr>
	<tr>
		<td class="td_left">
			<label for = "board_subject">제 목</label>
		</td>
		<td class="td_right">
			<input name="board_subject" type="text" id = "board_subject" value = "${article.board_subject}"/>
		</td>
	</tr>
	<tr>
		<td class="td_left">
			<label for = "board_content">내 용</label>
		</td>
		<td>
			<textarea id = "board_content" name="board_content" cols="40" rows="15">${article.board_content}</textarea>
		</td>
	</tr>
</table>
	<section id = "commandCell">
			<a href="javascript:modifyboard()">[수정]</a>&nbsp;&nbsp;
			<a href="javascript:history.go(-1)">[뒤로]</a>
	</section>
</form>
</section>

<!-- 여기까지 modify form -->

	<div class="container pb-3 bg-light">


		<form>
			<div class="container p-2 ">
				<div class="row p-1 text-center ">
					<div class="col">
						<!-- https://codepen.io/jexordexan/pen/yyYEJa -->
						<table style="width: fit-content; margin: 0 auto;">
							<tr>
								<td>
									<div class="btn-group-sort" style="width: fit-content;">
										<button type="button"
											class="btn btn-secondary dropdown-toggle" id="sortDropdown"
											data-bs-toggle="dropdown" aria-expanded="false">문파선택</button>
										<ul class="dropdown-menu text-center"
											aria-labelledby="sortDropdown">
											<li><button class="dropdown-item" type="button">사먹파</button></li>
											<li><button class="dropdown-item" type="button">해먹파</button></li>
										</ul>
									</div>
								</td>
								<td>
									<div class="input-group" style="flex-shrink: 1;">
										<input type="text" class="form-control" id="keyword"
											placeholder="위치검색" aria-label="위치">
										<!-- 검색하기 버튼 아니고, 위치 DB에 있으면 자동으로 뜨고 그걸 선택하면 들어가게  -->
									</div>
								</td>
								<td colspan="2"></td>
							</tr>
							<tr>
								<td colspan="2"></td>
								<td colspan="2">
									<div class="col">
										<textarea name="reviewContent"
											style="width: 100%; height: 100%;" placeholder="제목을 입력해주세요"></textarea>
									</div>
								</td>
							</tr>
							<tr rowspan="2">
								<td colspan="2">

									<div class="col">
										<!-- https://codepen.io/emiemi/pen/zxNXWR -->
										<div class="card border rounded text-center justify-content-center">
											<!-- <input type="file" name="revImgFile" style="width: 100%;" placeholder="사진을 이 곳에 업로드 해주세요"> -->
											<div class="btn-container">
												<!--the three icons: default, ok file (img), error file (not an img)-->
												<h1 class="imgupload">
													<i class="fa fa-file-image-o"></i>
												</h1>
												<h1 class="imgupload ok">
													<i class="fa fa-check"></i>
												</h1>
												<h1 class="imgupload stop">
													<i class="fa fa-times"></i>
												</h1>
												<!--this field changes dinamically displaying the filename we are trying to upload-->
												<p id="namefile">사진만 올려주세요!(jpg,jpeg,bmp,png)</p>
												<!--our custom btn which which stays under the actual one-->
												<!--  내장버튼인가 <button type="button" id="btnup" class="btn btn-primary btn-lg">파일 선택2</button>-->
												<input type="file" value="" name="fileup" id="fileup">
											</div>
										</div>
									</div>
								</td>
								<td colspan="2">
								
									<div class="col">
												<textarea name="reviewContent" style="width: 265px; height: 260px;" placeholder="사진에 대해 설명해 주세요"></textarea>
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>

			<div class="row py-3">
				<div class="col text-center">
					<button class="btn border bd-secondary">취소</button>
					<input type="submit" class="btn border bd-secondary" value="등록" />
				</div>
			</div>

		</form>


	</div>

	<!-- 
<script>
    function dp_menu(){
        let click = document.getElementById("drop-content");
        if(click.style.display === "none"){
            click.style.display = "block";

        }else{
            click.style.display = "none";

        }
    }
</script> -->

	<script>
	$('#fileup').change(function(){
		//here we take the file extension and set an array of valid extensions
		    var res=$('#fileup').val();
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
		      
		        $('#namefile').css({"color":"red","font-weight":700});
		        $('#namefile').html("File "+filename+" is not  pic!");
		        
		        $( "#submitbtn" ).hide();
		        $( "#fakebtn" ).show();
		    }else{
		        //if file is valid we show the green alert and show the valid submit
		        $( ".imgupload" ).hide("slow");
		        $( ".imgupload.stop" ).hide("slow");
		        $( ".imgupload.ok" ).show("slow");
		      
		        $('#namefile').css({"color":"green","font-weight":700});
		        $('#namefile').html(filename);
		      
		        $( "#submitbtn" ).show();
		        $( "#fakebtn" ).hide();
		    }
		});
	
	</script>
</body>
</html>