<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반찬공유 게시판</title>
<style>

	#passForm{
		width:400px;
		margin:auto;
		border : 1px solid  #f6f3f3;
	}
	
</style>
</head>
<body>
<section id = "passForm">
<form name="deleteForm" action="sharedelete?articleNo=${articleNo}" method="post">
<input type = "hidden" name = "page" value = '${page }'/>
<table>
<tr>
	<td>
		<label>정말 삭제하시겠습니까?<br>삭제된 글은 복구 할 수 없습니다. </label>
	</td>
	
</tr>
<tr>
	<td>
		<input type="submit" value = "삭제"/>
		&nbsp;&nbsp;
		<input type = "button" value = "돌아가기" onClick ="javascript:history.go(-1)"/>
	</td>
</tr>
</table>
</form>
</section>
</body>
</html>