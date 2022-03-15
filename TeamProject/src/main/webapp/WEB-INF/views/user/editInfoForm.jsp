<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<style>
	#headertitle {
	font-family: 'Yeongdo-Rg';
	}
	#headertitle:link {
	color : black;
	}
	#headertitle:visited {
	color : black;
	}
	#headertitle:hover {
	color : black;
	}
	#headertitle:active {
	color : black;
	}
	@font-face {
	font-family: 'Yeongdo-Rg';
	src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2202-2@1.0/Yeongdo-Rg.woff') format('woff');
	font-weight: normal;
	font-style: normal;
	}
	@font-face {
	font-family: 'SUIT-Regular';
	src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
	font-weight: normal;
	font-style: normal;
	}


.card {
	position : absolute;
	top : 45%;
	left : 50%;
	transform: translate(-50%, -50%);
	z-index: 1;
	width : 500px;
}

.filebox label { 
	display: inline-block; 
	padding: .5em .75em; 
	 
	font-size: 	inherit; 
	line-height: normal; 
	vertical-align: middle; 
	background-color: #fdfdfd; 
	cursor: pointer; 
	border: 1px solid #ebebeb; 
	border-bottom-color: #e2e2e2; 
	border-radius: .25em; 
	} 
.filebox input[type="file"] { /* 파일 필드 숨기기 */ 
	position: absolute; 
	width: 1px; 
	height: 1px; 
	padding: 0; 
	margin: -1px; 
	overflow: hidden; 
	clip:rect(0,0,0,0); 
	border: 0; 
	}

#cancelImg {
	display: inline-block; 
	padding: .5em .75em; 
	
	font-size: 	inherit; 
	line-height: normal; 
	vertical-align: middle; 
	background-color: white; 
	cursor: pointer; 
	border: 1px solid #ebebeb; 
	border-bottom-color: #e2e2e2; 
	border-radius: .25em; 
}
.msg {
	height: 30px;
	text-align: center;
	font-size: 16px;
	color: red;
}

</style>    

</head>
<body>
<div class="container" >
<form action=/infoUpdate method="POST" enctype="multipart/form-data" >
	<div class="card" style="padding:30px">
	
	<div align="center">
	<img style="border-radius: 200px; width: 150px; height: 150px;"	src="/profile/${user.profileImg }">
	</div>
	
	<div id="preview" align="center"></div>
	
	<div align="center" class="filebox" style="padding:10px">
		<label for="profileImg">사진 등록</label>
		<input type="file" id="profileImg" name="profileImg" class="inp-img" accept=".gif, .jpg, .png">
		<button type="button" id="cancelImg" name="cancelImg" class="btn-delete">사진 삭제</button>
	</div>
	
	
	<div style="padding:20px">
		<div>
			<label class="control-label" for="email">이메일</label>
			<input class="form-control" type="text" id="email" name="email" value="${user.email}" readonly="readonly"/>
		</div>
		<div class="form-group has-feedback">
			<label class="control-label" for="nickname">닉네임</label>
			<input class="form-control" type="text" id="nickname" name="nickname"/>
			<span class="nickname_msg"></span>
		</div>
		<div class="form-group has-feedback">
			<label class="control-label" for="password">비밀번호</label>
			<input class="form-control" type="password" id="password" name="password"/>
			<span class="password_msg"></span>
		</div>
		
	</div>
		
		<div align="center" style="font-size:20px">혼밥레벨설정</div>
		
		<div style="margin:10px 50px"class="btn-group btn-group-sm" aria-label="Basic checkbox toggle button group">
			<input type="radio" class="btn-check " name="honbabLevel" id="lv1" value="1" checked>
			<label class="btn btn-outline-danger" for="lv1">Lv.1</label>
			<input type="radio" class="btn-check" name="honbabLevel" id="lv2" value="2">
			<label class="btn btn-outline-danger" for="lv2">Lv.2</label>
			<input type="radio" class="btn-check" name="honbabLevel" id="lv3" value="3">
			<label class="btn btn-outline-danger" for="lv3">Lv.3</label>
			<input type="radio" class="btn-check" name="honbabLevel" id="lv4" value="4">
			<label class="btn btn-outline-danger" for="lv4">Lv.4</label>
			<input type="radio" class="btn-check" name="honbabLevel" id="lv5" value="5">
			<label class="btn btn-outline-danger" for="lv5">Lv.5</label>
		</div>
		
	<div align="center">		
		<button class="btn btn-success" type="submit" id="joinBtn" name="joinBtn" disabled="disabled">수정</button>
		<button class="cancle btn btn-danger" type="button">취소</button>
	</div>
</div>
</form>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

function check(){
	if(user_nick==1) {	
		$("#joinBtn").attr("disabled",false)
	}
}

//닉네임 체크
$('#nickname').focusout(function(){
	$("#joinBtn").attr("disabled",true);
	var nickname = $('#nickname').val(); //id값이 "nickname"인 입력란의 값을 저장
        if (nickname != "" || nickname != null) {
	        $.ajax({
	            url:'/nickCheck', //Controller에서 인식할 주소
	            type:'POST', //POST 방식으로 전달
	            data:{nickname:nickname},
	            success:function(data){ //컨트롤러에서 넘어온 cnt 값을 받는다.
	                if (data != "사용가능한 닉네임입니다.") {
	                	$("#joinBtn").attr("disabled",true)
	                	user_nick = 0;
	                }
	                else{
		            	/* $("#joinBtn").attr("disabled",false) */
	                	user_nick = 1;
	                	check();
	                } 
	                $('.nickname_msg').text(data);
	            },
	            error:function(){
	                alert("에러입니다");
	            }
	        });
        } else {
        	console.log(nickname)
        	$('.nickname_msg').text("aaaaaaa");
        }
});

$('#password').keyup(function() {
	$("#joinBtn").attr("disabled",true);
	var password = $('#password').val();
		if(password !="" || password != null) {
			$.ajax({
				url:'/passCheck',
				type:'POST',
				data:{password:password},
				success:function(data) {
					let data2 = "";
					if(data != "비밀번호가 일치합니다."){
						$("#joinBtn").attr("disabled",false);
						console.log(data);
					} else {
						data2 = "비밀번호가 다릅니다.";
						console.log(data);
					}
					$('.password_msg').text(data2);
				}
				
			})
		}
})



//등록 이미지 등록 미리보기
function readInputFile(input) {
  if(input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
          $('#preview').html("<img src="+ e.target.result +" style='border-radius: 200px; width: 150px; height: 150px;'>");
      }
      reader.readAsDataURL(input.files[0]);
      document.getElementById("default_image").style.display="none";
  }
}

$(".inp-img").on('change', function(){
  readInputFile(this);
});


//등록 이미지 삭제 ( input file reset )
function resetInputFile($input, $preview) {
  var agent = navigator.userAgent.toLowerCase();
  if((navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1)) {
      // ie 일때
      $input.replaceWith($input.clone(true));
      $preview.empty();
  } else {
      //other
      $input.val("");
      $preview.empty();
  }       
}
$(".btn-delete").click(function(event) {
  var $input = $(".inp-img");
  var $preview = $('#preview');
  resetInputFile($input, $preview);
  document.getElementById("default_image").style.display="block";
  
});



</script>


</html>