<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 목업 코드, 아래 영역을 주석처리하면 로그아웃 처리된 것으로 짜볼 수 있음 -->
<%@ page import="com.ilinbun.mulcam.dto.User"%>
<%!User user = new User("mockup@mock.up", "목업", "", "#", 5, 1);%>
<c:set var="user" value='<%=user%>' />
<!-- 목업 코드 -->

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
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
		h4 > strong {
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
		input.star{
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
</style>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<h2>
		<strong>게시물 보기</strong>
	</h2>
<!-- 게시판 수정 -->
	<section id="articleForm">
		<h2>글 내용 상세보기</h2>
		<section id="basicInfoArea">
			제 목 : ${article.board_subject }
			첨부파일 :
			<c:if test="${article.board_filename!=null }">
				<a href="file_down?downFile=${article.board_filename}"> ${article.board_filename} </a>
			</c:if>
	</section>
	<section id="articleContentArea">
		${article.board_content }
	</section>
	</section>
	<section id="commandList">
		<a href="replyform?board_num=${article.board_num}&page=${page}"> [답변] </a> 
		<a href="modifyform?board_num=${article.board_num}"> [수정] </a> 
		<a href="deleteform?board_num=${article.board_num}&page=${page}"> [삭제] </a>
		<a href="./boardlist?page=${page}"> [목록]</a>&nbsp;&nbsp;
	</section>

	<script>
	$('#fileup').change(function(){
		//here we take the file extension and set an array of valid extensions
		    var res=$('#fileup').val();
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
		      
		        $('#namefile').css({"color":"red","font-weight":700});
		        $('#namefile').html("File "+filename+" is not  pic!");
		        
		        $( "#submitbtn" ).hide();
		        $( "#fakebtn" ).show();
		    }else{
		        //if file is valid we show the green alert and show the valid submit
		        $( ".imgupload" ).hide("slow");
		        $( ".imgupload.stop" ).hide("slow");
		        $( ".imgupload.ok" ).show("slow");
		      
		        $('#namefile').css({"color":"green","font-weight":700});
		        $('#namefile').html(filename);
		      
		        $( "#submitbtn" ).show();
		        $( "#fakebtn" ).hide();
		    }
		});
	
	</script>
</body>
</html>