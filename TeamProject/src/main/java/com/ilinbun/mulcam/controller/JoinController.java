package com.ilinbun.mulcam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class JoinController {
	
	
	
	
	//회원가입 폼으로 이동하는 컨트롤러
	@GetMapping("/join")
	public String join() {
		return "/user/joinForm";
	}
	
	//닉네임 중복확인 컨트롤러

	
	//이메일 인증 컨트롤러
	
	
	
		
	//회원가입 컨트롤러
	
	
	
	
	
	
	
}
