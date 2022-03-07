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
            <h2>반찬공유 <a href="/writeform"> 글쓰기</a></h2>

        <c:choose>
            <c:when test="${articleList!=null && pageInfo.listCount>0 }">
                <section id="listForm">
                    <table style="border:1px; width:100%;">
                        <tr id="tr_top">
                            <td>번호</td>
                            <td>제목</td>
                            <td>위치</td>
                            <td>작성자</td>
                            <td>날짜</td>
                            <td>조회수</td>
                            <td>추천수</td>
                        </tr>
                        <tr>
                        	<td>1</td>
                            <td>간장게장 나눔합니다~~</td>
                            <td>남영역</td>
                            <td>고시히카리</td>
                            <td>2022-03-04</td>
                            <td>123</td>
                            <td>1</td>
                        </tr>

                        <c:forEach var="article" items="${articleList }">
                            <tr>
                                <td>${article.board_num }</td>
                                <td>
                                    <a href="./boarddetail?board_num=${article.board_num}&page=${pageInfo.page}"
                                        ><!-- 링크 -->
                                        ${article.board_subject}
                                        <!-- 아티클 번호 -->
                                    </a>
                                </td>
                                <td>${article.board_title }</td>
                                <td>${article.board_location_sub }</td>
                                <td>${article.board_username }</td>
                                <td>${article.board_date }</td>
                                <td>${article.board_readcount }</td>
                                <td>${article.board_recommentcount }</td>
                            </tr>
                        </c:forEach>
                    </table>
                </section>
                
            </c:when>
            <c:otherwise>
                <section id="emptyArea">등록된 글이 없습니다.</section>
            </c:otherwise>
            <section id="pageList">
                    <!-- 페이지 목록 --><!-- if else 랑 같음.  페이지가 1보다 작거나 같으면 이전페이지로 -->
                    <c:choose>
                        <c:when test="${pageInfo.page<=1}">
                            [이전]&nbsp;
                        </c:when>
                        <c:otherwise>
                            <a href="boardlist?page=${pageInfo.page-1}"
                                >[이전]</a
                            >&nbsp;
                        </c:otherwise>
                    </c:choose>
                    <c:forEach
                        var="i"
                        begin="${pageInfo.startPage }"
                        end="${pageInfo.endPage }"
                    >
                        <!-- end page 마지막 페이지 -->
                        <!-- 현재페이지. 1페이지에서는 현재와 이전페이지 클릭될 필요가없음.-->
                        <!-- 현재페이지를 제외한 나머지페이지 -->
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
                            <a href="boardlist?page=${pageInfo.page+1}"
                                >[다음]</a
                            >
                        </c:otherwise>
                    </c:choose>
                    <!-- 페이지에 답변 달았으면 그 페이지 목록이 보여야함. -->
                    <!-- 눈에 보이진 않지만 페이지를 달고다님. -->
                </section>
        </c:choose>
        </div>
</body>
</html>