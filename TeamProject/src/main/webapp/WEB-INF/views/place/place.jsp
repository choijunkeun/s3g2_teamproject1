<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.ilinbun.mulcam.dto.Place"%>
<%-- <%!User user = new User("mockup@mock.up", "목업", "", "#", 5, 1);%>
<c:set var="user" value='<%=user%>' /> --%>
<!-- 목업 코드 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장소 보기</title>

</head>
<body>

	<c:choose>
		<c:when test="${not empty place }">
			<div class="container">
				<div class="row bg-light my-2"
					style="display: flex; flex-direction: row; flex-wrap: nowrap;">
					<div id="placeInfoSection"
						style="width: 100%; float: left; flex-shrink: 1;">
						<h1>
							<a href="javascript:window.history.back();"
								style="text-decoration: none;"><i class="fa fa-angle-left"></i></a>
						</h1>
						<h1>
							<strong>${place.place_name }</strong>
						</h1>
						<div>주소 : ${place.address_name }</div>
						<div>
							홈페이지 : <a href="${place.place_url }">${place.place_url }</a>
						</div>
						<div>연락처 : ${place.phone }</div>
						<!-- <img src="http://placehold.co/300"> -->
						<div class="container d-flex">
							<div class="py-2">
								<div style="display: inline; flex-wrap: nowrap;">
									<label>혼밥레벨</label>
									<span class="badge bg-danger rounded-pill">Lv. 5</span>
								</div>
								<div class="mt-1 d-flex justify-content-between align-items-center">
									<label class="review-stat">종합평점</label>
									<div class="small-ratings">
										<i class="fa fa-star rating-color"></i>
										<i class="fa fa-star rating-color"></i>
										<i class="fa fa-star rating-color"></i>
										<i class="fa fa-star rating-color"></i>
										<i class="fa fa-star"></i>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="staticMap" style="width: 400px; height: 350px; float: right;"></div>
					<script type="text/javascript"
						src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a69fc7ca725d20c3e61c5b6bb3d32242&libraries=services"></script>
					<script>
						var places = new kakao.maps.services.Places(); 
			
						places.keywordSearch("${place.place_name}",
							function(result, status) {
								if (status === kakao.maps.services.Status.OK && result[0].id == ${id}) {// 정상적으로 검색이 완료됐으면
									var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
								
									var staticMapContainer = document.getElementById('staticMap'), // 이미지 지도를 표시할 div  
									staticMapOption = {
										center : new kakao.maps.LatLng(result[0].y, result[0].x), // 이미지 지도의 중심좌표
										marker: {position: coords, text: result[0].place_name},
										level : 3 // 이미지 지도의 확대 레벨
									};
									console.log()
									// 이미지 지도를 표시할 div와 옵션으로 이미지 지도를 생성합니다
									var staticMap = new kakao.maps.StaticMap(staticMapContainer, staticMapOption);
								}
							});
					</script>
				</div>
			</div>
			<div class="container bg-light p-2 ">
				<div class="row my-2 d-flex align-bottom" style="flex-wrap: nowrap;">
					<div class="col">
						<h2 style="width: fit-content; float:left;"><strong>혼밥 맛집 리뷰</strong></h2>
						<div class="align-self-end" style="display: flex; vertical-align: bottom;">전체 3</div>
					</div>
					<div class="col">
						<button class="btn border border-secondary" onclick="writeReview()" style="width: fit-content; float: right;">리뷰 작성</button>
					</div>
				</div>
				<div class="row p-2">
					여기서부터 리뷰가 뜨는 영역
				</div>
			</div>
			<script>
				//var str = JSON.stringify(${place});
				
				function writeReview(){
					let f = document.createElement('form');
				    
				    let obj1;
				    obj1 = document.createElement('input');
				    obj1.setAttribute('type', 'hidden');
				    obj1.setAttribute('name', 'id');
				    obj1.setAttribute('value', ${id});
				    f.appendChild(obj1);
				    
				    let obj2;
				    obj2 = document.createElement('input');
				    obj2.setAttribute('type', 'hidden');
				    obj2.setAttribute('name', 'place_name');
				    obj2.setAttribute('value', '${place.place_name}');
				    f.appendChild(obj2);
				    
				    f.setAttribute('method', 'post');
				    f.setAttribute('action', './review/'+${id});
				    document.body.appendChild(f);
				    f.submit();
				}
			</script>
		</c:when>
	<c:otherwise>
		<span>결과를 가져오지 못했습니다. 다시 시도해주세요.</span>
	</c:otherwise>
</c:choose>

</body>
</html>