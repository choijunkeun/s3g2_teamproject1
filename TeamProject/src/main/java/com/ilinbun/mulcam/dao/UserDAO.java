package com.ilinbun.mulcam.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import com.ilinbun.mulcam.dto.User;

@Mapper
@Repository("userDAO")
public interface UserDAO {
	//회원가입
	void join(User user) throws Exception;
	//로그인
	User login(String user_email) throws Exception;
	
	
	
}
