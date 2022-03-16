<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
<title>반찬공유 게시판 수정페이지</title>
<script type="text/javascript">
	function modifyboard(){
		modifyform.submit();
	}
	</script>
		
<style type="text/css">
h5 {
	/* text-align: center; */
	font-size: 30px;
	margin-left: 0%
}

#commandCell {
	text-align: center;
}

/* @@@@@@  ck에디터   @@@@@@@ */
.ck-editor__editable {
	min-height: 550px;

	max-width: 100%;
}

</style>
</head>
<body>
<!-- 게시판 수정 -->

<section id="./writeForm">

	<div >
		<div class="container pb-3 bg-light" class="outer" >
			<div class="p-2 border-rounded d-flex justify-content-between">
				<h5 class="fw-bolder float-start" >반찬공유 글수정</h5>
				<c:if test="${user.grp eq 1 }">
			    <div class="btn-group-sort float-end" style="width: fit-content; display: inline-block; float: right;">
					<button type="button"
						class="btn btn-secondary dropdown-toggle" id="sortDropdownSub"
						data-bs-toggle="dropdown" aria-expanded="false">${not empty shboard.subway? shboard.subway:null  }</button>
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
				</c:if>
			</div>

			<form action="./modifyform" method="post" enctype="multipart/form-data" name="modifyform" >
				<input type="hidden" name="subway" id="subway" value='${shboard.subway}'>
				<div>
					<input type="hidden" id="articleNo" name ="articleNo" value="${shboard.articleNo}">
					<div class="container p-2 ">
						<div class="row p-1 text-center">
							<div class="col">
								<input name="title" id="title" style="display: inline-block;width:100%;" value='${shboard.title}' placeholder="제목을 입력해주세요!" required="required">
									<!-- ckEditor -->	
									<textarea id="editor" name="content" placeholder="내용을 입력해주세요!" >${shboard.content}</textarea>
							</div>
						</div>
					</div>

					<div class="row py-3">
						<div class="col text-center">
							<!-- <input type="reset" value="다시쓰기" /> -->
							<section id = "commandCell">
							<a class="btn border bd-secondary" href="javascript:history.go(-1)">취소</a>
							<a class="btn border bd-secondary" href="javascript:modifyboard()">수정</a>
							</section>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	</section>
<script>
/* function headerChange(arg) {
	document.getElementById('headerTag').value=arg; 
	if(arg == 0) {
		document.getElementById('sortDropdown').innerText='공유중';
	} else if (arg == 1) {
		document.getElementById('sortDropdown').innerText='공유완료';
	}	
} */
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
</script>
</body>
</html>