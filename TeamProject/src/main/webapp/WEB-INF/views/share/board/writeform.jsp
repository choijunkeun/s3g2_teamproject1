<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <!-- 목업 코드, 아래 영역을 주석처리하면 로그아웃 처리된 것으로 짜볼 수 있음 -->
<%@ page import="com.ilinbun.mulcam.dto.User"%> 
<%!User user = new User(1, "mockup@mock.up", "목업", "", "#", 5, 1);%>
<c:set var="user" value="<%=user%>" /> --%>
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
//        		window.editor=editor;
        		editor.setData('${content}');
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
	
}

.ck-editor__editable {
	max-width: 100%;
	font-weight: bolder;
	min-height: 350px;
}
</style>

<style>
.writeform {
	margin : 20px;
	float: center;
}

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
</head>
<body>
<section id="./writeform"> 
    <div class="container pb-3 bg-light" class="outer"> 
        <h2 class="fw-bolder" style="text-align:center;"><strong>반찬공유 글쓰기</strong></h2>
		<form action="./sharewrite" method="post" enctype="multipart/form-data" name="shareform" id="shform"> 
			<div>
			<input type="hidden" id="idx" name="idx" value=${user.idx }>
			<div class="container"> 
				<div class="row p-1 text-center">
					<div class="col">
						<input type="hidden" name="headerTag" id="headerTag">
						<div class="btn-group-sort" style="width: fit-content; display: inline-block; float: left">
							<button type="button"
								class="btn btn-secondary dropdown-toggle" id="sortDropdown"
								data-bs-toggle="dropdown" aria-expanded="false">말머리 선택</button>
							<ul class="dropdown-menu text-center" aria-labelledby="sortDropdown">
								<li><button class="dropdown-item" type="button"
									onclick="headerChange(0)">공유중</button></li>
								<li><button class="dropdown-item" type="button"
									onclick="headerChange(1)">공유완료</button></li>
							</ul>
						</div> <br>
						<input type="hidden" name="subway" id="subway">
					    <div class="btn-group-sort" style="width: fit-content; display: inline-block; float: right;">
							<button type="button"
								class="btn btn-secondary dropdown-toggle" id="sortDropdownSub"
								data-bs-toggle="dropdown" aria-expanded="false">위치를 골라주세요</button>
							<ul class="dropdown-menu text-center" aria-labelledby="sortDropdown">
								<li><button class="dropdown-item" type="button" name="용산역" value='${subway }'
									onclick="subwayChange('용산역')">용산역</button></li>
								<li><button class="dropdown-item" type="button" name="신용산역" value='${subway }'
									onclick="subwayChange('신용산역')">신용산역</button></li>
								<li><button class="dropdown-item" type="button" name="이촌역" value='${subway }'
									onclick="subwayChange('이촌역')">이촌역</button></li>
								<li><button class="dropdown-item" type="button" name="서빙고역" value='${subway }'
									onclick="subwayChange('서빙고역')">서빙고역</button></li>
								<li><button class="dropdown-item" type="button" name="한남역" value='${subway }'
									onclick="subwayChange('한남역')">한남역</button></li>
								<li><button class="dropdown-item" type="button" name="한강진역" value='${subway }'
									onclick="subwayChange('한강진역')">한강진역</button></li>
								<li><button class="dropdown-item" type="button" name="이태원역" value='${subway }'
									onclick="subwayChange('이태원역')">이태원역</button></li>
								<li><button class="dropdown-item" type="button" name="녹사평역" value='${subway }'
									onclick="subwayChange('녹사평역')">녹사평역</button></li>
								<li><button class="dropdown-item" type="button" name="삼각지역" value='${subway }'
									onclick="subwayChange('삼각지역')">삼각지역</button></li>
								<li><button class="dropdown-item" type="button" name="숙대입구역" value='${subway }'
									onclick="subwayChange('숙대입구역')">숙대입구역</button></li>
								<li><button class="dropdown-item" type="button" name="남영역" value='${subway }'
									onclick="subwayChange('남영역')">남영역</button></li>
								<li><button class="dropdown-item" type="button" name="효창공원앞역" value='${subway }'
									onclick="subwayChange('효창공원앞역')">효창공원앞역</button></li>
								<li><button class="dropdown-item" type="button" name="null" value='${subway }'
									onclick="subwayChange('')">지역을 골라주세요!</button></li>
							</ul>
							
						</div> 
						
							<!-- ckEditor -->
						<div class="writeform">
							<input name="title" id="title" style="display: inline-block; width: 100%;" value='${title }' placeholder="제목을 입력해주세요!" required="required">
							<textarea id="editor" name="content" placeholder="내용을 입력해주세요!"></textarea>
							<span></span>
						    <div id="classic">
								<br><p>공유할 식품을 사진으로 보여주세요!</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row py-3">
				<div class="col text-center">
					<!-- <input type="reset" value="다시쓰기" /> -->
					<button class="btn border bd-secondary" onclick="cancleboard()">취소</button>
					<input type="submit" name="writepost" class="btn border bd-secondary" value="등록" onclick="registerboard()" />
				</div>
	         </div>
	         </div>
		</form>
		
    </div>
</section>
	<script>
		function headerChange(arg) {
			document.getElementById('headerTag').value=arg; 
			
			if(arg == 0)
				document.getElementById('sortDropdown').innerText='공유중';
			else if (arg == 1)
				document.getElementById('sortDropdown').innerText='공유완료';
		}
		
		function subwayChange(sub) {
			document.getElementById('subway').value=sub;
			if(sub == '용산역') {
				document.getElementById('sortDropdownSub').innerText='용산역';
			} else if(sub == '신용산역') {
				document.getElementById('sortDropdownSub').innerText='신용산역';
			} else if(sub == '이촌역') {
				document.getElementById('sortDropdownSub').innerText='이촌역';
			} else if(sub == '서빙고역') {
				document.getElementById('sortDropdownSub').innerText='서빙고역';
			} else if(sub == '한남역') {
				document.getElementById('sortDropdownSub').innerText='한남역';
			} else if(sub == '한강진역') {
				document.getElementById('sortDropdownSub').innerText='한강진역';
			} else if(sub == '이태원역') {
				document.getElementById('sortDropdownSub').innerText='이태원역';
			} else if(sub == '녹사평역') {
				document.getElementById('sortDropdownSub').innerText='녹사평역';
			} else if(sub == '삼각지역') {
				document.getElementById('sortDropdownSub').innerText='삼각지역';
			} else if(sub == '숙대입구역') {
				document.getElementById('sortDropdownSub').innerText='숙대입구역';
			} else if(sub == '남영역') {
				document.getElementById('sortDropdownSub').innerText='남영역';
			} else if(sub == '효창공원앞역') {
				document.getElementById('sortDropdownSub').innerText='효창공원앞역';
			} else {
				document.getElementById('sortDropdownSub').innerText='지역을 골라주세요!';
			}
		}
		
    	function registerboard() {
    		 alert("반찬 및 식재료를 공유 시 발생되는 법적인 문제는 개인에게 달려있습니다. 개발진들은 이를 책임지지 않습니다.")
    		 
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