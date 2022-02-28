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
    <style>
        * { box-sizing:border-box; }

        form {
            width:800px;
            height:600px;
            display : flex;
            flex-direction: column;
            align-items:center;
            position : absolute;
            top:50%;
            left:50%;
            transform: translate(-50%, -50%) ;
            border: 1px solid rgb(89,117,196);
            border-radius: 10px;
             
            
        }

        .input-field {
            width: 300px;
            height: 40px;
            border : 1px solid rgb(89,117,196);
            border-radius:5px;
            padding: 0 10px;
            margin-bottom: 10px;
            
        }
        label {
            width:300px;
            height:30px;
            margin-top :4px;
            font-size:20px;
            
        }

		.check-btn {
			background-color: rgb(89,117,196);
            color : white;
            width:100px;
            height:40px;
            font-size: 15px;
            border : none;
            border-radius: 5px;
           	float : left;
           
          
            
		}
       

        .title {
            font-size : 30px;
            margin: 40px 0 30px 0;
            
        }
        
        .title-text {
        	font-size : 15px;
        }

        .msg {
            height: 30px;
            text-align:center;
            font-size:16px;
            color:red;
            margin-bottom: 20px;
        }
        
        .annotation {
        	font-size:13px;
        	color: #ced4da;
        }
        
	   	.nickname_ok{color:#fff; display: none;}
		.nickname_already{color:#6A82FB; display: none;}
	        
    </style>
    <title>일인분</title>
</head>
<body>
   <form action="<c:url value="/joinSuccess"/>" method="POST" onsubmit="return formCheck(this)">
   	
    <div class="title">
    	<div>
    		<img src="https://placehold.co/30">일인분
    	</div>
    	<div class="title-text">
    		<p align="center">혼밥 정보가 필요할 땐,</p>
    		<p align="center">일인분</p>
    	</div>
    </div>
    
    <hr style="width:700px">
    <br><br>
    <div>
    	<h1>회원가입이 완료 되었습니다.</h1>
    </div>
    <br><br>
    <button type="button" class="check-btn" onclick="location.href='/index'">메인으로</button>
  	<button type="button" class="check-btn" onclick="location.href='/login'">로그인</button>
   
     
   
   </form> 
   
   
   
   	
</body>
</html>