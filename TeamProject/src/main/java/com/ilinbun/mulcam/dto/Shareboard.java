package com.ilinbun.mulcam.dto;

import java.sql.Date;

public class Shareboard {
	int articleNo;
	int idx;
	String location;
	String title;
	String content;
	String filename;
	Date datetime;
	int headerTag;
	int views;
	
	public Shareboard() {
		
	}

	public Shareboard(int articleNo, int idx, String location, String title, String content, String filename,
			Date datetime, int headerTag, int views) {
		super();
		this.articleNo = articleNo;
		this.idx = idx;
		this.location = location;
		this.title = title;
		this.content = content;
		this.filename = filename;
		this.datetime = datetime;
		this.headerTag = headerTag;
		this.views = views;
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

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public Date getDatetime() {
		return datetime;
	}

	public void setDatetime(Date datetime) {
		this.datetime = datetime;
	}

	public int getHeaderTag() {
		return headerTag;
	}

	public void setHeaderTag(int headerTag) {
		this.headerTag = headerTag;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}
	
	
}
