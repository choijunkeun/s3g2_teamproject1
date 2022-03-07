<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 목업 코드, 아래 영역을 주석처리하면 로그아웃 처리된 것으로 짜볼 수 있음 -->
<%@ page import="com.ilinbun.mulcam.dto.User"%>
<%!User user = new User(1, "mockup@mock.up", "목업", "", "#", 5, 1);%>
<c:set var="user" value='<%=user%>' />
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
<script
	src="https://cdn.ckeditor.com/ckeditor5/29.1.0/classic/ckeditor.js"></script>
<title>게시글 작성</title>
<!-- <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"> -->
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
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

<script>
	class UploadAdapter {
	    constructor(loader) {
	        this.loader = loader;
	    }
	
	    upload() {
	        return this.loader.file.then( file => new Promise(((resolve, reject) => {
	            this._initRequest();
	            this._initListeners( resolve, reject, file );
	            this._sendRequest( file );
	        })))
	    }
	
	    _initRequest() {
	        const xhr = this.xhr = new XMLHttpRequest();
	        xhr.open('POST', './images/upload', true);
	        xhr.responseType = 'json';
	    }
	
	    _initListeners(resolve, reject, file) {
	        const xhr = this.xhr;
	        const loader = this.loader;
	        const genericErrorText = '파일을 업로드 할 수 없습니다.'
	
	        xhr.addEventListener('error', () => {reject(genericErrorText)})
	        xhr.addEventListener('abort', () => reject())
	        xhr.addEventListener('load', () => {
	            const response = xhr.response
	            if(!response || response.error) {
	                return reject( response && response.error ? response.error.message : genericErrorText );
	            }
	
	            resolve({
	                default: response.url //업로드된 파일 주소
	            })
	        })
	    }
	
	    _sendRequest(file) {
	        const data = new FormData()
	        data.append('upload',file)
	        this.xhr.send(data)
	    }
	}
	function ImageAdapterPlugin(editor) {
	    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
	        return new UploadAdapter(loader)
	    }
	}
</script>
</head>
<body>
	<section id="./writeForm">
		<!--  ./는 localhost:8090/brag임 -->
		<div class="container pb-3 bg-light" class="outer">
			<h5 class="fw-bolder text-center m-3">혼밥자랑</h5>
			
			<div class="row d-flex my-2" style="flex-wrap: nowrap;">
				<input type="hidden" name="moonpa" id="moonpa">
				<div class="btn-group-sort" style="width: fit-content;">
					<button type="button" class="btn btn-secondary dropdown-toggle" 
						id="sortDropdown" data-bs-toggle="dropdown" aria-expanded="false">문파선택</button>
					<ul class="dropdown-menu text-center" aria-labelledby="sortDropdown">
						<li><button class="dropdown-item" type="button"
								onclick="document.getElementById('moonpa').value='true'; document.getElementById('sortDropdown').innerText='사먹파'">사먹파</button></li>
						<li><button class="dropdown-item" type="button"
								onclick="document.getElementById('moonpa').value='false'; document.getElementById('sortDropdown').innerText='해먹파'">해먹파</button></li>
					</ul>
				</div>
				<div class="input-group" style="flex-shrink: 1; width: 50%;">
					<input type="text" class="form-control" id="location" 
						placeholder="위치를 검색해 보세요!" aria-label="위치">
					<!-- 검색하기 버튼 아니고, 위치 DB에 있으면 자동으로 뜨고 그걸 선택하면 들어가게  -->
				</div>
			</div>
	
			<div class="row m-1">
				<input type="text" class="form-control" id="title" name="brag_name" required="required"
					style="width: 50%; height: 100%;" placeholder="제목을 입력해주세요!">
			</div>
			
			<section class="row m-1">
				<div id="editor" style="max-width:100%; width:100%;"></div>
				<script>
				    ClassicEditor
				        .create(document.querySelector("#editor"),
				            {
				                /* language: "ko",
				                simpleUpload:
				                {
				                    uploadUrl: "/images/upload",
				                    withCredentials: true,
				                } */
				        		extraPlugins: [ImageAdapterPlugin]
				            })
				        .then(newEditor => {
				            editor = newEditor;
				        })
				        .catch(error => {
				            console.error(error);
				        });
				</script>
			</section>

			<div class="row py-3">
				<div class="col text-center">
					<button class="btn border bd-secondary">취소</button>
					<input type="submit" class="btn border bd-secondary" value="등록" />
				</div>
			</div>
		</div>
	</section>

	<!-- 
<script>
    function dp_menu(){
        let click = document.getElementById("drop-content");
        if(click.style.display === "none"){
            click.style.display = "block";

        }else{
            click.style.display = "none";

        }
    }
</script> -->


	<!-- ckEditor -->
	<!-- <script>
        ClassicEditor
            .create( document.querySelector( '#classic' ))
            .catch( error => {
                console.error( error );
            } );
    </script> -->

	<script>
	/* $('#file').change(function(){
		//here we take the file extension and set an array of valid extensions
	    var res=$('#file').val();
	    var arr = res.split("\\");
	    var filename=arr.slice(-1)[0];
	    filextension=filename.split(".");
	    filext="."+filextension.slice(-1)[0];
	    valid=[".jpg",".png",".jpeg",".bmp"];
		//if file is not valid we show the error icon, the red alert, and hide the submit button
	    if (valid.indexOf(filext.toLowerCase())==-1){
	        $( ".imgupload" ).hide("slow");
	        $( ".imgupload.ok" ).hide("slow");
	        $( ".imgupload.stop" ).show("slow");
	      
	        $('#namefile').css({"color":"gray","font-weight":700});
	        $('#namefile').html(filename+" 파일은 사진이 아닌 것 같습니다.");
	        
	    } else{
	        //if file is valid we show the green alert and show the valid submit
	        $( ".imgupload" ).hide("slow");
	        $( ".imgupload.stop" ).hide("slow");
	        $( ".imgupload.ok" ).show("slow");
	      
	        $('#namefile').css({"color":"#ff3f3f","font-weight":700});
	        $('#namefile').html(" 업로드한 파일 : " + filename);
	      
	    }
	}); */

		/* $('#bwForm').submit(function(e){
			e.preventDefault();
			console.log("ENTERED TO SUBMITTING");
			console.log($('#fileup')[0]);
			var formData = new FormData();
			var data = {
		        "email":$('#email').val(),
		        "moonpa":$('#moonpa').val(),
		        "location":$('#location').val(),
		        "title":$('#title').val(),
		        "content":$('#content').val(),
		    };

		    formData.append("file",$('#fileup')[0].files[0]);
		    formData.append("key", new Blob([JSON.stringify(data)], {type:"application/json"}));
			
			$.ajax({
				url:"./bragwrite",
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
		}); */
	</script>
</body>
