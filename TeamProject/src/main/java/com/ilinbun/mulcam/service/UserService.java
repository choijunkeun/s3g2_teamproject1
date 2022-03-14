package com.ilinbun.mulcam.service;

import java.util.List;

import com.ilinbun.mulcam.dto.PageInfo;
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

	String getUserNick(int idx) throws Exception;

	
	//회원정보수정
	void userUpdate(User user) throws Exception;

	//유저닉네임 게시판 불러오기(종현)
	User getUserinfo(int writerIdx) throws Exception;
	

	//유저 정보 불러오기(훈)
	User getUserDetail(int idx) throws Exception;
	
	
	//팔로잉/팔로워/팔로우/언팔로우 (훈)
	Integer getFollowingCount(int idx) throws Exception;
	Integer getFollowerCount(int follow) throws Exception;
	Integer didIFollowed(int idx, int follow) throws Exception;
	void toggleFollow(int idx, int follow) throws Exception;

	List<User> getFollowingList(int idx) throws Exception;

	List<User> getFollowerList(int idx) throws Exception;
}
