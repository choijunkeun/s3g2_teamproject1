package com.ilinbun.mulcam.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class Shareboard {
	int articleNo;
	int idx;
	String subway;
	String title;
	String content;
	
	/* Date date; */
	Timestamp date;
	int headerTag;
	int readCount;
	
	public Shareboard() {
		
	}
	
	public Shareboard(String title, String subway, String content, int idx, int headerTag) {
		super();
		this.title = title;
		this.subway = subway;
		this.content = content;
		this.idx = idx;
		this.headerTag = headerTag;
	}
	
	public Shareboard(int articleNo, int idx, String subway, String title, String content, Timestamp date, int headerTag, int readCount) {
		super();
		this.articleNo = articleNo;
		this.idx = idx;
		this.subway = subway;
		this.title = title;
		this.content = content;
		this.date = date;
		this.headerTag = headerTag;
		this.readCount = readCount;
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

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}

	public int getHeaderTag() {
		return headerTag;
	}

	public void setHeaderTag(int headerTag) {
		this.headerTag = headerTag;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	
	
}
