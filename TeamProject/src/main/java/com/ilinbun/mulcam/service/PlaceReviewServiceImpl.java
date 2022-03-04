package com.ilinbun.mulcam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ilinbun.mulcam.dao.PlaceReviewDAO;
import com.ilinbun.mulcam.dto.PlaceReview;
@Service
public class PlaceReviewServiceImpl implements PlaceReviewService {
	
	@Autowired
	PlaceReviewDAO placeReviewDAO;
	
	@Override
	public void writeBoard(PlaceReview pr) throws Exception {
		Integer boardNum = placeReviewDAO.selectMaxPRBoardNum();
		if(boardNum==null) boardNum=1;
		else boardNum+=1;
		//pr.setBoard_num(boardNum);
		pr.setReviewNo(boardNum);
		//pr.setBoard_re_ref(boardNum);
		//pr.setBoard_re_lev(0);
		//pr.setBoard_re_seq(0);
		//pr.setBoard_readcount(0);
		placeReviewDAO.insertReview(pr);
	}
	
	
}