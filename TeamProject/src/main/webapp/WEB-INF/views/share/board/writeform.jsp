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
<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
<!-- 클래식 에디터 -->
<script src="https://cdn.ckeditor.com/ckeditor5/29.1.0/classic/ckeditor.js"></script>
<title>Share Write Form</title>
<script type="text/javascript"	src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- ckEditor 넓이 높이 조절 -->
<style>
.ck.ck-editor {
	max-width: 500px;
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
		<h5 class="fw-bolder" style="margin-left:23%;">
			<strong>반찬공유 글쓰기</strong>
		</h5>
			<form action="./sharewrite" method="post" enctype="multipart/form-data" name="shareform" id="shform">
				<div class="container p-2">
					<div class="row p-1 text-center">
						<div class="col">
								<input type="hidden" name="noticewrtie" id="ntwrite">
									<div class="btn-group-sort" style="width: fit-content;">
										<button type="button"
											class="btn btn-secondary dropdown-toggle" id="sortDropdown"
											data-bs-toggle="dropdown" aria-expanded="false">공지글쓰기</button>
										<ul class="dropdown-menu text-center" aria-labelledby="sortDropdown">
											<li><button class="dropdown-item" type="button">공지글쓰기</button></li>
											<li><button class="dropdown-item" type="button">일반글쓰기</button></li>
										</ul>
									</div>
									
		<label for="location-subway">어디서 공유를 받고 싶으신가요?</label> <br>
            <select name="location" id="location-subway">
                <option value="">지역을 골라주세요!</option>
                <option value="용산역">용산역</option>
                <option value="효창공원역">효창공원역</option>
                <option value="남영역">남영역</option>
                <option value="삼각지역">삼각지역</option>
                <option value="숙대입구역">숙대입구역</option>
                <option value="이촌역">이촌역</option>
                <option value="서빙고역">서빙고역</option>
                <option value="한남역">한남역</option>
                <option value="한강진역">한강진역</option>
                <option value="이태원역">이태원역</option>
                <option value="녹사평역">녹사평역</option>
            </select>
            <div>
									<!-- ckEditor -->
									<h3>Classic editor</h3>
									<div id="classic">
										<p>This is some sample content.</p>
									</div>
								</div>

							</div>
						</div>
					</div>

					<div class="row py-3">
						<div class="col text-center">
							<!-- <input type="reset" value="다시쓰기" /> -->
							<button class="btn border bd-secondary">취소</button>
							<input type="submit" class="btn border bd-secondary" value="등록" />
						</div>
					</div>


				</div>
						</div>
					</div>
				</div>
			</form>
	</div>
</section>
	<!-- ckEditor -->
	<script>
        ClassicEditor
            .create( document.querySelector( '#classic' ))
            .catch( error => {
                console.error( error );
            } );
    </script>
  
        <script>
            $('#fileup').change(function () {
                //here we take the file extension and set an array of valid extensions
                var res = $('#fileup').val()
                var arr = res.split('\\')
                var filename = arr.slice(-1)[0]
                filextension = filename.split('.')
                filext = '.' + filextension.slice(-1)[0]
                valid = ['.jpg', '.png', '.jpeg', '.bmp']
                //if file is not valid we show the error icon, the red alert, and hide the submit button
                if (valid.indexOf(filext.toLowerCase()) == -1) {
                    $('.imgupload').hide('slow')
                    $('.imgupload.ok').hide('slow')
                    $('.imgupload.stop').show('slow')

                    $('#namefile').css({ color: 'red', 'font-weight': 700 })
                    $('#namefile').html('File ' + filename + ' is not  pic!')

                    $('#submitbtn').hide()
                    $('#fakebtn').show()
                } else {
                    //if file is valid we show the green alert and show the valid submit
                    $('.imgupload').hide('slow')
                    $('.imgupload.stop').hide('slow')
                    $('.imgupload.ok').show('slow')

                    $('#namefile').css({ color: 'green', 'font-weight': 700 })
                    $('#namefile').html(filename)

                    $('#submitbtn').show()
                    $('#fakebtn').hide()
                }
            })
            
            $('#shForm').submit(function(e){
			e.preventDefault();
			console.log("ENTERED TO SUBMITTING");
			console.log($('#fileup')[0]);
			var formData = new FormData();
			var data = {
		        "email":$('#email').val(),
		        "location":$('#location').val(),
		        "title":$('#title').val(),
		        "content":$('#content').val(),
		    };

		    formData.append("file",$('#fileup')[0].files[0]);
		    formData.append("key", new Blob([JSON.stringify(data)], {type:"application/json"}));
			
			$.ajax({
				url:"./sharewrite",
				type:"post",
				enctype: 'multipart/form-data',		
				processData: false, 
				contentType: false,
				data: formData,
				cache: false,           
		        timeout: 600000,  
				success:function(data, textStatus) {
					
					alert(data);
					return false;
					//location.window.href="/search";		
				},
				error: function(data, textStatus){
					alert(data);
					return false;
				}
			});
			
			return false; 
		});

        $('registerboard').onClick(function() {
            alert("반찬 및 식재료를 공유 시 발생되는 법적인 문제는 개인에게 달려있습니다. 개발진들은 이를 책임지지 않습니다.")
            alert("게시글이 작성되었습니다")
        })
        $('cancelboard').onClick(function() {
            if (confirm('게시글 작성을 취소하시겠습니까?')) {
                console.log('delete info')
            } else {
                console.log('go back to writeform')
            }
        })
        </script>
</body>
</html>