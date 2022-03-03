package com.ilinbun.mulcam.dto;

import java.sql.Date;

public class Place_Review {
	int reviwNo;
	int id;
	int user_PK;
	String reviewContent;
	String revImgFilepath;
	int rejectedCount;
	int honbabLv;
	String honbabReason;
	double interiorRate;
	double serviceRate;
	double priceRate;
	double tasteRate;
	Date writeTime;
	
	public Place_Review() {	
	}
	
	public Place_Review(int reviwNo, int id, int user_PK, String reviewContent, String revImgFilepath,
			int rejectedCount, int honbabLv, String honbabReason, double interiorRate, double serviceRate,
			double priceRate, double tasteRate, Date writeTime) {
		super();
		this.reviwNo = reviwNo;
		this.id = id;
		this.user_PK = user_PK;
		this.reviewContent = reviewContent;
		this.revImgFilepath = revImgFilepath;
		this.rejectedCount = rejectedCount;
		this.honbabLv = honbabLv;
		this.honbabReason = honbabReason;
		this.interiorRate = interiorRate;
		this.serviceRate = serviceRate;
		this.priceRate = priceRate;
		this.tasteRate = tasteRate;
		this.writeTime = writeTime;
	}
	
	public int getReviwNo() {
		return reviwNo;
	}
	public void setReviwNo(int reviwNo) {
		this.reviwNo = reviwNo;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUser_PK() {
		return user_PK;
	}
	public void setUser_PK(int user_PK) {
		this.user_PK = user_PK;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public String getRevImgFilepath() {
		return revImgFilepath;
	}
	public void setRevImgFilepath(String revImgFilepath) {
		this.revImgFilepath = revImgFilepath;
	}
	public int getRejectedCount() {
		return rejectedCount;
	}
	public void setRejectedCount(int rejectedCount) {
		this.rejectedCount = rejectedCount;
	}
	public int getHonbabLv() {
		return honbabLv;
	}
	public void setHonbabLv(int honbabLv) {
		this.honbabLv = honbabLv;
	}
	public String getHonbabReason() {
		return honbabReason;
	}
	public void setHonbabReason(String honbabReason) {
		this.honbabReason = honbabReason;
	}
	public double getInteriorRate() {
		return interiorRate;
	}
	public void setInteriorRate(double interiorRate) {
		this.interiorRate = interiorRate;
	}
	public double getServiceRate() {
		return serviceRate;
	}
	public void setServiceRate(double serviceRate) {
		this.serviceRate = serviceRate;
	}
	public double getPriceRate() {
		return priceRate;
	}
	public void setPriceRate(double priceRate) {
		this.priceRate = priceRate;
	}
	public double getTasteRate() {
		return tasteRate;
	}
	public void setTasteRate(double tasteRate) {
		this.tasteRate = tasteRate;
	}
	public Date getWriteTime() {
		return writeTime;
	}
	public void setWriteTime(Date writeTime) {
		this.writeTime = writeTime;
	}
}
