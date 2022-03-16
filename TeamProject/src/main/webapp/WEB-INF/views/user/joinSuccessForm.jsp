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
	
	.card {
	position : absolute;
	top : 50%;
	left : 50%;
	transform: translate(-50%, -50%);
	z-index: 1;
	width : 500px;
}
    </style>
    <title>일인분</title>
</head>
<body>
    <div class="container">
		<div class="card">
    		<div align="center" style="margin:15px">
				<h1 class="display-4 fw-bolder">
				<a href="/" id="headertitle" style="text-decoration: none; text-color:black;">일인분</a>
				</h1>
			</div>
    	<div class="title-text">
    		<p align="center">혼밥 정보가 필요할 땐,</p>
    		<p align="center">일인분</p>
    	</div>
    <hr style="width:500px">
    <div align="center" style="margin:15px;">
    	<h3>회원가입이 완료 되었습니다</h3>
    </div>
    <div align="center" style="padding:0px 0px 15px 0px; margin:15px;">
    <button type="button" class="btn btn-outline-danger" onclick="location.href='/index'">메인으로</button>
  	<button type="button" class="btn btn-outline-danger" onclick="location.href='/login'">로그인</button>
  	</div>
</div>
   </div>
   
   
   
   	
</body>
</html>