<%@ page language="java" contentType="text/html; charset=UTF-8"%>

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
        			uploadUrl : "/comm/upload"
        		}
        	}).then(editor=> {
        		window.editor=editor;
        	})
        	.catch((error) => {
        		console.error(error);
        	});
	});
</script>

<title>커뮤니티</title>

<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
	
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
	<!-- 게시판 등록 -->

<section id="./writeForm">

	<div >
		<div class="container pb-3 bg-light" class="outer" >
			<h5 class="fw-bolder" >커뮤니티</h5>

			<form action="./boardwrite" method="post" enctype="multipart/form-data" name="boardform" >
				<div>
					<input type="hidden" id="idx" name="idx" value=${user.idx }>
					<div class="container p-2 ">
						<div class="row p-1 text-center ">
							<div class="col">
								<input name="title" id="title" style="display: inline-block;width:100%;" value='${title }' placeholder="제목을 입력해주세요!" required="required">
									<!-- ckEditor -->	
									<textarea id="editor" name="content" placeholder="내용을 입력해주세요!"></textarea>
							</div>
						</div>
					</div>

					<div class="row py-3">
						<div class="col text-center">
							<!-- <input type="reset" value="다시쓰기" /> -->
							<button class="btn border bd-secondary">취소</button>
							<input type="submit" class="btn border bd-secondary" value="전송" />
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	</section>



	

	<!-- 게시판 등록 -->
	<script>
	$('#file').change(function(){
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
	});
	
	</script>
	<script>
		$('#prForm').submit(function(){
			console.log("ENTERED TO SUBMITTING");
			var formData = new FormData();
			var data = {
		        "id":$('#id').val(),
		        "user_PK":$('#user_PK').val(),
		        "reviewContent":$('#reviewContent').val(),
		        "rejectedCount":($('input[name="rejectedCount"]:checked').val() != null)? $('input[name="rejectedCount"]:checked').val() : "false",
		        "honbabReason":$('#honbabReason').val(),
		        "honbabLv":$('input[name="honbabLv"]:checked').val(),
		        "interiorRate":$('input[name="interiorRate"]:checked').val(),
		        "serviceRate":$('input[name="serviceRate"]:checked').val(),
		        "priceRate":$('input[name="priceRate"]:checked').val(),
		        "tasteRate":$('input[name="tasteRate"]:checked').val(),
		        
		    };

		    formData.append("file",$('#file')[0].files[0]);
		    formData.append("key", new Blob([JSON.stringify(data)], {type:"application/json"}));
			
			$.ajax({
				url:"../writeReview",
				type:"post",
				enctype: 'multipart/form-data',		
				processData: false, 
				contentType: false,
				data: formData,
				cache: false,           
		        timeout: 600000,  
				success:function(data, textStatus) {
					
					alert(data);
					//location.window.href="/search";		
				},
				error: function(data, textStatus){
					alert(data);
					//return false;
				}
			});
			
			return false; 
		});
	</script>
</body>
</html>