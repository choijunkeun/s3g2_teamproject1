<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.map_wrap, .map_wrap * {
	margin: 0;
	padding: 0;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	font-size: 12px;
}

.map_wrap a, .map_wrap a:hover, .map_wrap a:active {
	color: #000;
	text-decoration: none;
}

.map_wrap {
	position: relative;
	width: 100%;
	height: 500px;
}

#menu_wrap {
	position: absolute;
	top: 0;
	left: 0;
	bottom: 0;
	width: 250px;
	margin: 10px 0 30px 10px;
	padding: 5px;
	overflow-y: auto;
	background: rgba(255, 255, 255, 0.7);
	z-index: 1;
	font-size: 12px;
	border-radius: 10px;
}

.bg_white {
	background: #fff;
}

#menu_wrap hr {
	display: block;
	height: 1px;
	border: 0;
	border-top: 2px solid #5F5F5F;
	margin: 3px 0;
}

#menu_wrap .option {
	text-align: center;
}

#menu_wrap .option p {
	margin: 10px 0;
}

#menu_wrap .option button {
	margin-left: 5px;
}

#placesList li {
	list-style: none;
}

#placesList .item {
	position: relative;
	border-bottom: 1px solid #888;
	overflow: hidden;
	cursor: pointer;
	min-height: 65px;
}

#placesList .item span {
	display: block;
	margin-top: 4px;
}

#placesList .item h5, #placesList .item .info {
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

#placesList .item .info {
	padding: 10px 0 10px 55px;
}

#placesList .info .gray {
	color: #8a8a8a;
}

#placesList .info .jibun {
	padding-left: 26px;
	background:
		url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png)
		no-repeat;
}

#placesList .info .tel {
	color: #009900;
}

#placesList .item .markerbg {
	float: left;
	position: absolute;
	width: 36px;
	height: 37px;
	margin: 10px 0 0 10px;
	background:
		url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png)
		no-repeat;
}

#placesList .item .marker_1 {
	background-position: 0 -10px;
}

#placesList .item .marker_2 {
	background-position: 0 -56px;
}

#placesList .item .marker_3 {
	background-position: 0 -102px
}

#placesList .item .marker_4 {
	background-position: 0 -148px;
}

#placesList .item .marker_5 {
	background-position: 0 -194px;
}

#placesList .item .marker_6 {
	background-position: 0 -240px;
}

#placesList .item .marker_7 {
	background-position: 0 -286px;
}

#placesList .item .marker_8 {
	background-position: 0 -332px;
}

#placesList .item .marker_9 {
	background-position: 0 -378px;
}

#placesList .item .marker_10 {
	background-position: 0 -423px;
}

#placesList .item .marker_11 {
	background-position: 0 -470px;
}

#placesList .item .marker_12 {
	background-position: 0 -516px;
}

#placesList .item .marker_13 {
	background-position: 0 -562px;
}

#placesList .item .marker_14 {
	background-position: 0 -608px;
}

#placesList .item .marker_15 {
	background-position: 0 -654px;
}

#pagination {
	margin: 10px auto;
	text-align: center;
}

#pagination a {
	display: inline-block;
	margin-right: 10px;
}

#pagination .on {
	font-weight: bold;
	cursor: default;
	color: #777;
}
</style>
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script> -->
</head>
<body>
	<form class="container" onsubmit="searchPlaces(); return false;" >
		<input type="hidden" id="honbabLv" value="5">
		<div class="search_area row justify-content-center p-2" style="width: 100%; flex-wrap: nowrap; ">
			<div class="btn-group-level" style="width: fit-content;">
				<button type="button" class="btn btn-danger dropdown-toggle"
					id="honbabLevelDropdown" data-bs-toggle="dropdown" aria-expanded="false">혼밥 레벨</button>
				<ul class="dropdown-menu text-center" aria-labelledby="honbabLevelDropdown">
					<li><button class="dropdown-item" type="button">
					<span class="badge rounded-pill" style="background: #F6CECE">Lv. 1</span></button></li>
					<li><button class="dropdown-item" type="button"><span
							class="badge rounded-pill" style="background: #F5A9A9">Lv. 2</span></button></li>
					<li><button class="dropdown-item" type="button"><span
							class="badge rounded-pill" style="background: #F78181">Lv. 3</span></button></li>
					<li><button class="dropdown-item" type="button"><span
							class="badge rounded-pill" style="background: #FA5858">Lv. 4</span></button></li>
					<li><button class="dropdown-item" type="button"><span
							class="badge rounded-pill" style="background: #FF0000">Lv. 5</span></button></li>
				</ul>
			</div>
			<div class="input-group" style="flex-shrink:1;">
				<input type="text" class="form-control" id="keyword"
					placeholder="검색할 혼밥 맛집을 입력하세요" aria-label="혼밥 맛집 추천">
				<button class="input-group-text btn bg-primary text-white" type="submit">검색하기</button>
			</div>
			
			<div class="btn-group-sort" style="width: fit-content;">
				<button type="button" class="btn btn-secondary dropdown-toggle"
					id="sortDropdown" data-bs-toggle="dropdown" aria-expanded="false">분류별 검색</button>
				<ul class="dropdown-menu text-center" aria-labelledby="sortDropdown">
					<li><button class="dropdown-item" type="button">종합 평점 순</button></li>
					<li><button class="dropdown-item" type="button">가격 순</button></li>
					<li><button class="dropdown-item" type="button">맛 평점 순</button></li>
					<li><button class="dropdown-item" type="button">서비스 평점 순</button></li>
					<li><button class="dropdown-item" type="button">인테리어 평점 순</button></li>
				</ul>
			</div>
		</div>
	</form>


	<div class="map_wrap">
		<div id="map"
			style="width: auto; height: 100%; position: relative; overflow: hidden;">
		</div>

		<div id="menu_wrap" class="bg_white" style="visibility: hidden;">
			<ul id="placesList"></ul>
			<div id="pagination"></div>
		</div>
	</div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a69fc7ca725d20c3e61c5b6bb3d32242&libraries=services"></script>
	<script>
		// 마커를 담을 배열입니다
		var markers = [];
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(37.529521, 126.964540), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  
		
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places();  
		
		// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
		
		// 키워드로 장소를 검색합니다
		//searchPlaces();
		
		// 키워드 검색을 요청하는 함수입니다
		function searchPlaces() {
		
		    var keyword = '용산구[' +document.getElementById('keyword').value+"]";
		
		    if (!keyword.replace(/^\s+|\s+$/g, '')) {
		        alert('키워드를 입력해주세요!');
		        return false;
		    }
		
		    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
		    ps.keywordSearch( keyword, placesSearchCB, {category_group_code:'FD6, CE7'}); 
		}
		
		// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
		function placesSearchCB(data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {
		
		        // 정상적으로 검색이 완료됐으면
		        // 검색 목록과 마커를 표출합니다
		        document.getElementById('menu_wrap').style.visibility = "visible";
		        displayPlaces(data);
		
		        // 페이지 번호를 표출합니다
		        displayPagination(pagination);
		
		    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
		
		        alert('검색 결과가 존재하지 않습니다.');
		        return;
		
		    } else if (status === kakao.maps.services.Status.ERROR) {
		
		        alert('검색 결과 중 오류가 발생했습니다.');
		        return;
		
		    }
		}
		
		// 검색 결과 목록과 마커를 표출하는 함수입니다
		function displayPlaces(places) {
			
			/*
				여기에 혼밥 레벨별로 정렬하는 코드를 먼저 작성하자
				
			*/
			
		
		    var listEl = document.getElementById('placesList'), 
		    menuEl = document.getElementById('menu_wrap'),
		    fragment = document.createDocumentFragment(), 
		    bounds = new kakao.maps.LatLngBounds(), 
		    listStr = '';
		    
		    // 검색 결과 목록에 추가된 항목들을 제거합니다
		    removeAllChildNods(listEl);
		
		    // 지도에 표시되고 있는 마커를 제거합니다
		    removeMarker();
		    
		    for ( var i=0; i<places.length; i++ ) {
		
		        // 마커를 생성하고 지도에 표시합니다
		        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
		            marker = addMarker(placePosition, i), 
		            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
		
		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        bounds.extend(placePosition);
		
		        // 마커와 검색결과 항목에 mouseover 했을때
		        // 해당 장소에 인포윈도우에 장소명을 표시합니다
		        // mouseout 했을 때는 인포윈도우를 닫습니다
		        (function(marker, title) {
		            kakao.maps.event.addListener(marker, 'mouseover', function() {
		                displayInfowindow(marker, title);
		            });
		
		            kakao.maps.event.addListener(marker, 'mouseout', function() {
		                infowindow.close();
		            });
		
		            itemEl.onmouseover =  function () {
		                displayInfowindow(marker, title);
		            };
		
		            itemEl.onmouseout =  function () {
		                infowindow.close();
		            };
		        })(marker, places[i].place_name);
		
		        fragment.appendChild(itemEl);
		    }
		
		    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
		    listEl.appendChild(fragment);
		    menuEl.scrollTop = 0;
		
		    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		    map.setBounds(bounds);
		}
		
		// 검색결과 항목을 Element로 반환하는 함수입니다
		function getListItem(index, places) {
		
		    var el = document.createElement('li'),
		    //itemStr = '<form action="./place/' + places.id + '" method="post"><span class="markerbg marker_' + (index+1) + '"></span>';
			//itemStr += '<div class="info">' +
		    //            '   <h5>' + places.place_name + '</h5>';
		
		    //if (places.road_address_name) {
		    //    itemStr += '    <span>' + places.road_address_name + '</span>' +
		    //                '   <span class="jibun gray">' +  places.address_name  + '</span>';
		    //} else {
		    //    itemStr += '    <span>' +  places.address_name  + '</span>'; 
		    //}
		    //             
		    //  itemStr += '  <span class="tel">' + places.phone  + '</span>';
		    // /* '<a href="./place/' + places.id + '" style="text-decoration:none;">상세보기</a>' +  */
		    // itemStr += '<input type="hidden" name="place_name" value="' + places.place_name + '">' + 
		    // '<input type="submit" class="btn" value="상세보기">';
		    //            itemStr +='</div></form>';
			    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>';
			    itemStr += '<div class="info"><h5>' + places.place_name + '</h5>';
			    if (places.road_address_name) {
			        itemStr += '    <span>' + places.road_address_name + '</span>' +
			                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
			    } else {
			        itemStr += '    <span>' +  places.address_name  + '</span>'; 
			    }
				itemStr += '  <span class="tel">' + places.phone  + '</span>';
				//itemStr += makePlaceHiddenForm(places);
				itemStr += '</div>';
		
		    el.innerHTML = itemStr;
		    el.className = 'item';
		    el.children[1].appendChild(makePlaceHiddenForm(places));
		
		    return el;
		}
		
		function makePlaceHiddenForm(places){
			var f = document.createElement('form');
			
			let objid = document.createElement('input');
			objid.setAttribute('type', 'hidden');
			objid.setAttribute('name', 'id');
			objid.setAttribute('value', places.id);
			f.appendChild(objid);
			
			let objplace_name = document.createElement('input');
			objplace_name.setAttribute('type', 'hidden');
			objplace_name.setAttribute('name', 'place_name');
			objplace_name.setAttribute('value', places.place_name);
			f.appendChild(objplace_name);
			
			let objcategory_name = document.createElement('input');
			objcategory_name.setAttribute('type', 'hidden');
			objcategory_name.setAttribute('name', 'category_name');
			objcategory_name.setAttribute('value', places.category_name);
			f.appendChild(objcategory_name);
			
			let objcategory_group_code = document.createElement('input');
			objcategory_group_code.setAttribute('type', 'hidden');
			objcategory_group_code.setAttribute('name', 'category_group_code');
			objcategory_group_code.setAttribute('value', places.category_group_code);
			f.appendChild(objcategory_group_code);
			
			let objcategory_group_name = document.createElement('input');
			objcategory_group_name.setAttribute('type', 'hidden');
			objcategory_group_name.setAttribute('name', 'category_group_name');
			objcategory_group_name.setAttribute('value', places.category_group_name);
			f.appendChild(objcategory_group_name);
			
			let objphone = document.createElement('input');
			objphone.setAttribute('type', 'hidden');
			objphone.setAttribute('name', 'phone');
			objphone.setAttribute('value', places.phone);
			f.appendChild(objphone);
			
			let objaddress_name = document.createElement('input');
			objaddress_name.setAttribute('type', 'hidden');
			objaddress_name.setAttribute('name', 'address_name');
			objaddress_name.setAttribute('value', places.address_name);
			f.appendChild(objaddress_name);
			
			let objroad_address_name = document.createElement('input');
			objroad_address_name.setAttribute('type', 'hidden');
			objroad_address_name.setAttribute('name', 'road_address_name');
			objroad_address_name.setAttribute('value', places.road_address_name);
			f.appendChild(objroad_address_name);
			
			let objx = document.createElement('input');
			objx.setAttribute('type', 'hidden');
			objx.setAttribute('name', 'x');
			objx.setAttribute('value', places.x);
			f.appendChild(objx);
			
			let objy = document.createElement('input');
			objy.setAttribute('type', 'hidden');
			objy.setAttribute('name', 'y');
			objy.setAttribute('value', places.y);
			f.appendChild(objy);
			
			let objplace_url = document.createElement('input');
			objplace_url.setAttribute('type', 'hidden');
			objplace_url.setAttribute('name', 'place_url');
			objplace_url.setAttribute('value', places.place_url);
			f.appendChild(objplace_url);
			
			let objsubmit = document.createElement('input');
			objsubmit.setAttribute('type', 'submit');
			objsubmit.className = 'btn';
			objsubmit.setAttribute('value', "상세보기");
			f.appendChild(objsubmit);
			
			f.setAttribute('method', 'post');
			f.setAttribute('action', './place/'+places.id);
			//f.setAttribute('enctype', 'application/json');
			return f;
		}
		
		
		// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
		function addMarker(position, idx, title) {
		    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
		        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
		        imgOptions =  {
		            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
		            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
		        },
		        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
		            marker = new kakao.maps.Marker({
		            position: position, // 마커의 위치
		            image: markerImage 
		        });
		
		    marker.setMap(map); // 지도 위에 마커를 표출합니다
		    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
		
		    return marker;
		}
		
		// 지도 위에 표시되고 있는 마커를 모두 제거합니다
		function removeMarker() {
		    for ( var i = 0; i < markers.length; i++ ) {
		        markers[i].setMap(null);
		    }   
		    markers = [];
		}
		
		// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
		function displayPagination(pagination) {
		    var paginationEl = document.getElementById('pagination'),
		        fragment = document.createDocumentFragment(),
		        i; 
		
		    // 기존에 추가된 페이지번호를 삭제합니다
		    while (paginationEl.hasChildNodes()) {
		        paginationEl.removeChild (paginationEl.lastChild);
		    }
		
		    for (i=1; i<=pagination.last; i++) {
		        var el = document.createElement('a');
		        el.href = "#";
		        el.innerHTML = i;
		
		        if (i===pagination.current) {
		            el.className = 'on';
		        } else {
		            el.onclick = (function(i) {
		                return function() {
		                    pagination.gotoPage(i);
		                }
		            })(i);
		        }
		
		        fragment.appendChild(el);
		    }
		    paginationEl.appendChild(fragment);
		}
		
		// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
		// 인포윈도우에 장소명을 표시합니다
		function displayInfowindow(marker, title) {
		    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
		
		    infowindow.setContent(content);
		    infowindow.open(map, marker);
		}
		
		 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
		function removeAllChildNods(el) {   
		    while (el.hasChildNodes()) {
		        el.removeChild (el.lastChild);
		    }
		}
	</script>
</body>
</html>