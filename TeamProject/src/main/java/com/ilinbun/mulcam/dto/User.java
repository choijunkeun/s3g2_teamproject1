package com.ilinbun.mulcam.dto;

public class User {
	private int idx;
	private String email;
	private String nickname;
	private String password;
	private String profileImg;
	private int honbabLevel;
	private int grp;

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

	public int getGrp() {
		return grp;
	}

	public void setGrp(int grp) {
		this.grp = grp;
	}

	public User() {};


	public User(int idx, String email, String nickname, String password, String profileImg, int honbabLevel,
			int grp) {
		super();
		this.idx = idx;
		this.email = email;
		this.nickname = nickname;
		this.password = password;
		this.profileImg = profileImg;
		this.honbabLevel = honbabLevel;
		this.grp = grp;
	}

}
