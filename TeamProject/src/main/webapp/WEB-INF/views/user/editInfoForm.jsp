<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<style>
* {
	box-sizing: border-box;
}

form {
	width: 800px;
	display: flex;
	flex-direction: column;
	align-items: center;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -20%);
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
 
 .password_msg{
 	font-size:12px;
 	color : #ff3232;
 }



#joinBtn:disabled {
	background-color:#bdbebd;
	color : 
}
</style>


</head>
<body>
<form action=/infoUpdate method="POST" enctype="multipart/form-data">
	<div><input type="file" name="profileImg">
	</div>
	<div><img style="border-radius: 200px; width: 150px; height: 150px;"
							src="/profile/${user.profileImg }">
	</div>
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
		<label class="control-label" for="originPass">패스워드</label>
		<input class="form-control" type="password" id="originPass" name="originPass"/>
	</div>
	<div class="form-group has-feedback">
		<label class="control-label" for="password">변경 할 패스워드</label>
		<input class="form-control" type="password" id="password"name="password"/>
		<span class="password_msg"></span>
	</div>
	<div class="form-group has-feedback">
		<label class="control-label" for="password2">변경 할 패스워드 확인</label>
		<input class="form-control" type="password" id="password2"/>
	</div>
	<div>
		<div>혼밥레벨설정</div>
			<input type="radio" name="honbabLevel" id="lv1" value="1" checked> <label for="lv1">Lv.1</label>
			<input type="radio" name="honbabLevel" id="lv2" value="2"> <label for="lv2">Lv.2</label>
			<input type="radio" name="honbabLevel" id="lv3" value="3"> <label for="lv3">Lv.3</label>
			<input type="radio" name="honbabLevel" id="lv4" value="4"> <label for="lv4">Lv.4</label>
			<input type="radio" name="honbabLevel" id="lv5" value="5"> <label for="lv5">Lv.5</label>
	</div>
	<div class="form-group has-feedback">
		<button class="btn btn-success" type="submit" id="submit">회원정보수정</button>
		<button class="cancle btn btn-danger" type="button">취소</button>
	</div>
</form>
</body>
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

//비밀번호 유효성 체크
$(function(){
	$('#password2').focusout(function(){
	   if($('#password').val() != $('#password2').val()){
	    	if($('#password2').val()!=''){
		    	$('.password_msg').text("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
	    	    $('#password2').val('');
	          	$('#password2').focus();
	      	}
	    } else if($('#password').val().length < 1) {
	    	$('.password_msg').text("비밀번호를 입력해주세요");
	    } else if($('#password').val() == $('#password2').val()) {
	    	$('.password_msg').text("비밀번호가 일치합니다.");
	    } 
	   
	})  	   
});   


// 약관 동의 체크




    
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
<script type="text/javascript">
$(document).ready(function(){
	// 취소
	$(".cancle").on("click", function(){
		
		location.href = "/myPage";
				    
	})

	$("#submit").on("click", function(){
		if($("#password").val()==""){
			alert("비밀번호를 입력해주세요.");
			$("#password").focus();
			return false;
		}
		if($("#nickname").val()==""){
			alert("닉네임을 입력해주세요.");
			$("#nickname").focus();
			return false;
		}
	});
});


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

//비밀번호 유효성 체크
$(function(){
	$('#password2').focusout(function(){
	   if($('#password').val() != $('#password2').val()){
	    	if($('#password2').val()!=''){
		    	$('.password_msg').text("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
	    	    $('#password2').val('');
	          	$('#password2').focus();
	      	}
	    } else if($('#password').val().length < 1) {
	    	$('.password_msg').text("비밀번호를 입력해주세요");
	    } else if($('#password').val() == $('#password2').val()) {
	    	$('.password_msg').text("비밀번호가 일치합니다.");
	    } 
	   
	})  	   
});   


</script> -->

</html>