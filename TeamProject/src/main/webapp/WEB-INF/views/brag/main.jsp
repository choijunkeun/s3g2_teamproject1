<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>



<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>혼밥자랑 메인</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	
</head>
<body>
<!-- <a></a> BEST게시판 이동 링크 --> ${BragBest1.user_PK } ${BragBest1.content } ${BragBest1.location }
	
	<div class="row justify-content-center">
		<div class="col mt-5">
			<div class="card p-4">
				<h5 class="fw-bolder">이달의혼밥</h5>
				<div class="text-center">
					<!--  <h5 class="fw-bolder">이달의 혼밥</h5>-->
				</div>
				<div class="card-body">
					<img width="450px" height="450px" class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
				</div>
				
			</div>
		</div>
		
		
		<div class="col mt-5">
			<div class="card p-4">
			<a href="/brag/best"><h5 class="fw-bolder">BEST</h5></a>
				<div class="card-body">
					<table>
						<tr>
							<td>
								<img width="230px" height="230px"  class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
						</tr>
						<tr>
							<td>
								<img width="230px" height="230px"  class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
						</tr>
					</table>
					
				</div>
			</div>
		</div>
		</div>
		
		<div>
		<!-- 나중에 onclick으로 변경 -->
		<a style="float: right;" href="/brag/writeform"><button>글쓰기</button></a>
		</div>
		
			<div class="col mt-5">
			<div class="card p-4">
				<div class="text-center">
					 <a href="/brag/brag"><h5 class="fw-bolder">혼밥자랑</h5></a>
				</div>
				<div class="card-body">
					<table>
						<tr>
							<td>
								<img width="230px" height="230px"  class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td>
								<img width="230px" height="230px"  class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td>
								<img width="230px" height="230px"  class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td>
								<img width="230px" height="230px"  class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
						</tr>
						<tr>
							<td>
								<img width="230px" height="230px"  class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td>
								<img width="230px" height="230px"  class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td>
								<img width="230px" height="230px"  class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
							<td>
								<img width="230px" height="230px"  class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="...">
							</td>
						</tr>
					</table>
					
				</div>
			</div>
		</div>
		
		<!-- Paging[s] -->

<form method="get"  id="listForm" action="/board/list">
	<input type="hidden" id="pageIndex" name="pageIndex" val="" />
</form>

<div class="col-sm-12 col-md-7" style="text-align:right">
<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
	<ul class="pagination">
	
	<c:if test="${searchVO.prev}">
	<li class="paginate_button page-item previous" id="dataTable_previous">
		 <a href="javascript:void(0);" onclick="fn_go_page(${searchVO.startDate - 1}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a>
	</li>
	</c:if>
	
	<c:forEach var="num" begin="${searchVO.startDate}" end="${searchVO.endDate}">
	<li class="paginate_button page-item">
		 <a href="javascript:void(0);" onclick="fn_go_page(${num}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link" title="${num}">${num}</a>
	</li>
	</c:forEach>
	
	<c:if test="${searchVO.next}">
	<li class="paginate_button page-item next" id="dataTable_next">
		 <a href="javascript:void(0);" onclick="fn_go_page(${searchVO.endDate + 1}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Next</a>
	</li>
	</c:if>
	</ul>
</div>
</div>


<script>
$(document).ready(function() {
	
	var thisIndex = "${searchVO.pageIndex}"
	$(".pagination li a").each(function(){
		var idx = $(this).parent().index();
		var thistitle = $(this).attr("title");
		if(thistitle == thisIndex){
			$(".pagination").find("li").eq(idx).addClass("active");
		}
	});

	});
	
function fn_go_page(pageNo) {
	$("#pageIndex").val(pageNo);
	$("#listForm").submit();
	return false;
}
</script>

<!-- Paging[e] -->		
	
</body>
</html>