package com.ilinbun.mulcam.dto;

import java.sql.Date;

public class Shareboard {
	int articleNo;
	int idx;
	String subway;
	String title;
	String content;
	
	Date datetime;
	int headerTag;
	int readcount;
	
	public Shareboard() {
		
	}
	
	public Shareboard(String title, String subway, String content, int idx) {
		super();
		this.title = title;
		this.subway = subway;
		this.content = content;
		this.idx = idx;
	}
	
	public Shareboard(int articleNo, int idx, String subway, String title, String content, Date datetime, int headerTag, int readcount) {
		super();
		this.articleNo = articleNo;
		this.idx = idx;
		this.subway = subway;
		this.title = title;
		this.content = content;
		this.datetime = datetime;
		this.headerTag = headerTag;
		this.readcount = readcount;
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

	public String getSubway() {
		return subway;
	}

	public void setSubway(String subway) {
		this.subway = subway;
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

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	
	
}
