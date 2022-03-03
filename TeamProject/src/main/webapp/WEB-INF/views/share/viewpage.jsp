<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글보기</title>
</head>
<body>
    <section id="shareBoardForm">
        <div>
            <h2>반찬공유 게시판</h2>
        </div>
		<div>
            <section id="basicInfoArea">
                <a>[반찬공유중]</a>
                <a>${shareBoard_title }</a>
                <a>
                    <button type="button" class="delete button" value="delete">
                        delete button
                    </button>
                </a>
                <hr>
                <div>
                    <a>${프사}</a>
                    <a>${유저닉네임}</a>
                    <a>${유저 혼밥 레벨}</a>
                    <a>${프사}</a>
                    <a>
                        <label class="switch">
                            <input type="checkbox" checked>
                            <span class="slider round"></span>
                        </label>
                    </a>
                    <a>조회수 : ${조회수}</a>
                    <a>작성일 : ${작성일}</a>
                </div>
                <hr>
                <div>
                    <a>${img:location}</a>
                    <a>${info:location}</a>
                </div>
        </section>
        <section id="articleContentArea">
            <div>
                ${shareBoard_picture}
            </div>
            <div>
                ${shareBoard_content}
            </div>
        </section>
        <section id="articleCommentArea">
            <div>
                <a>${img:recommend}</a>
                <a>${shareBoardLikes_likes}</a>
                <a>${img:comment}</a>
                <a>${shareBoardConmment_num}</a>
            </div>
            <hr>
            <div>
                <a>${프사}</a>
                <a>${유저닉네임}</a>
                <a>${shareBoardComment_content}}</a>
                <a>${shareBoardComment_date}</a>
                <a>
                    <button type="button" class="edit button" value="edit">edit</button>
                </a>
                <a>
                    <button type="button" class="delete button" value="delete">delete</button>
                </a>
            </div>
        </section>
        <section>
            <div>
                <<input type="textarea" class="comment area">
                <button type="button" value="comment reply">댓글입력</button>
            </div>
        </section>
        <section id="commandList">
            <a href=""> [수정] </a> 
            <a href=""> [삭제] </a>
            <a href=""> [목록]</a>&nbsp;&nbsp;
        </section>    
        </div>
		
    
</body>
</html>