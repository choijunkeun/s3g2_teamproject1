package com.ilinbun.mulcam.service;

import com.ilinbun.mulcam.dto.User;

public interface UserService {
	
	// 회원가입
	void makeUser(User user) throws Exception;
	
	//로그인
	boolean loginUser(String email, String password) throws Exception;

	boolean userOverlap(String nickname) throws Exception;
	
}
