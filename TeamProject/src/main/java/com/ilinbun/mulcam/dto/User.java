package com.ilinbun.mulcam.dto;

public class User {
	private int idx;

//	@NotBlank(message = "이메일은 필수 입력값입니다.")
//	@Email(message = "이메일 형식이 맞지 않습니다.")
	private String email;

//	@NotBlank(message = "닉네임은 필수 입력값입니다.")
//	@Size(min=2, max=6, message = "닉네임은 2~6자 사이어야 합니다.")
	private String nickname;

//	@NotBlank(message = "패스워드는 필수 입력값입니다.")
//	@Pattern(regexp="(?=.*[0-9])(?=.*[a-z])(?=.*\\W)(?=\\S+$).{6,12}",
//			message = "비밀번호는 영문자,숫자,특수기호가 적어도 1개 이상 포함된 6~12자의 비밀번호여야 합니다.")
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
