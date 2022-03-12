package com.ilinbun.mulcam.service;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ilinbun.mulcam.dao.BragDAO;
import com.ilinbun.mulcam.dao.UserDAO;
import com.ilinbun.mulcam.dto.User;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDAO userDAO;
	
	@Autowired
	BragDAO bragDAO;
	
	@Autowired
	SqlSessionTemplate sqlSession;

	// 회원 가입
	@Override
	public void makeUser(User user) throws Exception {
		userDAO.join(user);
	}
	
	// 닉네임 중복확인
	@Override
	public String nickCheck(String nickname) throws Exception {
		String msg = "사용가능한 닉네임입니다.";
		if(nickname.length()>=2) {
			if(userDAO.nickCheck(nickname) == 1) {
				msg = "이미 사용중인 닉네임입니다.";
			}
		} else {
			msg = "닉네임은 2 ~ 6글자만 가능합니다.";
		}
		return msg;
	}
	// 이메일 정규표현식 체크(이메일 형식 체크)
	public boolean isValidEmail(String email) {
		boolean emailcheck = false;
		String regex = "^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(email);
		if(m.matches()) {
			emailcheck = true;
		}
		return emailcheck;	
	}
	
	//이메일 중복확인
	@Override
	public String emailCheck(String email) throws Exception {
		String msg = "사용가능한 이메일입니다.";
		if(isValidEmail(email)) {
			if(userDAO.emailCheck(email) == 1) {
				msg = "이미 사용중인 이메일입니다.";
			}
		} else {
			msg = "이메일 형식을 확인하세요.";
		}
		return msg;
	}
	
	
// 로그인
	@Override
	public User loginUser(String email, String password) throws Exception {
		User user = userDAO.login(email);
		if(user==null) {
			throw new Exception("존재하지 않는 이메일입니다");
		}
		if(email.equals(user.getEmail())&&password.equals(user.getPassword())) {
			return user;
		} else if(email.equals(user.getEmail())&&!password.equals(user.getPassword())) {
			throw new Exception("비밀번호가 일치하지 않습니다");
		} else return null;
	}

	@Override
	public String getUserNick(int idx) throws Exception {
		return userDAO.getUserNick(idx);
	}

	//회원정보 수정
	@Override
	public void userUpdate(User user) throws Exception {
		userDAO.userUpdate(user);
	
	}

	@Override
	public void userDelete(User user) throws Exception {
		userDAO.remove(user);
		
	}
	
	
}