package com.ilinbun.mulcam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ilinbun.mulcam.dao.UserDAO;
import com.ilinbun.mulcam.dto.User;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDAO userDAO;

	// 회원 가입
	@Override
	public void makeUser(User user) throws Exception {
		userDAO.join(user);
	}

	// 닉네임 중복확인
	@Override
	public boolean nickCheck(String nickname) throws Exception {
			User user = userDAO.nickCheck(nickname);
			if(user==null) return false;
			return true;
	}

	@Override
	public boolean loginUser(String email, String password) throws Exception {
		User user = userDAO.login(email);
		if(user==null) {
			throw new Exception("존재하지 않는 이메일입니다");
		}
		if(email.equals(user.getEmail())&&password.equals(user.getPassword())) {
			return true;
		} else if(email.equals(user.getEmail())&&!password.equals(user.getPassword())) {
			throw new Exception("비밀번호가 일치하지 않습니다");
		} else return false;
	}

}