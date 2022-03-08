package com.ilinbun.mulcam.service;

import com.ilinbun.mulcam.dto.User;

public interface UserService {
	
	// 회원가입
	void makeUser(User user) throws Exception;
	
	//로그인
	User loginUser(String email, String password) throws Exception;

	
	//닉네임 체크
	String nickCheck(String nickname) throws Exception;

	
	//이메일 체크
	String emailCheck(String email) throws Exception;

	
}
