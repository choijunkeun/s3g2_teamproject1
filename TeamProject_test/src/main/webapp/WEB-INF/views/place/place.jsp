<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장소 보기</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<div class="container">
		<div id="placeInfoSection" style="width: auto; float: left;">
			<h1><a href="javascript:window.history.back();" style="text-decoration: none; "><i class="fa fa-angle-left" ></i></a></h1>
			<!-- <img src="http://placehold.co/300"> -->
		</div>


		<!-- 이미지 지도를 표시할 div 입니다 -->
		<div id="staticMap" style="width: 400px; height: 350px; float:right;"></div>
		<!-- <div id="map" ></div> -->
		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a69fc7ca725d20c3e61c5b6bb3d32242&libraries=services"></script>
		<script>
/* 			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  
		
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			 */
			var places = new kakao.maps.services.Places(); 

			places.keywordSearch("${place_name}",
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


						// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
						//staticMap.setCenter(coords);
						document.getElementById("placeInfoSection").innerHTML += "<h1><strong>" + result[0].place_name +"</strong></h1>";
						document.getElementById("placeInfoSection").innerHTML += "<div> 주소 : "+result[0].address_name +"</div>";
						document.getElementById("placeInfoSection").innerHTML += "<div> 홈페이지 : <a href='"+result[0].place_url +"'>" + result[0].place_url +"</a></div>";
						document.getElementById("placeInfoSection").innerHTML += "<div> 연락처 : "+result[0].phone +"</div>";
						
						document.getElementById("placeInfoSection").innerHTML += "<div>~ 대충 여기쯤에 평가를 불러오는 코드 예정 ~</div>";
					}
					else {// 검색 결과가 없다면
						document.getElementById("placeInfoSection").innerHTML += "<span>결과를 가져오지 못했습니다. 다시 시도해주세요.</span>";
					}
				});
			
			
		</script>
		<!-- <div id="map" style="width: 100%; height: 350px; float:right;"></div>

		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a69fc7ca725d20c3e61c5b6bb3d32242&libraries=services"></script>
		<script>
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			mapOption = {
				center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
				level : 3// 지도의 확대 레벨
			};

			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption);

			var places = new kakao.maps.services.Places();

			places.keywordSearch("${place_name}",
							function(result, status) {

								// 정상적으로 검색이 완료됐으면 
								if (status === kakao.maps.services.Status.OK) {

									var coords = new kakao.maps.LatLng(
											result[0].y, result[0].x);

									// 결과값으로 받은 위치를 마커로 표시합니다
									var marker = new kakao.maps.Marker({
										map : map,
										position : coords
									});

									// 인포윈도우로 장소에 대한 설명을 표시합니다
									var infowindow = new kakao.maps.InfoWindow(
											{
												content : '<div style="width:150px;text-align:center;padding:6px 0;">' + result[0].place_name + '</div>'
											});
									infowindow.open(map, marker);

									// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
									map.setCenter(coords);
								}
							});
		</script> -->
	</div>
</body>
</html>