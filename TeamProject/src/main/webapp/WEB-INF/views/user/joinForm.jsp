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
            height:1000px;
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
		
		div{
		/* background-color: green; */
		/* border:1px solid black; */
		width:500px;
		}
		
		.agreeText {
		height:100px;
		overflow:auto;
		}
	        
    </style>
   
    <title>일인분</title>
    
    
</head>
<body>
   <form action="<c:url value="/join"/>" method="POST" onsubmit="return formCheck(this)">
   	
    <div class="title">
    	<div style="align-items:center">
    		<img src="https://placehold.co/30">일인분
    	</div>
    	<div class="title-text">
    		<p align="center">혼밥 정보가 필요할 땐,</p>
    		<p align="center">일인분</p>
    	</div>
    </div>
    
    <hr style="width:700px">
    <div>
   	<p class="annotation"> * 필수항목
   	</div>
   	
   	
   	<div>
    <label for="nickname">닉네임</label>
    <input class="input-field" type="text" id="nickname" name="user_nickname" placeholder="닉네임을 입력해주세요.">
    <button type="button" class="check-btn">중복확인</button>
    </div>
    
   	<div>
   		<span class="nickname_ok">사용 가능한 닉네임입니다.</span>
   		<span class="nickname_alreadey">이미 사용중인 닉네임입니다.</span>
   	</div>
    <div>
    <div><p class="annotation"> * 2-10자 이내, 공백 불가능, 한글 가능</div>
    <label for="email">이메일</label>
    <input class="input-field" type="email" id="email" name="user_email" placeholder="이메일을 입력해주세요.">
     <button type="button" class="check-btn" onclick="onDisplay()">인증메일발송</button>
    </div>
    
    <div id="onDispaly" style="display: none;">
    <input class="input-field" placeholder="인증번호">
     <button class="check-btn">인증하기</button>
    </div>
    
     
   <div>
   	<label for="password">비밀번호</label>
    <input class="input-field" type="text" id="password" name="user_password" placeholder="비밀번호를 입력해주세요.">
     <div><p class="annotation"> * 8-20자 이내, 공백 불가능, 한글 가능</div>
     </div>
     <div>
    <label for="password2">비밀번호 확인</label>
    <input class="input-field" type="text" id="password2" placeholder="비밀번호와 동일하게 입력해주세요">
    <div><p class="annotation"> * 2-10자 이내, 공백 불가능, 한글 가능</div>
    </div>
    
    <hr style="width:700px">
    
    <div>
		<!-- 레벨 선택 -->
		<!-- 클릭 시 색상 변경 -->
		<div>
			<div>혼밥레벨설정</div>
			<input type="radio" name="level" id="lv1">
			<label for="lv1">Lv.1</label>
			<input type="radio" name="level" id="lv2"> 
			<label for="lv2">Lv.2</label>
			<input type="radio" name="level" id="lv3">
			<label for="lv3">Lv.3</label>
			<input type="radio" name="level" id="lv4"> 
			<label for="lv4">Lv.4</label>
			<input type="radio" name="level" id="lv5"> 
			<label for="lv5">Lv.5</label>
			
		</div>
			<!-- 클릭 시 팝오버 설명 -->
		 혼밥 레벨이란?


	</div>
    
    
   <!-- 프로필 이미지 -->
    
    
    <hr style="width:700px">
    
    
	<!-- 약관 동의 -->
	<div>
	<div><input type="checkbox" id="agreeBtn"><label for="agreeBtn">약관 동의</label></div>
	<div class="agreeText">
		<h3>제 1조(목적)</h3>
		<p>본 약관은 주식회사 일인용(이하"회사"라 합니다)에서 제공하는 인터넷 관련서비스(접속 가능한 유, 무선 단말기의 종류와 )관계없이 회사가 제공하는 모든 서비스를 의미하며, 이하 "서비스"라 합니다)를 이용함에 있어 회사와 회원의 권리와 의무, 책임사항을 규정함을 그 목적으로 합니다.
	</div>
	</div>
	  
	<br>
	<!-- 회원 가입 -->
	<div id="msg" class="msg"> ${URLDecoder.decode(param.msg, "utf-8")}</div>  
    <button type="submit" class="join-btn">회원가입하기</button>
    
   </form> 
   
   
   
   	
   	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
   	<script>
   		
	  

       	function formCheck(frm) {
            var msg ='';

            if(frm.nickname.value.length<2) {
                setMessage('닉네임은 2글자 이상이어야 합니다.', frm.nickname);
                return false;
            }
            
            if(frm.password.value.length<8 || frm.password.value.length>20) {
                setMessage('비밀번호는 8-20자 사이어야 합니다.', frm.password);
                return false;
            }
            
            if(frm.password.value != frm.password2.value) {
                setMessage('비밀번호와 비밀번호확인이 일치하지 않습니다.', frm.password);
                return false;
            }
           return true;
       }

       function setMessage(msg, element){
            document.getElementById("msg").innerHTML = `<i class="fa fa-exclamation-circle"> ${'${msg}'}</i>`;
            if(element) {
                element.select();
            }
       }
   </script>
</body>
</html>