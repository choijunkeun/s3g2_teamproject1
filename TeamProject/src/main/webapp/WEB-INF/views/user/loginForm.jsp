<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
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

hr {
	border: 1px solid #d3d3d3;
}


.p { 
	margin:20px 50px 30px; }
/* form과 fieldset은 선택자로 사용하지 않는다. */

/* 스타일 */
.p { position:relative; width:80%; height:40px; } /* 기본세팅 */



.p input { box-sizing:border-box; padding:10px 0 0; width:100%; height:100%; border:0 none; color:#595f63; outline:none; }
.p label { color: #9e9e9e; position:absolute; left:0%; bottom:0; width:100%; height:100%; border-bottom:1px solid #000; text-align:left; pointer-events:none; }

.p label:after { content:""; position:absolute; left:0; bottom:-1px; width:0; height:100%; border-bottom:3px solid #db2d21; transition:all .3s ease; } /* 파란색 가로줄 */
.p label span { position:absolute; left:0; bottom:5px; transition:all .3s ease; }
.p input:focus + label span, 
.p input:valid + label span { transform:translateY(-120%); font-size:14px; color:#616161; }  /* input에 글을 입력하고 포커스가 지나간 상태에서 제어하려면 valid 선택자를 써야한다. */
/* 포커스 될 때 label span(name)이 위로 올라감 */
.p input:focus + label::after,
.p input:valid + label::after { width:100%; transform:translateX(0); } 
/* 포커스 될 때 파란색 가로줄이 생김 */

.title {
	font-size: 30px;
	margin: 20px 0 15px 0;
}

.title-text {
	font-size: 17px;
	
}

.msg {
	height: 30px;
	text-align: center;
	font-size: 16px;
	color: red;
}

.annotation {
	font-size: 13px;
	color: #ced4da;
}

.nickname_ok {
	color: #fff;
	display: none;
}

.nickname_already {
	color: #6A82FB;
	display: none;
}

.agreeText {
	height: 100px;
	overflow: auto;
}

.title-top {
	font-size: 15px;
	margin : 20px;
}


.div-text {
	
	height : 80px;
	display: flex;
}	

.nickname_msg {
 	font-size:12px;
 	color : #ff3232;
 }
 
 .email_msg {
 	font-size:12px;
 	color : #ff3232;
 }
 
 .password_msg{
 	font-size:12px;
 	color : #ff3232;
 }

#joinBtn:disabled {
	background-color:#bdbebd;
	
}

.card {
	position : absolute;
	top : 50%;
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




a:link {text-decoration: none;}
a:visited { color: black; text-decoration: none;}
a:hover { color: black; text-decoration: underline;}
/*배너 이미지 사이즈 조절 코드 크롬에서만 됨  */
.logo {
	width: 40%;
	height: auto;
}
</style>    
	<title>일인분</title>
</head>
<body>
<div class="container">
	<form action="<c:url value="/login"/>" method="POST" onsubmit="return formCheck(this)">
		<div class="title-top card">
			<div class="title">
				<div align="center">
					<h1 class="display-4 fw-bolder">
					<a href="/" id="headertitle" style="text-decoration: none; text-color:black;"><img src="${path}/banner/logo.gif" class="logo" /></a>
					</h1>
				</div>
				<div class="title-text">
					<p align="center">혼밥 정보가 필요할 땐,</p>
					<p align="center">혼산족들의 공간!</p>
				</div>
			</div>
    		<hr style="width:500px">
    		<div style="height:60px">
				<p class="p">
				<input class="input-field" type="text" id="email" name="email" autocomplete="email" value="${cookie.email.value}" required>
				<label for="id"><span>이메일</span></label> 
				<span class="email_msg"></span>
				</p>				
			</div>
			<div style="height:60px">
				<p class="p">
				<input class="input-field" type="password" id="password" name="password" autocomplete="password" required>
				<label for="password"><span>비밀번호</span></label>
				</p>
			</div>
		
			<div align="center" style="padding:15px">
				<div class="row">
					<div align="center" class="col">
					<label for="checkbox"><input type="checkbox" id="checkbox" name="rememberEmail" style="padding:20px" value="on" ${empty cookie.email.value ? "":"checked"}>로그인 저장</label>
					</div>
					 
				</div>
			</div>
			<div align="center" class="d-grid gap-2 col-6 mx-auto" style="padding:0px 0px 15px 0px">
		  		<div id="msg" class="msg"> ${URLDecoder.decode(param.msg, "utf-8")}</div>
		 		<button type="submit" id="joinBtn" name="joinBtn" class="btn btn-outline-danger" disabled="disabled">로그인</button>
		  		<a href="/join">아직 계정이 없으신가요? 가입하기</a>
		   		
		    </div>
		</div>
	</form> 
</div>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$('#password').keyup(function(){
		var passLength = $('#password').val().length;
		
		if(passLength>0) {
			$('#joinBtn').attr("disabled", false);
		} 
		if(passLength==0) {
			$('#joinBtn').attr("disabled", true);
		}
	});
	



</script>

</body>
</html>