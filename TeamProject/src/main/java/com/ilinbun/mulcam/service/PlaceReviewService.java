package com.ilinbun.mulcam.service;

import java.util.List;

import com.ilinbun.mulcam.dto.PageInfo;
import com.ilinbun.mulcam.dto.PlaceReview;
import com.ilinbun.mulcam.dto.PlaceReviewExtended;

public interface PlaceReviewService {
	
	void writeBoard(PlaceReview pr) throws Exception;
	List<PlaceReviewExtended> getReviewList(int page, PageInfo pageInfo, int id) throws Exception;
	int getReviewAmount(int id) throws Exception;
}
