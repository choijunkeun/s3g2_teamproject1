package com.ilinbun.mulcam.dto;

public class User {
	private int user_PK;
	
	private String user_email;
	

	private String user_nickname;
	

	private String user_password;
	
	private String user_profileImg;
	
	private int user_honbabLevel;
	
	private int user_group;
	
	public int getUser_PK() {
		return user_PK;
	}
	public void setUser_PK(int user_PK) {
		this.user_PK = user_PK;
	}
	public String getUser_email() {
		return user_email;
	}
	public String getUser_nickname() {
		return user_nickname;
	}
	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_password() {
		return user_password;
	}
	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}
	public String getUser_profileImg() {
		return user_profileImg;
	}
	public void setUser_profileImg(String user_profileImg) {
		this.user_profileImg = user_profileImg;
	}
	public int getUser_honbabLevel() {
		return user_honbabLevel;
	}
	public void setUser_honbabLevel(int user_honbabLevel) {
		this.user_honbabLevel = user_honbabLevel;
	}
	public int getUser_group() {
		return user_group;
	}
	public void setUser_group(int user_group) {
		this.user_group = user_group;
	}
	
	public User() {
		
	}
	
	public User(String user_email, String user_nickname, String user_password, String user_profileImg, int user_honbabLevel, int user_group) {
		super();
		this.user_email = user_email;
		this.user_nickname = user_nickname;
		this.user_password = user_password;
		this.user_profileImg = user_profileImg;
		this.user_honbabLevel = user_honbabLevel;
		this.user_group = user_group;
	}
	

	
	
}
