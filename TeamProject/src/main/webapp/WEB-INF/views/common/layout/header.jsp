<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<style>
#headertitle {
	font-family: 'Yeongdo-Rg';
}

#headertitle:link {
	color: black;
}

#headertitle:visited {
	color: black;
}

#headertitle:hover {
	color: black;
}

#headertitle:active {
	color: black;
}
/*배너 이미지 사이즈 조절 코드 크롬에서만 됨  */
.logo {
	width: 20%;
	height: auto;
}
</style>
</head>
<body>

<header class="bg-white py-5">
	<div class="container px-4 px-lg-5">
		<div class="text-center text-black">
				<a href="/" id="headertitle" style="text-decoration: none; text-color:black;"><img src="${path}/banner/logo.gif" class="logo" /></a>
		</div>
	</div>
</header>
</body>
</html>