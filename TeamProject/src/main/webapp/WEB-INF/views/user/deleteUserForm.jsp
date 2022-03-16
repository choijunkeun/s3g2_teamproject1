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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
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

#cancelImg, #defaultImg{
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
    <title>일인분</title>
</head>
<body>
<div class="container">
	<form action="/deleteUser" method="POST">
	<div class="col-md-6" style="float:none; margin:0 auto;">
		<div class="card">
			<div class="title">
				<div align="center">
					<h1 class="display-4 fw-bolder">
					<a href="/" id="headertitle" style="text-decoration: none; text-color:black;">일인분</a>
					</h1>
				</div>
				<div class="title-text">
					<p align="center">혼밥 정보가 필요할 땐,</p>
					<p align="center">일인분</p>
				</div>
			</div>
    
    		<div align="center">계정 삭제를 원하시면 이메일과 비밀번호를 입력해주세요</div>
    		<hr style="width:500px">
    		<div style="padding:20px">
	   			<div style="padding:20px">
					<div>
						<label class="control-label" for="email">이메일</label>
						<input class="form-control" type="text" id="email" name="email" value="${user.email}" readonly="readonly"/>
					</div>
					<div class="form-group has-feedback">
						<label class="control-label" for="password">비밀번호</label>
						<input class="form-control" type="password" id="password" name="password"/>
					</div>
				</div>
   			</div>
   	<div id="msg" class="msg"> ${URLDecoder.decode(param.msg, "utf-8")}</div>
   	<div align="center" class="d-grid gap-2 col-6 mx-auto" style="padding:0px 0px 15px 0px">
   	<button type="submit" id="joinBtn" name="joinBtn" class="btn btn-outline-danger">탈퇴하기</button>
	<button class="cancle btn btn-danger" type="button" onclick="history.go(-1);">취소</button>
   	</div>
	</div>
      </div>
   </form>
</div> 
</body>
</html>