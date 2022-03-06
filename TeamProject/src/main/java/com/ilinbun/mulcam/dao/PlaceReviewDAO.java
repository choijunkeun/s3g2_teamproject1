package com.ilinbun.mulcam.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ilinbun.mulcam.dto.PlaceReview;

@Mapper
@Repository("placereview")
public interface PlaceReviewDAO {
	void insertReview(PlaceReview pr) throws Exception;
	PlaceReview selectReview(int reviewNo) throws Exception;
	
	List<PlaceReview> selectPRBoardList(int startrow) throws Exception;
	Integer selectMaxPRBoardNum() throws Exception;
	int selectPRBoardCount() throws Exception;
	
	void updateReview(PlaceReview pr) throws Exception;
	void deleteReview(int reviewNo) throws Exception;
}
