<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">



<style>
  .content {
    display: none;
    padding-bottom: 30px;
  }
  #faq-title {
    font-size: 25px;
  }
  .faq-content {
    border-bottom: 1px solid #e0e0e0;
  }
  .menu {
    font-size: 19px;
    padding: 30px 0;
    cursor: pointer;
    border: none;
    outline: none;
    background: none;
    width: 100%;
    text-align: left;
  }
  .menu:hover {
    color: #2962ff;
  }
  [id$="-toggle"] {
    margin-right: 15px;
  }
</style>


<title>Insert title here</title>
</head>
<body>
	<div class="container pb-3 bg-light">
		<div class="row p-2">


		
			<div class="faq-content">
				<button class="menu" id="menu-1"><span id="menu-1-toggle">+</span><span>닉네임 변경</span></button>
				<div class="content" id="content-1">
					<input type="text" id="nickname" name="nickname">
					
					
				</div>
			</div>
		
			
			<div class="faq-content">
				<button class="menu" id="menu-2"><span id="menu-2-toggle">+</span><span>비밀번호 변경</span></button>
				<div class="content" id="content-2">비밀번호 변경</div>
			</div>
			<div class="faq-content">
				<button class="menu" id="menu-3"><span id="menu-3-toggle">+</span><span>혼밥 레벨 설정</span></button>
				<div class="content" id="content-3">혼밥 레벨 설정</div>
			</div>
			<div class="faq-content">
				<button class="menu" id="menu-4"><span id="menu-4-toggle">+</span><span>프로필 이미지 변경</span></button>
				<div class="content" id="content-4">프로필 이미지 변경</div>
			</div>
			<div class="faq-content">
				<button class="menu" id="menu-5"><span id="menu-5-toggle">+</span><span>회원 탈퇴</span></button>
				<div class="content" id="content-5">회원 탈퇴</div>
			</div>

		</div>
	</div>
</body>

<script>
	const items = document.querySelectorAll('.menu');
	
	function openCloseContent() {
		const contentId = this.id.replace('menu', 'content');
		
   		if(document.getElementById(contentId).style.display === 'block') {
   		document.getElementById(contentId).style.display = 'none';
   		document.getElementById(this.id + '-toggle').textContent = '+';
		} else {
   		document.getElementById(contentId).style.display = 'block';
   		document.getElementById(this.id + '-toggle').textContent = '-';
   		}
	}
 		items.forEach(item => item.addEventListener('click', openCloseContent));
</script>

</html>