package com.ilinbun.mulcam.dto;


import javax.validation.constraints.Pattern;

public class User {
	private int idx;
	

	@Pattern(regexp = "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$" , message = "올바른 이메일 형식이 아닙니다")
	private String email;
	
	@Pattern(regexp = "^[가-힣|a-z|A-Z|0-9|]+$", message = "닉네임은 한글, 영어, 숫자만 4~10자리로 입력 가능합니다")
	private String nickname;
	
	@Pattern(regexp = "^[가-힣|a-z|A-Z|0-9|]+$", message = "비밀번호는 한글, 영어, 숫자만 4~10자리로 입력 가능합니다")
	private String password;
	private String profileImg;
	private int honbabLevel;
	private int group;

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public int getHonbabLevel() {
		return honbabLevel;
	}

	public void setHonbabLevel(int honbabLevel) {
		this.honbabLevel = honbabLevel;
	}

	public int getGroup() {
		return group;
	}

	public void setGroup(int group) {
		this.group = group;
	}

	public User() {};


	public User(int idx, String email, String nickname, String password, String profileImg, int honbabLevel,
			int group) {
		super();
		this.idx = idx;
		this.email = email;
		this.nickname = nickname;
		this.password = password;
		this.profileImg = profileImg;
		this.honbabLevel = honbabLevel;
		this.group = group;
	}

}
