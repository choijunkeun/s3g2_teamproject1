package com.ilinbun.mulcam.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;

import com.ilinbun.mulcam.dao.UserDAO;
import com.ilinbun.mulcam.dto.User;
@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserDAO userDAO;
	
	//회원 가입
	@Override
	public void makeUser(User user) throws Exception {
		userDAO.join(user);
	}
	
	
	//회원가입시,유효성 체크 구현
	@Override
	public Map<String, String> validateHandling(Errors errors) throws Exception {
		Map<String, String> validatorResult = new HashMap<>();
		for (FieldError error : errors.getFieldErrors()) {
            String validKeyName = String.format("valid_%s", error.getField());
            validatorResult.put(validKeyName, error.getDefaultMessage());
        }
        return validatorResult;
	}
	
	
	// 닉네임 중복확인
	@Override
	public boolean userOverlap(String nickname) throws Exception {
		User user = userDAO.nickCheck(nickname);
		if(user==null) return false;
		return true;
		
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
	

	
}