package com.ilinbun.mulcam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ilinbun.mulcam.dao.UserDAO;
import com.ilinbun.mulcam.dto.User;
@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserDAO userDAO;
	@Override
	public void makeUser(User user) throws Exception {
		userDAO.join(user);
	}
	@Override
	public boolean loginUser(String email, String password) throws Exception {
		try {
			User user = userDAO.login(email);
			if(user == null) throw new Exception();
			if(password.equals(user.getPassword())) {
				return true;
			}
		} catch(Exception e) {
			throw new Exception("비밀번호 오류");
		}
		return false;
	}
	@Override
	public boolean userOverlap(String nickname) throws Exception {
		User user = userDAO.nickCheck(nickname);
		if(user==null) return false;
		return true;
		
	}
	
}