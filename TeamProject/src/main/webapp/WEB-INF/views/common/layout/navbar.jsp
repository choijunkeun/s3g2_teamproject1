<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일인분 : 혼밥 정보가 필요할 땐, 일인분</title>
</head>
<style>
.active {
	
}
/* .nav_container {

	backgrount-color : black !important;
	color : grey !important;
	font-weight : bolder !important;
	font-size : large !important;
	margin : 10px !important;
	padding: 6px !important;
	
	
} */


a:link, a:visited, a:hover, a:active { 
	color: grey; text-decoration: none; !important
}
</style>
<body>
	<nav class="container container-fluid navbar navbar-dark bg-dark navbar-expand-sm p-3" style="flex-shrink: 0; max-width: 1200px;">
		<ul class="navbar-nav">
			<li class="nav-item"><a class="mt-auto mx-3" id="search-nav" href="/search">혼밥검색</a></li>
			<li class="nav-item"><a class="mt-auto mx-3" id="share-nav" href="/share">반찬공유</a></li>
			<li class="nav-item"><a class="mt-auto mx-3" id="brag-nav" href="/brag">혼밥자랑</a></li>
			<li class="nav-item"><a class="mt-auto mx-3" id="comm-nav" href="/comm/listform">커뮤니티</a></li>
		</ul>

				<ul class="navbar-nav">
					<li class="nav-item"><a class="mt-auto mx-3" id="search-nav" href="/search">혼밥검색</a></li>
					<li class="nav-item"><a class="mt-auto mx-3" id="share-nav" href="/share/board/listform">반찬공유</a></li>
					<li class="nav-item"><a class="mt-auto mx-3" id="brag-nav" href="/brag">혼밥자랑</a></li>
					<li class="nav-item"><a class="mt-auto mx-3" id="comm-nav" href="/comm/listform">커뮤니티</a></li>
				</ul>

			</nav>
		</div>
	</div>



	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		//$('#'+window.location.pathname.split("/")[1]+'-nav').addClass('btn-dark text-white');
		//$('#'+window.location.pathname.split("/")[1]+'-nav').addClass('btn-dark text-white');
		if (window.location.pathname !== "/") {
			if (window.location.pathname.split("/")[1] != 'place') {
				//document.getElementById(window.location.pathname.split("/")[1]+'-nav').classList.add('btn-dark');
				//document.getElementById(window.location.pathname.split("/")[1]+'-nav').classList.add('text-white');
				document.getElementById(window.location.pathname.split("/")[1]
						+ '-nav').classList.add('font-weight-bold');
				document.getElementById(window.location.pathname.split("/")[1]
						+ '-nav').classList.add('text-white');
			}
		}
	</script>
</body>

</html>