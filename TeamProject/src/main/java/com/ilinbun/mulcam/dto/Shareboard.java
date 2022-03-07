package com.ilinbun.mulcam.dto;

public class Shareboard {
	int articleNo, user_PK, readCount = 0;
	String location_sub, content, imgfilename = null;
	
	public int getArticleNo() {
		return articleNo;
	}

	public void setArticleNo(int articleNo) {
		this.articleNo = articleNo;
	}
	public int getUser_PK() {
		return user_PK;
	}
	public void setUser_PK(int user_PK) {
		this.user_PK = user_PK;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public String getLocation_sub() {
		return location_sub;
	}
	public void setLocation_sub(String location_sub) {
		this.location_sub = location_sub;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImgfilename() {
		return imgfilename;
	}
	public void setImgfilename(String imgfilename) {
		this.imgfilename = imgfilename;
	}
	public Shareboard() {
		super();
	}
	public Shareboard(int articleNo, int user_PK, int readCount, String location_sub, String content, String imgfilename) {
		super();
		this.articleNo = articleNo;
		this.user_PK = user_PK;
		this.readCount = readCount;
		this.location_sub = location_sub;
		this.content = content;
		this.imgfilename = imgfilename;
	}
}
