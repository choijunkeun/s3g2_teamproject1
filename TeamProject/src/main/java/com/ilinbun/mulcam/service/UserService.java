package com.ilinbun.mulcam.service;

import com.ilinbun.mulcam.dto.User;

public interface UserService {
	
	// 회원가입
	void makeUser(User user) throws Exception;
	
	//로그인
	boolean loginUser(String user_email, String user_password) throws Exception;
	
}
