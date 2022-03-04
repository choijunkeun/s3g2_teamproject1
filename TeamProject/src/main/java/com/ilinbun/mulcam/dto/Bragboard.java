package com.ilinbun.mulcam.dto;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class Bragboard { // 자랑

	
	int articleNo; 
	int user_PK;

	int inRestaurant;
	
	String title; 
	String location;
	 
	int readCount;
	Date date;
	String imgfilename; 
	String content; 
	
	MultipartFile file;

	
	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public  Bragboard() {
		
	}

	

	public Bragboard(int articleNo, int user_PK, int inRestaurant, String title, String location, int readCount,
			Date date, String imgfilename, String content, MultipartFile file) {
		super();
		this.articleNo = articleNo;
		this.user_PK = user_PK;
		this.inRestaurant = inRestaurant;
		this.title = title;
		this.location = location;
		this.readCount = readCount;
		this.date = date;
		this.imgfilename = imgfilename;
		this.content = content;
		this.file = file;
	}

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

	public int getInRestaurant() {
		return inRestaurant;
	}

	public void setInRestaurant(int inRestaurant) {
		this.inRestaurant = inRestaurant;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getImgfilename() {
		return imgfilename;
	}

	public void setImgfilename(String imgfilename) {
		this.imgfilename = imgfilename;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}


	
	
//	public int getArticleNo() {
//	return articleNo;
//
//}

	
}
