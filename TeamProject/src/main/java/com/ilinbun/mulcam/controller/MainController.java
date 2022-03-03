package com.ilinbun.mulcam.controller;

import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ilinbun.mulcam.dto.User;
import com.ilinbun.mulcam.service.UserService;

@Controller
@RequestMapping("/")
public class MainController {

	@Autowired
	UserService userService;
	
	@Autowired
	HttpSession session;

	@GetMapping({ "", "/index" })
	public String Main() {
		return "main";
	}

	// 회원가입 폼으로 이동하는 컨트롤러
	@GetMapping("/join")
	public String getJoin() {
		return "/user/joinForm";
	}

	// 회원가입 기능 컨트롤러
	@PostMapping("/join")
	public String postJoin(User user) throws Exception {
		userService.makeUser(user);
		return "redirect:/loginSuccess"; 
	}
	
	// 회원가입 완료 폼으로 가는 컨트롤러
	@GetMapping("/loginSuccess")
	public String loginSuccess() {
		return "user/joinSuccessForm";
	}

	// 로그인 폼으로 이동하는 컨트롤러
	@GetMapping("/login")
	public String loginForm() {
		return "/user/loginForm";
	}

	// 로그인 기능 컨트롤러
	@PostMapping("/login")
	public String login(@RequestParam(value="user_email")String user_email,
			@RequestParam(value="user_password") String user_password, Model model, HttpServletResponse response, boolean rememberEmail) throws Exception {
		System.out.println("1");
		try {
			userService.loginUser(user_email, user_password);
			System.out.println("2");
			session.setAttribute("user_email", user_email);
			System.out.println("3");
			// 쿠키기능(로그인저장)
			if (rememberEmail) {
				// 1. 쿠키를 생성
				System.out.println("4");
				Cookie cookie = new Cookie("user_email", user_email);
				// 2. 응답에 저장
				response.addCookie(cookie);
				System.out.println("5");
			} else {
				// 1. 쿠키를 생성
				System.out.println("6");
				Cookie cookie = new Cookie("user_email", user_email);
				// 쿠키의 유효기간 0으로 설정
				System.out.println("7");
				cookie.setMaxAge(0);
				// 2. 응답에 저장
				System.out.println("8");
				response.addCookie(cookie);
			}
		} catch(Exception e) {
			System.out.println("9");
			e.printStackTrace();
			String msg = URLEncoder.encode("아이디 또는 비밀번호가 일치하지 않아요!!", "utf-8");
			return "redirect:/login?msg=" + msg;
		}
		return "redirect:/";
	}

	// 비밀번호 찾기 폼으로 이동하는 컨트롤러
	@GetMapping("/searchPwd")
	public String searchPwd() {
		return "/user/searchPwdForm";
	}

	// 닉네임 중복확인 컨트롤러

	// 이메일 인증 컨트롤러

	// 마이 페이지 폼으로 이동하는 컨트롤러
	@GetMapping("/myPage")
	public String myPage() {
		return "user/myPageForm";
	}

}
