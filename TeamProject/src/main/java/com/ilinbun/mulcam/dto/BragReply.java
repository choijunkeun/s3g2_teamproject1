package com.ilinbun.mulcam.dto;

import java.sql.Date;

public class BragReply {
	
	int commentNo, articleNo, idx;
	Date date;
	String comment;
	boolean blind;
	int refer, lev, seq;
	
	public BragReply(int commentNo, int articleNo, int idx, Date date, String comment, boolean blind, int refer,
			int lev, int seq) {
		super();
		this.commentNo = commentNo;
		this.articleNo = articleNo;
		this.idx = idx;
		this.date = date;
		this.comment = comment;
		this.blind = blind;
		this.refer = refer;
		this.lev = lev;
		this.seq = seq;
	}

	public boolean isBlind() {
		return blind;
	}

	public void setBlind(boolean blind) {
		this.blind = blind;
	}

	public int getRefer() {
		return refer;
	}

	public void setRefer(int refer) {
		this.refer = refer;
	}

	public int getLev() {
		return lev;
	}

	public void setLev(int lev) {
		this.lev = lev;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}


	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
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

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}
	
	
	

}
