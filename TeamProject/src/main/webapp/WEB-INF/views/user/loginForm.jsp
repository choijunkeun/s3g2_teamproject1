<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder"%>
<%-- <%@ page session="false" %> --%>
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
            height:500px;
            display : flex;
            flex-direction: column;
            align-items:center;
            position : absolute;
            top:50%;
            left:50%;
            transform: translate(-50%, -50%) ;
            border: 1px solid #d3d3d3;
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
          
            
		}
        .join-btn {
            background-color: rgb(89,117,196);
            color : white;
            width:300px;
            height:50px;
            font-size: 17px;
            border : none;
            border-radius: 5px;
            margin : 20px 0 30px 0;
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
   <form action="<c:url value="/login"/>" method="POST" onsubmit="return formCheck(this)">
   	
    <div class="title d-flex">
    	<div class="justify-content-center text-center">
    		<img src="https://placehold.co/30">일인분
    	</div>
    	<div class="title-text">
    		<p align="center">혼밥 정보가 필요할 땐,</p>
    		<p align="center">일인분</p>
    	</div>
    </div>
    <!-- <div class="container p-4 px-lg-5"  onclick="window.locaiton.href="/">
		<div class="text-center justify-content-center text-black">
			<h1 class="display-4 fw-bolder text-center justify-content-center "
				style="text-align: center;">
				<a style="text-decoration: none; font-color:black;" href="/">
				일인분
				</a>
			</h1>
			<span>혼밥 정보가 필요할 땐, 일인분</span>
		</div>
	</div> -->
    
    <hr style="width:700px">
   	
   	<table>
   		<tr>
   			<td><label for="email">이메일</label></td>
   			<td><input class="input-field" type="email" id="email" name="email" 
   				value="${cookie.email.value}" placeholder="이메일을 입력해주세요."></td>
   		</tr>
		<tr>
			<td><label for="password">비밀번호</label></td>
			<td><input class="input-field" type="password" id="password" 
				name="password" placeholder="비밀번호를 입력해주세요."></td>
		</tr>   	
   	</table>
	<div>
		<div>
			<label><input type="checkbox" name="rememberEmail" value="on" ${empty cookie.email.value ? "":"checked"}>로그인 저장</label> 
		</div>
		<div>
			<a href="searchPwd">비밀번호 찾기</a>
		</div>
	</div>
     
    <div id="msg" class="msg"> ${URLDecoder.decode(param.msg, "utf-8")}</div>
    <button type="submit" class="join-btn">로그인</button>
    <a href="/join">아직 계정이 없으신가요? 가입하기</a>
      
	</form> 
</body>
 <script>
      
       
   </script>
</html>