package com.ilinbun.mulcam.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ilinbun.mulcam.dto.BragBoard;
import com.ilinbun.mulcam.dto.User;

@Mapper
@Repository("User")
public interface UserDAO {
	//회원가입
	void join(User user) throws Exception;
	
	// 닉네임 중복확인에 사용할 쿼리와 연결
	int nickCheck(String nickname) throws Exception;
	
	//이메일 중복확인에 사용할 쿼리와 연결
	int emailCheck(String email) throws Exception;
	
	//로그인
	User login(String email) throws Exception;
	 
	// 회원정보수정
	void updateInfo(User user) throws Exception;
	
	//회원 탈퇴
	void remove(User user) throws Exception;
	//이메일을 이용해 비밀번호 가져오기
	String getPwd(String email) throws Exception;
	
	
	
	// 혼밥자랑 게시글 출력
	List<BragBoard> bragPosting(BragBoard bragBoard) throws Exception;
	
	//user 불러오기(소연)
	User selectUserDetail(int idx) throws Exception;

	//UserNick 불러오기(종현)
	String getUserNick(int idx) throws Exception;
	
	// 팔로워 수, 팔로잉 수, 팔로우, 언팔로우(훈)
	Integer getFollowerCount(int follow) throws Exception;
	Integer getFollowingCount(int idx) throws Exception;
	void follow(Map<String, Integer> map) throws Exception;
	void unfollow(Map<String, Integer> map) throws Exception;
	Integer didIFollowed(Map<String, Integer> map) throws Exception;
	List<User> getFollowerList(int idx) throws Exception;
	List<User> getFollowingList(int idx) throws Exception;
}
