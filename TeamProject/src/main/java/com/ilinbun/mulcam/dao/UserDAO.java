package com.ilinbun.mulcam.dao;


import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ilinbun.mulcam.dto.User;

@Mapper
@Repository("userDAO")
public interface UserDAO {
	public User nickCheck(String nickname) throws Exception;
	
}
