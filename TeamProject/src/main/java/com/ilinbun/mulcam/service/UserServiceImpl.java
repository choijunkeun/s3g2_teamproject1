package com.ilinbun.mulcam.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public void makeUser(String email, String nickname, String password, int honbabLevel, String profileImgName) throws Exception {
		String profileImg = profileImgName;
		User user = new User();
		user.setEmail(email);
		user.setNickname(nickname);
		user.setPassword(password);
		user.setProfileImg(profileImg);
		user.setHonbabLevel(honbabLevel);
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

	// 회원 탈퇴
	@Override
	public void userDelete(User user) throws Exception {
		userDAO.remove(user);
	}

	//비밀번호 DB에서 가져오기
	@Override
	public String getPwd(String email) throws Exception {
		String getpass = userDAO.getPwd(email);
		return getpass;
	}

	@Override
	public void updateInfo(String email, String nickname, String password, String profileImgName, int honbabLevel)
			throws Exception {
		String profileImg = profileImgName;
		System.out.println("updateInfo ServiceImpl");
		User user = new User();
		user.setEmail(email);
		user.setNickname(nickname);
		user.setPassword(password);
		user.setProfileImg(profileImg);
		user.setHonbabLevel(honbabLevel);
		userDAO.updateInfo(user);
		
	}

	//유저 닉네임 게시판 불러오기 (종현)
	@Override
	public User getUserinfo(int writerIdx) throws Exception {
		return userDAO.selectUserDetail(writerIdx);
	}
	
	//회원정보 가져오기 (훈)
	@Override
	public User getUserDetail(int idx) throws Exception {
		User user = userDAO.selectUserDetail(idx); 
		user.setPassword("");
		return user;
	}
	
	//해당 회원의 팔로잉 수 가져오기(훈)
	@Override
	public Integer getFollowingCount(int idx) throws Exception{
		return userDAO.getFollowingCount(idx);
	}
	//해당 회원의 팔로워 수 가져오기(훈)
	@Override
	public Integer getFollowerCount(int follow) throws Exception{
		return userDAO.getFollowerCount(follow);
	}
	// 팔로우(훈)
	@Override
	public void toggleFollow(int idx, int follow) throws Exception{
		Integer didIFollowed = didIFollowed(idx, follow);
		
		Map<String, Integer> map = new HashMap<>();
		map.put("idx", idx);
		map.put("follow", follow);
		
		if(didIFollowed >0) {
			userDAO.unfollow(map);
		} else userDAO.follow(map);
		
	}
	//팔로우 했는지 확인
	@Override
	public Integer didIFollowed(int idx, int follow) throws Exception {
		Map<String, Integer> map = new HashMap<>();
		map.put("idx", idx);
		map.put("follow", follow);
		return userDAO.didIFollowed(map);
	}
	
	@Override
	public List<User> getFollowingList(int idx) throws Exception{
		return userDAO.getFollowingList(idx);
	}
	@Override
	public List<User> getFollowerList(int idx) throws Exception{
		return userDAO.getFollowerList(idx);
	}
}