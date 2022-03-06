package com.ilinbun.mulcam.dto;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class PlaceReview {
	int reviewNo;
	int id; // reviewForm에서 작성됨
	int user_PK; // reviewForm에서 작성됨
	String reviewContent; // reviewForm에서 작성됨
	String revImgFilepath; // 컨트롤러에서 작성됨
	boolean rejectedCount; // reviewForm에서 작성됨
	int honbabLv; // reviewForm에서 작성됨
	String honbabReason; // reviewForm에서 작성됨
	double interiorRate; // reviewForm에서 작성됨
	double serviceRate; // reviewForm에서 작성됨
	double priceRate; // reviewForm에서 작성됨
	double tasteRate; // reviewForm에서 작성됨
	Date writeTime;
	MultipartFile file; // reviewForm에서 writeForm으로 넘어갈 때에 파일 담아주는 객체
		
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
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
	public boolean getRejectedCount() {
		return rejectedCount;
	}
	public void setRejectedCount(boolean rejectedCount) {
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
	
	public PlaceReview(int reviewNo, int id, int user_PK, String reviewContent, String revImgFilepath,
			boolean rejectedCount, int honbabLv, String honbabReason, double interiorRate, double serviceRate,
			double priceRate, double tasteRate, Date writeTime, MultipartFile file) {
		super();
		this.reviewNo = reviewNo;
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
		this.file = file;
	}
	
	public PlaceReview(int reviewNo, int id, int user_PK, String reviewContent, String revImgFilepath,
			boolean rejectedCount, int honbabLv, String honbabReason, double interiorRate, double serviceRate,
			double priceRate, double tasteRate, Date writeTime) {
		super();
		this.reviewNo = reviewNo;
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
	
	public PlaceReview(int id, int user_PK, String reviewContent,
			boolean rejectedCount, int honbabLv, String honbabReason, double interiorRate, double serviceRate,
			double priceRate, double tasteRate) {
		super();
		this.id = id;
		this.user_PK = user_PK;
		this.reviewContent = reviewContent;
		this.rejectedCount = rejectedCount;
		this.honbabLv = honbabLv;
		this.honbabReason = honbabReason;
		this.interiorRate = interiorRate;
		this.serviceRate = serviceRate;
		this.priceRate = priceRate;
		this.tasteRate = tasteRate;
	}
}
