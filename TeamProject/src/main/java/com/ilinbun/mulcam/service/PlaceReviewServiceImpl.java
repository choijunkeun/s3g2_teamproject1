package com.ilinbun.mulcam.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ilinbun.mulcam.dao.PlaceReviewDAO;
import com.ilinbun.mulcam.dto.PageInfo;
import com.ilinbun.mulcam.dto.PlaceRating;
import com.ilinbun.mulcam.dto.PlaceReview;
import com.ilinbun.mulcam.dto.PlaceReviewExtended;
@Service
public class PlaceReviewServiceImpl implements PlaceReviewService {
	
	@Autowired
	PlaceReviewDAO placeReviewDAO;
	
	@Override
	public void writeBoard(PlaceReview pr) throws Exception {
		Integer boardNum = placeReviewDAO.selectMaxPRNum();
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
	
	@Override
	public List<PlaceReviewExtended> getReviewList(int page, PageInfo pageInfo, int id) throws Exception {
		int listCount = placeReviewDAO.selectPRBoardCount(id);
		
		// 총 페이지 수. 올림처리
		int maxPage = (int)Math.ceil((double)listCount/10);
		
		// 현재 페이지에 보여줄 시작 페이지 수
		int startPage =(((int)((double)page/10+0.9))-1)*10+1;
		
		// 현재 페이지에 보여줄 마지막 페이지 수(10,20,30,..)
		int endPage = startPage+10 -1;
		
		if(endPage>maxPage) endPage = maxPage;
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setPage(page);
		pageInfo.setListCount(listCount);
		int startrow = (page-1)*10+1;
		HashMap<String, Integer> input = new HashMap<>();
		input.put("startrow", startrow);
		input.put("id", id);
		return placeReviewDAO.selectPRReviewList(input);
	}

	@Override
	public int getReviewAmount(int id) throws Exception {
		return placeReviewDAO.selectPRBoardCount(id);
	}

	@Override
	public Double getInteriorRating(int id) throws Exception {
		Double result;
		try {
			result = placeReviewDAO.selectPlaceInteriorRating(id);
			result = (double) Math.round((result * 10))/10;
		} catch(NullPointerException e) {
			result = 0.0;
		}
		return result != null? result : 0.0;
	}

	@Override
	public Double getPriceRating(int id) throws Exception {
		// TODO Auto-generated method stub
		Double result;
		try {
			result = placeReviewDAO.selectPlacePriceRating(id);
			result = (double) Math.round((result * 10))/10;
		} catch(NullPointerException e) {
			result = 0.0;
		}
		return result != null? result : 0.0;
	}

	@Override
	public Double getServiceRating(int id) throws Exception {
		// TODO Auto-generated method stub
		Double result;
		try {
			result = placeReviewDAO.selectPlaceServiceRating(id);
			result = (double) Math.round((result * 10))/10;
		} catch(NullPointerException e) {
			result = 0.0;
		}
		return result != null? result : 0.0;
	}

	@Override
	public Double getTasteRating(int id) throws Exception {
		// TODO Auto-generated method stub
		Double result;
		try {
			result = placeReviewDAO.selectPlaceTasteRating(id);
			result = (double) Math.round((result * 10))/10;
		} catch(NullPointerException e) {
			result = 0.0;
		}
		return result != null? result : 0.0;
	}

	@Override
	public Double getTotalRating(int id) throws Exception {
		// TODO Auto-generated method stub
		Double result;
		try {
			result =placeReviewDAO.selectPlaceTotalRating(id);
			result = (double) Math.round((result * 10))/10;
		} catch(NullPointerException e) {
			result = 0.0;
		}
		
		return result != null? result : 0.0;
	}

	@Override
	public PlaceRating getAllRating(int id) throws Exception {
		// TODO Auto-generated method stub
		return placeReviewDAO.selectPlaceAllRating(id);
	}
	@Override
	public Double getHonbabLv(int id) throws Exception {
		Double result = placeReviewDAO.selectPlaceHonbabLv(id) ;
		return result != null? result : 1.0;
	}
	
	@Override
	public int updateReview(PlaceReview pr) throws Exception {
		System.out.println("### : "+pr.getReviewContent());
		// TODO Auto-generated method stub
		return placeReviewDAO.updateReview(pr);
	}
	
	public int updateReviewFilePath(PlaceReview pr) throws Exception {
		// TODO Auto-generated method stub
		return placeReviewDAO.updateReviewFilePath(pr);
	}
	
	@Override
	public int deleteReview(int reviewNo) throws Exception {
		// TODO Auto-generated method stub
		return placeReviewDAO.deleteReview(reviewNo);
	}
	
	@Override
	public PlaceReview getReview(int reviewNo) throws Exception {
		// TODO Auto-generated method stub
		return placeReviewDAO.selectReview(reviewNo);
	}
}