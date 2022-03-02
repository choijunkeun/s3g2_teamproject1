package com.ilinbun.mulcam.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class JoinController {
	
	
	
	
	//회원가입 폼으로 이동하는 컨트롤러
	@GetMapping("/join")
	public String join() {
		return "/user/joinForm";
	}
	
	//회원가입 완료 폼으로 이동하는 컨트롤러
	@PostMapping("/joinSuccess")
		public String joinSeccess() {
		return "/user/joinSuccessForm";
	}
	
	//로그인 폼으로 이동하는 컨트롤러(GET 방식)
	@GetMapping("/login")
	public String loginForm() {
		return "/user/loginForm";
	}
	
	
	
	//로그인 기능 컨트롤러(POST방식)
	@PostMapping("/login")
		public String login(String email, String password, String toURL, boolean rememberEmail, 
				HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		
		// email, password 확인
		
		
		// 쿠키 
		
		if(rememberEmail) {
			//     1. 쿠키를 생성
				Cookie cookie = new Cookie("email", email);
//			       2. 응답에 저장
				response.addCookie(cookie);
			} else {
				// 1. 쿠키를 생성
				Cookie cookie = new Cookie("email", email);
				cookie.setMaxAge(0); // 쿠키의 유효기간 0으로 설정
//			       2. 응답에 저장
				response.addCookie(cookie);
			}
		
		return "redirect:/";
	}
	
	@GetMapping("/searchPwd")
		public String searchPwd() {
		return "/user/searchPwdForm";
	}
	
	//닉네임 중복확인 컨트롤러

	
	//이메일 인증 컨트롤러
	
	
	//마이 페이지 컨트롤러
	@GetMapping("myPage")
		public String myPage() {
		return "/user/myPageForm";
	}
	
	
	
	
		
	
	
	
	
	
	
	
	
}
