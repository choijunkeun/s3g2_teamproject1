package com.ilinbun.mulcam.dao;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ilinbun.mulcam.dto.PlaceRating;
import com.ilinbun.mulcam.dto.PlaceReview;
import com.ilinbun.mulcam.dto.PlaceReviewExtended;

@Mapper
@Repository("placereview")
public interface PlaceReviewDAO {
	void insertReview(PlaceReview pr) throws Exception;
	PlaceReview selectReview(int reviewNo, int id) throws Exception;
	
	List<PlaceReview> selectPRBoardList(HashMap<String, Integer> input) throws Exception;
	List<PlaceReviewExtended> selectPRReviewList(HashMap<String, Integer> input) throws Exception;
	Integer selectMaxPRNum() throws Exception;
	int selectPRBoardCount(int id) throws Exception;
	
	void updateReview(PlaceReview pr) throws Exception;
	void deleteReview(int reviewNo) throws Exception;
	
	Double selectPlaceInteriorRating(int id) throws Exception;
	Double selectPlacePriceRating(int id) throws Exception;
	Double selectPlaceServiceRating(int id) throws Exception;
	Double selectPlaceTasteRating(int id) throws Exception;
	Double selectPlaceTotalRating(int id) throws Exception;
	PlaceRating selectPlaceAllRating(int id) throws Exception;
	Double selectPlaceHonbabLv(int id) throws Exception;
}
