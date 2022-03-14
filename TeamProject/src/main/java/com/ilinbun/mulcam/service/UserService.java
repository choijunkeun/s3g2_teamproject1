package com.ilinbun.mulcam.service;

import com.ilinbun.mulcam.dto.User;

public interface UserService {
	
	// 회원가입
	void makeUser(String email, String nickname, String password, int honbabLevel, String profileImgName) throws Exception;
	
	//로그인
	User loginUser(String email, String password) throws Exception;

	
	//닉네임 체크
	String nickCheck(String nickname) throws Exception;

	
	//이메일 체크
	String emailCheck(String email) throws Exception;

	String getUserNick(int idx) throws Exception;

		
	//회원정보수정
	void updateInfo(String email, String nickname, String password, String profileImgName, int honbabLevel) throws Exception;

	// 회원 삭제
	void userDelete(User user) throws Exception;
	
	//비밀번호 가져오기
	String getPwd(String email) throws Exception;


	
	
	
}
