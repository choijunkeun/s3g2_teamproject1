package com.ilinbun.mulcam.dto;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class BragBoard { // 자랑

	int articleNo;
	int idx;

	boolean inRestaurant;

	String title;
	String location;

	int readCount;
	Date date;
//	String imgfilename; 
	String content;

	public BragBoard() {

	}

	public BragBoard(int articleNo, int idx, boolean inRestaurant, String title, String location, int readCount,
			Date date, String imgfilename, String content) {
		super();
		this.articleNo = articleNo;
		this.idx = idx;
		this.inRestaurant = inRestaurant;
		this.title = title;
		this.location = location;
		this.readCount = readCount;
		this.date = date;
//		this.imgfilename = imgfilename;
		this.content = content;
	}

	public BragBoard(int idx, boolean inRestaurant, String title, String location, int readCount, String imgfilename,
			String content) {
		super();
		this.idx = idx;
		this.inRestaurant = inRestaurant;
		this.title = title;
		this.location = location;
		this.readCount = readCount;
//		this.imgfilename = imgfilename;
		this.content = content;
	}

	public int getArticleNo() {
		return articleNo;
	}

	public void setArticleNo(int articleNo) {
		this.articleNo = articleNo;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public boolean isInRestaurant() {
		return inRestaurant;
	}

	public void setInRestaurant(boolean inRestaurant) {
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
//
//	public String getImgfilename() {
//		return imgfilename;
//	}
//
//	public void setImgfilename(String imgfilename) {
//		this.imgfilename = imgfilename;
//	}

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
