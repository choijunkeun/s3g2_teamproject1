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

/* 
* {
	box-sizing: border-box;
} */

/* .container {
	
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
 */
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



/* .input-field {
	width: 300px;
	height: 40px;
	border: 1px solid rgb(89, 117, 196);
	border-radius: 5px;
	padding: 0 10px;
	margin-bottom: 10px;
} */

/* label {
	width: 300px;
	height: 30px;
	margin-top: 4px;
	font-size: 20px;
} */

/* .check-btn {
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
	
} */

/* .join-btn {
	background-color: #ff0044;
	color: white;
	width: 300px;
	height: 50px;
	font-size: 17px;
	border: none;
	border-radius: 5px;
	margin: 20px 0 30px 0;
} */

.title {
	font-size: 30px;
	margin: 20px 0 15px 0;
}

.title-text {
	font-size: 17px;
	
}

/* .msg {
	height: 30px;
	text-align: center;
	font-size: 16px;
	color: red;
	margin-bottom: 20px;
} */

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
	width : 600px;
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




</style>

<title>일인분</title>


</head>
<body>
<div class="container">
	<form action="/join" method="POST" enctype="multipart/form-data">
		<div class="title-top card">
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

		<hr style="width: 600px" >
		<div>
			
			<div style="height:60px">
				<p class="p">
				<input class="input-field" type="text" id="email" name="email" autocomplete="email" required/>
				<label for="id"><span>이메일</span></label> 
				<span class="email_msg"></span>
				</p>				
			</div>
			
			<div style="height:60px">
				<p class="p">
				<input class="input-field" type="text" id="nickname" name="nickname" autocomplete="nickname"  required/>
				<label for="nickname"><span>닉네임</span></label>
				<span class="nickname_msg"></span>
				</p>				
			</div>

			
			<div style="height:60px">
				<p class="p">
				<input class="input-field" type="password" id="password" name="password" autocomplete="password" required >
				<label for="password"><span>비밀번호</span></label>
				</p>
			</div>
			
			
			<div style="height:60px">
				<p class="p">
				<input class="input-field" type="password" id="password2" autocomplete="password" required>
				<label for="password2"><span>비밀번호 확인</span></label>
				<span class="password_msg"></span>
				</p>			
			</div>
			
			
		</div>
		
		<hr style="width: 600px">
		
		

		
		
			<!-- 레벨 선택 -->
			<!-- 클릭 시 색상 변경 -->
			
				<div align="center" style="font-size:20px">혼밥레벨설정</div>
				<div style="margin:10px 50px"class="btn-group btn-group-sm" aria-label="Basic checkbox toggle button group">
				<input type="radio" class="btn-check " name="honbabLevel" id="lv1" value="1" checked>
				<label class="btn btn-outline-danger" for="lv1">Lv.1</label>
				<input type="radio" class="btn-check" name="honbabLevel" id="lv2" value="2">
				<label class="btn btn-outline-danger" for="lv2">Lv.2</label>
				<input type="radio" class="btn-check" name="honbabLevel" id="lv3" value="3">
				<label class="btn btn-outline-danger" for="lv3">Lv.3</label>
				<input type="radio" class="btn-check" name="honbabLevel" id="lv4" value="4">
				<label class="btn btn-outline-danger" for="lv4">Lv.4</label>
				<input type="radio" class="btn-check" name="honbabLevel" id="lv5" value="5">
				<label class="btn btn-outline-danger" for="lv5">Lv.5</label>
				</div>
			
			<!-- 클릭 시 팝오버 설명 -->
				<div style="margin:0px 40px">
				<span class="d-inline-block" tabindex="0" data-bs-toggle="popover" data-bs-html="true" data-bs-trigger="hover focus" 
				data-bs-content="
					<h3>혼밥레벨이란?</h3>
					<h6>혼밥 레벨은 1부터 5까지 있습니다. 각 레벨 설명을 보고 선택해주세요.</h6>
					<p>Lv1 : 난 조금 소심하다... 혼자선 눈치보여서 편의점이나 패스트푸드점만 간다.</p>
					<p>Lv2 : 무시하지마라. 김밥천국이나 동네밥집정도는 혼자 갈 수 있다.</p>
					<p>Lv3 : 조금은 부끄럽지만 인스타 맛집가서 커플들 사이에서 먹을 수 있다.</p>
					<p>Lv4 : 밥 먹는데 혼자가는게 뭔 상관이냐??? 아웃백이나 고깃집도 혼자다닌다.</p>
					<p>Lv5 : 난 밥먹으러 밥집 안간다. 고기집이든 아웃백이든 중국집이든 무조건 혼술한다.</p>
					">
  				<button class="btn" type="button" disabled>혼밥레벨이란?</button>
				</span>
				</div>
		

		
		<!-- 프로필 이미지 -->
			
		<hr style="width: 600px">
		<div align="center" style="font-size:20px">프로필 사진 설정</div>
		<div align="center" id="image_container" >
				<img id="default_image" style="border-radius: 200px; width: 150px; height: 150px;"
					src="<c:url value='/profile/DEFAULT.png'/>"/>
		</div>
		
		<!-- <div align="center" class="filebox" style="padding:10px">
			<label for="profileImg">사진 등록</label>
			<input type="file" id="profileImg" name="profileImg" onchange="setThumbnail(event);"/>
			<button type="button" id="cancelImg" name="cancelImg" onchange="deleteThumbnail(event);">사진 삭제</button>
		</div> -->
		
		<!-- 이미지 파일만 등록되게 accept 확장지 지정 -->
		<div id="preview" align="center"></div>
		<div align="center" class="filebox" style="padding:10px">
			<label for="profileImg">사진 등록</label>
			<input type="file" id="profileImg" name="profileImg" class="inp-img" accept=".gif, .jpg, .png">
			<button type="button" id="cancelImg" name="cancelImg" class="btn-delete">사진 삭제</button>
		</div>


		
		<hr style="width: 600px">
		<!-- 회원 가입 -->
		<%-- <div id="msg" class="msg">${URLDecoder.decode(param.msg, "utf-8")}</div> --%>
		<div align="center" class="d-grid gap-2 col-6 mx-auto" style="padding:0px 0px 15px 0px">
		<button type="submit" id="joinBtn" name="joinBtn" class="btn btn-outline-danger" disabled="disabled">회원 가입하기</button>
		</div>
		</div>
	</form>
</div>
		
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
let user_email = 0;
let user_nick = 0;
let user_pass = 0;
let user_pass2 = 0;

function check(){
	console.log(user_email+user_nick+user_pass+user_pass2)
	if((user_email+user_nick+user_pass+user_pass2)==4) {	
		$("#joinBtn").attr("disabled",false)
	}
}




//닉네임 체크
$('#nickname').focusout(function(){
	$("#joinBtn").attr("disabled",true);
	var nickname = $('#nickname').val(); //id값이 "nickname"인 입력란의 값을 저장
        if (nickname != "" || nickname != null) {
	        $.ajax({
	            url:'/nickCheck', //Controller에서 인식할 주소
	            type:'POST', //POST 방식으로 전달
	            data:{nickname:nickname},
	            success:function(data){ //컨트롤러에서 넘어온 cnt 값을 받는다.
	                if (data != "사용가능한 닉네임입니다.") {
	                	$("#joinBtn").attr("disabled",true)
	                	user_nick = 0;
	                }
	                else{
		            	/* $("#joinBtn").attr("disabled",false) */
	                	user_nick = 1;
	                	check();
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
	                	user_email = 0;
	                }
	                else{
		            	/* $("#joinBtn").attr("disabled",false) */
	                	user_email = 1;
	                	check();
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
	          	user_pass = 0;
		    	user_pass2 = 0;
		    	$("#joinBtn").attr("disabled",true)
	      	}
	    } else if($('#password').val().length < 1) {
	    	$('.password_msg').text("비밀번호를 입력해주세요");
	    	user_pass = 0;
	    	user_pass2 = 0;
	    	$("#joinBtn").attr("disabled",true);
	    	
	    } else if($('#password').val().length < 6) {
	    	$('.password_msg').text("비밀번호는 6자리 이상이어야 합니다.");
	    	user_pass = 0;
	    	user_pass2 = 0;
	    	$("#joinBtn").attr("disabled",true)	
	    	
	    	
	    } else if($('#password').val() == $('#password2').val()) {
	    	$('.password_msg').text("비밀번호가 일치합니다.");
	    	user_pass = 1;
	    	user_pass2 = 1;
	    	check();
	    } 
	   
	})  	   
});   

//혼밥레벨이란? 팝오버 
var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
  return new bootstrap.Popover(popoverTriggerEl)
});


//등록 이미지 등록 미리보기
function readInputFile(input) {
    if(input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#preview').html("<img src="+ e.target.result +" style='border-radius: 200px; width: 150px; height: 150px;'>");
        }
        reader.readAsDataURL(input.files[0]);
        document.getElementById("default_image").style.display="none";
    }
}
 
$(".inp-img").on('change', function(){
    readInputFile(this);
});
 
 
// 등록 이미지 삭제 ( input file reset )
function resetInputFile($input, $preview) {
    var agent = navigator.userAgent.toLowerCase();
    if((navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1)) {
        // ie 일때
        $input.replaceWith($input.clone(true));
        $preview.empty();
    } else {
        //other
        $input.val("");
        $preview.empty();
    }       
}
$(".btn-delete").click(function(event) {
    var $input = $(".inp-img");
    var $preview = $('#preview');
    resetInputFile($input, $preview);
    document.getElementById("default_image").style.display="block";
    
});




/* 
//프로필 사진 미리보기(사진 등록)
function setThumbnail(event){
	var reader = new FileReader();
	
	reader.onload = function(event){
		var img = document.createElement("img");
		img.setAttribute("src", event.target.result);
		img.setAttribute("style", "border-radius: 200px; width: 150px; height: 150px;");
		document.querySelector("div#image_container").appendChild(img);
	};
	reader.readAsDataURL(event.target.files[0]);
	document.getElementById("default_image").style.display="none";
}; 

//프로필 사진 등록 삭제
function deleteThumbnail(event) {
	$('#profileImg').removeAttr('file')
}
 */

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
