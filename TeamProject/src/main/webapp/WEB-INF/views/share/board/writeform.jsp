<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 목업 코드, 아래 영역을 주석처리하면 로그아웃 처리된 것으로 짜볼 수 있음 -->
<%@ page import="com.ilinbun.mulcam.dto.User"%> 
<%!User user = new User(1, "mockup@mock.up", "목업", "", "#", 5, 1);%>
<c:set var="user" value="<%=user%>" />
<!-- 목업 코드 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- ckEditor -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, viewport-fit=cover">
<!-- 클래식 에디터 -->
<script	src="https://cdn.ckeditor.com/ckeditor5/32.0.0/classic/ckeditor.js"></script>
<script>
	$(function(){
        ClassicEditor
        	.create(document.querySelector("#editor"), {
        		ckfinder : {
        			uploadUrl : "/share/upload"
        		}
        	}).then(editor=> {
        		window.editor=editor;
        	})
        	.catch((error) => {
        		console.error(error);
        	});
	});
</script>

<title>Share Write Form</title>
<script type="text/javascript"	src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- ckEditor 넓이 높이 조절 -->
<style>
.ck.ck-editor {
	max-width: 100%;
	font-weight: bolder;
}

.ck-editor__editable {
	min-height: 300px;
}
</style>

<style>
#top {
	margin-top: 20px;
}

.btn-container {
	background: #fff;
	border-radius: 5px;
	padding-bottom: 20px;
	margin-bottom: 20px;
}

.white {
	color: white;
}

.imgupload {
	color: #1e2832;
	padding-top: 40px;
	font-size: 7em;
}

#namefile {
	color: black;
}

h4>strong {
	color: #ff3f3f;
}

.btn-primary {
	border-color: #ff3f3f !important;
	color: #ffffff;
	text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
	background-color: #ff3f3f !important;
	border-color: #ff3f3f !important;
}

/*these two are set to not display at start*/
.imgupload.ok {
	display: none;
	color: green;
}

.imgupload.stop {
	display: none;
	color: red;
}

/*this sets the actual file input to overlay our button*/
#fileup {
	opacity: 0;
	-moz-opacity: 0;
	filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0);
	width: 200px;
	cursor: pointer;
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
	bottom: 40px;
	height: 50px;
}

/*switch between input and not active input*/
#submitbtn {
	padding: 5px 50px;
	display: none;
}

#fakebtn {
	padding: 5px 40px;
}

/*www.emilianocostanzo.com*/
#sign {
	color: #1e2832;
	position: fixed;
	right: 10px;
	bottom: 10px;
	text-shadow: 0px 0px 0px #1e2832;
	transition: all.3s;
}

#sign:hover {
	color: #1e2832;
	text-shadow: 0px 0px 5px #1e2832;
}
</style>
<style>
input.star {
	display: none;
}

label.star {
	float: right;
	padding: 5px;
	font-size: 20px;
	color: #444;
	/* transition: all .2s; */
}

input.star:checked ~ label.star:before {
	content: '\f005';
	color: #FD4;
	/* transition: all .25s; */
}

/* input.star-5:checked ~ label.star:before {
			color: #FE7;
			text-shadow: 0 0 20px #952;
		}
		
		input.star-1:checked ~ label.star:before {
			color: #F62;
		}
		
		label.star:hover {
			transform: rotate(-15deg) scale(1.3);
		} */
label.star:before {
	content: '\f006';
	font-family: FontAwesome;
}
.outer {
  text-align: center;
}
</style>
</head>
<body>
<section id="./writeform"> 
    <div class="container pb-3 bg-light" class="outer"> 
        <h2 class="fw-bolder" style="text-align:center;">
			<strong>반찬공유 글쓰기</strong>
		</h2>
			<form action="./sharewrite" method="post" enctype="multipart/form-data" name="shareform" id="shform"> 
			<input type="hidden" id="idx" name="idx" value=${user.idx }>
				<div class="container p-2"> 
                    <div class="row p-1 text-center">
						<div class="col">
							<input type="hidden" name="noticewrtie" id="ntwrite">
							<div class="btn-group-sort" style="width: fit-content;">
								<button type="button"
									class="btn btn-secondary dropdown-toggle" id="sortDropdown"
									data-bs-toggle="dropdown" aria-expanded="false">공지글쓰기</button>
								<ul class="dropdown-menu text-center" aria-labelledby="sortDropdown">
									<li><button class="dropdown-item" type="button"
										onclick="noticeChange('true')">공지글쓰기</button></li>
									<li><button class="dropdown-item" type="button"
										onclick="noticeChange('false')">일반글쓰기</button></li>
								</ul>
							</div> <br>
						    <input type="hidden" name="subway" id="subway">
						    <div class="btn-group-sort" style="width: fit-content;">
								<button type="button"
									class="btn btn-secondary dropdown-toggle" id="sortDropdownSub"
									data-bs-toggle="dropdown" aria-expanded="">위치를 골라주세요</button>
								<ul class="dropdown-menu text-center" aria-labelledby="sortDropdown">
									<li><button class="dropdown-item" type="button"
										onclick="subwayChange('0')">용산역</button></li>
									<li><button class="dropdown-item" type="button"
										onclick="subwayChange('1')">신용산역</button></li>
									<li><button class="dropdown-item" type="button"
										onclick="subwayChange('2')">이촌역</button></li>
									<li><button class="dropdown-item" type="button"
										onclick="subwayChange('3')">서빙고역</button></li>
									<li><button class="dropdown-item" type="button"
										onclick="subwayChange('4')">한남역</button></li>
									<li><button class="dropdown-item" type="button"
										onclick="subwayChange('5')">한강진역</button></li>
									<li><button class="dropdown-item" type="button"
										onclick="subwayChange('6')">이태원역</button></li>
									<li><button class="dropdown-item" type="button"
										onclick="subwayChange('7')">녹사평역</button></li>
									<li><button class="dropdown-item" type="button"
										onclick="subwayChange('8')">삼각지역</button></li>
									<li><button class="dropdown-item" type="button"
										onclick="subwayChange('9')">숙대입구역</button></li>
									<li><button class="dropdown-item" type="button"
										onclick="subwayChange('10')">남영역</button></li>
									<li><button class="dropdown-item" type="button"
										onclick="subwayChange('11')">효창공원앞역</button></li>
									<li><button class="dropdown-item" type="button"
										onclick="subwayChange('')">지역을 골라주세요!</button></li>
								</ul>
							</div> <br>
							<!-- ckEditor -->
							<div>
							<input name="title" id="title" size="100%" value='${title }' placeholder="제목을 입력해주세요!" required="required">
							</div>
							<div class="row p-1 text-center">
                                <textarea id="editor" name="content" placeholder="내용을 입력해주세요!"></textarea>
								<span></span>
								    <div id="classic">
										<br><p>반찬공유 게시판은 거래가 아닌 공유 목적의 게시판임을 알려드립니다.</p>
									</div>
                            </div>
					    </div>
				    </div>
				</div>
		</div>
		<div class="row py-3">
			<div class="col text-center">
				<!-- <input type="reset" value="다시쓰기" /> -->
				<button class="btn border bd-secondary" onclick="cancleboard()">취소</button>
				<input type="submit" class="btn border bd-secondary" value="등록" onclick="registerboard()" />
			</div>
         </div>
			</form>
    </div>
</section>
	<script>
		function noticeChange(arg) {
			document.getElementById('ntwrite').value=arg; 
			
			if(arg == 'true')
				document.getElementById('sortDropdown').innerText='공지글쓰기';
			else
				document.getElementById('sortDropdown').innerText='일반글쓰기';
		}
		
		function subwayChange(sub) {
			document.getElementById('subway').value=sub;
			if(sub == '0') {
				document.getElementById('sortDropdownSub').innerText='용산역';
			} else if(sub == '1') {
				document.getElementById('sortDropdownSub').innerText='신용산역';
			} else if(sub == '2') {
				document.getElementById('sortDropdownSub').innerText='이촌역';
			} else if(sub == '3') {
				document.getElementById('sortDropdownSub').innerText='서빙고역';
			} else if(sub == '4') {
				document.getElementById('sortDropdownSub').innerText='한남역';
			} else if(sub == '5') {
				document.getElementById('sortDropdownSub').innerText='한강진역';
			} else if(sub == '6') {
				document.getElementById('sortDropdownSub').innerText='이태원역';
			} else if(sub == '7') {
				document.getElementById('sortDropdownSub').innerText='녹사평역';
			} else if(sub == '8') {
				document.getElementById('sortDropdownSub').innerText='삼각지역';
			} else if(sub == '9') {
				document.getElementById('sortDropdownSub').innerText='숙대입구역';
			} else if(sub == '10') {
				document.getElementById('sortDropdownSub').innerText='남영역';
			} else if(sub == '11') {
				document.getElementById('sortDropdownSub').innerText='효창공원앞역';
			} else {
				document.getElementById('sortDropdownSub').innerText='지역을 골라주세요!';
			}
		}
		
    	function registerboard() {
    		 alert("반찬 및 식재료를 공유 시 발생되는 법적인 문제는 개인에게 달려있습니다. 개발진들은 이를 책임지지 않습니다.")
        	 alert("게시글이 작성되었습니다")
    	}
    	
   	 	function cancleboard() {
   	 		if(confirm('게시글 작성을 취소하시겠습니까?')) {
   	 			console.log('delete info')
   	 		} else {
   	 			console.log('go back to writeform')
   	 		}
   	 	}	
 
    </script>
</body>
</html>