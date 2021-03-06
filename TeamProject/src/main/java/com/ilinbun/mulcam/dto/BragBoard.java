package com.ilinbun.mulcam.dto;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class BragBoard { // 자랑

	int articleNo;
	int idx;

	boolean moonpa;

	String title;
	String location;

	int readCount;
	Date date;
	String content;


	public BragBoard(int articleNo, int idx, boolean moonpa, String title, String location, 
			int readCount, Date date, String content) {
		super();
		this.articleNo = articleNo;
		this.idx = idx;
		this.moonpa = moonpa;
		this.title = title;
		this.location = location;
		this.readCount = readCount;
		this.date = date;
		this.content = content;
	}

	public BragBoard(int idx, boolean moonpa, String title, String location, int readCount, 
			String content) {
		super();
		this.idx = idx;
		this.moonpa = moonpa;
		this.title = title;
		this.location = location;
		this.readCount = readCount;
		this.content = content;
	}
	public BragBoard() {}

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

	public boolean getMoonpa() {
		return moonpa;
	}

	public void setMoonpa(boolean moonpa) {
		this.moonpa = moonpa;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}
