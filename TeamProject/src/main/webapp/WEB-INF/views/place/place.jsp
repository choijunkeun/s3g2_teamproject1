<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
							<a href="../../search;"
								style="text-decoration: none;"><i class="fa fa-angle-left"></i></a>
						</h1>
						<h1>
							<strong>${place.place_name }</strong>
						</h1>
						<div>주소 : ${place.address_name }</div>
						<div>
							홈페이지 : <a href="${place.place_url }" target='_blank'>${place.place_url }</a>
						</div>
						<div>연락처 : ${place.phone }</div>
						<!-- <img src="http://placehold.co/300"> -->
						<div class="container d-flex">
							<div class="py-2">
								<div style="display: inline; flex-wrap: nowrap;">
									<label>혼밥레벨</label>
									<span class="badge bg-danger rounded-pill">Lv. ${honbabLv}</span>
								</div>
								<div class="mt-1 d-flex justify-content-between align-items-center">
									<label class="review-stat">종합평점</label>
									<span> : <strong>${totalRate }</strong></span>
								</div>
								<div class="mt-1 d-flex justify-content-between align-items-center">
									<label class="review-stat">가격평점</label>
									<span> : <strong>${priceRate }</strong></span>
								</div>
								<div class="mt-1 d-flex justify-content-between align-items-center">
									<label class="review-stat">맛 평점</label>
									<span> : <strong>${tasteRate }</strong></span>
								</div>
								<div class="mt-1 d-flex justify-content-between align-items-center">
									<label class="review-stat">서비스 평점</label>
									<span> : <strong>${serviceRate }</strong></span>
								</div>
								<div class="mt-1 d-flex justify-content-between align-items-center">
									<label class="review-stat">멋(인테리어) 평점</label>
									<span> : <strong>${interiorRate }</strong></span>
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
			<div class="container bg-light p-3">
				<div class="row my-2 px-2 d-flex align-bottom" style="flex-wrap: nowrap;">
					<div class="col">
						<h2 style="width: fit-content; float:left;"><strong>혼밥 맛집 리뷰<c:if test="${not empty reviewAmount }">(${reviewAmount })</c:if></strong></h2>
					</div>
					<div class="col text-right" style="vertical-align: center">
						<c:if test="${not empty user }">
							<button class="btn border border-secondary" onclick="writeReview()" style="width: fit-content; float: right;">리뷰 작성</button>
						</c:if>
					</div>
				</div>
				<div class="row px-2 d-flex justify-content-center" style="margin: 0 auto;">
					<c:choose>
					<c:when test="${empty prList }">
						<p>해당 맛집에 대한 리뷰가 없습니다.</p>
					</c:when>
					<c:otherwise>
						<c:forEach var="pr" items="${prList }">
							<div class="row bg-white my-1 p-3 border ">
								<div class="justify-content-center text-center border-right" style="width:120px;">
									<img style="border-radius: 50px; width: 60px; height: 60px; margin: 0 auto;" src='/profile/${pr.profileImg }'><br>
									<span class="badge bg-danger rounded-pill mb-2">Lv .${pr.honbabLevel }</span>
									<div class="border pb-2 pt-1 m-2 mx-auto rounded" style="display: inline; text-overflow: ellipsis; overflow:hidden; white-space: nowrap;">${pr.nickname } 님</div>
								</div>
								<div class="col" >
									<section>
										<div class="justify-content-between d-flex flex-wrap">
											<h5><strong>${pr.honbabReason }</strong></h5>
											<c:if test="${user.idx == pr.user_PK || user.grp == 2 }">
												<div class="if-thisArticle-mine text-end">
													<div class="btn border-dark">수정</div>
													<div class="btn border-dark">삭제</div>
												</div>
											</c:if>
										</div>
										<p>${pr.reviewContent }</p>
									</section>
									<div class="d-flex flex-wrap" style="float: bottom; font-size: 0.9rem;">
										<span class="badge bg-danger rounded-pill">Lv .${pr.honbabLevel }</span>&nbsp;
										<span><i class="bi bi-star-fill"></i> 종합평점 : <fmt:formatNumber value="${(pr.serviceRate + pr.interiorRate + pr.priceRate + pr.tasteRate)/4 }" pattern=".00"/>&nbsp;</span>
										<span style="font-size: 0.9rem;"><i class="bi bi-pencil-square"></i> ${pr.writeTime }</span>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:otherwise>
					</c:choose>
				</div>
				<section class="text-center" id="pageList">
					<c:choose>
						<c:when test="${pageInfo.page<=1}">
							[이전]&nbsp;
						</c:when>
						<c:otherwise>
							<a href="boardlist?page=${pageInfo.page-1}">[이전]</a>&nbsp;
						</c:otherwise>
					</c:choose>
					<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }">
						<c:choose>
							<c:when test="${pageInfo.page==i }">[${i }]</c:when>
							<c:otherwise>
								<a href="boardlist?page=${i}">[${i }]</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${pageInfo.page>=pageInfo.maxPage }">
							[다음]
						</c:when>
						<c:otherwise>
							<a href="boardlist?page=${pageInfo.page+1}">[다음]</a>
						</c:otherwise>
					</c:choose>
				</section>
			</div>
			<script>
				function writeReview(){
					let f = document.createElement('form');
					
				    f.appendChild(makeInputHiddenObj('id','${place.id}'));
				    f.appendChild(makeInputHiddenObj('place_name','${place.place_name}'));
				    f.appendChild(makeInputHiddenObj('category_name','${place.category_name}'));
				    f.appendChild(makeInputHiddenObj('category_group_code','${place.category_group_code}'));
				    f.appendChild(makeInputHiddenObj('category_group_name','${place.category_group_name}'));
				    f.appendChild(makeInputHiddenObj('phone','${place.phone}'));
				    f.appendChild(makeInputHiddenObj('address_name','${place.address_name}'));
				    f.appendChild(makeInputHiddenObj('road_address_name','${place.road_address_name}'));
				    f.appendChild(makeInputHiddenObj('x','${place.x}'));
				    f.appendChild(makeInputHiddenObj('y','${place.y}'));
				    f.appendChild(makeInputHiddenObj('place_url','${place.place_url}'));
				    
				    
				    //f.setAttribute('enctype','application/json');
				    f.setAttribute('method', 'post');
				    f.setAttribute('action', './review/'+${id});
				    document.body.appendChild(f);
				    f.submit();
				}
				
				function makeInputHiddenObj(key, value){
					let obj = document.createElement('input');
					obj.setAttribute('type', 'hidden');
				    obj.setAttribute('name', key);
				    obj.setAttribute('value', value);
				    return obj;
				}
			</script>
		</c:when>
	<c:otherwise>
		<span>결과를 가져오지 못했습니다. 다시 시도해주세요.</span>
	</c:otherwise>
</c:choose>

</body>
</html>