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
	</style>
<body>
	<nav class="navbar navbar-expand-sm">
		<div class="container-fluid justify-content-center">
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="btn btn-outline-dark mt-auto mx-3" id="search-nav" href="/search">혼밥검색</a>
				</li>
				<li class="nav-item">
					<a class="btn btn-outline-dark mt-auto mx-3" id="brag-nav" href="/brag">혼밥자랑</a>
				</li>
				<li class="nav-item">
					<a class="btn btn-outline-dark mt-auto mx-3" id="share-nav" href="/share">반찬공유</a>
				</li>
				<li class="nav-item">
					<a class="btn btn-outline-dark mt-auto mx-3" id="comm-nav" href="/comm">커뮤니티</a>
				</li>
				
			</ul>
		</div>
	</nav>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		//$('#'+window.location.pathname.split("/")[1]+'-nav').addClass('btn-dark text-white');
		//$('#'+window.location.pathname.split("/")[1]+'-nav').addClass('btn-dark text-white');
		document.getElementById(window.location.pathname.split("/")[1]+'-nav').classList.add( 'btn-dark');
		document.getElementById(window.location.pathname.split("/")[1]+'-nav').classList.add('text-white');
	</script>
</body>
</html>