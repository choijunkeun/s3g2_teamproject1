package com.ilinbun.mulcam.dto;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class PlaceReviewExtended extends PlaceReview{
	String nickname;
	String profileImg;
	int honbabLevel;
	int group;
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
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
	
	public PlaceReviewExtended() {}
	
	public PlaceReviewExtended(String nickname, String profileImg, int honbabLevel, int group) {
		super();
		this.nickname = nickname;
		this.profileImg = profileImg;
		this.honbabLevel = honbabLevel;
		this.group = group;
	}
	
	
}
