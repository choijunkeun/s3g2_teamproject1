package com.ilinbun.mulcam.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
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
	User login(String nickname) throws Exception;

	
	
	
	
}
