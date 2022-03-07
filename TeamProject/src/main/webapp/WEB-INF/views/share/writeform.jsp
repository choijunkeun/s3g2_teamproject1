<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 목업 코드, 아래 영역을 주석처리하면 로그아웃 처리된 것으로 짜볼 수 있음 -->
<%@ page import="com.ilinbun.mulcam.dto.User"%> 

<%!User user = new User(1, "mockup@mock.up", "목업", "", "#", 5, 1);%>
<c:set var="user" value="<%=user%>" />
<!-- 목업 코드 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Share Write Form</title>
        <style>
            #top {
                margin-top: 20px;
            }
            .btn-container {
                background: #fff;
                border-radius: 5px;
                padding-bottom: 20px;
                margin-bottom: 20px;
            }
            .white {
                color: white;
            }
            .imgupload {
                color: #1e2832;
                padding-top: 40px;
                font-size: 7em;
            }
            #namefile {
                color: black;
            }
            h4 > strong {
                color: #ff3f3f;
            }
            .btn-primary {
                border-color: #ff3f3f !important;
                color: #ffffff;
                text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
                background-color: #ff3f3f !important;
                border-color: #ff3f3f !important;
            }

            /*these two are set to not display at start*/
            .imgupload.ok {
                display: none;
                color: green;
            }
            .imgupload.stop {
                display: none;
                color: red;
            }

            /*this sets the actual file input to overlay our button*/
            #fileup {
                opacity: 0;
                -moz-opacity: 0;
                filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0);
                width: 200px;
                cursor: pointer;
                position: absolute;
                left: 50%;
                transform: translateX(-50%);
                bottom: 40px;
                height: 50px;
            }

            /*switch between input and not active input*/
            #submitbtn {
                padding: 5px 50px;
                display: none;
            }
            #fakebtn {
                padding: 5px 40px;
            }

            /*www.emilianocostanzo.com*/
            #sign {
                color: #1e2832;
                position: fixed;
                right: 10px;
                bottom: 10px;
                text-shadow: 0px 0px 0px #1e2832;
                transition: all.3s;
            }
            #sign:hover {
                color: #1e2832;
                text-shadow: 0px 0px 5px #1e2832;
            }
        </style>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
  <h2>
            <strong>반찬공유 글쓰기</strong>
        </h2>
        <div>
            <label for="admin-write">관리자 계정 공지글쓰기</label> <br>
            <select id="admin-write">
                <option value="공지글쓰기">공지글쓰기</option>
                <option value="일반글쓰기">일반글쓰기</option>
            </select> 
        </div>
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
            <form>
                <div class="container p-2">
                    <div class="row p-1 text-center">
                        <div class="col">
                            <!-- https://codepen.io/jexordexan/pen/yyYEJa -->
                        </div>
                        <div class="col">
                            <input
                                type="text"
                                name="shareboardtitle"
                                style="width: 100%"
                                placeholder="제목을 써주세요"
                            />
                        </div>
                    </div>
                    <div class="row p-1">
                        <div class="col">
                            <!-- https://codepen.io/emiemi/pen/zxNXWR -->
                            <div
                                class="card border rounded text-center justify-content-center"
                            >
                                <!-- <input type="file" name="revImgFile" style="width: 100%;" placeholder="사진을 이 곳에 업로드 해주세요"> -->
                                <div class="btn-container">
                                    <!--the three icons: default, ok file (img), error file (not an img)-->
                                    <h1 class="imgupload">
                                        <i class="fa fa-file-image-o"></i>
                                    </h1>
                                    <h1 class="imgupload ok">
                                        <i class="fa fa-check"></i>
                                    </h1>
                                    <h1 class="imgupload stop">
                                        <i class="fa fa-times"></i>
                                    </h1>
                                    <!--this field changes dinamically displaying the filename we are trying to upload-->
                                    <p id="namefile">
                                        사진을 올려주세요!(.jpg,.jpeg,.bmp,.png 파일만 허용됩니다)                                        파일만 허용됩니다.)
                                    </p>
                                    <!--our custom btn which which stays under the actual one-->
                                    <button
                                        type="button"
                                        id="btnup"
                                        class="btn btn-primary btn-lg"
                                    >
                                        파일 선택
                                    </button>
                                    <input
                                        type="file"
                                        value=""
                                        name="fileup"
                                        id="fileup"
                                    />
                                </div>
                            </div>
                        </div>
                        <div class="col">
                            <textarea
                                name="shareboardcontent"
                                style="width: 100%; height: 100%"
                                placeholder="상세 내용을 입력해주세요"
                            ></textarea>
                        </div>
                    </div>
                </div>
                <div class="row py-3">
                    <div class="col text-center">
                       
                        <input
                            type="submit"
                            name="cancelboard"
                            class="btn border bd-secondary"
                            value="취소"
                        />
                       
                        <input
                            type="submit"
                            name="registerboard"
                            class="btn border bd-secondary"
                            value="등록"
                        />
                    </div>
                </div>
            </form>
        </div>

        <script>
            $('#fileup').change(function () {
                //here we take the file extension and set an array of valid extensions
                var res = $('#fileup').val()
                var arr = res.split('\\')
                var filename = arr.slice(-1)[0]
                filextension = filename.split('.')
                filext = '.' + filextension.slice(-1)[0]
                valid = ['.jpg', '.png', '.jpeg', '.bmp']
                //if file is not valid we show the error icon, the red alert, and hide the submit button
                if (valid.indexOf(filext.toLowerCase()) == -1) {
                    $('.imgupload').hide('slow')
                    $('.imgupload.ok').hide('slow')
                    $('.imgupload.stop').show('slow')

                    $('#namefile').css({ color: 'red', 'font-weight': 700 })
                    $('#namefile').html('File ' + filename + ' is not  pic!')

                    $('#submitbtn').hide()
                    $('#fakebtn').show()
                } else {
                    //if file is valid we show the green alert and show the valid submit
                    $('.imgupload').hide('slow')
                    $('.imgupload.stop').hide('slow')
                    $('.imgupload.ok').show('slow')

                    $('#namefile').css({ color: 'green', 'font-weight': 700 })
                    $('#namefile').html(filename)

                    $('#submitbtn').show()
                    $('#fakebtn').hide()
                }
            })

        $('registerboard').onClick(function() {
            alert("반찬 및 식재료를 공유 시 발생되는 법적인 문제는 개인에게 달려있습니다. 개발진들은 이를 책임지지 않습니다.")
            alert("게시글이 작성되었습니다")
        })
        $('cancelboard').onClick(function() {
            if (confirm('게시글 작성을 취소하시겠습니까?')) {
                console.log('delete info')
            } else {
                console.log('go back to writeform')
            }
        })
        </script>
</body>
</html>