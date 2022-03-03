<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	 <!-- 반찬공유 공지사항 게시판 -->
        <div class="container notice board">
            <div class="board title"><a>공지사항</a><a>더보기</a></div>
            <div class="column notice board">
                <div class="col">
                    <a>${noticeArticle_num}</a>
                    <a>${noticeArticle_title}</a>
                    <a>${noticeArticle_date}</a>
                </div>
            </div>
        </div>

        <!-- 위치검색 쿼리 -->
        <div>
            <label for="location-subway""">어디서 공유를 받고 싶으신가요?</label> <br>
            <select name="location" id="location-subway">
                <option value="">지역을 골라주세요!</option>
                <option value="용산역">용산역</option>
                <option value="효창공원역">효창공원역</option>
                <option value="남영역">남영역</option>
                <option value="삼각지역">삼각지역</option>
                <option value="숙대입구역">숙대입구역</option>
                <option value="이촌역">이촌역</option>
                <option value="서빙고역">서빙고역</option>
                <option value="한남역">한남역</option>
                <option value="한강진역">한강진역</option>
                <option value="이태원역">이태원역</option>
                <option value="녹사평역">녹사평역</option>
            </select>
            <button class="select button" type="button" value="검색">검색</button>
        </div>
        <!-- 반찬공유 게시판 리스트 -->
        <h2><a>반찬공유 게시판 - 혼자 먹는 당신을 위해 나눠드립니다.</a></h2>
        <div class="container share board">
            <div class="board title"><a>반찬공유 게시판</a></div>
            <div class="column share board">
                <div class="col">
                    <a>No</a>
                    <a>제목</a>
                    <a>위치</a>
                    <a>작성자</a>
                    <a>작성일</a>
                    <a>조회수</a>
                    <a>추천수</a>
                </div>
                <div class="col">
                    <a>${shareBoard_num}</a>
                    <a>${shareBoard_title}</a>
                    <a>${shareBoard_location}</a>
                    <a>${shareBoard_author}</a>
                    <a>${shareBoard_date}</a>
                    <a>${shareBoard_views}</a>
                    <a>${shareBoard_recommend}</a>
                </div>
            </div>
        </div>
</body>
</html>