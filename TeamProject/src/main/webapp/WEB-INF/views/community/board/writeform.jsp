<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MVC 게시판</title>
<style type="text/css">
h2 {
	text-align: center;
}

#commandCell {
	text-align: center;
}
</style>

</head>
<body>
	<!-- 게시판 등록 -->

	<section id="./writeForm">
		<h2>커뮤니티 글쓰기</h2>
		<form action="./boardwrite" method="post"
			enctype="multipart/form-data" name="boardform">
			<div class="container pb-3 bg-light">
				<form>
					<div class="container p-2 ">
						<div class="row p-1 text-center ">
							<div class="col">
								<!-- https://codepen.io/jexordexan/pen/yyYEJa -->
								<table style="width: fit-content; margin: 0 auto;">
									<tr>
										<td colspan="2"></td>
										<td colspan="2">
											<div class="col">
												<input type="text" name="honbabReason" id="honbabReason"
													style="width: 100%;" placeholder="제목을 써주세요">
											</div>
										</td>
									</tr>
									<tr rowspan="2">
										<td colspan="2">

											<div class="col">
												<!-- https://codepen.io/emiemi/pen/zxNXWR -->
												<div
													class="card border rounded text-center justify-content-center">
													<!-- <input type="file" name="revImgFile" style="width: 100%;" placeholder="사진을 이 곳에 업로드 해주세요"> -->
													<div class="btn-container">
														<!--the three icons: default, ok file (img), error file (not an img)-->
														<h1 class="imgupload"><i class="fa fa-file-image-o"></i></h1>
														<h1 class="imgupload ok"><i class="fa fa-check"></i></h1>
														<h1 class="imgupload stop"><i class="fa fa-times"></i></h1>
														<!--this field changes dinamically displaying the filename we are trying to upload-->
														<p id="namefile">사진만 올려주세요!(jpg,jpeg,bmp,png)</p>
														<!--our custom btn which which stays under the actual one-->
														<!-- 내장버튼인가 <button type="button" id="btnup" class="btn btn-primary">파일 선택2</button> -->
														<button type="button" id="btnup" class="btn btn-primary btn-lg">파일 선택</button>
														<input type="file" value="" name="file" id="file">
													</div>
												</div>
											</div>
										</td> &nbsp;
										<td colspan="2">
											<div class="col">
												<textarea name="reviewContent"
													style="width: 265px; height: 260px;"
													placeholder="사진에 대해 설명해 주세요"></textarea>
											</div>
										</td>
									</tr>
								</table>
							</div>
						</div>
					</div>

					<div class="row py-3">
						<div class="col text-center">
							<section id="commandCell">
								<button class="btn border bd-secondary">취소</button>
								<input type="submit" class="btn border bd-secondary" value="등록" />
							</section>
						</div>
					</div>

				</form>


			</div>
			</table>

		</form>
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