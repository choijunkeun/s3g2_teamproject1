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
	        
    </style>
    <title>일인분</title>
</head>
<body>
   <form action="<c:url value="/register/save"/>" method="POST" onsubmit="return formCheck(this)">
   	
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
    <div>
   	<p class="annotation"> * 필수항목
   	</div>
   	<div>
    <label for="nickname">닉네임</label>
    <input class="input-field" type="text" id="nickname" name="nickname" placeholder="닉네임을 입력해주세요.">
    <button class="check-btn">중복확인</button>
    </div>
   	<div>
   		<span class="nickname_ok">사용 가능한 닉네임입니다.</span>
   		<span class="nickname_alreadey">이미 사용중인 닉네임입니다.</span>
   	</div>
    <div>
    <div><p class="annotation"> * 2-10자 이내, 공백 불가능, 한글 가능</div>
    <label for="email">이메일</label>
    <input class="input-field" type="email" id="email" name="email" placeholder="이메일을 입력해주세요.">
     <button class="check-btn" onclick="onDisplay()">인증메일발송</button>
    </div>
    
    <div id="onDispaly" style="display: none;">
    <input class="input-field" placeholder="인증번호">
     <button class="check-btn">인증하기</button>
    </div>
    
     
   <div>
   	<label for="password">비밀번호</label>
    <input class="input-field" type="text" id="password" name="password" placeholder="비밀번호를 입력해주세요.">
     <div><p class="annotation"> * 8-20자 이내, 공백 불가능, 한글 가능</div>
     </div>
     <div>
    <label for="password2">비밀번호 확인</label>
    <input class="input-field" type="text" id="password2" placeholder="비밀번호와 동일하게 입력해주세요">
    <div><p class="annotation"> * 2-10자 이내, 공백 불가능, 한글 가능</div>
    </div>
    
    
    <button class="join-btn">회원가입하기</button>
    <div id="msg" class="msg"> ${URLDecoder.decode(param.msg, "utf-8")}</div>  
   </form> 
   
   
   
   	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript">
        function checkId(){
            var id = $('#id').val();
        $.ajax({
            url:'/user/idCheck',
            type:'post',
            data:{id:id},
            success:function(cnt){ //컨트롤러에서 넘어온 cnt값을 받는다 
                if(cnt != 1){ //cnt가 1이 아니면(=0일 경우) -> 사용 가능한 아이디 
                    $('.id_ok').css("display","inline-block"); 
                    $('.id_already').css("display", "none");
                } else { // cnt가 1일 경우 -> 이미 존재하는 아이디
                    $('.id_already').css("display","inline-block");
                    $('.id_ok').css("display", "none");
                }
            },
            error:function(){
                alert("에러입니다");
            }
        });
        };
    </script>
   
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