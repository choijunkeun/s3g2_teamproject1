<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">



<style>

</style>


<title>Insert title here</title>
</head>
<body>
<form action="/infoUpdate" method="POST">
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
		<label class="control-label" for="password">패스워드</label>
		<input class="form-control" type="password" id="password" name="password"/>
		<span class="password_msg"></span>
	</div>
	<div class="form-group has-feedback">
		<label class="control-label" for="password2">패스워드 확인</label>
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


</script>

</html>