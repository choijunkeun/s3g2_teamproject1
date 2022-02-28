package com.ilinbun.mulcam.controller;

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
	
	//로그인 폼으로 이동하는 컨트롤러 
	@GetMapping("/login")
	public String login() {
		return "/user/loginForm";
	}
	
	//로그인 성공시 메인으로 가는 컨트롤러(POST형식의 컨트롤러)
	@PostMapping("/loginSuccess")
		public String loginSuccess() {
		return "redirect:/";
	}
	
	//닉네임 중복확인 컨트롤러

	
	//이메일 인증 컨트롤러
	
	
	
		
	
	
	
	
	
	
	
	
}
