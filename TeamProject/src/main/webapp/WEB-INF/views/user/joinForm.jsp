<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<style>
* {
	box-sizing: border-box;
}

form {
	width: 550px;
	display: flex;
	flex-direction: column;
	align-items: center;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	border: 1px solid #d3d3d3;
	border-radius: 10px;
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

.p label:after { content:""; position:absolute; left:0; bottom:-1px; width:0; height:100%; border-bottom:3px solid #5fa8d3; transition:all .3s ease; } /* 파란색 가로줄 */
.p label span { position:absolute; left:0; bottom:5px; transition:all .3s ease; }
.p input:focus + label span, 
.p input:valid + label span { transform:translateY(-150%); font-size:15px; color:#616161; }  /* input에 글을 입력하고 포커스가 지나간 상태에서 제어하려면 valid 선택자를 써야한다. */
/* 포커스 될 때 label span(name)이 위로 올라감 */
.p input:focus + label::after,
.p input:valid + label::after { width:100%; transform:translateX(0); } 
/* 포커스 될 때 파란색 가로줄이 생김 */



.input-field {
	width: 300px;
	height: 40px;
	border: 1px solid rgb(89, 117, 196);
	border-radius: 5px;
	padding: 0 10px;
	margin-bottom: 10px;
}

label {
	width: 300px;
	height: 30px;
	margin-top: 4px;
	font-size: 20px;
}

.check-btn {
	background: #d3d3d3;
	color: white;
	width: 100px;
	height: 40px;
	font-size: 15px;
	border: 1px solid #d3d3d3;
	border-radius: 5px;
	

	-moz-transition: background 1s;
	-o-transition: background, 1s;
    -webkit-transition: background, 1s;
    transition: background, 1s;
}
.check-btn:hover {	
	background-color: #ff0044;
	
}

.join-btn {
	background-color: #ff0044;
	color: white;
	width: 300px;
	height: 50px;
	font-size: 17px;
	border: none;
	border-radius: 5px;
	margin: 20px 0 30px 0;
}

.title {
	font-size: 30px;
	margin: 20px 0 15px 0;
}

.title-text {
	font-size: 15px;
	
}

.msg {
	height: 30px;
	text-align: center;
	font-size: 16px;
	color: red;
	margin-bottom: 20px;
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

div {
	/* background-color: green;   */
	/* border:1px solid black;  */
	/* width: 500px; */
}

.agreeText {
	height: 100px;
	overflow: auto;
}

.title-top {
	font-size: 15px;
	margin : 20px;
}

button {
	float : left;
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



#joinBtn:disabled {
	background-color:#bdbebd;
	color : 
}




</style>

<title>일인분</title>


</head>
<body>
	<form action="<c:url value="/join"/>" method="POST" name="joinform">
	<div class="title-top">
		<div class="title">
			<div align="center">
				<img src="https://placehold.co/30">일인분
			</div>
			<div class="title-text">
				<p align="center">혼밥 정보가 필요할 땐,</p>
				<p align="center">일인분</p>
			</div>
		</div>

		<hr style="width: 500px">
		<div>
			<div style="height:60px">
				<p class="p">
				<input class="input-field" type="text" id="nickname" name="nickname" autocomplete="nickname"  required/>
				<label for="nickname"><span>닉네임</span></label>
				<span class="nickname_msg"></span>
				</p>
			
							
			</div>
			
			<div style="height:60px">
				<p class="p">
				<input class="input-field" type="email" id="email" name="email" autocomplete="email" required/>
				<label for="id"><span>이메일</span></label> 
				<span class="email_msg "></span>
				</p>				
			</div>

			
			<div style="height:60px">
				<p class="p">
				<input class="input-field" type="password" id="password" name="password" autocomplete="off" required >
				<label for="password"><span>비밀번호</span></label>
				</p>
			</div>
			
			
			<div style="height:60px">
				<p class="p">
				<input class="input-field" type="password" id="password2" autocomplete="off" required>
				<label for="password2"><span>비밀번호 확인</span></label>
				</p>			
			</div>
			
			
		</div>
		
		<hr style="width: 500px">

		
		<div style="margin: 0 50px ">
			<!-- 레벨 선택 -->
			<!-- 클릭 시 색상 변경 -->
			<div>
				<div>혼밥레벨설정</div>
				<input type="radio" name="honbabLevel" id="lv1" value="1" checked> <label for="lv1">Lv.1</label>
				<input type="radio" name="honbabLevel" id="lv2" value="2"> <label for="lv2">Lv.2</label>
				<input type="radio" name="honbabLevel" id="lv3" value="3"> <label for="lv3">Lv.3</label>
				<input type="radio" name="honbabLevel" id="lv4" value="4"> <label for="lv4">Lv.4</label>
				<input type="radio" name="honbabLevel" id="lv5" value="5"> <label for="lv5">Lv.5</label>
			</div>
			<!-- 클릭 시 팝오버 설명 -->
			혼밥 레벨이란?
		</div>

		
		<!-- 프로필 이미지 -->
		
		<hr style="width: 500px">


		<!-- 약관 동의 -->
		<div style="margin: 0 50px">
			<div>
				<input type="checkbox" id="agreeBtn" name="agree"><label
					for="agreeBtn">약관 동의</label>
			</div>
			<div class="agreeText">
				<h3>제 1조(목적)</h3>
				<p>본 약관은 주식회사 일인용(이하"회사"라 합니다)에서 제공하는 인터넷 관련서비스(접속 가능한 유, 무선
					단말기의 종류와 )관계없이 회사가 제공하는 모든 서비스를 의미하며, 이하 "서비스"라 합니다)를 이용함에 있어 회사와
					회원의 권리와 의무, 책임사항을 규정함을 그 목적으로 합니다.
			</div>
		</div>
		</div>
		<!-- 회원 가입 -->
		<div id="msg" class="msg">${URLDecoder.decode(param.msg, "utf-8")}</div>
		<button type="submit" id="joinBtn" class="join-btn" disabled="disabled">회원가입하기</button>
	</form>
		
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

//닉네임 체크
$('#nickname').focusout(function(){
	$("#joinBtn").attr("disabled",true)
	var nickname = $('#nickname').val(); //id값이 "nickname"인 입력란의 값을 저장
        if (nickname != "" || nickname != null) {
	        $.ajax({
	            url:'/nickCheck', //Controller에서 인식할 주소
	            type:'POST', //POST 방식으로 전달
	            data:{nickname:nickname},
	            success:function(data){ //컨트롤러에서 넘어온 cnt 값을 받는다.
	                if (data != "사용가능한 닉네임입니다.") {
	                	$("#joinBtn").attr("disabled",true)
	                }
	                else{
		            	$("#joinBtn").attr("disabled",false)
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


//이메일 체크
$('#email').focusout(function(){
	$("#joinBtn").attr("disabled",true)
	var email = $('#email').val(); //id값이 "email"인 입력란의 값을 저장
        if (email != "" || email != null) {
	        $.ajax({
	            url:'/emailCheck', //Controller에서 인식할 주소
	            type:'POST', //POST 방식으로 전달
	            data:{email:email},
	            success:function(data){ //컨트롤러에서 넘어온 cnt 값을 받는다.
	                if (data != "사용가능한 이메일입니다.") {
	                	$("#joinBtn").attr("disabled",true)
	                }
	                else{
		            	$("#joinBtn").attr("disabled",false)
	                }
	                $('.email_msg').text(data);
	            },
	            error:function(){
	                alert("에러입니다");
	            }
	        });
        } else {
        	console.log(email)
        	$('.email_msg').text("aaaaaaa");
        }
});

    
    
    /* function checkEmail(){
        var email = $('#email').val(); //id값이 "nickname"인 입력란의 값을 저장
        $.ajax({
            url:'/emailCheck', //Controller에서 인식할 주소
            type:'POST', //POST 방식으로 전달
            data:{email:email},
            success:function(cnt){ //컨트롤러에서 넘어온 cnt 값을 받는다.
            	 if(cnt != 1){ //cnt가 1이 아니면(=0일 경우) -> 사용 가능한 아이디
                     $('.email_ok').css("display","inline-block"); 
                     $('.email_already').css("display", "none");
            	 } else { // cnt가 1일 경우 -> 이미 존재하는 아이디
            		 $('.email_already').css("display","inline-block");
                     $('.email_ok').css("display", "none");
            	 }
            },
            error:function(){
                alert("에러입니다");
            }
        });
    }; */
</script>
		
	<!-- <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	
	
	<script>		
	
	
	

		
			$('#nickCheck').click(function () {
	    		if($('#nickname').val()=="" || $('#nickname').val().length<2){
					return false;
				}
	    		$.ajax({
					type:"post",
					dataType:"text",
					async:false,
					url:"http://localhost:8090/nickCheck",
					data:{nickname:$('#nickname').val()},
					success: function(data, textStatus){
						console.log(data)
						if(data=="true"){
							alert("이미 존재하는 닉네임 입니다.");
							$('#nickCheck').attr("disabled", false);
						} else {
							alert("사용 가능한 닉네임입니다.");
							$('input[name=nickCheck]').attr('value',"사용가능");
						}
					}
				});
			});
	
		
       	function formCheck(frm) {
       		let submitOk = true;
            var msg ='';
      
            if(frm.nickname.value.length<2) {
                setMessage('닉네임은 2글자 이상이어야 합니다.', frm.nickname);
                submitOk=false;
            } else{
            	document.getElementById("nick_msg").innerHTML = "";
            }
            
            if(frm.email.value.length<1) {
                setMessage('아이디를 입력해주세요', frm.email);
                submitOk=false;
            } else{
            	document.getElementById("email_msg").innerHTML = "";
            }
            if(frm.password.value.length<6 || frm.password.value.length>12) {
                setMessage('비밀번호는 6-12자 사이어야 합니다.', frm.password);
                submitOk=false;
            } else{
            	document.getElementById("pass_msg").innerHTML = "";
            }
            
            if(frm.password.value != frm.password2.value) {
                setMessage('비밀번호와 비밀번호확인이 일치하지 않습니다.', frm.password2);
                submitOk=false;
            } else{
            	document.getElementById("pass2_msg").innerHTML = "";
            }
            if(!frm.agree.checked) {
            	setMessage('약관에 동의하셔야 합니다.', frm.agree);
            	submitOk=false;
            } else{
            	document.getElementById("msg").innerHTML = "";
            }
               
           return submitOk;
       }

       function setMessage(msg, element){
    	   if(element.id=='nickname') {
    		   document.getElementById("nick_msg").innerHTML = `<i class="fa fa-exclamation-circle"> ${'${msg}'}</i>`;
    	   } else if (element.id=='email') {
    		   document.getElementById("email_msg").innerHTML = `<i class="fa fa-exclamation-circle"> ${'${msg}'}</i>`;
    	   } else if (element.id=='password') {
    		   $('#pass_msg').innerHTML = `<i class="fa fa-exclamation-circle"> ${'${msg}'}</i>`;
    	   } else if (element.id=='password2') {
    		   $('#pass2_msg').innerHTML = `<i class="fa fa-exclamation-circle"> ${'${msg}'}</i>`;
    	   } else {
    		   document.getElementById("msg").innerHTML = `<i class="fa fa-exclamation-circle"> ${'${msg}'}</i>`;
    	   }
    	   
    	   
            if(element) {
                element.select();
            }
       }  
   </script> -->
</body>
</html> 
