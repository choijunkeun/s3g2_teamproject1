package com.ilinbun.mulcam.service;

import java.util.Map;

import org.springframework.validation.Errors;

import com.ilinbun.mulcam.dto.User;

public interface UserService {
	
	// 회원가입
	void makeUser(User user) throws Exception;
	
	//로그인
	boolean loginUser(String email, String password) throws Exception;

	boolean userOverlap(String nickname) throws Exception;

//	//회원가입 시, 유효성 체크
	Map<String, String> validateHandling(Errors errors) throws Exception;
	
}
